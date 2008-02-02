From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/13] builtin-apply.c: mark common context lines in lineinfo structure.
Date: Sat,  2 Feb 2008 02:54:12 -0800
Message-ID: <1201949659-27725-7-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
 <1201949659-27725-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2q-0005Ue-IO
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762781AbYBBKyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762705AbYBBKyw
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:52 -0500
Received: from rune.pobox.com ([208.210.124.79]:50270 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762273AbYBBKyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:40 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id E92C0191758
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 49D65191754
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:59 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72253>

This updates the way preimage and postimage in a patch hunk is
parsed and prepared for applying.  By looking at image->line[n].flag,
the code can tell if it is a common context line that is the
same between the preimage and the postimage.

This matters when we actually start applying a patch with
contexts that have whitespace breakages that have already been
fixed in the target file.
---
 builtin-apply.c |   57 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index dc650f1..acd84f9 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -170,6 +170,7 @@ struct line {
 	size_t len;
 	unsigned hash : 24;
 	unsigned flag : 8;
+#define LINE_COMMON     1
 };
 
 /*
@@ -179,6 +180,7 @@ struct image {
 	char *buf;
 	size_t len;
 	size_t nr;
+	size_t alloc;
 	struct line *line_allocated;
 	struct line *line;
 };
@@ -195,49 +197,39 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
+static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
+{
+	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
+	img->line_allocated[img->nr].len = len;
+	img->line_allocated[img->nr].hash = hash_line(bol, len);
+	img->line_allocated[img->nr].flag = flag;
+	img->nr++;
+}
+
 static void prepare_image(struct image *image, char *buf, size_t len,
 			  int prepare_linetable)
 {
 	const char *cp, *ep;
-	int n;
 
+	memset(image, 0, sizeof(*image));
 	image->buf = buf;
 	image->len = len;
 
-	if (!prepare_linetable) {
-		image->line = NULL;
-		image->line_allocated = NULL;
-		image->nr = 0;
+	if (!prepare_linetable)
 		return;
-	}
 
 	ep = image->buf + image->len;
-
-	/* First count lines */
 	cp = image->buf;
-	n = 0;
-	while (cp < ep) {
-		cp = strchrnul(cp, '\n');
-		n++;
-		cp++;
-	}
-
-	image->line_allocated = xcalloc(n, sizeof(struct line));
-	image->line = image->line_allocated;
-	image->nr = n;
-	cp = image->buf;
-	n = 0;
 	while (cp < ep) {
 		const char *next;
 		for (next = cp; next < ep && *next != '\n'; next++)
 			;
 		if (next < ep)
 			next++;
-		image->line[n].len = next - cp;
-		image->line[n].hash = hash_line(cp, next - cp);
+		add_line_info(image, cp, next - cp, 0);
 		cp = next;
-		n++;
 	}
+	image->line = image->line_allocated;
 }
 
 static void clear_image(struct image *image)
@@ -1822,6 +1814,9 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	struct image preimage;
 	struct image postimage;
 
+	memset(&preimage, 0, sizeof(preimage));
+	memset(&postimage, 0, sizeof(postimage));
+
 	while (size > 0) {
 		char first;
 		int len = linelen(patch, size);
@@ -1857,10 +1852,14 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				break;
 			old[oldsize++] = '\n';
 			new[newsize++] = '\n';
+			add_line_info(&preimage, "\n", 1, LINE_COMMON);
+			add_line_info(&postimage, "\n", 1, LINE_COMMON);
 			break;
 		case ' ':
 		case '-':
 			memcpy(old + oldsize, patch + 1, plen);
+			add_line_info(&preimage, old + oldsize, plen,
+				      (first == ' ' ? LINE_COMMON : 0));
 			oldsize += plen;
 			if (first == '-')
 				break;
@@ -1869,6 +1868,9 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 			if (first != '+' || !no_add) {
 				int added = apply_line(new + newsize, patch,
 						       plen, ws_rule);
+				add_line_info(&postimage, new + newsize, added,
+					      (first == '+' ? 0 : LINE_COMMON));
+
 				newsize += added;
 				if (first == '+' &&
 				    added == 1 && new[newsize-1] == '\n')
@@ -1921,8 +1923,13 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	}
 
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
-	prepare_image(&preimage, oldlines, oldsize, 1);
-	prepare_image(&postimage, newlines, newsize, 1);
+	preimage.buf = old;
+	preimage.len = oldsize;
+	postimage.buf = new;
+	postimage.len = newsize;
+	preimage.line = preimage.line_allocated;
+	postimage.line = postimage.line_allocated;
+
 	for (;;) {
 
 		applied_pos = find_pos(img, &preimage, &postimage,
-- 
1.5.4.2.g41ac4
