From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/13] builtin-apply.c: move copy_wsfix() function a bit higher.
Date: Sat,  2 Feb 2008 02:54:16 -0800
Message-ID: <1201949659-27725-11-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
 <1201949659-27725-6-git-send-email-gitster@pobox.com>
 <1201949659-27725-7-git-send-email-gitster@pobox.com>
 <1201949659-27725-8-git-send-email-gitster@pobox.com>
 <1201949659-27725-9-git-send-email-gitster@pobox.com>
 <1201949659-27725-10-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2t-0005Ue-6n
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762881AbYBBKzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762915AbYBBKy7
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762342AbYBBKy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 501EA50F6
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DB150F5
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:53 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-10-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72254>

I'll be calling this from match_fragment() in later rounds.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |  188 +++++++++++++++++++++++++++---------------------------
 1 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 0bc33bd..2af625a 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1515,6 +1515,100 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	}
 }
 
+static int copy_wsfix(char *output, const char *patch, int plen,
+		      unsigned ws_rule)
+{
+	/*
+	 * plen is number of bytes to be copied from patch, starting
+	 * at patch.  Typically patch[plen-1] is '\n', unless this is
+	 * the incomplete last line.
+	 */
+	int i;
+	int add_nl_to_tail = 0;
+	int fixed = 0;
+	int last_tab_in_indent = -1;
+	int last_space_in_indent = -1;
+	int need_fix_leading_space = 0;
+	char *buf;
+
+	/*
+	 * Strip trailing whitespace
+	 */
+	if ((ws_rule & WS_TRAILING_SPACE) &&
+	    (2 < plen && isspace(patch[plen-2]))) {
+		if (patch[plen-1] == '\n')
+			add_nl_to_tail = 1;
+		plen--;
+		while (0 < plen && isspace(patch[plen-1]))
+			plen--;
+		fixed = 1;
+	}
+
+	/*
+	 * Check leading whitespaces (indent)
+	 */
+	for (i = 0; i < plen; i++) {
+		char ch = patch[i];
+		if (ch == '\t') {
+			last_tab_in_indent = i;
+			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
+			    0 <= last_space_in_indent)
+			    need_fix_leading_space = 1;
+		} else if (ch == ' ') {
+			last_space_in_indent = i;
+			if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
+			    8 <= i - last_tab_in_indent)
+				need_fix_leading_space = 1;
+		} else
+			break;
+	}
+
+	buf = output;
+	if (need_fix_leading_space) {
+		/* Process indent ourselves */
+		int consecutive_spaces = 0;
+		int last = last_tab_in_indent + 1;
+
+		if (ws_rule & WS_INDENT_WITH_NON_TAB) {
+			/* have "last" point at one past the indent */
+			if (last_tab_in_indent < last_space_in_indent)
+				last = last_space_in_indent + 1;
+			else
+				last = last_tab_in_indent + 1;
+		}
+
+		/*
+		 * between patch[0..last-1], strip the funny spaces,
+		 * updating them to tab as needed.
+		 */
+		for (i = 0; i < last; i++) {
+			char ch = patch[i];
+			if (ch != ' ') {
+				consecutive_spaces = 0;
+				*output++ = ch;
+			} else {
+				consecutive_spaces++;
+				if (consecutive_spaces == 8) {
+					*output++ = '\t';
+					consecutive_spaces = 0;
+				}
+			}
+		}
+		while (0 < consecutive_spaces--)
+			*output++ = ' ';
+		plen -= last;
+		patch += last;
+		fixed = 1;
+	}
+
+	memcpy(output, patch, plen);
+	if (add_nl_to_tail)
+		output[plen++] = '\n';
+	if (fixed)
+		applied_after_fixing_ws++;
+	return output + plen - buf;
+}
+
 static int match_fragment(struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
@@ -1642,100 +1736,6 @@ static void remove_last_line(struct image *img)
 	img->len -= img->line[--img->nr].len;
 }
 
-static int copy_wsfix(char *output, const char *patch, int plen,
-		      unsigned ws_rule)
-{
-	/*
-	 * plen is number of bytes to be copied from patch, starting
-	 * at patch.  Typically patch[plen-1] is '\n', unless this is
-	 * the incomplete last line.
-	 */
-	int i;
-	int add_nl_to_tail = 0;
-	int fixed = 0;
-	int last_tab_in_indent = -1;
-	int last_space_in_indent = -1;
-	int need_fix_leading_space = 0;
-	char *buf;
-
-	/*
-	 * Strip trailing whitespace
-	 */
-	if ((ws_rule & WS_TRAILING_SPACE) &&
-	    (2 < plen && isspace(patch[plen-2]))) {
-		if (patch[plen-1] == '\n')
-			add_nl_to_tail = 1;
-		plen--;
-		while (0 < plen && isspace(patch[plen-1]))
-			plen--;
-		fixed = 1;
-	}
-
-	/*
-	 * Check leading whitespaces (indent)
-	 */
-	for (i = 0; i < plen; i++) {
-		char ch = patch[i];
-		if (ch == '\t') {
-			last_tab_in_indent = i;
-			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
-			    0 <= last_space_in_indent)
-			    need_fix_leading_space = 1;
-		} else if (ch == ' ') {
-			last_space_in_indent = i;
-			if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
-			    8 <= i - last_tab_in_indent)
-				need_fix_leading_space = 1;
-		} else
-			break;
-	}
-
-	buf = output;
-	if (need_fix_leading_space) {
-		/* Process indent ourselves */
-		int consecutive_spaces = 0;
-		int last = last_tab_in_indent + 1;
-
-		if (ws_rule & WS_INDENT_WITH_NON_TAB) {
-			/* have "last" point at one past the indent */
-			if (last_tab_in_indent < last_space_in_indent)
-				last = last_space_in_indent + 1;
-			else
-				last = last_tab_in_indent + 1;
-		}
-
-		/*
-		 * between patch[0..last-1], strip the funny spaces,
-		 * updating them to tab as needed.
-		 */
-		for (i = 0; i < last; i++) {
-			char ch = patch[i];
-			if (ch != ' ') {
-				consecutive_spaces = 0;
-				*output++ = ch;
-			} else {
-				consecutive_spaces++;
-				if (consecutive_spaces == 8) {
-					*output++ = '\t';
-					consecutive_spaces = 0;
-				}
-			}
-		}
-		while (0 < consecutive_spaces--)
-			*output++ = ' ';
-		plen -= last;
-		patch += last;
-		fixed = 1;
-	}
-
-	memcpy(output, patch, plen);
-	if (add_nl_to_tail)
-		output[plen++] = '\n';
-	if (fixed)
-		applied_after_fixing_ws++;
-	return output + plen - buf;
-}
-
 static void update_image(struct image *img,
 			 int applied_pos,
 			 struct image *preimage,
-- 
1.5.4.2.g41ac4
