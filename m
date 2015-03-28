From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 1/2] git-p4: Check branch detection and client view together
Date: Sat, 28 Mar 2015 12:28:49 +0000
Message-ID: <1427545730-3563-2-git-send-email-vitor.hda@gmail.com>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 13:29:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybprz-0004ca-Ev
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 13:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbbC1M3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2015 08:29:38 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33640 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbbC1M3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2015 08:29:38 -0400
Received: by wgbgs4 with SMTP id gs4so34000153wgb.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2015 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2KQp6Npd+qar0DrC/LomyUAcpTybW1q9Pi5s5r4gmBM=;
        b=WK1RTyj62jvR73xFPxIcxf508MbdbMxOZ/zEb+Wn01e4wVQBIjEIm2guIH7zxwVfUV
         M+KNgtE2cVj+Lbfxwahd9Lq03TP1BvAug4qc4qxPyF4as+hnZcdwnwwxiTl0RgHix4Ky
         nlcl5bTTsAFtRaQDzcWrJDm2mfhxdPQ2+VKKEMrmWE459Qs3qnA9GS6loYizbPJw8ZMx
         vwoO3rAEjwznpxf0JKsJx8pvtD/1NZ3rGNiesYl0iLTfTWhkmmgqyJlgg7YHe/Mx4+Yf
         FDoqhK6t1IAbKFrxkn4POUx+bfB1jiprMePLPAZuNeqHmEfvuBTwqXjLH5khMwdJYeMr
         3eyg==
X-Received: by 10.194.23.39 with SMTP id j7mr46943731wjf.9.1427545776726;
        Sat, 28 Mar 2015 05:29:36 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id e2sm6948133wjy.46.2015.03.28.05.29.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2015 05:29:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266413>

Add failing scenario where using branch detection and a client view will break
git p4 submit functionality.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |   98 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 2bf142d..2f0361a 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -504,6 +504,104 @@ test_expect_success 'use-client-spec detect-branches skips files in branches' '
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
+# 2: integrate //depot/branch1/base/... -> //depot/branch2/base/...
+# 3: //depot/branch1/base/file3
+# 4: //depot/branch1/base/file2 (edit)
+# 5: integrate //depot/branch1/base/... -> //depot/branch3/base/...
+#
+# Note: the client view remove the "base" folder from the workspace
+test_expect_success 'add simple p4 branches with common base folder on each branch' '
+	(
+		cd "$cli" &&
+		client_view "//depot/branch1/base/... //client/branch1/..." \
+			    "//depot/branch2/base/... //client/branch2/..." \
+			    "//depot/branch3/base/... //client/branch3/..." &&
+		mkdir -p branch1 &&
+		cd branch1 &&
+		echo file1 >file1 &&
+		echo file2 >file2 &&
+		p4 add file1 file2 &&
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
+		grep update file2 &&
+		git reset --hard p4/depot/branch2 &&
+		test -f file1 &&
+		test -f file2 &&
+		test ! -f file3 &&
+		! grep update file2 &&
+		git reset --hard p4/depot/branch3 &&
+		test -f file1 &&
+		test -f file2 &&
+		test -f file3 &&
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
