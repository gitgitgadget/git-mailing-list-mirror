From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCH 2/3] Test environment of git-remote-mw
Date: Tue,  5 Jun 2012 15:25:55 +0200
Message-ID: <1338902756-4162-2-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <4FCE07A5.9020001@ensimag.imag.fr>
 <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Cc: Matthieu.Moy@imag.fr, simon.cathebras@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, Guillaume.Sasdy@ensimag.imag.fr,
	Julien.Khayat@ensimag.imag.fr, Simon.Perrat@ensimag.imag.fr,
	peff@peff.net, gitster@pobox.com,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 15:26:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbtmE-0004Zt-QC
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 15:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934126Ab2FEN0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 09:26:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43735 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934116Ab2FEN0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 09:26:18 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q55DHNkX014300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 15:17:23 +0200
Received: from Hithlum.grenet.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q55DPvHe027034;
	Tue, 5 Jun 2012 15:25:58 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Jun 2012 15:17:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55DHNkX014300
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339507043.83654@0zU3A2cDCKjnU8lt85dkTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199240>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

In order to test git-remote-mediawiki, we need a package of functions
to manage a MediaWiki: edit a page, remove a page, fetch a page,
fetch all pages on a given wiki.

We also need functions to compare the content of directories.

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
---
 t/test-gitmw-lib.sh | 105 +++++++++++++++++++++++++++++++
 t/test-gitmw.pl     | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 281 insertions(+)
 create mode 100755 t/test-gitmw.pl

diff --git a/t/test-gitmw-lib.sh b/t/test-gitmw-lib.sh
index cebef24..cb5ba19 100755
--- a/t/test-gitmw-lib.sh
+++ b/t/test-gitmw-lib.sh
@@ -26,6 +26,111 @@ DB_INSTALL_SCRIPT="db_install.php"
 WIKI_ADMIN="WikiAdmin"
 WIKI_PASSW="AdminPass"
 
+wiki_getpage () {
+	$GIT_BUILD_DIR/t/test-gitmw.pl get_page "$@"
+}
+
+wiki_delete_page () {
+	$GIT_BUILD_DIR/t/test-gitmw.pl delete_page "$@"
+}
+
+wiki_editpage () {
+	$GIT_BUILD_DIR/t/test-gitmw.pl edit_page "$@"
+}
+
+die () {
+	die_with_status 1 "$@"
+}
+
+die_with_status () {
+	status=$1
+	shift
+	echo >&2 "$*"
+	exit "$status"
+}
+
+# git_diff_directories <dir_git> <dir_wiki>
+#
+# Compare the contents of directories <dir_git> and <dir_wiki> with diff
+# and dies if they do not match. The program will
+# not look into .git in the process.
+# Warning: the first argument MUST be the directory containing the git data
+git_diff_directories () {
+	mkdir -p "$1_tmp"
+	cp "$1"/*.mw "$1_tmp"
+
+	diff -r -b "$1_tmp" "$2"
+
+	if test $? -ne 0
+	then
+		rm -rf "$1_tmp"
+		die "test failed: directories $1 and $2 do not match"
+	fi
+	rm -rf "$1_tmp"
+}
+
+
+# wiki_check_content <file_name> <page_name> 
+#
+# Compares the contents of the file <file_name> and the wiki page
+# <page_name> and exits with error 1 if they do not match.
+wiki_check_content () {
+	mkdir -p wiki_tmp
+	wiki_getpage "$2" wiki_tmp
+	diff -b "$1" wiki_tmp/"$2".mw
+	if test $? -ne 0
+	then
+		rm -rf wiki_tmp
+		die "ERROR: file $2 not found on wiki"
+	fi
+	rm -rf wiki_tmp
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
+		rm "$1".mw
+	else
+		die "test failed: file $1 not found on wiki"
+	fi
+}
+
+# wiki_getallpagename
+# 
+# Fetch the name of each page on the wiki.
+wiki_getallpagename () {
+	$GIT_BUILD_DIR/t/test-gitmw.pl getallpagename
+}
+
+# wiki_getallpagecategory <category>
+# 
+# Fetch the name of each page belonging to <category> on the wiki.
+wiki_getallpagecategory () {
+	$GIT_BUILD_DIR/t/test-gitmw.pl getallpagename "$@"
+}
+
+# wiki_getallpage <dest_dir> [<category>]
+#
+# Fetch all the pages from the wiki and place them in the directory
+# <dest_dir>.
+# If <category> is define, then wiki_getallpage fetch the pages included
+# in <category>.
+wiki_getallpage () {
+	if test -z "$2";
+	then
+		wiki_getallpagename
+	else
+		wiki_getallpagecategory "$2"
+	fi
+	mkdir -p "$1"
+	while read -r line; do
+		wiki_getpage "$line" $1;
+	done < all.txt
 }
 
 # Create the SQLite database of the MediaWiki. If the database file already
diff --git a/t/test-gitmw.pl b/t/test-gitmw.pl
new file mode 100755
index 0000000..ff7f63e
--- /dev/null
+++ b/t/test-gitmw.pl
@@ -0,0 +1,176 @@
+#!/usr/bin/perl -w
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
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
+	# Replace spaces by underscore in the page name
+	$pagename=$page->{'title'};
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
+	} else {
+		die "no page with such name found: $pagename\n";
+	}
+}
+
+# wiki_editpage <wiki_page> <wiki_content> <wiki_append> [<category>]
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
+	
+	# Eventually, add this page to a category.
+	if (defined($_[3])) {
+		my $category_name="[[Category:$_[3]]]";
+		$text="$text\n $category_name"
+	}
+	$mw->edit( { action => 'edit', title => $wiki_page, text => "$text"} );
+}
+
+
+# wiki_getallpagename [<category>]
+#
+# Fetch all pages of the wiki referenced by the global variable $mw
+# and print the names of each one in the file all.txt with a new line
+# ("\n") between these.
+# If the argument <category> is defined, then this function get only the pages 
+# belonging to <category>.
+sub wiki_getallpagename {
+	# fetch the pages of the wiki
+	if (defined($_[0])) {
+		$mw->list ( { action => 'query',
+				list => 'categorymembers',
+				cmtitle => "Category:$_[0]",
+				cmnamespace => 0,
+				cmlimit=> 500 },
+			{ max => 4, hook => \&cat_names } )
+			|| die $mw->{error}->{code}.": ".$mw->{error}->{details};
+	} else {
+		$mw->list ( { action => 'query',
+				list => 'allpages',
+				#cmnamespace => 0,
+				cmlimit=> 500 },
+			{ max => 4, hook => \&cat_names } )
+			|| die $mw->{error}->{code}.": ".$mw->{error}->{details};
+	}
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
+
+	&wiki_login($wiki_admin,$wiki_admin_pass);
+
+switch ($fct_to_call) {
+	case "get_page" { &wiki_getpage(@ARGV)}
+	case "delete_page" { &wiki_delete_page(@ARGV)}
+	case "edit_page" { &wiki_editpage(@ARGV)}
+	case "getallpagename" { &wiki_getallpagename(@ARGV)}
+	else { die("test-gitmw.pl ERROR: wrong argument")}
+}
+
-- 
1.7.10.2.552.gaa3bb87
