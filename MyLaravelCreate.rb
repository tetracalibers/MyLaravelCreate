# ruby MyLaravelCreate.rb プロジェクト名 データベース名

project = ARGV[0]
database = ARGV[1]
db_port = 8889
db_username = 'root'
db_password = 'root'
db_socket = '/Applications/MAMP/tmp/mysql/mysql.sock'

`composer create-project --prefer-dist laravel/laravel #{project}`

env_file = File.open("#{project}/.env", "r")
buffer = env_file.read()
buffer.gsub!("DB_PORT=3306", "DB_PORT=#{db_port}")
buffer.gsub!("DB_DATABASE=laravel", "DB_DATABASE=#{database}")
buffer.gsub!("DB_PASSWORD=", "DB_PASSWORD=#{db_password}")
env_file = File.open("#{project}/.env", "w")
env_file.write(buffer)
env_file.close()

database_file = File.open("#{project}/config/database.php", "r")
buffer = database_file.read()
buffer.gsub!("'port' => env('DB_PORT', '3306')", "'port' => env('DB_PORT', '#{db_port}')")
buffer.gsub!("'database' => env('DB_DATABASE', 'forge')", "'database' => env('DB_DATABASE', '#{database}')")
buffer.gsub!("'username' => env('DB_USERNAME', 'forge')", "'username' => env('DB_USERNAME', '#{db_username}')")
buffer.gsub!("'password' => env('DB_PASSWORD', '')", "'password' => env('DB_PASSWORD', '#{db_password}')")
buffer.gsub!("'unix_socket' => env('DB_SOCKET', '')", "'unix_socket' => env('DB_SOCKET', '#{db_socket}')")
database_file = File.open("#{project}/config/database.php", 'w')
database_file.write(buffer)
database_file.close()  

# config/app.phpの修正
app_file = File.open("#{project}/config/app.php", 'r')
buffer = app_file.read()
buffer.gsub!("'timezone' => 'UTC'", "'timezone' => 'Asia/Tokyo'")
buffer.gsub!("'locale' => 'en'", "'locale' => 'ja'")
buffer.gsub!("'faker_locale' => 'en_US'", "'faker_locale' => 'ja_JP'")
app_file = File.open("#{project}/config/app.php", "w")
app_file.write(buffer)
app_file.close() 

# viewsフォルダの初期設定
`mkdir #{project}/resources/views/layouts`
`mkdir #{project}/resources/views/components`

# フォーム処理を短く書けるヘルパー集をインストール
`composer require laravelcollective/html`

# マイグレーションによるテーブル変更用のパッケージ
`composer require doctrine/dbal`

# プロジェクトフォルダを開く
`open -a "/Applications/Visual Studio Code.app" #{project}`