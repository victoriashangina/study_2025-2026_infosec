#!/bin/bash

echo "Установка Quarto для архитектуры ARM64..."

# Переход во временную папку
cd /tmp

# Удаление старых версий
sudo rm -rf /opt/quarto
sudo rm -f /usr/local/bin/quarto

# Скачивание Quarto для ARM64
echo "Скачивание Quarto 1.5.57 для ARM64..."
wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.57/quarto-1.5.57-linux-arm64.tar.gz

if [ $? -ne 0 ]; then
    echo "Ошибка при скачивании!"
    exit 1
fi

# Распаковка
echo "Распаковка архива..."
tar -xzf quarto-1.5.57-linux-arm64.tar.gz

if [ ! -d "quarto-1.5.57" ]; then
    echo "Ошибка: папка quarto-1.5.57 не найдена!"
    exit 1
fi

# Проверка архитектуры
echo "Проверка структуры..."
ls -la quarto-1.5.57/bin/tools/

# Перемещение в /opt
echo "Установка в /opt/quarto..."
sudo mv quarto-1.5.57 /opt/quarto

# Создание символической ссылки
echo "Создание ссылки в /usr/local/bin..."
sudo ln -s /opt/quarto/bin/quarto /usr/local/bin/quarto

# Проверка установки
echo "Проверка установки:"
quarto --version

if [ $? -eq 0 ]; then
    echo "Quarto успешно установлен!"
else
    echo "Ошибка установки Quarto!"
fi
