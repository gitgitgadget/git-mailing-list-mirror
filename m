From: Kenichi Saita <nitoyon@gmail.com>
Subject: [PATCH v3] difftool --dir-diff: allow changing any clean working tree file
Date: Thu, 30 May 2013 01:01:23 +0900
Message-ID: <1369843283-2328-1-git-send-email-nitoyon@gmail.com>
References: <7v7gij0w6z.fsf@alter.siamese.dyndns.org>
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Kenichi Saita <nitoyon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 18:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhipT-0005P3-S7
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 18:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab3E2QCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 12:02:20 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:48080 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab3E2QCT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 12:02:19 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so9393752pbc.37
        for <git@vger.kernel.org>; Wed, 29 May 2013 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yxA+UpMYuhb1xadBqpbzoTTwB8S72HsVfZygahkgEY8=;
        b=QFb3iVOO8TUjPumX6aU3/igP3ynuGupjNA7NtF64HlAf/ZKOYhjRhsMFHamBKVgQ3P
         RoexNvS/mvOiknvSs4kKBheHhu+q39ArIA42vRAvqGftkkokjD3vlZvC7aTMqmRrlyyZ
         42xNmFpTUkcQP6wTmbyKmKLcZcXo2pK/vxqOxgzWZdteNjQt780BxLeUQJ2qJ5HxmtwK
         6vXjc9B12fBiSO2FLMj+neB1J0DFNPTR3pEXoWhpM8SjRYaJuXl6rkZHXTGeXBEqLMEP
         yQy/7dMKf0xeqiyQOg3e6hYoKxA64HDJhIC9SoedF0GYEK8TMtcr4syJWUSzhGeVIuxj
         mD2Q==
X-Received: by 10.66.158.101 with SMTP id wt5mr4088791pab.8.1369843338599;
        Wed, 29 May 2013 09:02:18 -0700 (PDT)
Received: from localhost.localdomain (144.72.102.121.dy.bbexcite.jp. [121.102.72.144])
        by mx.google.com with ESMTPSA id q18sm40447316pao.4.2013.05.29.09.02.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 09:02:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <7v7gij0w6z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225836>

The temporary directory prepared by "difftool --dir-diff" to
show the result of a change can be modified by the user via
the tree diff program, and we try hard not to lose changes
to them after tree diff program returns to us.

However, the set of files to be copied back is computed
differently between --symlinks and --no-symlinks modes.  The
former checks all paths that start out as identical to the
working tree file, while the latter checks paths that
already had a local modification in the working tree,
allowing changes made in the tree diff program to paths that
did not have any local change to be lost.

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
