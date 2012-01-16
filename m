From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 3/3] git-p4: Add test case for complex branch import
Date: Mon, 16 Jan 2012 00:39:20 +0000
Message-ID: <1326674360-2771-4-git-send-email-vitor.hda@gmail.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 01:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmac7-000672-Mx
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 01:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab2APAjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 19:39:51 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46895 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab2APAju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 19:39:50 -0500
Received: by wgbdq11 with SMTP id dq11so74340wgb.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 16:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=e5y/h2b2u02mB0C7r/D/BreRZP10ZevFol2u2tLwMLg=;
        b=aXez3U24O9lxFyvkEzDolzM8p5LY84z2g+e3kgcdHirMNvTu8Q0OzNfZz/cb8r7g6p
         BQzd7f7bk+Mim9bfi9Az6YgIIzqI4K7VatnrHlTkLO82l2p6OaDrMGo6/wZ3CS6YRpgK
         l4IsfgFOLYM92KUsv6b9nvure8652Fe5P0nCM=
Received: by 10.180.19.138 with SMTP id f10mr19938432wie.3.1326674388808;
        Sun, 15 Jan 2012 16:39:48 -0800 (PST)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id q5sm20225601wbo.8.2012.01.15.16.39.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 16:39:48 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188604>

Check if branches created from old changelists are correctly imported.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |   83 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index a25f18d..0f10e00 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -226,6 +226,89 @@ test_expect_success 'git-p4 clone simple branches' '
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
+		changelist=$((changelist - 5)) &&
+		p4 integrate //depot/branch1/...@$changelist //depot/branch4/... &&
+		p4 submit -d "branch4" &&
+		changelist=$((changelist + 2)) &&
+		p4 integrate //depot/branch1/...@$changelist //depot/branch5/... &&
+		p4 submit -d "branch5" &&
+		cd "$TRASH_DIRECTORY"
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
+		test_when_finished cleanup_git &&
+		test_create_repo "$git" &&
+		cd "$git" &&
+		git config git-p4.branchList branch1:branch2 &&
+		git config --add git-p4.branchList branch1:branch3 &&
+		git config --add git-p4.branchList branch1:branch4 &&
+		git config --add git-p4.branchList branch1:branch5 &&
+		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+		git log --all --graph --decorate --stat &&
+		git reset --hard p4/depot/branch1 &&
+		test -f file1 &&
+		test -f file2 &&
+		test -f file3 &&
+		grep -q update file2 &&
+		git reset --hard p4/depot/branch2 &&
+		test -f file1 &&
+		test -f file2 &&
+		test ! -f file3 &&
+		! grep -q update file2 &&
+		git reset --hard p4/depot/branch3 &&
+		test -f file1 &&
+		test -f file2 &&
+		test -f file3 &&
+		grep -q update file2 &&
+		git reset --hard p4/depot/branch4 &&
+		test -f file1 &&
+		test -f file2 &&
+		test ! -f file3 &&
+		! grep -q update file2 &&
+		git reset --hard p4/depot/branch5 &&
+		test -f file1 &&
+		test -f file2 &&
+		test -f file3 &&
+		! grep -q update file2 &&
+		test ! -d .git/git-p4-tmp
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.3
