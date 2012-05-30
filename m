From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCH 1/3] Script to install, delete and clear a MediaWiki
Date: Wed, 30 May 2012 19:04:50 +0200
Message-ID: <1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
Cc: Matthieu.Moy@imag.fr, simon.cathebras@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, Guillaume.Sasdy@ensimag.imag.fr,
	Julien.Khayat@ensimag.imag.fr, Simon.Perrat@ensimag.imag.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 19:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZmKj-0005Yw-J6
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 19:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab2E3RFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 13:05:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39728 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab2E3RE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 13:04:59 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4UGuY6P004660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 18:56:34 +0200
Received: from Hithlum.grenet.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4UH4qWh014805;
	Wed, 30 May 2012 19:04:52 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <4FC64B0C.6070507@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 May 2012 18:56:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4UGuY6P004660
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339001796.29378@daMTFz2JULks+FcMB+1Leg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198821>

From: Charles Roussel <charles.roussel@ensimag.fr>

install_wiki.sh expects the first argument to be 'install' or 'delete'
'install' installs a MediaWiki on the web's server with SQLite3
'delete' deletes the previously created wiki. Note those
functionnalities are made to be used from the user command line in the
directory /t

install_wiki also defines a function cmd_reset which clear all content
of the previously created wiki. Note this functionnality is made to be
used only by our test function in a subdirectory of t/

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@gmail.com>
---
 t/install-wiki.sh                |  38 ++++++++++
 t/install-wiki/LocalSettings.php | 129 ++++++++++++++++++++++++++++++++++
 t/install-wiki/wikidb.sqlite     | Bin 0 -> 210944 bytes
 t/test-gitmw-lib.sh              | 147 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100755 t/install-wiki.sh
 create mode 100644 t/install-wiki/LocalSettings.php
 create mode 100644 t/install-wiki/wikidb.sqlite
 create mode 100755 t/test-gitmw-lib.sh
 mode change 100644 => 100755 t/test-lib-functions.sh
 mode change 100644 => 100755 t/test-lib.sh

diff --git a/t/install-wiki.sh b/t/install-wiki.sh
new file mode 100755
index 0000000..725346e
--- /dev/null
+++ b/t/install-wiki.sh
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
+		cmd_install
+		exit 0
+		;;
+	"delete")
+		cmd_delete
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
diff --git a/t/install-wiki/LocalSettings.php b/t/install-wiki/LocalSettings.php
new file mode 100644
index 0000000..c2fe3d5
--- /dev/null
+++ b/t/install-wiki/LocalSettings.php
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
diff --git a/t/install-wiki/wikidb.sqlite b/t/install-wiki/wikidb.sqlite
new file mode 100644
index 0000000000000000000000000000000000000000..809047334bf15891de943b480171beb2558f7cb8
GIT binary patch
literal 210944
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

literal 0
HcmV?d00001

diff --git a/t/test-gitmw-lib.sh b/t/test-gitmw-lib.sh
new file mode 100755
index 0000000..2deead7
--- /dev/null
+++ b/t/test-gitmw-lib.sh
@@ -0,0 +1,147 @@
+#
+# CONFIGURATION VARIABLES
+# You might want to change those ones ...
+#
+WIKI_DIR_NAME="wiki"            # Name of the wiki's directory
+WIKI_DIR_INST="/var/www"        # Directory of the web server
+TMP="/tmp"                      # Temporary directory for downloads
+                                # Absolute address needed!
+SERVER_ADDR="localhost"         # Web server's address
+
+#
+# CONFIGURATION
+# You should not change those ones unless you know what you to
+#
+# Do not change the variables below
+MW_VERSION="mediawiki-1.19.0"
+DB_FILE="wikidb.sqlite"
+FILES_FOLDER="install-wiki"
+WIKI_ADMIN="WikiAdmin"
+WIKI_PASSW="AdminPass"
+
+fail () {
+	echo "$1"
+	exit 1
+}
+
+
+
+# Install a wiki in your web server directory.
+cmd_install () {
+
+	# Copy the generic LocalSettings.php in the web server's directory
+	# And modify parameters according to the ones set at the top
+	# of this script.
+	# Note that LocalSettings.php is never modified.
+	if [ ! -f "$FILES_FOLDER/LocalSettings.php" ] ; then
+		fail "Can't find $FILES_FOLDER/LocalSettings.php " \
+			"in the current folder.
+		Please run the script inside its folder."
+	fi
+	cp "$FILES_FOLDER/LocalSettings.php" \
+		"$FILES_FOLDER/LocalSettings-tmp.php" ||
+		fail "Unable to copy $FILES_FOLDER/LocalSettings.php " \
+		"to $FILES_FOLDER/LocalSettings-tmp.php"
+
+	# Parse and set the LocalSettings file of the user according to the
+	# CONFIGURATION VARIABLES section at the beginning of this script
+	file_swap="$FILES_FOLDER/LocalSettings-swap.php"
+	sed "s,@WG_SCRIPT_PATH@,/$WIKI_DIR_NAME," \
+		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+	sed "s,@WG_SERVER@,http://$SERVER_ADDR," \
+		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+	sed "s,@WG_SQLITE_DATADIR@,$TMP," \
+		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+
+	mkdir -p "$WIKI_DIR_INST/$WIKI_DIR_NAME"
+	if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ; then
+		fail "Folder $WIKI_DIR_INST/$WIKI_DIR_NAME doesn't exist. Please create it
+		and launch the script again."
+	fi
+
+	mv "$FILES_FOLDER/LocalSettings-tmp.php" \
+		"$WIKI_DIR_INST/$WIKI_DIR_NAME/LocalSettings.php" ||
+		fail "Unable to move $FILES_FOLDER/LocalSettings-tmp.php" \
+		"in $WIKI_DIR_INST/$WIKI_DIR_NAME"
+	echo "File $FILES_FOLDER/LocalSettings.php is set in $WIKI_DIR_INST/$WIKI_DIR_NAME"
+
+	chmod ugo+w "$FILES_FOLDER/$DB_FILE"
+	reset_db_wiki "."
+
+	# Fetch MediaWiki's archive if not already present in the TMP directory
+	cd "$TMP"
+	if [ ! -f "$MW_VERSION.tar.gz" ] ; then
+		echo "Downloading $MW_VERSION sources ..."
+		wget http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.0.tar.gz ||
+			fail "Unable to download" \
+			"http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.0.tar.gz.
+		Please fix your connection and launch the script again."
+	fi
+	tar xfz "$MW_VERSION.tar.gz"
+	echo "$MW_VERSION.tar.gz downloaded in `pwd`. You can delete it later if you want."
+
+	# Copy the files of MediaWiki wiki in the web server's directory.
+	cd "$MW_VERSION"
+	cp -Rf * "$WIKI_DIR_INST/$WIKI_DIR_NAME/" ||
+		fail "Unable to copy WikiMedia's files from `pwd` to $WIKI_DIR_INST/$WIKI_DIR_NAME"
+
+	set_admin_wiki
+
+	echo "Your wiki has been installed. You can check it at http://$SERVER_ADDR/$WIKI_DIR_NAME"
+}
+
+# Copy the initial database of the wiki over the actual one.
+# Argument $1 is the relative path to the folder $FILES_FOLDER
+#
+# Warning: This function should be not called by user. This is a private
+# function used by cmd_install and cmd_delete
+reset_db_wiki () {
+
+	# Copy initial database of the wiki
+	if [ ! -f "$1/$FILES_FOLDER/$DB_FILE" ] ; then
+		fail "Can't find $1/$FILES_FOLDER/$DB_FILE in the current folder."
+	fi
+	cp --preserve=mode,ownership "$1/$FILES_FOLDER/$DB_FILE" "$TMP" ||
+		fail "Can't copy $1/$FILES_FOLDER/$DB_FILE in $TMP"
+	echo "File $FILES_FOLDER/$DB_FILE is set in $TMP"
+}
+
+# Set the admin WikiAdmin with password AdminPass in the database.
+#
+# Warning: This function should be not called by user. This is a private
+# function used by cmd_install and cmd_delete
+set_admin_wiki () {
+
+	#Add the admin
+	my_pwd="`pwd`"
+	cd "$WIKI_DIR_INST/$WIKI_DIR_NAME/maintenance/"
+	php changePassword.php --user="$WIKI_ADMIN" --password="$WIKI_PASSW" ||
+		fail "Unable to add an admin with the script $WIKI_DIR_INST/$WIKI_DIR_NAME/maintenance/
+	changePassword.php. Check you have the perms to do it."
+	echo "Admin \"$WIKI_ADMIN\" has password \"$WIKI_PASSW\""
+	cd "$my_pwd"
+}
+
+# Reset the database of the wiki and the password of the admin
+#
+# Warning: This function must be called only in a subdirectory of t/ directory
+cmd_reset () {
+	reset_db_wiki ".."
+	set_admin_wiki
+}
+
+# Delete the wiki created in the web server's directory and all its content
+# saved in the database.
+cmd_delete () {
+	# Delete the wiki's directory.
+	rm -rf "$WIKI_DIR_INST/$WIKI_DIR_NAME" ||
+		fail "Wiki's directory $WIKI_DIR_INST/" \
+		"$WIKI_DIR_NAME could not be deleted"
+
+	# Delete the wiki's SQLite database
+	rm -f "$TMP/$DB_FILE" || fail "Database $TMP/$DB_FILE could not be deleted."
+}
+
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
old mode 100644
new mode 100755
diff --git a/t/test-lib.sh b/t/test-lib.sh
old mode 100644
new mode 100755
-- 
1.7.10.2.552.gaa3bb87
