From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v4 4/4] git-p4: Add simple test case for branch import
Date: Sun, 28 Aug 2011 22:58:30 +0100
Message-ID: <1314568710-6472-5-git-send-email-vitor.hda@gmail.com>
References: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 23:59:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxnOO-00033c-IC
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 23:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470Ab1H1V7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 17:59:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41197 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab1H1V7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 17:59:43 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so3635385wyg.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ikc5/ph7N8fx0+MK7NG0P9woC/N3+LiXljBlAMnHsfI=;
        b=jL14m4YjkgQfqkIpRY3OCyfuiXf6I00yQJ3/q/0zmfY3OzZrUmg4A1vnwiw98TvlSJ
         p/8HZCeQEsJzcMrON1MakqICa6FE8MZgoL/bdg+stbWEuEL2O+H29D+7vceihV3B8ngB
         rJmF2mEB7EbtDRtLjffpExQ55b+02Hf+jS8rE=
Received: by 10.227.42.75 with SMTP id r11mr3092095wbe.79.1314568782931;
        Sun, 28 Aug 2011 14:59:42 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fh17sm3211909wbb.3.2011.08.28.14.59.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 14:59:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180287>

Create a basic branch structure in P4 and clone it with git-p4.
Also, make an update on P4 side and check if git-p4 imports it correctly.
The branch structure is created in such a way that git-p4 will fail to import
updates if patch "git-p4: Correct branch base depot path detection" is not
applied.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 9d4d4bf..01ba041 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -405,6 +405,67 @@ test_expect_success 'detect copies' '
 	p4 filelog //depot/file13 | grep -q "branch from //depot/file"
 '
 
+# Create a simple branch structure in P4 depot to check if it is correctly
+# cloned.
+test_expect_success 'add simple p4 branches' '
+	cd "$cli" &&
+	mkdir branch1 &&
+	cd branch1 &&
+	echo file1 >file1 &&
+	echo file2 >file2 &&
+	p4 add file1 file2 &&
+	p4 submit -d "branch1" &&
+	p4 integrate //depot/branch1/... //depot/branch2/... &&
+	p4 submit -d "branch2" &&
+	echo file3 >file3 &&
+	p4 add file3 &&
+	p4 submit -d "add file3 in branch1" &&
+	p4 open file2 &&
+	echo update >>file2 &&
+	p4 submit -d "update file2 in branch1" &&
+	p4 integrate //depot/branch1/... //depot/branch3/... &&
+	p4 submit -d "branch3" &&
+	cd "$TRASH_DIRECTORY"
+'
+
+# Configure branches through git-config and clone them.
+# All files are tested to make sure branches were cloned correctly.
+# Finally, make an update to branch1 on P4 side to check if it is imported
+# correctly by git-p4.
+test_expect_success 'git-p4 clone simple branches' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	cd "$git" &&
+	git config git-p4.branchList branch1:branch2 &&
+	git config --add git-p4.branchList branch1:branch3 &&
+	"$GITP4" clone --dest=. --detect-branches //depot@all &&
+	git log --all --graph --decorate --stat &&
+	git reset --hard p4/depot/branch1 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	grep -q update file2 &&
+	git reset --hard p4/depot/branch2 &&
+	test -f file1 &&
+	test -f file2 &&
+	test ! -f file3 &&
+	! grep -q update file2 &&
+	git reset --hard p4/depot/branch3 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	grep -q update file2 &&
+	cd "$cli" &&
+	cd branch1 &&
+	p4 edit file2 &&
+	echo file2_ >>file2 &&
+	p4 submit -d "update file2 in branch1" &&
+	cd "$git" &&
+	git reset --hard p4/depot/branch1 &&
+	"$GITP4" rebase &&
+	grep -q file2_ file2
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.5.4
