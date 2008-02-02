From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/13] builtin-apply.c: clean-up apply_one_fragment()
Date: Sat,  2 Feb 2008 02:54:13 -0800
Message-ID: <1201949659-27725-8-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
 <1201949659-27725-6-git-send-email-gitster@pobox.com>
 <1201949659-27725-7-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2r-0005Ue-7v
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbYBBKyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762705AbYBBKyy
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762298AbYBBKyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0187450F4
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A4E750F3
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:42 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72252>

We had two pointer variables pointing to the same buffer and an
integer variable used to index into its tail part that was
active (old, oldlines and oldsize for the preimage, and their
'new' counterparts for the postimage).

To help readability, use 'oldlines' as the allocated pointer,
and use 'old' as the pointer to the tail that advances while the
code builds up the contents in the buffer.  The size 'oldsize'
can be computed as (old-oldines).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |   55 +++++++++++++++++++++++++++----------------------------
 1 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index acd84f9..7fb3305 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1804,10 +1804,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	int match_beginning, match_end;
 	const char *patch = frag->patch;
 	int size = frag->size;
-	char *old = xmalloc(size);
-	char *new = xmalloc(size);
-	char *oldlines, *newlines;
-	int oldsize = 0, newsize = 0;
+	char *old, *new, *oldlines, *newlines;
 	int new_blank_lines_at_end = 0;
 	unsigned long leading, trailing;
 	int pos, applied_pos;
@@ -1816,7 +1813,11 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 
 	memset(&preimage, 0, sizeof(preimage));
 	memset(&postimage, 0, sizeof(postimage));
+	oldlines = xmalloc(size);
+	newlines = xmalloc(size);
 
+	old = oldlines;
+	new = newlines;
 	while (size > 0) {
 		char first;
 		int len = linelen(patch, size);
@@ -1833,7 +1834,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 		 * followed by "\ No newline", then we also remove the
 		 * last one (which is the newline, of course).
 		 */
-		plen = len-1;
+		plen = len - 1;
 		if (len < size && patch[len] == '\\')
 			plen--;
 		first = *patch;
@@ -1850,30 +1851,30 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 			if (plen < 0)
 				/* ... followed by '\No newline'; nothing */
 				break;
-			old[oldsize++] = '\n';
-			new[newsize++] = '\n';
+			*old++ = '\n';
+			*new++ = '\n';
 			add_line_info(&preimage, "\n", 1, LINE_COMMON);
 			add_line_info(&postimage, "\n", 1, LINE_COMMON);
 			break;
 		case ' ':
 		case '-':
-			memcpy(old + oldsize, patch + 1, plen);
-			add_line_info(&preimage, old + oldsize, plen,
+			memcpy(old, patch + 1, plen);
+			add_line_info(&preimage, old, plen,
 				      (first == ' ' ? LINE_COMMON : 0));
-			oldsize += plen;
+			old += plen;
 			if (first == '-')
 				break;
 		/* Fall-through for ' ' */
 		case '+':
 			if (first != '+' || !no_add) {
-				int added = apply_line(new + newsize, patch,
+				int added = apply_line(new, patch,
 						       plen, ws_rule);
-				add_line_info(&postimage, new + newsize, added,
+				add_line_info(&postimage, new, added,
 					      (first == '+' ? 0 : LINE_COMMON));
 
-				newsize += added;
+				new += added;
 				if (first == '+' &&
-				    added == 1 && new[newsize-1] == '\n')
+				    added == 1 && new[-1] == '\n')
 					added_blank_line = 1;
 			}
 			break;
@@ -1892,16 +1893,13 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 		patch += len;
 		size -= len;
 	}
-
 	if (inaccurate_eof &&
-	    oldsize > 0 && old[oldsize - 1] == '\n' &&
-	    newsize > 0 && new[newsize - 1] == '\n') {
-		oldsize--;
-		newsize--;
+	    old > oldlines && old[-1] == '\n' &&
+	    new > newlines && new[-1] == '\n') {
+		old--;
+		new--;
 	}
 
-	oldlines = old;
-	newlines = new;
 	leading = frag->leading;
 	trailing = frag->trailing;
 
@@ -1923,10 +1921,10 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	}
 
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
-	preimage.buf = old;
-	preimage.len = oldsize;
-	postimage.buf = new;
-	postimage.len = newsize;
+	preimage.buf = oldlines;
+	preimage.len = old - oldlines;
+	postimage.buf = newlines;
+	postimage.len = new - newlines;
 	preimage.line = preimage.line_allocated;
 	postimage.line = postimage.line_allocated;
 
@@ -1990,11 +1988,12 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 		update_image(img, applied_pos, &preimage, &postimage);
 	} else {
 		if (apply_verbosely)
-			error("while searching for:\n%.*s", oldsize, oldlines);
+			error("while searching for:\n%.*s",
+			      (int)(old - oldlines), oldlines);
 	}
 
-	free(old);
-	free(new);
+	free(oldlines);
+	free(newlines);
 	free(preimage.line_allocated);
 	free(postimage.line_allocated);
 
-- 
1.5.4.2.g41ac4
