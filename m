From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCHv3 1/6] Scripts to install, delete and clear a MediaWiki
Date: Mon, 11 Jun 2012 22:28:41 +0200
Message-ID: <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <4FD654C8.6040208@ensimag.imag.fr>
Cc: simon.cathebras@ensimag.imag.fr, Matthieu.Moy@imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, gitster@pobox.com, peff@peff.net,
	Simon.Perrat@ensimag.imag.fr,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 22:29:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBEm-0006rW-5M
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab2FKU3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:29:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42501 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032Ab2FKU3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:29:14 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BKJwTB010749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 22:19:58 +0200
Received: from Hithlum.crous-grenoble.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BKSkIT022262;
	Mon, 11 Jun 2012 22:28:46 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <4FD654C8.6040208@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 22:19:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BKJwTB010749
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340050800.60099@h3KftBWMIC3etRSP/vqHew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199719>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

Install_wiki.sh expects the first argument to be 'install' or 'delete'
'install' installs a MediaWiki on the web's server with SQLite3
'delete' deletes the previously created wiki.
Note those functionnalities are made to be used from the user command line in
the directory git/contrib/mw-to-git/t/

install_wiki also defines a function wiki_reset which clear all content
of the previously created wiki. Note this functionnality is made to be
used only by our test function in a subdirectory of t/

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>

---
 contrib/mw-to-git/t/install-wiki.sh                |  38 +++++
 contrib/mw-to-git/t/install-wiki/LocalSettings.php | 129 +++++++++++++++++
 contrib/mw-to-git/t/install-wiki/db_install.php    | 110 +++++++++++++++
 contrib/mw-to-git/t/test-gitmw-lib.sh              | 154 +++++++++++++++++++++
 4 files changed, 431 insertions(+)
 create mode 100755 contrib/mw-to-git/t/install-wiki.sh
 create mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
 create mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php
 create mode 100755 contrib/mw-to-git/t/test-gitmw-lib.sh

diff --git a/contrib/mw-to-git/t/install-wiki.sh b/contrib/mw-to-git/t/install-wiki.sh
new file mode 100755
index 0000000..322f46d
--- /dev/null
+++ b/contrib/mw-to-git/t/install-wiki.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+# This script installs or deletes a MediaWiki on your computer.
+# It requires a web server with PHP and SQLite running. In addition, if you 
+# do not have MediaWiki sources on your computer, the option 'install' 
+# downloads them for you.
+# Please set the CONFIGURATION VARIABLES in ./test-gitmw-lib.sh
+
+. ./test-gitmw-lib.sh
+
+usage () {
+        echo "Usage: "
+        echo "  ./install-wiki.sh <install|delete|--help|-h>"
+        echo "          install: Install a wiki on your computer."
+        echo "          delete: Delete the wiki and all its pages and      content"
+}
+
+
+# Argument: install, delete, --help | -h
+case "$1" in
+	"install")
+		wiki_install
+		exit 0
+		;;
+	"delete")
+		wiki_delete
+		exit 0
+		;;
+	"--help" | "-h")
+		usage
+		exit 0
+		;;
+	*)
+		usage
+		exit 0
+		;;
+esac
+
diff --git a/contrib/mw-to-git/t/install-wiki/LocalSettings.php b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
new file mode 100644
index 0000000..c2fe3d5
--- /dev/null
+++ b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
@@ -0,0 +1,129 @@
+<?php
+# This file was automatically generated by the MediaWiki 1.19.0
+# installer. If you make manual changes, please keep track in case you
+# need to recreate them later.
+#
+# See includes/DefaultSettings.php for all configurable settings
+# and their default values, but don't forget to make changes in _this_
+# file, not there.
+#
+# Further documentation for configuration settings may be found at:
+# http://www.mediawiki.org/wiki/Manual:Configuration_settings
+
+# Protect against web entry
+if ( !defined( 'MEDIAWIKI' ) ) {
+	exit;
+}
+
+## Uncomment this to disable output compression
+# $wgDisableOutputCompression = true;
+
+$wgSitename      = "Git-MediaWiki-Test";
+$wgMetaNamespace = "Git-MediaWiki-Test";
+
+## The URL base path to the directory containing the wiki;
+## defaults for all runtime URL paths are based off of this.
+## For more information on customizing the URLs please see:
+## http://www.mediawiki.org/wiki/Manual:Short_URL
+$wgScriptPath       = "@WG_SCRIPT_PATH@";
+$wgScriptExtension  = ".php";
+
+## The protocol and server name to use in fully-qualified URLs
+$wgServer           = "@WG_SERVER@";
+
+## The relative URL path to the skins directory
+$wgStylePath        = "$wgScriptPath/skins";
+
+## The relative URL path to the logo.  Make sure you change this from the default,
+## or else you'll overwrite your logo when you upgrade!
+$wgLogo             = "$wgStylePath/common/images/wiki.png";
+
+## UPO means: this is also a user preference option
+
+$wgEnableEmail      = true;
+$wgEnableUserEmail  = true; # UPO
+
+$wgEmergencyContact = "apache@localhost";
+$wgPasswordSender   = "apache@localhost";
+
+$wgEnotifUserTalk      = false; # UPO
+$wgEnotifWatchlist     = false; # UPO
+$wgEmailAuthentication = true;
+
+## Database settings
+$wgDBtype           = "sqlite";
+$wgDBserver         = "";
+$wgDBname           = "wikidb";
+$wgDBuser           = "";
+$wgDBpassword       = "";
+
+# SQLite-specific settings
+$wgSQLiteDataDir    = "@WG_SQLITE_DATADIR@";
+
+
+## Shared memory settings
+$wgMainCacheType    = CACHE_NONE;
+$wgMemCachedServers = array();
+
+## To enable image uploads, make sure the 'images' directory
+## is writable, then set this to true:
+$wgEnableUploads  = false;
+$wgUseImageMagick = true;
+$wgImageMagickConvertCommand ="@CONVERT@";
+
+# InstantCommons allows wiki to use images from http://commons.wikimedia.org
+$wgUseInstantCommons  = false;
+
+## If you use ImageMagick (or any other shell command) on a
+## Linux server, this will need to be set to the name of an
+## available UTF-8 locale
+$wgShellLocale = "en_US.utf8";
+
+## If you want to use image uploads under safe mode,
+## create the directories images/archive, images/thumb and
+## images/temp, and make them all writable. Then uncomment
+## this, if it's not already uncommented:
+#$wgHashedUploadDirectory = false;
+
+## Set $wgCacheDirectory to a writable directory on the web server
+## to make your wiki go slightly faster. The directory should not
+## be publically accessible from the web.
+#$wgCacheDirectory = "$IP/cache";
+
+# Site language code, should be one of the list in ./languages/Names.php
+$wgLanguageCode = "en";
+
+$wgSecretKey = "1c912bfe3519fb70f5dc523ecc698111cd43d81a11c585b3eefb28f29c2699b7";
+#$wgSecretKey = "@SECRETKEY@";
+
+
+# Site upgrade key. Must be set to a string (default provided) to turn on the
+# web installer while LocalSettings.php is in place
+$wgUpgradeKey = "ddae7dc87cd0a645";
+
+## Default skin: you can change the default skin. Use the internal symbolic
+## names, ie 'standard', 'nostalgia', 'cologneblue', 'monobook', 'vector':
+$wgDefaultSkin = "vector";
+
+## For attaching licensing metadata to pages, and displaying an
+## appropriate copyright notice / icon. GNU Free Documentation
+## License and Creative Commons licenses are supported so far.
+$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
+$wgRightsUrl  = "";
+$wgRightsText = "";
+$wgRightsIcon = "";
+
+# Path to the GNU diff3 utility. Used for conflict resolution.
+$wgDiff3 = "/usr/bin/diff3";
+
+# Query string length limit for ResourceLoader. You should only set this if
+# your web server has a query string length limit (then set it to that limit),
+# or if you have suhosin.get.max_value_length set in php.ini (then set it to
+# that value)
+$wgResourceLoaderMaxQueryLength = -1;
+
+
+
+# End of automatically generated settings.
+# Add more configuration options below.
+
diff --git a/contrib/mw-to-git/t/install-wiki/db_install.php b/contrib/mw-to-git/t/install-wiki/db_install.php
new file mode 100644
index 0000000..bd7a075
--- /dev/null
+++ b/contrib/mw-to-git/t/install-wiki/db_install.php
@@ -0,0 +1,110 @@
+<?php
+/**
+ * This script generates a SQLite database for a MediaWiki version 1.19.0
+ * You must specify the login of the admin (argument 1) and its
+ * password (argument 2) and the folder where the database file
+ * is located (absolute path in argument 3).
+ * It is used by the script install-wiki.sh in order to make easy the
+ * installation of a MediaWiki.
+ *
+ * In order to generate a SQLite database file, MediaWiki ask the user
+ * to submit some forms in its web browser. This script simulates this
+ * behavior though the functions <get> and <submit>
+ *
+ */
+$argc = $_SERVER['argc'];
+$argv = $_SERVER['argv'];
+
+$login = $argv[2];
+$pass = $argv[3];
+$tmp = $argv[4];
+
+$db_dir = urlencode($tmp);
+$tmp_cookie = tempnam($tmp,"COOKIE_");
+
+/*
+ * Fetchs a page with cURL.
+ */
+function get ($page_name = "") {
+        $curl = curl_init();
+        $page_name_add = "";
+        if ($page_name != "") {
+                $page_name_add = '?page='.$page_name;
+        }
+        $url = 'http://localhost/wiki/mw-config/index.php'.$page_name_add;
+        $tmp_cookie=$GLOBALS['tmp_cookie'];
+        curl_setopt($curl, CURLOPT_COOKIEJAR, $tmp_cookie);
+        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
+        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
+        curl_setopt($curl, CURLOPT_COOKIEFILE, $tmp_cookie);
+        curl_setopt($curl, CURLOPT_HEADER, true);
+        curl_setopt($curl, CURLOPT_URL,
+                'http://localhost/wiki/mw-config/index.php'.$page_name_add);
+
+        $page = curl_exec($curl);
+        curl_close($curl);
+        return $page;
+}
+
+/*
+ * Submits a form with cURL.
+ */
+function submit($page_name, $option = "") {
+        $curl = curl_init();
+        $datapost = 'submit-continue=Continue+%E2%86%92';
+        if ($option != "") {
+                $datapost = $option.'&'.$datapost;
+        }
+        $url = 'http://localhost/wiki/mw-config/index.php?page='.$page_name;
+        $tmp_cookie = $GLOBALS['tmp_cookie'];
+        curl_setopt($curl, CURLOPT_URL, $url);
+        curl_setopt($curl, CURLOPT_POST, true);
+        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
+        curl_setopt($curl, CURLOPT_POSTFIELDS, $datapost);
+        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
+        curl_setopt($curl, CURLOPT_COOKIEJAR, $tmp_cookie);
+        curl_setopt($curl, CURLOPT_COOKIEFILE, $tmp_cookie);
+
+        $page = curl_exec($curl);
+        curl_close($curl);
+        return "$page";
+}
+
+/*
+ * Here starts this script: simulates the behavior of the user
+ * submitting forms to generates the database file.
+ * Note this simulation was made for the MediaWiki version 1.19.0,
+ * we can't assume it works with other versions.
+ *
+ */
+
+$page = get();
+preg_match('/input type="hidden" value="([0-9]+)" name="LanguageRequestTime"/',
+        $page, $matches);
+$timestamp = $matches[1];
+$language = "LanguageRequestTime=$timestamp&uselang=en&ContLang=en";
+$page = submit('Language', $language);
+
+submit('Welcome');
+
+$db_config = 'DBType=sqlite';
+$db_config = $db_config.'&sqlite_wgSQLiteDataDir='.$db_dir;
+$db_config = $db_config.'&sqlite_wgDBname='.$argv[1];
+submit('DBConnect', $db_config);
+
+$wiki_config = 'config_wgSitename=TEST';
+$wiki_config = $wiki_config.'&config__NamespaceType=site-name';
+$wiki_config = $wiki_config.'&config_wgMetaNamespace=MyWiki';
+$wiki_config = $wiki_config.'&config__AdminName='.$login;
+
+$wiki_config = $wiki_config.'&config__AdminPassword='.$pass;
+$wiki_config = $wiki_config.'&config__AdminPassword2='.$pass;
+
+$wiki_config = $wiki_config.'&wiki__configEmail=email%40email.org';
+$wiki_config = $wiki_config.'&config__SkipOptional=skip';
+submit('Name', $wiki_config);
+submit('Install');
+submit('Install');
+
+unlink($tmp_cookie);
+?>
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
new file mode 100755
index 0000000..80b4f4f
--- /dev/null
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -0,0 +1,154 @@
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+# License: GPL v2 or later
+
+#
+# CONFIGURATION VARIABLES
+# You might want to change these ones
+#
+WIKI_DIR_NAME="wiki"            # Name of the wiki's directory
+WIKI_DIR_INST="/var/www"        # Directory of the web server
+TMP="/tmp"                      # Temporary directory for downloads
+                                # Absolute path required!
+SERVER_ADDR="localhost"         # Web server's address
+
+# CONFIGURATION
+# You should not change these ones unless you know what you do
+#
+MW_VERSION="mediawiki-1.19.0"
+DB_FILE="wikidb.sqlite"
+FILES_FOLDER="install-wiki"
+DB_INSTALL_SCRIPT="db_install.php"
+WIKI_ADMIN="WikiAdmin"
+WIKI_PASSW="AdminPass"
+
+}
+
+# Create the SQLite database of the MediaWiki. If the database file already
+# exists, it will be deleted.
+# This script should be runned from the directory where $FILES_FOLDER is
+# located.
+create_db () {
+        rm -f "$TMP/$DB_FILE"
+
+        echo "Generating the SQLite database file. It can take some time ..."
+        # Run the php script to generate the SQLite database file
+        # with cURL calls.
+        php "$FILES_FOLDER/$DB_INSTALL_SCRIPT" $(basename "$DB_FILE" .sqlite) \
+                "$WIKI_ADMIN" "$WIKI_PASSW" "$TMP"
+
+        if [ ! -f "$TMP/$DB_FILE" ] ; then
+                error "Can't create database file in TODO. Try to run ./install-wiki.sh delete first."
+        fi
+        chmod 666 "$TMP/$DB_FILE"
+
+        # Copy the generated database file into the directory the
+        # user indicated.
+        cp --preserve=mode,ownership "$TMP/$DB_FILE" "$FILES_FOLDER" ||
+                error "Unable to copy $TMP/$DB_FILE to $FILES_FOLDER"
+}
+
+# Install a wiki in your web server directory.
+wiki_install () {
+
+        # In this part, we change directory to $TMP in order to download,
+        # unpack and copy the files of MediaWiki
+        (
+        mkdir -p "$WIKI_DIR_INST/$WIKI_DIR_NAME"
+        if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ; then
+                error "Folder $WIKI_DIR_INST/$WIKI_DIR_NAME doesn't exist.
+                Please create it and launch the script again."
+        fi
+
+        # Fetch MediaWiki's archive if not already present in the TMP directory
+        cd "$TMP"
+        if [ ! -f "$MW_VERSION.tar.gz" ] ; then
+                echo "Downloading $MW_VERSION sources ..."
+                wget "http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.0.tar.gz" ||
+                        error "Unable to download "\
+                        "http://download.wikimedia.org/mediawiki/1.19/"\
+                        "mediawiki-1.19.0.tar.gz. "\
+                        "Please fix your connection and launch the script again."
+        fi
+        tar xfz "$MW_VERSION.tar.gz"
+        echo "$MW_VERSION.tar.gz downloaded in `pwd`."\
+                "You can delete it later if you want."
+
+        # Copy the files of MediaWiki wiki in the web server's directory.
+        cd "$MW_VERSION"
+        cp -Rf * "$WIKI_DIR_INST/$WIKI_DIR_NAME/" ||
+                error "Unable to copy WikiMedia's files from `pwd` to "\
+                        "$WIKI_DIR_INST/$WIKI_DIR_NAME"
+        )
+
+        create_db
+
+        # Copy the generic LocalSettings.php in the web server's directory
+        # And modify parameters according to the ones set at the top
+        # of this script.
+        # Note that LocalSettings.php is never modified.
+        if [ ! -f "$FILES_FOLDER/LocalSettings.php" ] ; then
+                error "Can't find $FILES_FOLDER/LocalSettings.php " \
+                        "in the current folder. "\
+                "Please run the script inside its folder."
+        fi
+        cp "$FILES_FOLDER/LocalSettings.php" \
+                "$FILES_FOLDER/LocalSettings-tmp.php" ||
+                error "Unable to copy $FILES_FOLDER/LocalSettings.php " \
+                "to $FILES_FOLDER/LocalSettings-tmp.php"
+
+        # Parse and set the LocalSettings file of the user according to the
+        # CONFIGURATION VARIABLES section at the beginning of this script
+        file_swap="$FILES_FOLDER/LocalSettings-swap.php"
+        sed "s,@WG_SCRIPT_PATH@,/$WIKI_DIR_NAME," \
+                "$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+        mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+        sed "s,@WG_SERVER@,http://$SERVER_ADDR," \
+                "$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+        mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+        sed "s,@WG_SQLITE_DATADIR@,$TMP," \
+                "$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+        mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+
+        mv "$FILES_FOLDER/LocalSettings-tmp.php" \
+                "$WIKI_DIR_INST/$WIKI_DIR_NAME/LocalSettings.php" ||
+                error "Unable to move $FILES_FOLDER/LocalSettings-tmp.php" \
+                "in $WIKI_DIR_INST/$WIKI_DIR_NAME"
+        echo "File $FILES_FOLDER/LocalSettings.php is set in" \
+                " $WIKI_DIR_INST/$WIKI_DIR_NAME"
+
+        chmod ugo+w "$FILES_FOLDER/$DB_FILE"
+
+        echo "Your wiki has been installed. You can check it at
+                http://$SERVER_ADDR/$WIKI_DIR_NAME"
+}
+
+# Reset the database of the wiki and the password of the admin
+#
+# Warning: This function must be called only in a subdirectory of t/ directory
+wiki_reset () {
+        # Copy initial database of the wiki
+        if [ ! -f "../$FILES_FOLDER/$DB_FILE" ] ; then
+                error "Can't find ../$FILES_FOLDER/$DB_FILE in the current folder."
+        fi
+        cp "../$FILES_FOLDER/$DB_FILE" "$TMP" ||
+                error "Can't copy ../$FILES_FOLDER/$DB_FILE in $TMP"
+        echo "File $FILES_FOLDER/$DB_FILE is set in $TMP"
+}
+
+# Delete the wiki created in the web server's directory and all its content
+# saved in the database.
+wiki_delete () {
+	# Delete the wiki's directory.
+	rm -rf "$WIKI_DIR_INST/$WIKI_DIR_NAME" ||
+		error "Wiki's directory $WIKI_DIR_INST/" \
+		"$WIKI_DIR_NAME could not be deleted"
+
+	# Delete the wiki's SQLite database
+	rm -f "$TMP/$DB_FILE" || error "Database $TMP/$DB_FILE could not be deleted."
+}
+
-- 
1.7.10.2.552.gaa3bb87
