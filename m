From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 3/3] git-svn: info --url [path]
Date: Tue, 20 Nov 2007 22:43:19 -0800
Message-ID: <1195627399-25209-4-git-send-email-ddkilzer@kilzer.net>
References: <20071117225402.GC28755@muzzle>
 <1195627399-25209-1-git-send-email-ddkilzer@kilzer.net>
 <1195627399-25209-2-git-send-email-ddkilzer@kilzer.net>
 <1195627399-25209-3-git-send-email-ddkilzer@kilzer.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujJH-0003I2-4G
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbXKUGn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbXKUGn1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:43:27 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:55951 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbXKUGnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:43:21 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 2F3C519CCE03;
	Tue, 20 Nov 2007 22:43:21 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 10DC42804F;
	Tue, 20 Nov 2007 22:43:21 -0800 (PST)
X-AuditID: 1180711d-a22c1bb0000008bf-d9-4743d3885cdd
Received: from localhost.localdomain (unknown [17.151.112.145])
	by relay13.apple.com (Apple SCV relay) with ESMTP id C7B0E28057;
	Tue, 20 Nov 2007 22:43:20 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1195627399-25209-3-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65598>

Return the svn URL for the given path, or return the svn
repository URL if no path is given.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 git-svn.perl            |    9 +++++++--
 t/t9117-git-svn-info.sh |    4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

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
