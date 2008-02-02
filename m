From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/13] builtin-apply.c: simplify calling site to apply_line()
Date: Sat,  2 Feb 2008 02:54:14 -0800
Message-ID: <1201949659-27725-9-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
 <1201949659-27725-6-git-send-email-gitster@pobox.com>
 <1201949659-27725-7-git-send-email-gitster@pobox.com>
 <1201949659-27725-8-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2r-0005Ue-Th
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762828AbYBBKy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760623AbYBBKyz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:55 -0500
Received: from rune.pobox.com ([208.210.124.79]:50273 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762342AbYBBKys (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:48 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 24BA019179D
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 92F15191799
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:08 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-8-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72251>

The function apply_line() changed its behaviour depending on the
ws_error_action, whitespace_error and if the input was a context.
Make its caller responsible for such checking so that we can convert
the function to copy the contents of line while fixing whitespace
breakage more easily.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 7fb3305..d0d008f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1642,7 +1642,7 @@ static void remove_last_line(struct image *img)
 	img->len -= img->line[--img->nr].len;
 }
 
-static int apply_line(char *output, const char *patch, int plen,
+static int copy_wsfix(char *output, const char *patch, int plen,
 		      unsigned ws_rule)
 {
 	/*
@@ -1659,12 +1659,6 @@ static int apply_line(char *output, const char *patch, int plen,
 	int need_fix_leading_space = 0;
 	char *buf;
 
-	if ((ws_error_action != correct_ws_error) || !whitespace_error ||
-	    *patch != '+') {
-		memcpy(output, patch + 1, plen);
-		return plen;
-	}
-
 	/*
 	 * Strip trailing whitespace
 	 */
@@ -1821,7 +1815,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	while (size > 0) {
 		char first;
 		int len = linelen(patch, size);
-		int plen;
+		int plen, added;
 		int added_blank_line = 0;
 
 		if (!len)
@@ -1866,17 +1860,25 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				break;
 		/* Fall-through for ' ' */
 		case '+':
-			if (first != '+' || !no_add) {
-				int added = apply_line(new, patch,
-						       plen, ws_rule);
-				add_line_info(&postimage, new, added,
-					      (first == '+' ? 0 : LINE_COMMON));
-
-				new += added;
-				if (first == '+' &&
-				    added == 1 && new[-1] == '\n')
-					added_blank_line = 1;
+			/* --no-add does not add new lines */
+			if (first == '+' && no_add)
+				break;
+
+			if (first != '+' ||
+			    !whitespace_error ||
+			    ws_error_action != correct_ws_error) {
+				memcpy(new, patch + 1, plen);
+				added = plen;
+			}
+			else {
+				added = copy_wsfix(new, patch, plen, ws_rule);
 			}
+			add_line_info(&postimage, new, added,
+				      (first == '+' ? 0 : LINE_COMMON));
+			new += added;
+			if (first == '+' &&
+			    added == 1 && new[-1] == '\n')
+				added_blank_line = 1;
 			break;
 		case '@': case '\\':
 			/* Ignore it, we already handled it */
-- 
1.5.4.2.g41ac4
