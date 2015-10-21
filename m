From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: gracefully handle symlinks to directories
Date: Wed, 21 Oct 2015 01:04:33 -0700
Message-ID: <1445414673-15307-1-git-send-email-davvid@gmail.com>
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 10:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZooO5-0005yD-4x
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 10:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbbJUIEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 04:04:39 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36740 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbbJUIEg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 04:04:36 -0400
Received: by pacfv9 with SMTP id fv9so49709720pac.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NaayUy9J0rue1Vq+aRfr8c/yXKQKSamz1Z27f4ItG/g=;
        b=zgEga1pxnC1298y2RiE4ZX4eqNZF2Ba56OGtrMt4SYd/TygsxLqdbpw24TPMU8Jb/L
         XJ615wI0pE2zKp5uPI4UBFgP7JiRnFSgTqH6KQPSj0mYKAppFaehe8VOjJe5OH+RAwt7
         9iYspilF9WPrExKFW4HEWJj/ZhVdkqLS/eUrvsI5ZQTGdjxlR0XPGfTqy2fdgi9PNaCM
         3pkueTcL8q3ksqeuvA5AX6YxmtaRLiQZypQGXgjfw7RQC8K3DDqRRKer1+/GT+ARepZ1
         cZJjKQYem8KiTjTs99yUH9k6BSJDjTH1pJI3I4GKBACgQk7L2vNN3XkaU71Xwqk4GjgM
         mSUQ==
X-Received: by 10.68.69.45 with SMTP id b13mr8981638pbu.67.1445414675829;
        Wed, 21 Oct 2015 01:04:35 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id im9sm7689822pbc.1.2015.10.21.01.04.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Oct 2015 01:04:35 -0700 (PDT)
X-Mailer: git-send-email 2.6.2.281.gac28444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279973>

difftool's dir-diff feature was blindly feeding worktree paths
to hash-object without checking whether the path was indeed a
file, causing the feature to fail when repositories contain
symlinks to directories.

Ensure that only files are ever given to hash-object.
Add a test to demonstrate the breakage.

Reported-by: Ismail Badawi <ismail@badawi.io>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl   |  4 +---
 t/t7800-difftool.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 7df7c8a..1abe647 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -70,9 +70,7 @@ sub use_wt_file
 	my ($repo, $workdir, $file, $sha1) = @_;
 	my $null_sha1 = '0' x 40;
 
-	if (! -e "$workdir/$file") {
-		# If the file doesn't exist in the working tree, we cannot
-		# use it.
+	if (! -f "$workdir/$file") {
 		return (0, $null_sha1);
 	}
 
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 48c6e2b..ec8bc8c 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -504,4 +504,23 @@ test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
 	)
 '
 
+test_expect_success PERL,SYMLINKS 'difftool --dir-diff symlinked directories' '
+	git init dirlinks &&
+	(
+		cd dirlinks &&
+		git config diff.tool checktrees &&
+		git config difftool.checktrees.cmd "echo good" &&
+		mkdir foo &&
+		: >foo/bar &&
+		git add foo/bar &&
+		test_commit symlink-one &&
+		ln -s foo link &&
+		git add link &&
+		test_commit symlink-two &&
+		echo good >expect &&
+		git difftool --tool=checktrees --dir-diff HEAD~ >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.6.2.281.gac28444
