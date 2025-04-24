CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE products (
    Sku_Code VARCHAR(50) PRIMARY KEY,
    Design_No VARCHAR(50),
    Stock INT,
    Category VARCHAR(100),
    Size VARCHAR(10),
    Color VARCHAR(50)
);
SELECT * FROM products LIMIT 10;


SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category;

SELECT * FROM products
WHERE Stock > 100
ORDER BY Stock DESC;


##JOINS (Create a dummy second table to demonstrate)
### Let's assume you have a second table for sales:

CREATE TABLE sales (
    Sale_ID INT PRIMARY KEY AUTO_INCREMENT,
    Sku_Code VARCHAR(50),
    Quantity_Sold INT,
    Sale_Date DATE,
    FOREIGN KEY (Sku_Code) REFERENCES products(Sku_Code)
);

#### INNER JOIN: Product info with sales
SELECT p.Sku_Code, p.Category, s.Quantity_Sold, s.Sale_Date
FROM products p
INNER JOIN sales s ON p.Sku_Code = s.Sku_Code;

### LEFT JOIN: Show all products even if not sold
SELECT p.Sku_Code, p.Category, s.Quantity_Sold
FROM products p
LEFT JOIN sales s ON p.Sku_Code = s.Sku_Code;


### RIGHT JOIN: Show all sales including unsold product references
SELECT p.Sku_Code, p.Category, s.Quantity_Sold
FROM products p
RIGHT JOIN sales s ON p.Sku_Code = s.Sku_Code;

#Subqueries
## Products with stock above average

SELECT * FROM products
WHERE Stock > (SELECT AVG(Stock) FROM products);

#### Aggregate Functions (SUM, AVG)
# Total stock per category

SELECT Category, SUM(Stock) AS Total_Stock
FROM products
GROUP BY Category;

# Average stock by color

SELECT Color, AVG(Stock) AS Avg_Stock
FROM products
GROUP BY Color;

### Create a View for Analysis
## High stock products view

CREATE VIEW High_Stock_Products AS
SELECT * FROM products
WHERE Stock > 200;


#### Optimize Queries with Indexes
# Index on Category

CREATE INDEX idx_category ON products(Category);

CREATE INDEX idx_stock ON products(Stock);


