From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 3/3] git-svn: fix svn fetch erroneously recreating empty dir placeholder deleted earlier, try #2
Date: Mon, 29 Apr 2013 00:11:02 +0400
Message-ID: <991177798.20130429001102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 28 22:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWXxm-0005Os-1h
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 22:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab3D1UMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 16:12:42 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:52577 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab3D1UMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 16:12:41 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so4225198lbh.20
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:x-priority:message-id:to:cc:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=FVaH4o6EZ/cnPZOBRBko4BHTU1FxL5Q3MnXYLUFrB14=;
        b=v4bDlrEBBl7NkGT+YtiL0v/bWIXdbfBUrCrEw/y+O64p3/OXRwt12zMJZbUctyjCA5
         UQsPmniCObxHKCT3u5Xl24U6ypY3ZMEDhX/qWVvkXMa6cDFPoPeBHdgNTmSUqvUFt2aW
         9p1KshKb+Q8wOW2QU3FTI8AbmIDMmTehaUpCVPcWD8N/aXGxviHj7lWoI8I+RdD64RZe
         Ne2lyN+3mlqn7r5zS67R5XaDznHD3r+wSEtzL45dCtU8PGhW3GqBwNvS+PDL0I5VsH9K
         8qx5CjkUugZlyNh0O+QsRzsT3NcNuKquV+08lLNITuArR12sws544/dqTpThr7z5aPOA
         OZtA==
X-Received: by 10.152.5.106 with SMTP id r10mr25936108lar.18.1367179959875;
        Sun, 28 Apr 2013 13:12:39 -0700 (PDT)
Received: from [192.168.0.78] (92-100-235-219.dynamic.avangarddsl.ru. [92.100.235.219])
        by mx.google.com with ESMTPSA id c15sm963737lbj.17.2013.04.28.13.12.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 28 Apr 2013 13:12:39 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222753>

The Fetcher accumulates deleted paths in an array and doesn't reset the
array on next commit. This causes different results when interrupting
and resuming the fetch.
When --preserve-empty-dirs flag is used, a path in the array can be
erroneously treated as just deleted (although it was deleted in the
previous commit) and cause the creation of an empty dir placeholder.
---
 perl/Git/SVN/Fetcher.pm                |  1 +
 t/t9160-git-svn-preserve-empty-dirs.sh | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 4f96076..e658889 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -19,6 +19,7 @@ sub new {
 	my ($class, $git_svn, $switch_path) = @_;
 	my $self = SVN::Delta::Editor->new;
 	bless $self, $class;
+	@deleted_gpath = ();
 	if (exists $git_svn->{last_commit}) {
 		$self->{c} = $git_svn->{last_commit};
 		$self->{empty_symlinks} =
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 43b1852..d50314d 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -15,18 +15,27 @@ say 'define NO_SVN_TESTS to skip git svn tests'
 GIT_REPO=git-svn-repo
 
 test_expect_success 'initialize source svn repo containing empty dirs' '
+	#exec 1>/dev/tty 2>&1
 	svn_cmd mkdir -m x "$svnrepo"/trunk &&
 	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
 	(
 		cd "$SVN_TREE" &&
-		mkdir -p 1 2 3/a 3/b 4 5 6 &&
+		mkdir -p 1 2 3/a 3/b 4 5 6 7 &&
 		echo "First non-empty file"  > 2/file1.txt &&
 		echo "Second non-empty file" > 2/file2.txt &&
 		echo "Third non-empty file"  > 3/a/file1.txt &&
 		echo "Fourth non-empty file" > 3/b/file1.txt &&
-		svn_cmd add 1 2 3 4 5 6 &&
+		echo "x" > 7/file.txt &&
+		svn_cmd add 1 2 3 4 5 6 7 &&
 		svn_cmd commit -m "initial commit" &&
 
+		svn_cmd del 7/file.txt &&
+		svn_cmd commit -m "delete last entry in directory" &&
+		svn_cmd up &&
+
+		svn_cmd del 7 &&
+		svn_cmd commit -m "delete empty dir that had files in it; subsequent commits should not recreate it" &&
+
 		mkdir 4/a &&
 		svn_cmd add 4/a &&
 		svn_cmd commit -m "nested empty directory" &&
@@ -60,6 +69,11 @@ test_expect_success 'clone svn repo with --preserve-empty-dirs --stdlayout' '
 	git svn clone "$svnrepo" --preserve-empty-dirs --stdlayout "$GIT_REPO"
 '
 
+# "$GIT_REPO"/7/ should not be recreated
+test_expect_success 'no recreating empty dir deleted earlier' '
+	test_must_fail test -d "$GIT_REPO"/7/
+'
+
 # "$GIT_REPO"/1 should only contain the placeholder file.
 test_expect_success 'directory empty from inception' '
 	test -f "$GIT_REPO"/1/.gitignore &&
-- 
1.8.1.5
