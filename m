From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Test 'git add' for unmerged entries when core.symlinks=false.
Date: Mon,  2 Jul 2007 13:28:42 +0200
Message-ID: <1183375722665-git-send-email-johannes.sixt@telecom.at>
Cc: j.sixt@eudaptics.com, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 13:28:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5K5I-00050a-OC
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 13:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbXGBL2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 07:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbXGBL2q
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 07:28:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28841 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbXGBL2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 07:28:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1I5K5D-00016B-8c; Mon, 02 Jul 2007 13:28:43 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 186BE6D9; Mon,  2 Jul 2007 13:28:43 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id DDD57102; Mon,  2 Jul 2007 13:28:42 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.2.555.g24e57
X-Spam-Score: 3.6 (+++)
X-Spam-Report: BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51356>

In 20314271679e169f324c118c69c8d9e0399feec9 git add was fixed if unmerged
entries are in the index and core.filemode=false. core.symlinks=false is
a similar case, which touches the same code path. Here is a test that
makes sure that the symlink property in the index is preserved, too.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t3700-add.sh |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 0d80c6a..e6466d7 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -110,30 +110,37 @@ test_expect_success 'check correct prefix detection' '
 	git add 1/2/a 1/3/b 1/2/c
 '
 
-test_expect_success 'git add and filemode=0 with unmerged entries' '
-	echo 1 > stage1 &&
-	echo 2 > stage2 &&
-	echo 3 > stage3 &&
+test_expect_success 'git add with filemode=0, symlinks=0, and unmerged entries' '
 	for s in 1 2 3
 	do
+		echo $s > stage$s
 		echo "100755 $(git hash-object -w stage$s) $s	file"
+		echo "120000 $(printf $s | git hash-object -w -t blob --stdin) $s	symlink"
 	done | git update-index --index-info &&
 	git config core.filemode 0 &&
+	git config core.symlinks 0 &&
 	echo new > file &&
-	git add file &&
-	git ls-files --stage | grep "^100755 .* 0	file$"
+	echo new > symlink &&
+	git add file symlink &&
+	git ls-files --stage | grep "^100755 .* 0	file$" &&
+	git ls-files --stage | grep "^120000 .* 0	symlink$"
 '
 
-test_expect_success 'git add and filemode=0 prefers stage 2 over stage 1' '
-	git rm --cached -f file &&
+test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over stage 1' '
+	git rm --cached -f file symlink &&
 	(
 		echo "100644 $(git hash-object -w stage1) 1	file"
 		echo "100755 $(git hash-object -w stage2) 2	file"
+		echo "100644 $(printf $s | git hash-object -w -t blob --stdin) 1	symlink"
+		echo "120000 $(printf $s | git hash-object -w -t blob --stdin) 2	symlink"
 	) | git update-index --index-info &&
 	git config core.filemode 0 &&
+	git config core.symlinks 0 &&
 	echo new > file &&
-	git add file &&
-	git ls-files --stage | grep "^100755 .* 0	file$"
+	echo new > symlink &&
+	git add file symlink &&
+	git ls-files --stage | grep "^100755 .* 0	file$" &&
+	git ls-files --stage | grep "^120000 .* 0	symlink$"
 '
 
 test_done
-- 
1.5.2.2.555.g24e57
