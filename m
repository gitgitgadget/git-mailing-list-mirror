From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Sat, 21 Jan 2012 00:21:32 +0000
Message-ID: <1327105292-30092-4-git-send-email-vitor.hda@gmail.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 01:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoOio-0005vt-I8
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 01:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab2AUAWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 19:22:11 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61679 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599Ab2AUAWC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 19:22:02 -0500
Received: by mail-ww0-f44.google.com with SMTP id ed3so950759wgb.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 16:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=H9UDmKOJm5Rxh0TZRGw9VDENfcfg/A1f6plRTOXzenc=;
        b=oTsb5zoWADKF/61pE2Bqz8CJ+R+puOmoWwK4QjT+7YJlmu2RRktD2SJrpE0dap62E4
         hUjvMczZ69jr0BZQ1cXnIrs3h00ByVVenylL5nJFdRW1vuXLXQ5ZVtxc/7cuNzbsIYHt
         RcRDhgjsNzAPFMBiW2AfrdR0akc+SS4MIVl4c=
Received: by 10.180.83.72 with SMTP id o8mr858536wiy.22.1327105321333;
        Fri, 20 Jan 2012 16:22:01 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id q7sm566234wix.5.2012.01.20.16.22.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Jan 2012 16:22:00 -0800 (PST)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
In-Reply-To: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188914>

Check if branches created from old changelists are correctly imported.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |   80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index a25f18d..ed4e48c 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -226,6 +226,86 @@ test_expect_success 'git-p4 clone simple branches' '
 	)
 '
 
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
+		p4 submit -d "branch4" &&
+		changelist=$(($changelist + 2)) &&
+		p4 integrate //depot/branch1/...@$changelist //depot/branch5/... &&
+		p4 submit -d "branch5"
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
+		grep -q update file2 &&
+		git reset --hard p4/depot/branch2 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_missing file3 &&
+		! grep -q update file2 &&
+		git reset --hard p4/depot/branch3 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		grep -q update file2 &&
+		git reset --hard p4/depot/branch4 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_missing file3 &&
+		! grep -q update file2 &&
+		git reset --hard p4/depot/branch5 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		! grep -q update file2 &&
+		test_path_is_missing .git/git-p4-tmp
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.7.rc2.14.g5e044.dirty
