From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Subject: [PATCH 2/3] Test environment of git-remote-mw
Date: Fri,  1 Jun 2012 12:41:56 +0200
Message-ID: <1338547317-26088-2-git-send-email-guillaume.sasdy@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
 <1338547317-26088-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Cathebras <Simon.Cathebras@ensimag.imag.fr>,
	Simon Perrat <Simon.Perrat@ensimag.imag.fr>,
	Charles Roussel <Charles.Roussel@ensimag.imag.fr>,
	Julien Khayat <Julien.Khayat@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 12:43:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaPK4-00052W-MO
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 12:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759311Ab2FAKnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 06:43:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35061 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759249Ab2FAKnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 06:43:03 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q51AYZKL032677
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 12:34:36 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q51Agxul009534;
	Fri, 1 Jun 2012 12:42:59 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q51AgwYg026398;
	Fri, 1 Jun 2012 12:42:58 +0200
Received: (from sasdygu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q51Agwmr026397;
	Fri, 1 Jun 2012 12:42:58 +0200
X-Mailer: git-send-email 1.7.10.2.568.g4c26a3a
In-Reply-To: <1338547317-26088-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Jun 2012 12:34:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q51AYZKL032677
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: guillaume.sasdy@ensimag.imag.fr
MailScanner-NULL-Check: 1339151678.70635@byi7X5UJaxqWTRmnSGlZZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198976>

From: Charles Roussel <charles.roussel@ensimag.fr>

In order to test git-remote-mediawiki, we need a package of functions
to manage a MediaWiki: edit a page, remove a page, fetch a page,
fetch all pages on a given wiki.

We also need functions to compare the content of directories.

Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Simon Cathebras <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Simon Perrat <Simon.Perrat@ensimag.imag.fr>
Signed-off-by: Charles Roussel <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Julien Khayat <Julien.Khayat@ensimag.imag.fr>
---
 t/test-gitmw-lib.sh | 124 ++++++++++++++++++++++++++++++++++++---
 t/test-gitmw.pl     | 164 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 280 insertions(+), 8 deletions(-)
 create mode 100755 t/test-gitmw.pl

diff --git a/t/test-gitmw-lib.sh b/t/test-gitmw-lib.sh
index b1023d7..d7c7459 100755
--- a/t/test-gitmw-lib.sh
+++ b/t/test-gitmw-lib.sh
@@ -1,27 +1,135 @@
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#     Matthieu Moy <matthieu.moy@imag.fr>
+# License: GPL v2 or later
+
 #
 # CONFIGURATION VARIABLES
-# You might want to change those ones ...
+# You might want to change these ones
 #
 WIKI_DIR_NAME="wiki"            # Name of the wiki's directory
 WIKI_DIR_INST="/var/www"        # Directory of the web server
 TMP="/tmp"                      # Temporary directory for downloads
-                                # Absolute address needed!
+                                # Absolute path required!
 SERVER_ADDR="localhost"         # Web server's address
 
-#
 # CONFIGURATION
-# You should not change those ones unless you know what you to
+# You should not change these ones unless you know what you do
 #
-# Do not change the variables below
 MW_VERSION="mediawiki-1.19.0"
 DB_FILE="wikidb.sqlite"
 FILES_FOLDER="install-wiki"
 WIKI_ADMIN="WikiAdmin"
 WIKI_PASSW="AdminPass"
 
-fail () {
-	echo "$1"
-	exit 1
+# wiki_getpage <page_name> <dest_path>
+#
+# Fetch a page <page_name> from the wiki and copy its content
+# into directory <dest_path>.
+wiki_getpage () {
+	../test-gitmw.pl get_page -p "$1" "$2"
+}
+
+# wiki_delete_page <page_name>
+#
+# Delete the page <page_name> on the wiki.
+wiki_delete_page () {
+	../test-gitmw.pl delete_page -p "$1"
+}
+
+# wiki_edit_page <page_name> <page_content> <page_append>
+#
+# Edit a page <wiki_page> on the wiki with content <wiki_content>
+# If <wiki_append> == true the content will be appended
+# If the page doesn't exist, it is created.
+wiki_editpage () {
+	../test-gitmw.pl edit_page -p "$1" "$2" "$3"
+}
+
+# git_content <dir_1> <dir_2>
+#
+# Compare the contents of directories <dir_1> and <dir_2> with diff
+# and exits with error 1 if they do not match. The program will
+# not look into .git in the process.
+git_content () {
+	result=$(diff -r -b --exclude=".git" "$1" "$2")
+
+	if echo $result | grep -q ">" ; then
+		echo "test failed: files $1 and $2 do not match"
+		exit 1
+	fi
+}
+
+# git_exist <rep_name> <file_name>
+#
+# Check the existence of <file_name> into the git repository
+# <rep_name> and exits with error 1 if it is absent.
+git_exist () {
+	result=$(find "$1" -type f -name "$2")
+
+	if ! echo $result | grep -q "$2" ; then
+		echo "test failed: file $2 does not exist in $1"
+		exit 1
+	fi
+}
+
+# wiki_check_content <file_name> <page_name> 
+#
+# Compares the contents of the file <file_name> and the wiki page
+# <page_name> and exits with error 1 if they do not match.
+wiki_check_content () {
+	wiki_getpage "$2" .
+
+	if test -f "$2".mw ; then
+	        git_content "$1" "$2".mw
+		rm "$2".mw
+	else
+		die "ERROR: file $2 not found on wiki"
+	fi
+}
+
+# wiki_page_exist <page_name>
+#
+# Check the existence of the page <page_name> on the wiki and exits
+# with error if it is absent from it.
+wiki_page_exist () {
+	wiki_getpage "$1" .
+
+	if test -f "$1".mw ; then
+		echo "test failed: file $1 not found on wiki"
+		exit 1
+	else 
+		rm "$1".mw
+	fi
+}
+
+# wiki_getallpagename
+# 
+# Fetch the name of each page on the wiki.
+wiki_getallpagename () {
+	../test-gitmw.pl "getallpagename" -p
+}
+
+# wiki_getallpage <dest_dir>
+#
+# Fetch all the pages from the wiki and place them in the directory
+# <dest_dir>.
+wiki_getallpage () {
+	wiki_getallpagename
+	mkdir -p "$1"
+	while read -r line; do
+		wiki_getpage "$line" $1;
+	done < all.txt
+}
+
+fail()
+{
+    echo "$1"
+    exit 1
 }
 
 
diff --git a/t/test-gitmw.pl b/t/test-gitmw.pl
new file mode 100755
index 0000000..bf71485
--- /dev/null
+++ b/t/test-gitmw.pl
@@ -0,0 +1,164 @@
+#!/usr/bin/perl -w
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#     Matthieu Moy <matthieu.moy@imag.fr>
+# License: GPL v2 or later
+
+# Usage:
+#       ./test-gitmw.pl <command> [argument]*
+# Execute in terminal using the name of the function to call as first
+# parameter, and the function's arguments as following parameters
+#
+# Example:
+#     ./test-gitmw.pl "get_page" foo .
+# will call <wiki_getpage> with arguments <foo> and <.>
+#
+# Available functions are:
+#     "get_page"
+#     "delete_page"
+#     "edit_page"
+#     "getallpagename"
+
+use MediaWiki::API;
+use Switch;
+# URL of the wiki used for the tests
+my $wiki_url="http://localhost/wiki/api.php";
+my $wiki_admin='WikiAdmin';
+my $wiki_admin_pass='AdminPass';
+my $mw = MediaWiki::API->new;
+$mw->{config}->{api_url} = $wiki_url;
+
+# wiki_login <name> <password>
+#
+# Logs the user with <name> and <password> in the global variable
+# of the mediawiki $mw
+sub wiki_login {
+	$mw->login( { lgname => "$_[0]",lgpassword => "$_[1]" } )
+                || die "getpage: login failed";
+}
+
+# wiki_getpage <wiki_page> <dest_path>
+#
+# fetch a page <wiki_page> from the wiki referenced in the global variable
+# $mw and copies its content in directory dest_path
+sub wiki_getpage {
+	my $pagename = $_[0];
+	my $destdir = $_[1];
+	
+	my $page = $mw->get_page( { title => $pagename } );
+	if (!defined($page)) {
+		die "getpage: wiki does not exist";
+	}
+
+	my $content = $page->{'*'};
+	if (!defined($content)) {
+		die "getpage: page does not exist";
+	}
+
+        # Replace spaces by underscore in the page name
+	$pagename=~s/\ /_/;
+	open(my $file, ">$destdir/$pagename.mw");
+	print $file "$content";
+	close ($file);
+}
+
+# wiki_delete_page <page_name>
+#
+# delete the page with name <page_name> from the wiki referenced
+# in the global variable $mw
+sub wiki_delete_page {
+	my $pagename = $_[0];
+
+	my $exist=$mw->get_page({title => $pagename});
+
+	if (defined($exist->{'*'})){
+		$mw->edit({ action => 'delete',
+			        title => $pagename})
+		|| die $mw->{error}->{code} . ": " . $mw->{error}->{details};
+	}
+        else{
+		die "no page with such name found: $pagename\n";
+	}
+}
+
+# wiki_editpage <wiki_page> <wiki_content> <wiki_append>
+#
+# Edit a page named <wiki_page> with content <wiki_content> on the wiki
+# referenced with the global variable $mw
+# If <wiki_append> == true : append <wiki_content> at the end of the actual
+# content of the page <wiki_page>
+# If <wik_page> doesn't exist, that page is created with the <wiki_content>
+sub wiki_editpage {
+	my $wiki_page = $_[0];
+	my $wiki_content = $_[1];
+	my $wiki_append = $_[2];
+
+	my $append = 0;
+	if (defined($wiki_append) && $wiki_append eq 'true') {
+		$append=1;
+	}
+
+	my $previous_text ="";
+
+	if ($append) {
+	my $ref = $mw->get_page( { title => $wiki_page } );
+		$previous_text = $ref->{'*'};
+	}
+
+	my $text = $wiki_content;
+	if (defined($previous_text)) {
+		$text="$previous_text$text";
+	}
+	$mw->edit( { action => 'edit', title => $wiki_page, text => "$text"} );
+}
+
+# wiki_getallpagename
+#
+# Fetch all pages of the wiki referenced by the global variable $mw
+# and print the names of each one in the file all.txt with a new line
+# ("\n") between these.
+sub wiki_getallpagename {
+        # fetch the pages of the wiki
+	$mw->list ( { action => 'query',
+			list => 'allpages',
+			#cmtitle => "Category:Surnames",
+			#cmnamespace => 0,
+			cmlimit=> 500 },
+		{ max => 4, hook => \&cat_names } )
+	        || die $mw->{error}->{code}.": ".$mw->{error}->{details};
+
+	# print the name of each page
+	sub cat_names {
+		my ($ref) = @_;
+
+		open(my $file, ">all.txt");
+		foreach (@$ref) {
+			print $file "$_->{title}\n";
+		}
+		close ($file);
+	}
+}
+
+# Main part of this script: parse the command line arguments
+# and select which function to execute
+my $fct_to_call = shift;
+my $login = $ARGV[0];
+
+if ($login eq "-p")
+{
+	&wiki_login($wiki_admin,$wiki_admin_pass);
+	shift;
+}
+
+switch ($fct_to_call) {
+	case "get_page" { &wiki_getpage($ARGV[0], $ARGV[1])}
+	case "delete_page" { &wiki_delete_page($ARGV[0])}
+	case "edit_page" { &wiki_editpage($ARGV[0], $ARGV[1], $ARGV[2])}
+	case "getallpagename" { &wiki_getallpagename()}
+	else{ die("test-gitmw.pl ERROR: wrong argument")}
+}
+
-- 
1.7.10.2.568.g4c26a3a
