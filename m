From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 5/6] git svn info: make info relative to the current directory
Date: Tue, 26 Aug 2008 21:32:36 +0200
Message-ID: <1219779157-31602-6-git-send-email-trast@student.ethz.ch>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-2-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-3-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-4-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-5-git-send-email-trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 21:35:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY4JV-0004pl-Ee
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825AbYHZTct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759588AbYHZTct
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:32:49 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37853 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759620AbYHZTcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:32:45 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:37 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:37 +0200
X-Mailer: git-send-email 1.6.0.1.169.g494a
In-Reply-To: <1219779157-31602-5-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 26 Aug 2008 19:32:37.0364 (UTC) FILETIME=[7F090340:01C907B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93811>

Previously 'git svn info <path>' would always treat the <path> as
relative to the working directory root, with a default of ".".  This
does not match the behaviour of 'svn info'.  Prepend $(git rev-parse
--show-prefix) to the path used inside cmd_info to make it relative to
the current working directory.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I realise that this might break things for people who rely on the
current behaviour, but looking at the tests, the goal is to imitate
'svn info' as closely as possible.  This also matches my use case of
'svn info || git svn info', which is why I stumbled over the problem
in the first place.


 git-svn.perl            |    5 +++--
 t/t9119-git-svn-info.sh |   14 +++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7a1d26d..46bc0b0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -805,6 +805,7 @@ sub cmd_commit_diff {
 
 sub cmd_info {
 	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
+	my $fullpath = canonicalize_path($cmd_dir_prefix . $path);
 	if (exists $_[1]) {
 		die "Too many arguments specified\n";
 	}
@@ -825,7 +826,7 @@ sub cmd_info {
 	# canonicalize_path() will return "" to make libsvn 1.5.x happy,
 	$path = "." if $path eq "";
 
-	my $full_url = $url . ($path eq "." ? "" : "/$path");
+	my $full_url = $url . ($fullpath eq "" ? "" : "/$fullpath");
 
 	if ($_url) {
 		print $full_url, "\n";
@@ -861,7 +862,7 @@ sub cmd_info {
 	}
 
 	my ($lc_author, $lc_rev, $lc_date_utc);
-	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $path);
+	my @args = Git::SVN::Log::git_svn_log_cmd($rev, $rev, "--", $fullpath);
 	my $log = command_output_pipe(@args);
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 821507d..8709bcc 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -45,12 +45,18 @@ test_expect_success 'setup repository and import' '
 		ln -s directory symlink-directory &&
 		svn import -m "initial" . "$svnrepo" &&
 	cd .. &&
+	svn co "$svnrepo" svnwc &&
+	cd svnwc &&
+		echo foo > foo &&
+		svn add foo &&
+		svn commit -m "change outside directory" &&
+		svn update &&
+	cd .. &&
 	mkdir gitwc &&
 	cd gitwc &&
 		git-svn init "$svnrepo" &&
 		git-svn fetch &&
 	cd .. &&
-	svn co "$svnrepo" svnwc &&
 	ptouch gitwc/file svnwc/file &&
 	ptouch gitwc/directory svnwc/directory &&
 	ptouch gitwc/symlink-file svnwc/symlink-file &&
@@ -93,6 +99,12 @@ test_expect_success 'info directory' "
 	test_cmp expected.info-directory actual.info-directory
 	"
 
+test_expect_success 'info inside directory' "
+	(cd svnwc/directory; svn info) > expected.info-inside-directory &&
+	(cd gitwc/directory; git-svn info) > actual.info-inside-directory &&
+	test_cmp expected.info-inside-directory actual.info-inside-directory
+	"
+
 test_expect_success 'info --url directory' '
 	test "$(cd gitwc; git-svn info --url directory)" = "$svnrepo/directory"
 	'
-- 
1.6.0.1.96.g9307e.dirty
