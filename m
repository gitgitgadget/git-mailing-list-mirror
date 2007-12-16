From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] whitespace: minor cleanup
Date: Sat, 15 Dec 2007 22:48:36 -0500
Message-ID: <1197776919-16121-4-git-send-email-bfields@citi.umich.edu>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
 <1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-2-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kVc-0003KB-KO
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbXLPDsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758913AbXLPDsy
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:48:54 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56277 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475AbXLPDsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:48:47 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3kUa-0004F3-Fw; Sat, 15 Dec 2007 22:48:40 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68436>

The variable leading_space is initially used to represent the index of
the last space seen before a non-space.  Then later it represents the
index of the first non-indent character.

It will prove simpler to replace it by a variable representing a number
of bytes.  Eventually it will represent the number of bytes written so
far (in the stream != NULL case).

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 ws.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/ws.c b/ws.c
index 7165874..1b32e45 100644
--- a/ws.c
+++ b/ws.c
@@ -121,7 +121,7 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 			     const char *reset, const char *ws)
 {
 	unsigned result = 0;
-	int leading_space = -1;
+	int written = 0;
 	int trailing_whitespace = -1;
 	int trailing_newline = 0;
 	int i;
@@ -147,18 +147,18 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 	/* Check for space before tab in initial indent. */
 	for (i = 0; i < len; i++) {
 		if (line[i] == ' ') {
-			leading_space = i;
+			written = i + 1;
 			continue;
 		}
 		if (line[i] != '\t')
 			break;
-		if ((ws_rule & WS_SPACE_BEFORE_TAB) && (leading_space != -1))
+		if ((ws_rule & WS_SPACE_BEFORE_TAB) && (written != 0))
 			result |= WS_SPACE_BEFORE_TAB;
 		break;
 	}
 
 	/* Check for indent using non-tab. */
-	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && leading_space >= 7)
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && written >= 8)
 		result |= WS_INDENT_WITH_NON_TAB;
 
 	if (stream) {
@@ -166,23 +166,20 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 		if ((result & WS_SPACE_BEFORE_TAB) ||
 		    (result & WS_INDENT_WITH_NON_TAB)) {
 			fputs(ws, stream);
-			fwrite(line, leading_space + 1, 1, stream);
+			fwrite(line, written, 1, stream);
 			fputs(reset, stream);
-			leading_space++;
 		}
-		else
-			leading_space = 0;
 
-		/* Now the rest of the line starts at leading_space.
+		/* Now the rest of the line starts at written.
 		 * The non-highlighted part ends at trailing_whitespace. */
 		if (trailing_whitespace == -1)
 			trailing_whitespace = len;
 
 		/* Emit non-highlighted (middle) segment. */
-		if (trailing_whitespace - leading_space > 0) {
+		if (trailing_whitespace - written > 0) {
 			fputs(set, stream);
-			fwrite(line + leading_space,
-			    trailing_whitespace - leading_space, 1, stream);
+			fwrite(line + written,
+			    trailing_whitespace - written, 1, stream);
 			fputs(reset, stream);
 		}
 
-- 
1.5.4.rc0.41.gf723
