From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: Add shorthand URLs for summary and a special html branch
Date: Wed, 3 May 2006 01:25:23 +0200
Message-ID: <20060502232523.GN20847@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 03 01:25:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4FE-0000uX-MQ
	for gcvg-git@gmane.org; Wed, 03 May 2006 01:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWEBXZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 19:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWEBXZ0
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 19:25:26 -0400
Received: from admingilde.org ([213.95.32.146]:45195 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750802AbWEBXZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 19:25:25 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Fb4F9-0001un-FH
	for git@vger.kernel.org; Wed, 03 May 2006 01:25:23 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19438>

gitweb now supports URLs like .../gitweb.cgi/<projectpath> as a shortcut
for the project summary page and .../gitweb.cgi/<projectpath>/<file.html>
to access .html pages in an "html" branch.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 gitweb.cgi |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 56 insertions(+), 4 deletions(-)

05d0376478ccc273d12dbe177cf11c62c86ab848
diff --git a/gitweb.cgi b/gitweb.cgi
index c1bb624..959ca3e 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -20,6 +20,7 @@ my $cgi = new CGI;
 my $version =		"264";
 my $my_url =		$cgi->url();
 my $my_uri =		$cgi->url(-absolute => 1);
+my $my_path =		$cgi->url(-path => 1);
 my $rss_link =		"";
 
 # absolute fs-path which will be prepended to the project path
@@ -42,8 +43,30 @@ # source of projects list
 #my $projects_list =	$projectroot;
 my $projects_list =	"index/index.aux";
 
+
+my ($action, $project, $file_name, $hash);
+
+# rewrite to support direct access to .html files in the "html" branch
+if ($my_path =~ /^$my_url\/(.*\.git)\/?$/) {
+	$action = "summary";
+	$project = validate_input($1);
+} elsif ($my_path =~ /^$my_url\/(.*\.git)\/(.*\.html)$/) {
+	$action = "blob_html";
+	$project = validate_input($1);
+	$file_name = validate_input($2);
+	$hash = "html:$file_name";
+} elsif ($my_path =~ /^$my_url\/(.*\.git)\/(HEAD|objects\/info\/packs|info\/refs|refs\/.*)$/) {
+	$action = "direct_text";
+	$project = validate_input($1);
+	$file_name = validate_input($2);
+} elsif ($my_path =~ /^$my_url\/(.*\.git)\/(objects\/.*)$/) {
+	$action = "direct_object";
+	$project = validate_input($1);
+	$file_name = validate_input($2);
+}
+
 # input validation and dispatch
-my $action = $cgi->param('a');
+$action ||= $cgi->param('a');
 if (defined $action) {
 	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
 		undef $action;
@@ -66,7 +89,7 @@ if (defined $order) {
 	}
 }
 
-my $project = $cgi->param('p');
+$project ||= $cgi->param('p');
 if (defined $project) {
 	$project = validate_input($project);
 	if (!defined($project)) {
@@ -88,7 +111,7 @@ if (defined $project) {
 	exit;
 }
 
-my $file_name = $cgi->param('f');
+$file_name ||= $cgi->param('f');
 if (defined $file_name) {
 	$file_name = validate_input($file_name);
 	if (!defined($file_name)) {
@@ -96,7 +119,7 @@ if (defined $file_name) {
 	}
 }
 
-my $hash = $cgi->param('h');
+$hash ||= $cgi->param('h');
 if (defined $hash) {
 	$hash = validate_input($hash);
 	if (!defined($hash)) {
@@ -167,6 +190,9 @@ if (!defined $action || $action eq "summ
 } elsif ($action eq "blob_plain") {
 	git_blob_plain();
 	exit;
+} elsif ($action eq "blob_html") {
+	git_blob_html();
+	exit;
 } elsif ($action eq "tree") {
 	git_tree();
 	exit;
@@ -203,6 +229,10 @@ if (!defined $action || $action eq "summ
 } elsif ($action eq "tag") {
 	git_tag();
 	exit;
+} elsif ($action eq "direct_text") {
+	git_direct_text();
+} elsif ($action eq "direct_object") {
+	git_direct_object();
 } else {
 	undef $action;
 	die_error(undef, "Unknown action.");
@@ -1423,6 +1453,28 @@ sub git_blob_plain {
 	close $fd;
 }
 
+sub git_blob_html {
+	my $save_as = "$hash";
+	if (defined $file_name) {
+		$save_as = $file_name;
+	}
+	print $cgi->header(-type => "text/html", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"$save_as\"");
+	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or return;
+	undef $/;
+	print <$fd>;
+	$/ = "\n";
+	close $fd;
+}
+
+sub git_direct_text {
+	print $cgi->header(-type => "test/plain");
+	exec("cat", "$projectroot/$project/$file_name");
+}
+sub git_direct_object {
+	print $cgi->header(-type => "application/binary", -expires => "+1y");
+	exec("cat", "$projectroot/$project/$file_name");
+}
+
 sub git_tree {
 	if (!defined $hash) {
 		$hash = git_read_head($project);
-- 
1.3.1.g6ef7


-- 
Martin Waitz
