From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 3/3 v2] git-svn: info --url [path]
Date: Tue, 20 Nov 2007 22:49:28 -0800
Message-ID: <1195627768-26689-1-git-send-email-ddkilzer@kilzer.net>
References: <1195627399-25209-4-git-send-email-ddkilzer@kilzer.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujP9-0004dW-TC
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbXKUGta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbXKUGta
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:49:30 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:53728 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbXKUGta (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:49:30 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 92AC8191A69A;
	Tue, 20 Nov 2007 22:49:29 -0800 (PST)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 75D5628083;
	Tue, 20 Nov 2007 22:49:29 -0800 (PST)
X-AuditID: 11807134-a4f66bb000001d52-06-4743d4f953a9
Received: from localhost.localdomain (unknown [17.151.112.145])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 25CBB28060;
	Tue, 20 Nov 2007 22:49:29 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1195627399-25209-4-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65600>

Return the svn URL for the given path, or return the svn
repository URL if no path is given.

Added one test to t/t9117-git-svn-info.sh.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---

Added missing documentation change, and tweaked commit log.

 Documentation/git-svn.txt |    2 +-
 git-svn.perl              |    9 +++++++--
 t/t9117-git-svn-info.sh   |    4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c3fc878..295b14b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -196,7 +196,7 @@ Any other arguments are passed directly to `git log'
 'info'::
 	Shows information about a file or directory similar to what
 	`svn info' provides.  Does not currently support a -r/--revision
-	argument.
+	argument.  Use the --url option to output only the 'URL:' field.
 
 --
 
diff --git a/git-svn.perl b/git-svn.perl
index 406ee6f..eaf2187 100755
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
@@ -770,6 +770,11 @@ sub cmd_info {
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
diff --git a/t/t9117-git-svn-info.sh b/t/t9117-git-svn-info.sh
index c7ca006..800d1c4 100644
--- a/t/t9117-git-svn-info.sh
+++ b/t/t9117-git-svn-info.sh
@@ -183,4 +183,8 @@ test_expect_success 'info unknown-symlink-directory' "
 	git-diff ../t9117/expected.info-unknown-symlink-directory -
 	"
 
+test_expect_success 'info --url' '
+	test $(cd gitwc; git-svn info --url) = $svnrepo
+	'
+
 test_done
-- 
1.5.3.4
