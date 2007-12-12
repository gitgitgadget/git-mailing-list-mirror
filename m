From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/4] Fix "diff --check" whitespace detection
Date: Wed, 12 Dec 2007 17:22:59 +0100
Message-ID: <1197476582-18956-2-git-send-email-win@wincent.com>
References: <1197476582-18956-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 17:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2UNF-0002Qk-77
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbXLLQXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbXLLQXd
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:23:33 -0500
Received: from wincent.com ([72.3.236.74]:44670 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755760AbXLLQXb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 11:23:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCGN3CH026521;
	Wed, 12 Dec 2007 10:23:06 -0600
X-Mailer: git-send-email 1.5.3.7.1159.g2f071-dirty
In-Reply-To: <1197476582-18956-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68066>

"diff --check" would only detect spaces before tabs if a tab was the
last character in the leading indent. Fix that and add a test case to
make sure the bug doesn't regress in the future.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

Although this patch is made to apply on top of the topic I posted
earlier, it can be applied to master with a couple of tweaks. Let
me know if you want me to send such a patch.

In any case, [2/4] and [3/4] factor away the code that had the bug
in it anyway...

 diff.c                     |   13 ++++++++++---
 t/t4015-diff-whitespace.sh |    8 ++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e89c7ce..c9b3884 100644
--- a/diff.c
+++ b/diff.c
@@ -1010,11 +1010,18 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		int i, spaces = 0, space_before_tab = 0, white_space_at_end = 0;
 
 		/* check space before tab */
-		for (i = 1; i < len && (line[i] == ' ' || line[i] == '\t'); i++)
+		for (i = 1; i < len; i++) {
 			if (line[i] == ' ')
 				spaces++;
-		if (line[i - 1] == '\t' && spaces)
-			space_before_tab = 1;
+			else if (line[i] == '\t') {
+				if (spaces) {
+					space_before_tab = 1;
+					break;
+				}
+			}
+			else
+				break;
+		}
 
 		/* check whitespace at line end */
 		if (line[len - 1] == '\n')
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 5aaf2db..ff77a16 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -248,4 +248,12 @@ test_expect_failure 'check with space before tab in indent (diff-tree)' '
 
 '
 
+# was a bug: space before tab only caught if tab was last in the indent
+test_expect_failure 'check mixed spaces and tabs in indent' '
+
+	echo " 	 foo();" > x &&
+	git diff --check
+
+'
+
 test_done
-- 
1.5.3.7.1159.g2f071-dirty
