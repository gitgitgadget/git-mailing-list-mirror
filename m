From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 6/6] git svn info: always quote URLs in 'info' output
Date: Tue, 26 Aug 2008 21:32:37 +0200
Message-ID: <1219779157-31602-7-git-send-email-trast@student.ethz.ch>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-2-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-3-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-4-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-5-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-6-git-send-email-trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 21:34:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY4JW-0004pl-3Y
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758651AbYHZTcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759600AbYHZTcu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:32:50 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37853 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759171AbYHZTcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:32:48 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:37 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:37 +0200
X-Mailer: git-send-email 1.6.0.1.169.g494a
In-Reply-To: <1219779157-31602-6-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 26 Aug 2008 19:32:37.0536 (UTC) FILETIME=[7F234200:01C907B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93808>

Changes 'git svn info' to always URL-escape the 'URL' and 'Repository'
fields and --url output, like SVN (at least 1.5) does.

Note that reusing the escape_url() further down in Git::SVN::Ra is not
possible because it only triggers for http(s) URLs.  I did not know
whether extending it to all schemes would break SVN access anywhere,
so I made a new one that quotes in all schemes.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I wasn't sure if I should quote --url too.  It is not an 'svn info'
feature, so we could do it either way.  Eventually I decided for the
change to be consistent with the 'URL:' field of normal output.  If
this breaks scripts for someone, I can change it back.

 git-svn.perl            |   25 ++++++++++++++++++++++---
 t/t9119-git-svn-info.sh |   30 ++++++++++++++++--------------
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 46bc0b0..11ff813 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -803,6 +803,25 @@ sub cmd_commit_diff {
 	}
 }
 
+sub escape_uri_only {
+	my ($uri) = @_;
+	my @tmp;
+	foreach (split m{/}, $uri) {
+		s/([^\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
+		push @tmp, $_;
+	}
+	join('/', @tmp);
+}
+
+sub escape_url {
+	my ($url) = @_;
+	if ($url =~ m#^([^:]+)://([^/]*)(.*)$#) {
+		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
+		$url = "$scheme://$domain$uri";
+	}
+	$url;
+}
+
 sub cmd_info {
 	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
 	my $fullpath = canonicalize_path($cmd_dir_prefix . $path);
@@ -829,18 +848,18 @@ sub cmd_info {
 	my $full_url = $url . ($fullpath eq "" ? "" : "/$fullpath");
 
 	if ($_url) {
-		print $full_url, "\n";
+		print escape_url($full_url), "\n";
 		return;
 	}
 
 	my $result = "Path: $path\n";
 	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
-	$result .= "URL: " . $full_url . "\n";
+	$result .= "URL: " . escape_url($full_url) . "\n";
 
 	eval {
 		my $repos_root = $gs->repos_root;
 		Git::SVN::remove_username($repos_root);
-		$result .= "Repository Root: $repos_root\n";
+		$result .= "Repository Root: " . escape_url($repos_root) . "\n";
 	};
 	if ($@) {
 		$result .= "Repository Root: (offline)\n";
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 8709bcc..1811010 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -34,6 +34,8 @@ ptouch() {
 	' "`svn info $2 | grep '^Text Last Updated:'`" "$1"
 }
 
+quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"
+
 test_expect_success 'setup repository and import' '
 	mkdir info &&
 	cd info &&
@@ -70,7 +72,7 @@ test_expect_success 'info' "
 	"
 
 test_expect_success 'info --url' '
-	test "$(cd gitwc; git-svn info --url)" = "$svnrepo"
+	test "$(cd gitwc; git-svn info --url)" = "$quoted_svnrepo"
 	'
 
 test_expect_success 'info .' "
@@ -80,7 +82,7 @@ test_expect_success 'info .' "
 	"
 
 test_expect_success 'info --url .' '
-	test "$(cd gitwc; git-svn info --url .)" = "$svnrepo"
+	test "$(cd gitwc; git-svn info --url .)" = "$quoted_svnrepo"
 	'
 
 test_expect_success 'info file' "
@@ -90,7 +92,7 @@ test_expect_success 'info file' "
 	"
 
 test_expect_success 'info --url file' '
-	test "$(cd gitwc; git-svn info --url file)" = "$svnrepo/file"
+	test "$(cd gitwc; git-svn info --url file)" = "$quoted_svnrepo/file"
 	'
 
 test_expect_success 'info directory' "
@@ -106,7 +108,7 @@ test_expect_success 'info inside directory' "
 	"
 
 test_expect_success 'info --url directory' '
-	test "$(cd gitwc; git-svn info --url directory)" = "$svnrepo/directory"
+	test "$(cd gitwc; git-svn info --url directory)" = "$quoted_svnrepo/directory"
 	'
 
 test_expect_success 'info symlink-file' "
@@ -117,7 +119,7 @@ test_expect_success 'info symlink-file' "
 
 test_expect_success 'info --url symlink-file' '
 	test "$(cd gitwc; git-svn info --url symlink-file)" \
-	     = "$svnrepo/symlink-file"
+	     = "$quoted_svnrepo/symlink-file"
 	'
 
 test_expect_success 'info symlink-directory' "
@@ -130,7 +132,7 @@ test_expect_success 'info symlink-directory' "
 
 test_expect_success 'info --url symlink-directory' '
 	test "$(cd gitwc; git-svn info --url symlink-directory)" \
-	     = "$svnrepo/symlink-directory"
+	     = "$quoted_svnrepo/symlink-directory"
 	'
 
 test_expect_success 'info added-file' "
@@ -150,7 +152,7 @@ test_expect_success 'info added-file' "
 
 test_expect_success 'info --url added-file' '
 	test "$(cd gitwc; git-svn info --url added-file)" \
-	     = "$svnrepo/added-file"
+	     = "$quoted_svnrepo/added-file"
 	'
 
 test_expect_success 'info added-directory' "
@@ -172,7 +174,7 @@ test_expect_success 'info added-directory' "
 
 test_expect_success 'info --url added-directory' '
 	test "$(cd gitwc; git-svn info --url added-directory)" \
-	     = "$svnrepo/added-directory"
+	     = "$quoted_svnrepo/added-directory"
 	'
 
 test_expect_success 'info added-symlink-file' "
@@ -195,7 +197,7 @@ test_expect_success 'info added-symlink-file' "
 
 test_expect_success 'info --url added-symlink-file' '
 	test "$(cd gitwc; git-svn info --url added-symlink-file)" \
-	     = "$svnrepo/added-symlink-file"
+	     = "$quoted_svnrepo/added-symlink-file"
 	'
 
 test_expect_success 'info added-symlink-directory' "
@@ -218,7 +220,7 @@ test_expect_success 'info added-symlink-directory' "
 
 test_expect_success 'info --url added-symlink-directory' '
 	test "$(cd gitwc; git-svn info --url added-symlink-directory)" \
-	     = "$svnrepo/added-symlink-directory"
+	     = "$quoted_svnrepo/added-symlink-directory"
 	'
 
 # The next few tests replace the "Text Last Updated" value with a
@@ -244,7 +246,7 @@ test_expect_success 'info deleted-file' "
 
 test_expect_success 'info --url file (deleted)' '
 	test "$(cd gitwc; git-svn info --url file)" \
-	     = "$svnrepo/file"
+	     = "$quoted_svnrepo/file"
 	'
 
 test_expect_success 'info deleted-directory' "
@@ -265,7 +267,7 @@ test_expect_success 'info deleted-directory' "
 
 test_expect_success 'info --url directory (deleted)' '
 	test "$(cd gitwc; git-svn info --url directory)" \
-	     = "$svnrepo/directory"
+	     = "$quoted_svnrepo/directory"
 	'
 
 test_expect_success 'info deleted-symlink-file' "
@@ -287,7 +289,7 @@ test_expect_success 'info deleted-symlink-file' "
 
 test_expect_success 'info --url symlink-file (deleted)' '
 	test "$(cd gitwc; git-svn info --url symlink-file)" \
-	     = "$svnrepo/symlink-file"
+	     = "$quoted_svnrepo/symlink-file"
 	'
 
 test_expect_success 'info deleted-symlink-directory' "
@@ -309,7 +311,7 @@ test_expect_success 'info deleted-symlink-directory' "
 
 test_expect_success 'info --url symlink-directory (deleted)' '
 	test "$(cd gitwc; git-svn info --url symlink-directory)" \
-	     = "$svnrepo/symlink-directory"
+	     = "$quoted_svnrepo/symlink-directory"
 	'
 
 # NOTE: git does not have the concept of replaced objects,
-- 
1.6.0.1.96.g9307e.dirty
