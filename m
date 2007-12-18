From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Fix test failure due to broken sed on Leopard
Date: Tue, 18 Dec 2007 16:11:15 +0100
Message-ID: <1197990675-41698-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 16:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4e8C-0004WX-Rs
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417AbXLRPMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 10:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755072AbXLRPMx
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:12:53 -0500
Received: from wincent.com ([72.3.236.74]:33290 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbXLRPMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 10:12:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBIFBGBN025333;
	Tue, 18 Dec 2007 09:11:17 -0600
X-Mailer: git-send-email 1.5.4.rc0.1099.g76fa0-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68758>

The newly-added common-tail-optimization test fails on Leopard because
the broken sed implementation bails with a spurious "unterminated
substitute pattern" error because of the length of one of the
arguments.

So halve the size of the argument (to 1024 - 1, down from the previous
2048 - 1) to get the test passing again.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t4024-diff-optimize-common.sh |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 20fe87b..bbda816 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -7,26 +7,26 @@ test_description='common tail optimization'
 z=zzzzzzzz ;# 8
 z="$z$z$z$z$z$z$z$z" ;# 64
 z="$z$z$z$z$z$z$z$z" ;# 512
-z="$z$z$z$z" ;# 2048
-z2047=$(expr "$z" : '.\(.*\)') ; #2047
+z="$z$z" ;# 1024
+z1023=$(expr "$z" : '.\(.*\)') ; #1023
 
 test_expect_success setup '
 
-	echo "a$z2047" >file-a &&
+	echo "a$z1023" >file-a &&
 	echo "b" >file-b &&
-	echo "$z2047" >>file-b &&
-	echo "c$z2047" | tr -d "\012" >file-c &&
+	echo "$z1023" >>file-b &&
+	echo "c$z1023" | tr -d "\012" >file-c &&
 	echo "d" >file-d &&
-	echo "$z2047" | tr -d "\012" >>file-d &&
+	echo "$z1023" | tr -d "\012" >>file-d &&
 
 	git add file-a file-b file-c file-d &&
 
-	echo "A$z2047" >file-a &&
+	echo "A$z1023" >file-a &&
 	echo "B" >file-b &&
-	echo "$z2047" >>file-b &&
-	echo "C$z2047" | tr -d "\012" >file-c &&
+	echo "$z1023" >>file-b &&
+	echo "C$z1023" | tr -d "\012" >file-c &&
 	echo "D" >file-d &&
-	echo "$z2047" | tr -d "\012" >>file-d
+	echo "$z1023" | tr -d "\012" >>file-d
 
 '
 
@@ -61,7 +61,7 @@ EOF
 
 test_expect_success 'diff -U0' '
 
-	git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
+	git diff -U0 | sed -e "/^index/d" -e "s/$z1023/Z/g" >actual &&
 	diff -u expect actual
 
 '
-- 
1.5.4.rc0.1099.g76fa0-dirty
