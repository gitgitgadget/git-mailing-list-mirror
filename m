From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/13] builtin-apply.c: do not feed copy_wsfix() leading '+'
Date: Sat,  2 Feb 2008 02:54:15 -0800
Message-ID: <1201949659-27725-10-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
 <1201949659-27725-6-git-send-email-gitster@pobox.com>
 <1201949659-27725-7-git-send-email-gitster@pobox.com>
 <1201949659-27725-8-git-send-email-gitster@pobox.com>
 <1201949659-27725-9-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2s-0005Ue-I0
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762992AbYBBKy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762881AbYBBKy5
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:57 -0500
Received: from rune.pobox.com ([208.210.124.79]:50277 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762655AbYBBKyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:52 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 73B5C1917B4
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D0A841917AF
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:11 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-9-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72257>

The "patch" parameter used to include leading '+' of an added
line in the patch, and the array was treated as 1-based.  Make
it accept the contents of the line alone and simplify the code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |   38 ++++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index d0d008f..0bc33bd 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1646,16 +1646,15 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 		      unsigned ws_rule)
 {
 	/*
-	 * plen is number of bytes to be copied from patch,
-	 * starting at patch+1 (patch[0] is '+').  Typically
-	 * patch[plen] is '\n', unless this is the incomplete
-	 * last line.
+	 * plen is number of bytes to be copied from patch, starting
+	 * at patch.  Typically patch[plen-1] is '\n', unless this is
+	 * the incomplete last line.
 	 */
 	int i;
 	int add_nl_to_tail = 0;
 	int fixed = 0;
-	int last_tab_in_indent = 0;
-	int last_space_in_indent = 0;
+	int last_tab_in_indent = -1;
+	int last_space_in_indent = -1;
 	int need_fix_leading_space = 0;
 	char *buf;
 
@@ -1663,11 +1662,11 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 	 * Strip trailing whitespace
 	 */
 	if ((ws_rule & WS_TRAILING_SPACE) &&
-	    (1 < plen && isspace(patch[plen-1]))) {
-		if (patch[plen] == '\n')
+	    (2 < plen && isspace(patch[plen-2]))) {
+		if (patch[plen-1] == '\n')
 			add_nl_to_tail = 1;
 		plen--;
-		while (0 < plen && isspace(patch[plen]))
+		while (0 < plen && isspace(patch[plen-1]))
 			plen--;
 		fixed = 1;
 	}
@@ -1675,25 +1674,25 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 	/*
 	 * Check leading whitespaces (indent)
 	 */
-	for (i = 1; i < plen; i++) {
+	for (i = 0; i < plen; i++) {
 		char ch = patch[i];
 		if (ch == '\t') {
 			last_tab_in_indent = i;
 			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
-			    0 < last_space_in_indent)
+			    0 <= last_space_in_indent)
 			    need_fix_leading_space = 1;
 		} else if (ch == ' ') {
 			last_space_in_indent = i;
 			if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
 			    8 <= i - last_tab_in_indent)
 				need_fix_leading_space = 1;
-		}
-		else
+		} else
 			break;
 	}
 
 	buf = output;
 	if (need_fix_leading_space) {
+		/* Process indent ourselves */
 		int consecutive_spaces = 0;
 		int last = last_tab_in_indent + 1;
 
@@ -1706,10 +1705,10 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 		}
 
 		/*
-		 * between patch[1..last], strip the funny spaces,
+		 * between patch[0..last-1], strip the funny spaces,
 		 * updating them to tab as needed.
 		 */
-		for (i = 1; i < last; i++, plen--) {
+		for (i = 0; i < last; i++) {
 			char ch = patch[i];
 			if (ch != ' ') {
 				consecutive_spaces = 0;
@@ -1724,13 +1723,12 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 		}
 		while (0 < consecutive_spaces--)
 			*output++ = ' ';
+		plen -= last;
+		patch += last;
 		fixed = 1;
-		i = last;
 	}
-	else
-		i = 1;
 
-	memcpy(output, patch + i, plen);
+	memcpy(output, patch, plen);
 	if (add_nl_to_tail)
 		output[plen++] = '\n';
 	if (fixed)
@@ -1871,7 +1869,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				added = plen;
 			}
 			else {
-				added = copy_wsfix(new, patch, plen, ws_rule);
+				added = copy_wsfix(new, patch + 1, plen, ws_rule);
 			}
 			add_line_info(&postimage, new, added,
 				      (first == '+' ? 0 : LINE_COMMON));
-- 
1.5.4.2.g41ac4
