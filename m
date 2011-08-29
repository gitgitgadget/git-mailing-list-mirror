From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH] git-p4: simple branch tests edits
Date: Mon, 29 Aug 2011 10:32:23 +0100
Message-ID: <1314610343-13488-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 11:33:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxyDJ-0001MP-Hd
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 11:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab1H2JdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 05:33:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36981 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab1H2Jc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 05:32:58 -0400
Received: by wyg24 with SMTP id 24so3910848wyg.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sn2DHRKSR+7iHZ2l1vCC1gA10/XESCzYXfbrldePWKU=;
        b=R8fucoVMRTVMde+oVmRWzfJpkZ3sA1iiiWXphZxWSUiaNCFpKJef0WKipq3sTwgyC1
         Z6zkMqzM3IFEFz2EUzHGTNTJXgtJuSRvK+KtFX+yj0y6n3WLb5+b1GvfkTpZW7M6N/Gg
         SoMgzqT0sNHTQYNL81lp6dCUkGbWHuQ7Xjqh8=
Received: by 10.227.57.211 with SMTP id d19mr3598389wbh.93.1314610377569;
        Mon, 29 Aug 2011 02:32:57 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fh17sm3569325wbb.54.2011.08.29.02.32.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 02:32:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180307>

From: Pete Wyckoff <pw@padd.com>

More review comments.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9800-git-p4.sh |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 39e7f78..01ba041 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -413,7 +413,7 @@ test_expect_success 'add simple p4 branches' '
 	cd branch1 &&
 	echo file1 >file1 &&
 	echo file2 >file2 &&
-	p4 add file* &&
+	p4 add file1 file2 &&
 	p4 submit -d "branch1" &&
 	p4 integrate //depot/branch1/... //depot/branch2/... &&
 	p4 submit -d "branch2" &&
@@ -433,13 +433,12 @@ test_expect_success 'add simple p4 branches' '
 # Finally, make an update to branch1 on P4 side to check if it is imported
 # correctly by git-p4.
 test_expect_success 'git-p4 clone simple branches' '
-	git init "$git" &&
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
 	cd "$git" &&
 	git config git-p4.branchList branch1:branch2 &&
 	git config --add git-p4.branchList branch1:branch3 &&
-	cd "$TRASH_DIRECTORY" &&
-	"$GITP4" clone --dest="$git" --detect-branches //depot@all &&
-	cd "$git" &&
+	"$GITP4" clone --dest=. --detect-branches //depot@all &&
 	git log --all --graph --decorate --stat &&
 	git reset --hard p4/depot/branch1 &&
 	test -f file1 &&
@@ -449,7 +448,7 @@ test_expect_success 'git-p4 clone simple branches' '
 	git reset --hard p4/depot/branch2 &&
 	test -f file1 &&
 	test -f file2 &&
-	test \! -z file3 &&
+	test ! -f file3 &&
 	! grep -q update file2 &&
 	git reset --hard p4/depot/branch3 &&
 	test -f file1 &&
@@ -459,14 +458,12 @@ test_expect_success 'git-p4 clone simple branches' '
 	cd "$cli" &&
 	cd branch1 &&
 	p4 edit file2 &&
-	echo file2_ >> file2 &&
-	p4 submit -d "update file2 in branch3" &&
+	echo file2_ >>file2 &&
+	p4 submit -d "update file2 in branch1" &&
 	cd "$git" &&
 	git reset --hard p4/depot/branch1 &&
 	"$GITP4" rebase &&
-	grep -q file2_ file2 &&
-	cd "$TRASH_DIRECTORY" &&
-	rm -rf "$git" && mkdir "$git"
+	grep -q file2_ file2
 '
 
 test_expect_success 'shutdown' '
-- 
1.7.5.4
