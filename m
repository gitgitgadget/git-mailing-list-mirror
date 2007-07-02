From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Test that git add removes stages 1,2,3.
Date: Mon,  2 Jul 2007 13:18:06 +0200
Message-ID: <11833750863127-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org, j.sixt@eudaptics.com
X-From: git-owner@vger.kernel.org Mon Jul 02 13:18:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Jv4-0003At-6v
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 13:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbXGBLSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 07:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbXGBLSM
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 07:18:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53928 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbXGBLSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 07:18:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1I5Juy-0002Wy-8L; Mon, 02 Jul 2007 13:18:08 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0D59D6D9; Mon,  2 Jul 2007 13:18:08 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id 5AF13102; Mon,  2 Jul 2007 13:18:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.2.555.g24e57
X-Spam-Score: 3.6 (+++)
X-Spam-Report: BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51354>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
git add seems to have a bug, where it doesn't remove stages 1,2,3
if a stage 0 entry is already in the index.

Here is a test (on top of maint) for the kind soul who wants to fix
this border case.  Feel free to merge this patch into your patch
that provides the fix.

-- Hannes

 t/t3700-add.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ad8cc7d..d7dd6ca 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -110,4 +110,16 @@ test_expect_success 'check correct prefix detection' '
 	git add 1/2/a 1/3/b 1/2/c
 '
 
+test_expect_success 'git add removes unmerged entries' '
+	git rm --cached -f file &&
+	for s in 0 1 2 3
+	do
+		echo "100644 0123456789012345678901234567890123456789 $s	file"
+	done | git update-index --index-info &&
+	echo new > file &&
+	git add file &&
+	git ls-files --stage | grep "^100644 .* 0	file$" &&
+	! git ls-files --stage | grep "^100644 .* [^0]	file$"
+'
+
 test_done
-- 
1.5.2.2.555.g24e57
