From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] whitespace: fix initial-indent checking
Date: Sat, 15 Dec 2007 22:48:37 -0500
Message-ID: <1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
 <1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-2-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-4-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kVb-0003KB-Sw
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758912AbXLPDsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758838AbXLPDsw
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:48:52 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56270 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757167AbXLPDsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:48:47 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3kUa-0004F5-PV; Sat, 15 Dec 2007 22:48:40 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197776919-16121-4-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68434>

After this patch, "written" counts the number of bytes up to and
including the most recently seen tab.  This allows us to detect (and
count) spaces by comparing to "i".

This allows catching initial indents like '\t        ' (a tab followed
by 8 spaces), while previously indent-with-non-tab caught only indents
that consisted entirely of spaces.

This also allows fixing an indent-with-non-tab regression, so we can
again detect indents like '\t \t'.

Also update tests to catch these cases.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 t/t4015-diff-whitespace.sh |   15 +++++++++++++++
 ws.c                       |   10 ++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 0f16bca..d30169f 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -125,6 +125,14 @@ test_expect_success 'check mixed spaces and tabs in indent' '
 
 '
 
+test_expect_success 'check mixed tabs and spaces in indent' '
+
+	# This is indented with HT SP HT.
+	echo "	 	foo();" > x &&
+	git diff --check | grep "space before tab in indent"
+
+'
+
 test_expect_success 'check with no whitespace errors' '
 
 	git commit -m "snapshot" &&
@@ -311,4 +319,11 @@ test_expect_success 'check spaces as indentation (indent-with-non-tab: on)' '
 
 '
 
+test_expect_success 'check tabs and spaces as indentation (indent-with-non-tab: on)' '
+
+	git config core.whitespace "indent-with-non-tab" &&
+	echo "	                foo ();" > x &&
+	! git diff --check
+
+'
 test_done
diff --git a/ws.c b/ws.c
index 1b32e45..aabd509 100644
--- a/ws.c
+++ b/ws.c
@@ -146,19 +146,17 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 
 	/* Check for space before tab in initial indent. */
 	for (i = 0; i < len; i++) {
-		if (line[i] == ' ') {
-			written = i + 1;
+		if (line[i] == ' ')
 			continue;
-		}
 		if (line[i] != '\t')
 			break;
-		if ((ws_rule & WS_SPACE_BEFORE_TAB) && (written != 0))
+		if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i)
 			result |= WS_SPACE_BEFORE_TAB;
-		break;
+		written = i + 1;
 	}
 
 	/* Check for indent using non-tab. */
-	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && written >= 8)
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && i - written >= 8)
 		result |= WS_INDENT_WITH_NON_TAB;
 
 	if (stream) {
-- 
1.5.4.rc0.41.gf723
