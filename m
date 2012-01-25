From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 2/3] git-p4: Add test case for complex branch import
Date: Wed, 25 Jan 2012 23:48:23 +0000
Message-ID: <1327535304-11332-3-git-send-email-vitor.hda@gmail.com>
References: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 00:49:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqCaP-0002Xp-0z
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 00:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab2AYXsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 18:48:52 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35258 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab2AYXso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 18:48:44 -0500
Received: by wgbed3 with SMTP id ed3so3286wgb.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 15:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=U+CnnBtdNC6cAp91BxgxRPvsfZrcBq2jB2wfj8gf7Tc=;
        b=N5ihN4naoKkMhhbWA2WzgrgX1qRKpYw60pKZZKV7gb1SbMscHbFXLB05o6rRneyBOZ
         ALwdQ9YjDYXDYB+1vzEb6xNlacTFkbKmacVsxQERYliuc14ozMcvx0WYpyi5NP4H9B+4
         WRCICyIUwY0KfezW76NWRd4Yq3cXaRUCeR8Po=
Received: by 10.180.103.97 with SMTP id fv1mr31893445wib.17.1327535323541;
        Wed, 25 Jan 2012 15:48:43 -0800 (PST)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id df2sm2551041wib.4.2012.01.25.15.48.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 15:48:43 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189137>

Check if branches created from old changelists are correctly imported.
Also included some updates to simple branch test so that both are
coherent in respect to each other.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |   94 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index a25f18d..6ff713b 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -172,9 +172,9 @@ test_expect_success 'add simple p4 branches' '
 		echo file1 >file1 &&
 		echo file2 >file2 &&
 		p4 add file1 file2 &&
-		p4 submit -d "branch1" &&
+		p4 submit -d "Create branch1" &&
 		p4 integrate //depot/branch1/... //depot/branch2/... &&
-		p4 submit -d "branch2" &&
+		p4 submit -d "Integrate branch2 from branch1" &&
 		echo file3 >file3 &&
 		p4 add file3 &&
 		p4 submit -d "add file3 in branch1" &&
@@ -182,7 +182,7 @@ test_expect_success 'add simple p4 branches' '
 		echo update >>file2 &&
 		p4 submit -d "update file2 in branch1" &&
 		p4 integrate //depot/branch1/... //depot/branch3/... &&
-		p4 submit -d "branch3"
+		p4 submit -d "Integrate branch3 from branch1"
 	)
 '
 
@@ -203,17 +203,17 @@ test_expect_success 'git-p4 clone simple branches' '
 		test -f file1 &&
 		test -f file2 &&
 		test -f file3 &&
-		grep -q update file2 &&
+		grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
 		test -f file1 &&
 		test -f file2 &&
 		test ! -f file3 &&
-		test_must_fail grep -q update file2 &&
+		test_must_fail grep update file2 &&
 		git reset --hard p4/depot/branch3 &&
 		test -f file1 &&
 		test -f file2 &&
 		test -f file3 &&
-		grep -q update file2 &&
+		grep update file2 &&
 		cd "$cli" &&
 		cd branch1 &&
 		p4 edit file2 &&
@@ -222,7 +222,87 @@ test_expect_success 'git-p4 clone simple branches' '
 		cd "$git" &&
 		git reset --hard p4/depot/branch1 &&
 		"$GITP4" rebase &&
-		grep -q file2_ file2
+		grep file2_ file2
+	)
+'
+
+# Create a complex branch structure in P4 depot to check if they are correctly
+# cloned. The branches are created from older changelists to check if git-p4 is
+# able to correctly detect them.
+# The final expected structure is:
+# `branch1
+# | `- file1
+# | `- file2 (updated)
+# | `- file3
+# `branch2
+# | `- file1
+# | `- file2
+# `branch3
+# | `- file1
+# | `- file2 (updated)
+# | `- file3
+# `branch4
+# | `- file1
+# | `- file2
+# `branch5
+#   `- file1
+#   `- file2
+#   `- file3
+test_expect_success 'git-p4 add complex branches' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$cli" &&
+		changelist=$(p4 changes -m1 //depot/... | cut -d" " -f2) &&
+		changelist=$(($changelist - 5)) &&
+		p4 integrate //depot/branch1/...@$changelist //depot/branch4/... &&
+		p4 submit -d "Integrate branch4 from branch1@${changelist}" &&
+		changelist=$(($changelist + 2)) &&
+		p4 integrate //depot/branch1/...@$changelist //depot/branch5/... &&
+		p4 submit -d "Integrate branch5 from branch1@${changelist}"
+	)
+'
+
+# Configure branches through git-config and clone them. git-p4 will only be able
+# to clone the original structure if it is able to detect the origin changelist
+# of each branch.
+test_expect_success 'git-p4 clone complex branches' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList branch1:branch2 &&
+		git config --add git-p4.branchList branch1:branch3 &&
+		git config --add git-p4.branchList branch1:branch4 &&
+		git config --add git-p4.branchList branch1:branch5 &&
+		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+		git log --all --graph --decorate --stat &&
+		git reset --hard p4/depot/branch1 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		grep update file2 &&
+		git reset --hard p4/depot/branch2 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_missing file3 &&
+		test_must_fail grep update file2 &&
+		git reset --hard p4/depot/branch3 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		grep update file2 &&
+		git reset --hard p4/depot/branch4 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_missing file3 &&
+		test_must_fail grep update file2 &&
+		git reset --hard p4/depot/branch5 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		test_must_fail grep update file2 &&
+		test_path_is_missing .git/git-p4-tmp
 	)
 '
 
-- 
1.7.8.3
