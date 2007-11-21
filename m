From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 3/3 v3] git-svn: info --url [path]
Date: Wed, 21 Nov 2007 11:57:19 -0800
Message-ID: <1195675039-26746-4-git-send-email-ddkilzer@kilzer.net>
References: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net>
 <1195675039-26746-2-git-send-email-ddkilzer@kilzer.net>
 <1195675039-26746-3-git-send-email-ddkilzer@kilzer.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuviQ-00055F-Oi
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 20:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbXKUT50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 14:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbXKUT5Z
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 14:57:25 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:52159 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173AbXKUT5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 14:57:21 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id 69F1F19D7A23;
	Wed, 21 Nov 2007 11:57:21 -0800 (PST)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 4DA852808A;
	Wed, 21 Nov 2007 11:57:21 -0800 (PST)
X-AuditID: 11807130-a7bacbb000006ed1-fe-47448da13a56
Received: from localhost.localdomain (unknown [17.151.86.253])
	by relay11.apple.com (Apple SCV relay) with ESMTP id EF83828087;
	Wed, 21 Nov 2007 11:57:20 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1195675039-26746-3-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65695>

Return the svn URL for the given path, or return the svn
repository URL if no path is given.

Added 18 tests to t/t9119-git-svn-info.sh.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 Documentation/git-svn.txt |    3 +-
 git-svn.perl              |    9 +++-
 t/t9119-git-svn-info.sh   |   93 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c3fc878..918a992 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -196,7 +196,8 @@ Any other arguments are passed directly to `git log'
 'info'::
 	Shows information about a file or directory similar to what
 	`svn info' provides.  Does not currently support a -r/--revision
-	argument.
+	argument.  Use the --url option to output only the value of the
+	'URL:' field.
 
 --
 
diff --git a/git-svn.perl b/git-svn.perl
index be9290c..62801c8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -65,7 +65,7 @@ my ($_stdin, $_help, $_edit,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
-	$_prefix, $_no_checkout, $_verbose);
+	$_prefix, $_no_checkout, $_url, $_verbose);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -181,7 +181,7 @@ my %cmd = (
 	'info' => [ \&cmd_info,
 		    "Show info about the latest SVN revision
 		     on the current branch",
-		    { } ],
+		    { 'url' => \$_url, } ],
 );
 
 my $cmd;
@@ -773,6 +773,11 @@ sub cmd_info {
 	}
 	my $full_url = $url . ($path eq "." ? "" : "/$path");
 
+	if ($_url) {
+		print $full_url, "\n";
+		return;
+	}
+
 	my $result = "Path: $path\n";
 	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
 	$result .= "URL: " . $full_url . "\n";
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index edd64d6..e81457f 100644
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -44,30 +44,51 @@ test_expect_success 'info' "
 	git-diff expected.info actual.info
 	"
 
+test_expect_success 'info --url' '
+	test $(cd gitwc; git-svn info --url) = $svnrepo
+	'
+
 test_expect_success 'info .' "
 	(cd svnwc; svn info .) > expected.info-dot &&
 	(cd gitwc; git-svn info .) > actual.info-dot &&
 	git-diff expected.info-dot actual.info-dot
 	"
 
+test_expect_success 'info --url .' '
+	test $(cd gitwc; git-svn info --url .) = $svnrepo
+	'
+
 test_expect_success 'info file' "
 	(cd svnwc; svn info file) > expected.info-file &&
 	(cd gitwc; git-svn info file) > actual.info-file &&
 	git-diff expected.info-file actual.info-file
 	"
 
+test_expect_success 'info --url file' '
+	test $(cd gitwc; git-svn info --url file) = "$svnrepo/file"
+	'
+
 test_expect_success 'info directory' "
 	(cd svnwc; svn info directory) > expected.info-directory &&
 	(cd gitwc; git-svn info directory) > actual.info-directory &&
 	git-diff expected.info-directory actual.info-directory
 	"
 
+test_expect_success 'info --url directory' '
+	test $(cd gitwc; git-svn info --url directory) = "$svnrepo/directory"
+	'
+
 test_expect_success 'info symlink-file' "
 	(cd svnwc; svn info symlink-file) > expected.info-symlink-file &&
 	(cd gitwc; git-svn info symlink-file) > actual.info-symlink-file &&
 	git-diff expected.info-symlink-file actual.info-symlink-file
 	"
 
+test_expect_success 'info --url symlink-file' '
+	test $(cd gitwc; git-svn info --url symlink-file) \
+	     = "$svnrepo/symlink-file"
+	'
+
 test_expect_success 'info symlink-directory' "
 	(cd svnwc; svn info symlink-directory) \
 		> expected.info-symlink-directory &&
@@ -76,6 +97,11 @@ test_expect_success 'info symlink-directory' "
 	git-diff expected.info-symlink-directory actual.info-symlink-directory
 	"
 
+test_expect_success 'info --url symlink-directory' '
+	test $(cd gitwc; git-svn info --url symlink-directory) \
+	     = "$svnrepo/symlink-directory"
+	'
+
 test_expect_success 'info added-file' "
 	echo two > gitwc/added-file &&
 	cd gitwc &&
@@ -91,6 +117,11 @@ test_expect_success 'info added-file' "
 	git-diff expected.info-added-file actual.info-added-file
 	"
 
+test_expect_success 'info --url added-file' '
+	test $(cd gitwc; git-svn info --url added-file) \
+	     = "$svnrepo/added-file"
+	'
+
 test_expect_success 'info added-directory' "
 	mkdir gitwc/added-directory svnwc/added-directory &&
 	ptouch gitwc/added-directory svnwc/added-directory &&
@@ -108,6 +139,11 @@ test_expect_success 'info added-directory' "
 	git-diff expected.info-added-directory actual.info-added-directory
 	"
 
+test_expect_success 'info --url added-directory' '
+	test $(cd gitwc; git-svn info --url added-directory) \
+	     = "$svnrepo/added-directory"
+	'
+
 test_expect_success 'info added-symlink-file' "
 	cd gitwc &&
 		ln -s added-file added-symlink-file &&
@@ -126,6 +162,11 @@ test_expect_success 'info added-symlink-file' "
 		 actual.info-added-symlink-file
 	"
 
+test_expect_success 'info --url added-symlink-file' '
+	test $(cd gitwc; git-svn info --url added-symlink-file) \
+	     = "$svnrepo/added-symlink-file"
+	'
+
 test_expect_success 'info added-symlink-directory' "
 	cd gitwc &&
 		ln -s added-directory added-symlink-directory &&
@@ -144,6 +185,11 @@ test_expect_success 'info added-symlink-directory' "
 		 actual.info-added-symlink-directory
 	"
 
+test_expect_success 'info --url added-symlink-directory' '
+	test $(cd gitwc; git-svn info --url added-symlink-directory) \
+	     = "$svnrepo/added-symlink-directory"
+	'
+
 # The next few tests replace the "Text Last Updated" value with a
 # placeholder since git doesn't have a way to know the date that a
 # now-deleted file was last checked out locally.  Internally it
@@ -165,6 +211,11 @@ test_expect_success 'info deleted-file' "
 	git-diff expected.info-deleted-file actual.info-deleted-file
 	"
 
+test_expect_success 'info --url file (deleted)' '
+	test $(cd gitwc; git-svn info --url file) \
+	     = "$svnrepo/file"
+	'
+
 test_expect_success 'info deleted-directory' "
 	cd gitwc &&
 		git rm -r -f directory > /dev/null &&
@@ -181,6 +232,11 @@ test_expect_success 'info deleted-directory' "
 	git-diff expected.info-deleted-directory actual.info-deleted-directory
 	"
 
+test_expect_success 'info --url directory (deleted)' '
+	test $(cd gitwc; git-svn info --url directory) \
+	     = "$svnrepo/directory"
+	'
+
 test_expect_success 'info deleted-symlink-file' "
 	cd gitwc &&
 		git rm -f symlink-file > /dev/null &&
@@ -198,6 +254,11 @@ test_expect_success 'info deleted-symlink-file' "
 		 actual.info-deleted-symlink-file
 	"
 
+test_expect_success 'info --url symlink-file (deleted)' '
+	test $(cd gitwc; git-svn info --url symlink-file) \
+	     = "$svnrepo/symlink-file"
+	'
+
 test_expect_success 'info deleted-symlink-directory' "
 	cd gitwc &&
 		git rm -f symlink-directory > /dev/null &&
@@ -215,6 +276,11 @@ test_expect_success 'info deleted-symlink-directory' "
 		 actual.info-deleted-symlink-directory
 	"
 
+test_expect_success 'info --url symlink-directory (deleted)' '
+	test $(cd gitwc; git-svn info --url symlink-directory) \
+	     = "$svnrepo/symlink-directory"
+	'
+
 # NOTE: git does not have the concept of replaced objects,
 # so we can't test for files in that state.
 
@@ -227,6 +293,12 @@ test_expect_success 'info unknown-file' "
 	git-diff expected.info-unknown-file actual.info-unknown-file
 	"
 
+test_expect_success 'info --url unknown-file' '
+	test -z $(cd gitwc; git-svn info --url unknown-file \
+			2> ../actual.info--url-unknown-file) &&
+	git-diff expected.info-unknown-file actual.info--url-unknown-file
+	'
+
 test_expect_success 'info unknown-directory' "
 	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
 	ptouch gitwc/unknown-directory svnwc/unknown-directory &&
@@ -238,6 +310,13 @@ test_expect_success 'info unknown-directory' "
 	git-diff expected.info-unknown-directory actual.info-unknown-directory
 	"
 
+test_expect_success 'info --url unknown-directory' '
+	test -z $(cd gitwc; git-svn info --url unknown-directory \
+			2> ../actual.info--url-unknown-directory) &&
+	git-diff expected.info-unknown-directory \
+		 actual.info--url-unknown-directory
+	'
+
 test_expect_success 'info unknown-symlink-file' "
 	cd gitwc &&
 		ln -s unknown-file unknown-symlink-file &&
@@ -254,6 +333,13 @@ test_expect_success 'info unknown-symlink-file' "
 		 actual.info-unknown-symlink-file
 	"
 
+test_expect_success 'info --url unknown-symlink-file' '
+	test -z $(cd gitwc; git-svn info --url unknown-symlink-file \
+			2> ../actual.info--url-unknown-symlink-file) &&
+	git-diff expected.info-unknown-symlink-file \
+		 actual.info--url-unknown-symlink-file
+	'
+
 test_expect_success 'info unknown-symlink-directory' "
 	cd gitwc &&
 		ln -s unknown-directory unknown-symlink-directory &&
@@ -271,4 +357,11 @@ test_expect_success 'info unknown-symlink-directory' "
 		 actual.info-unknown-symlink-directory
 	"
 
+test_expect_success 'info --url unknown-symlink-directory' '
+	test -z $(cd gitwc; git-svn info --url unknown-symlink-directory \
+			2> ../actual.info--url-unknown-symlink-directory) &&
+	git-diff expected.info-unknown-symlink-directory \
+		 actual.info--url-unknown-symlink-directory
+	'
+
 test_done
-- 
1.5.3.4
