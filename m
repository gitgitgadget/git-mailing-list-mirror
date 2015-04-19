From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V2 1/2] t9801: check git-p4's branch detection and client view together
Date: Sun, 19 Apr 2015 11:56:48 +0100
Message-ID: <1429441009-17775-2-git-send-email-vitor.hda@gmail.com>
References: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com>
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 12:57:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjmun-0001WC-7p
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 12:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbbDSK5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 06:57:24 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38103 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbDSK5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 06:57:22 -0400
Received: by wiun10 with SMTP id n10so62350757wiu.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRE3Mns9LAlIe+mfwnxMBVS6lHoFWWiMCRVE4+0Exq8=;
        b=OheqpFau5GJWgEfnBAkgf2MyxiRyo1m2FAMTj0+vnGvfdl+8yZQiks65prVLKvHGlS
         kMNyliCHpG1zr4vCqQP94zAvNRZxtfdbpEJlB8/l8ufKCq82myz27d9yjiOmIpdQUoGi
         k9otHR1AC0bjgKYOEBrIyeZq2lvRE2ZY7ArgsZvcmMp+IA+vRV++E4pMk5deG7dGmTIw
         U29B4w4gPUgaLB+lHMtmWalsJdQTFTpSoiE8xZGjj3Mri7X2cCAScuc23zk7O6xS26ka
         FzEbaiYtUUpzfAQaAb1sOuZOf9eTdhgD+P0iwINlLH2g0hdt0Vn8xMEs/pV0YZPDMyBj
         Btrw==
X-Received: by 10.195.13.133 with SMTP id ey5mr21954160wjd.3.1429441041114;
        Sun, 19 Apr 2015 03:57:21 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id z13sm22576630wjr.44.2015.04.19.03.57.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2015 03:57:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267436>

Add failing scenario where branch detection is enabled together with
use client view. In this specific scenario git-p4 will break when the
perforce client view removes part of the depot path.

The test case also includes an extra sub-file mapping to enforce
robustness check on git-p4 implementation.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9801-git-p4-branch.sh |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 2bf142d..36a7f51 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -504,6 +504,112 @@ test_expect_success 'use-client-spec detect-branches skips files in branches' '
 	)
 '
 
+test_expect_success 'restart p4d' '
+	kill_p4d &&
+	start_p4d
+'
+
+#
+# 1: //depot/branch1/base/file1
+#    //depot/branch1/base/file2
+#    //depot/branch1/base/dir/sub_file1
+# 2: integrate //depot/branch1/base/... -> //depot/branch2/base/...
+# 3: //depot/branch1/base/file3
+# 4: //depot/branch1/base/file2 (edit)
+# 5: integrate //depot/branch1/base/... -> //depot/branch3/base/...
+#
+# Note: the client view removes the "base" folder from the workspace
+#       and moves sub_file1 one level up.
+test_expect_success 'add simple p4 branches with common base folder on each branch' '
+	(
+		cd "$cli" &&
+		client_view "//depot/branch1/base/... //client/branch1/..." \
+			    "//depot/branch1/base/dir/sub_file1 //client/branch1/sub_file1" \
+			    "//depot/branch2/base/... //client/branch2/..." \
+			    "//depot/branch3/base/... //client/branch3/..." &&
+		mkdir -p branch1 &&
+		cd branch1 &&
+		echo file1 >file1 &&
+		echo file2 >file2 &&
+		mkdir dir &&
+		echo sub_file1 >sub_file1 &&
+		p4 add file1 file2 sub_file1 &&
+		p4 submit -d "Create branch1" &&
+		p4 integrate //depot/branch1/base/... //depot/branch2/base/... &&
+		p4 submit -d "Integrate branch2 from branch1" &&
+		echo file3 >file3 &&
+		p4 add file3 &&
+		p4 submit -d "add file3 in branch1" &&
+		p4 open file2 &&
+		echo update >>file2 &&
+		p4 submit -d "update file2 in branch1" &&
+		p4 integrate //depot/branch1/base/... //depot/branch3/base/... &&
+		p4 submit -d "Integrate branch3 from branch1"
+	)
+'
+
+# Configure branches through git-config and clone them.
+# All files are tested to make sure branches were cloned correctly.
+# Finally, make an update to branch1 on P4 side to check if it is imported
+# correctly by git p4.
+# git p4 is expected to use the client view to also not include the common
+# "base" folder in the imported directory structure.
+test_expect_success 'git p4 clone simple branches with base folder on server side' '
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList branch1:branch2 &&
+		git config --add git-p4.branchList branch1:branch3 &&
+		git p4 clone --dest=. --use-client-spec  --detect-branches //depot@all &&
+		git log --all --graph --decorate --stat &&
+		git reset --hard p4/depot/branch1 &&
+		test -f file1 &&
+		test -f file2 &&
+		test -f file3 &&
+		test -f sub_file1 &&
+		grep update file2 &&
+		git reset --hard p4/depot/branch2 &&
+		test -f file1 &&
+		test -f file2 &&
+		test ! -f file3 &&
+		test -f sub_file1 &&
+		! grep update file2 &&
+		git reset --hard p4/depot/branch3 &&
+		test -f file1 &&
+		test -f file2 &&
+		test -f file3 &&
+		test -f sub_file1 &&
+		grep update file2 &&
+		cd "$cli" &&
+		cd branch1 &&
+		p4 edit file2 &&
+		echo file2_ >>file2 &&
+		p4 submit -d "update file2 in branch1" &&
+		cd "$git" &&
+		git reset --hard p4/depot/branch1 &&
+		git p4 rebase &&
+		grep file2_ file2
+	)
+'
+
+# Now update a file in one of the branches in git and submit to P4
+test_expect_failure 'Update a file in git side and submit to P4 using client view' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git reset --hard p4/depot/branch1 &&
+		echo "client spec" >> file1 &&
+		git add -u . &&
+		git commit -m "update file1 in branch1" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --verbose &&
+		cd "$cli" &&
+		p4 sync ... &&
+		cd branch1 &&
+		grep "client spec" file1
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.10.4
