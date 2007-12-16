From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] whitespace: more accurate initial-indent highlighting
Date: Sat, 15 Dec 2007 22:48:38 -0500
Message-ID: <1197776919-16121-6-git-send-email-bfields@citi.umich.edu>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
 <1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-2-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-4-git-send-email-bfields@citi.umich.edu>
 <1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kVb-0003KB-6S
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758832AbXLPDsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758812AbXLPDsu
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:48:50 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56272 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327AbXLPDsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:48:47 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3kUb-0004F7-3P; Sat, 15 Dec 2007 22:48:41 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68433>

Instead of highlighting the entire initial indent, highlight only the
problematic spaces.

In the case of an indent like ' \t \t' there may be multiple problematic
ranges, so it's easiest to emit the highlighting as we go instead of
trying rember disjoint ranges and do it all at the end.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 ws.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/ws.c b/ws.c
index aabd509..d09b9df 100644
--- a/ws.c
+++ b/ws.c
@@ -150,24 +150,32 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 			continue;
 		if (line[i] != '\t')
 			break;
-		if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i)
+		if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i) {
 			result |= WS_SPACE_BEFORE_TAB;
+			if (stream) {
+				fputs(ws, stream);
+				fwrite(line + written, i - written, 1, stream);
+				fputs(reset, stream);
+			}
+		} else if (stream)
+			fwrite(line + written, i - written, 1, stream);
+		if (stream)
+			fwrite(line + i, 1, 1, stream);
 		written = i + 1;
 	}
 
 	/* Check for indent using non-tab. */
-	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && i - written >= 8)
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && i - written >= 8) {
 		result |= WS_INDENT_WITH_NON_TAB;
-
-	if (stream) {
-		/* Highlight errors in leading whitespace. */
-		if ((result & WS_SPACE_BEFORE_TAB) ||
-		    (result & WS_INDENT_WITH_NON_TAB)) {
+		if (stream) {
 			fputs(ws, stream);
-			fwrite(line, written, 1, stream);
+			fwrite(line + written, i - written, 1, stream);
 			fputs(reset, stream);
 		}
+		written = i;
+	}
 
+	if (stream) {
 		/* Now the rest of the line starts at written.
 		 * The non-highlighted part ends at trailing_whitespace. */
 		if (trailing_whitespace == -1)
-- 
1.5.4.rc0.41.gf723
