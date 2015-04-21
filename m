From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V3 1/2] t9801: check git-p4's branch detection with client spec enabled
Date: Tue, 21 Apr 2015 23:49:29 +0100
Message-ID: <1429656570-21825-2-git-send-email-vitor.hda@gmail.com>
References: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com>
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 00:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykgzp-0006a3-An
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 00:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbbDUWuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 18:50:19 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34285 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965068AbbDUWuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 18:50:15 -0400
Received: by wicmx19 with SMTP id mx19so73945069wic.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8e1pvnrI/0LE7acI+Dib6cyluKaedmYYCoy9DA3QO84=;
        b=fzr+54/r8wMvKIltigbgG6y5VtCYFzdVpMNY/NxT1bGY3h4ScpGKJ4CwJDO28RmJKR
         MLF+cm3+sk6E1hksv25JhKFXeVXREgzZXVlZplzGhME8q2PYA/GmaoICoGXv2Dbqv4Qd
         Z71vv1v1ougdixLsIM3UnxiMEbj3SlVqGDjevUo88Ms+Zuqfza3u5Kpom/KICs63w8Qr
         faAUXxsZKj7eXdBiZzw6xem4hZJ8Sg9KzLFLGI/mDbPavafSZ2P4OsV8E9jw+EzRs22f
         B9Ne9IExN0rtBzqXeL7bipvQ/E+SMYYIM6SfPvTirO1LMiKZPyyZHnpZrG6ZB1fHgxhq
         OA6Q==
X-Received: by 10.194.63.80 with SMTP id e16mr27626671wjs.56.1429656614065;
        Tue, 21 Apr 2015 15:50:14 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id dg8sm4573201wjc.9.2015.04.21.15.50.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 15:50:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267563>

Add failing scenario when branch detection (--detect-branches) is
enabled together with use client spec (--use-client-spec). In this
specific scenario git-p4 will break when the Perforce client view
removes part of the depot path, as in the following example:

  //depot/branch1/base/... //client/branch1/...

The test case also includes an extra sub-file mapping to enforce
robustness check of git-p4's client view support:

  //depot/branch1/base/dir/sub_file1 //client/branch1/sub_file1

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
