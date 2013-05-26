From: Kenichi Saita <nitoyon@gmail.com>
Subject: [PATCH] difftool --dir-diff: copy back all files matching the working tree
Date: Mon, 27 May 2013 00:00:46 +0900
Message-ID: <1369580446-32597-1-git-send-email-nitoyon@gmail.com>
Cc: Kenichi Saita <nitoyon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 17:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgcRm-0007aO-Ec
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 17:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab3EZPBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 11:01:18 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:55830 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab3EZPBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 11:01:17 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so5892739pbb.41
        for <git@vger.kernel.org>; Sun, 26 May 2013 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PsDm3v/FwcToW4F/IxhlpR6DIIn2MOok57FzsTcu5aY=;
        b=VGAW9dxD0FF89Yr+WVyeAMkVviHcmXqjH5tbrspByFn86RPdW3PmRmKDqirqO1bTTb
         TEWe09DAbj5kbCplk2Mu6EMWJY4Q9NEh6mxOg/oa3GftPTwNGWMTvUVKHcfuZYTc9ziJ
         Ps05Okch89sk/IX/cHK3pSVd0hhG8Tks628Qd/oHXeFHHLVdDRmXgRWdglVt/O0ufVVn
         OHQIHX3HjTP19/h8L3p05iH1ESqMFEhquvCN+Ip4VaHYX9u+XJtMk3tocosTvaOwtKQg
         HVlVxzlUDXLdsKqtXOzJTuDT4KfDUj1M0E/C6FWnylySMldUCEjpNpqNGdUQZvPhfgSc
         j0tQ==
X-Received: by 10.66.49.104 with SMTP id t8mr23347996pan.65.1369580477490;
        Sun, 26 May 2013 08:01:17 -0700 (PDT)
Received: from localhost.localdomain (144.72.102.121.dy.bbexcite.jp. [121.102.72.144])
        by mx.google.com with ESMTPSA id tb7sm24695240pbc.14.2013.05.26.08.01.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 26 May 2013 08:01:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225551>

After running the user's diff tool, "git difftool --dir-dif --no-symlink"
currently copied back a temporary file to working tree only when a file
contains unstaged changes in the working tree.

Change this behavior so that temporary files are copied back to working
tree whenever the right-hand side of the comparison has the same SHA1
as the file in the working tree.

Signed-off-by: Kenichi Saita <nitoyon@gmail.com>
---
 git-difftool.perl   |    9 ++-------
 t/t7800-difftool.sh |   19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 8a75205..e57d3d1 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -85,13 +85,9 @@ sub exit_cleanup
 
 sub use_wt_file
 {
-	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
+	my ($repo, $workdir, $file, $sha1) = @_;
 	my $null_sha1 = '0' x 40;
 
-	if ($sha1 ne $null_sha1 and not $symlinks) {
-		return 0;
-	}
-
 	if (! -e "$workdir/$file") {
 		# If the file doesn't exist in the working tree, we cannot
 		# use it.
@@ -213,8 +209,7 @@ EOF
 
 		if ($rmode ne $null_mode) {
 			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
-							  $dst_path, $rsha1,
-							  $symlinks);
+							  $dst_path, $rsha1);
 			if ($use) {
 				push @working_tree, $dst_path;
 				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index d46f041..2418528 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -385,6 +385,25 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstage
 	test_cmp actual expect
 '
 
+write_script modify-right-file <<\EOF
+echo "new content" >"$2/file"
+EOF
+
+run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change' '
+	test_when_finished git reset --hard &&
+	echo "orig content" >file &&
+	git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
+	echo "new content" >expect &&
+	test_cmp expect file
+'
+
+run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged change' '
+	test_when_finished git reset --hard &&
+	git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
+	echo "new content" >expect &&
+	test_cmp expect file
+'
+
 write_script modify-file <<\EOF
 echo "new content" >file
 EOF
-- 
1.7.1
