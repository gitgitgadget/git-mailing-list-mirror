From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 4/6] whitespace: replumb ws_fix_copy to take a strbuf *dst
 instead of char *dst
Date: Sat, 3 Apr 2010 00:37:23 +0100
Message-ID: <7608421896a8d149a3f0746d84eafd38441083d5.1270250437.git.chris@arachsys.com>
References: <cover.1270250437.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 01:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxqQp-00051w-Ou
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 01:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab0DBXha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 19:37:30 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:39393 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab0DBXhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 19:37:25 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NxqQV-0004wu-LE; Sat, 03 Apr 2010 00:37:24 +0100
Content-Disposition: inline
In-Reply-To: <cover.1270250437.git.chris@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143866>

To implement --whitespace=fix for tab-in-indent, we have to allow for the
possibility that whitespace can increase in size when it is fixed, expanding
tabs to to multiple spaces in the initial indent.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/apply.c |   81 ++++++++++++++++++++++++++----------------------------
 cache.h         |    2 +-
 ws.c            |   19 +++++-------
 3 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7ca9047..db9cbdd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1854,6 +1854,8 @@ static int match_fragment(struct image *img,
 {
 	int i;
 	char *fixed_buf, *buf, *orig, *target;
+	struct strbuf fixed;
+	size_t fixed_len;
 	int preimage_limit;
 
 	if (preimage->nr + try_lno <= img->nr) {
@@ -1977,12 +1979,12 @@ static int match_fragment(struct image *img,
 		 * use the whitespace from the preimage.
 		 */
 		extra_chars = preimage_end - preimage_eof;
-		fixed_buf = xmalloc(imgoff + extra_chars);
-		memcpy(fixed_buf, img->buf + try, imgoff);
-		memcpy(fixed_buf + imgoff, preimage_eof, extra_chars);
-		imgoff += extra_chars;
+		strbuf_init(&fixed, imgoff + extra_chars);
+		strbuf_add(&fixed, img->buf + try, imgoff);
+		strbuf_add(&fixed, preimage_eof, extra_chars);
+		fixed_buf = strbuf_detach(&fixed, &fixed_len);
 		update_pre_post_images(preimage, postimage,
-				fixed_buf, imgoff, postlen);
+				fixed_buf, fixed_len, postlen);
 		return 1;
 	}
 
@@ -1999,27 +2001,22 @@ static int match_fragment(struct image *img,
 	 * but in this loop we will only handle the part of the
 	 * preimage that falls within the file.
 	 */
-	fixed_buf = xmalloc(preimage->len + 1);
-	buf = fixed_buf;
+	strbuf_init(&fixed, preimage->len + 1);
 	orig = preimage->buf;
 	target = img->buf + try;
 	for (i = 0; i < preimage_limit; i++) {
-		size_t fixlen; /* length after fixing the preimage */
 		size_t oldlen = preimage->line[i].len;
 		size_t tgtlen = img->line[try_lno + i].len;
-		size_t tgtfixlen; /* length after fixing the target line */
-		char tgtfixbuf[1024], *tgtfix;
+		size_t fixstart = fixed.len;
+		struct strbuf tgtfix;
 		int match;
 
 		/* Try fixing the line in the preimage */
-		fixlen = ws_fix_copy(buf, orig, oldlen, ws_rule, NULL);
+		ws_fix_copy(&fixed, orig, oldlen, ws_rule, NULL);
 
 		/* Try fixing the line in the target */
-		if (sizeof(tgtfixbuf) > tgtlen)
-			tgtfix = tgtfixbuf;
-		else
-			tgtfix = xmalloc(tgtlen);
-		tgtfixlen = ws_fix_copy(tgtfix, target, tgtlen, ws_rule, NULL);
+		strbuf_init(&tgtfix, tgtlen);
+		ws_fix_copy(&tgtfix, target, tgtlen, ws_rule, NULL);
 
 		/*
 		 * If they match, either the preimage was based on
@@ -2031,15 +2028,15 @@ static int match_fragment(struct image *img,
 		 * so we might as well take the fix together with their
 		 * real change.
 		 */
-		match = (tgtfixlen == fixlen && !memcmp(tgtfix, buf, fixlen));
+		match = (tgtfix.len == fixed.len - fixstart &&
+			 !memcmp(tgtfix.buf, fixed.buf + fixstart,
+					     fixed.len - fixstart));
 
-		if (tgtfix != tgtfixbuf)
-			free(tgtfix);
+		strbuf_release(&tgtfix);
 		if (!match)
 			goto unmatch_exit;
 
 		orig += oldlen;
-		buf += fixlen;
 		target += tgtlen;
 	}
 
@@ -2051,19 +2048,18 @@ static int match_fragment(struct image *img,
 	 * false).
 	 */
 	for ( ; i < preimage->nr; i++) {
-		size_t fixlen; /* length after fixing the preimage */
+		size_t fixstart = fixed.len; /* start of the fixed preimage */
 		size_t oldlen = preimage->line[i].len;
 		int j;
 
 		/* Try fixing the line in the preimage */
-		fixlen = ws_fix_copy(buf, orig, oldlen, ws_rule, NULL);
+		ws_fix_copy(&fixed, orig, oldlen, ws_rule, NULL);
 
-		for (j = 0; j < fixlen; j++)
-			if (!isspace(buf[j]))
+		for (j = fixstart; j < fixed.len; j++)
+			if (!isspace(fixed.buf[j]))
 				goto unmatch_exit;
 
 		orig += oldlen;
-		buf += fixlen;
 	}
 
 	/*
@@ -2071,12 +2067,13 @@ static int match_fragment(struct image *img,
 	 * has whitespace breakages unfixed, and fixing them makes the
 	 * hunk match.  Update the context lines in the postimage.
 	 */
+	fixed_buf = strbuf_detach(&fixed, &fixed_len);
 	update_pre_post_images(preimage, postimage,
-			       fixed_buf, buf - fixed_buf, 0);
+			       fixed_buf, fixed_len, 0);
 	return 1;
 
  unmatch_exit:
-	free(fixed_buf);
+	strbuf_release(&fixed);
 	return 0;
 }
 
@@ -2244,7 +2241,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	int match_beginning, match_end;
 	const char *patch = frag->patch;
 	int size = frag->size;
-	char *old, *new, *oldlines, *newlines;
+	char *old, *oldlines;
+	struct strbuf newlines;
 	int new_blank_lines_at_end = 0;
 	unsigned long leading, trailing;
 	int pos, applied_pos;
@@ -2254,16 +2252,16 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	memset(&preimage, 0, sizeof(preimage));
 	memset(&postimage, 0, sizeof(postimage));
 	oldlines = xmalloc(size);
-	newlines = xmalloc(size);
+	strbuf_init(&newlines, size);
 
 	old = oldlines;
-	new = newlines;
 	while (size > 0) {
 		char first;
 		int len = linelen(patch, size);
-		int plen, added;
+		int plen;
 		int added_blank_line = 0;
 		int is_blank_context = 0;
+		size_t start;
 
 		if (!len)
 			break;
@@ -2293,7 +2291,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				/* ... followed by '\No newline'; nothing */
 				break;
 			*old++ = '\n';
-			*new++ = '\n';
+			strbuf_addch(&newlines, '\n');
 			add_line_info(&preimage, "\n", 1, LINE_COMMON);
 			add_line_info(&postimage, "\n", 1, LINE_COMMON);
 			is_blank_context = 1;
@@ -2315,18 +2313,17 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 			if (first == '+' && no_add)
 				break;
 
+			start = newlines.len;
 			if (first != '+' ||
 			    !whitespace_error ||
 			    ws_error_action != correct_ws_error) {
-				memcpy(new, patch + 1, plen);
-				added = plen;
+				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
-				added = ws_fix_copy(new, patch + 1, plen, ws_rule, &applied_after_fixing_ws);
+				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &applied_after_fixing_ws);
 			}
-			add_line_info(&postimage, new, added,
+			add_line_info(&postimage, newlines.buf + start, newlines.len - start,
 				      (first == '+' ? 0 : LINE_COMMON));
-			new += added;
 			if (first == '+' &&
 			    (ws_rule & WS_BLANK_AT_EOF) &&
 			    ws_blank_line(patch + 1, plen, ws_rule))
@@ -2351,9 +2348,9 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	}
 	if (inaccurate_eof &&
 	    old > oldlines && old[-1] == '\n' &&
-	    new > newlines && new[-1] == '\n') {
+	    newlines.len > 0 && newlines.buf[newlines.len - 1] == '\n') {
 		old--;
-		new--;
+		strbuf_setlen(&newlines, newlines.len - 1);
 	}
 
 	leading = frag->leading;
@@ -2385,8 +2382,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
 	preimage.buf = oldlines;
 	preimage.len = old - oldlines;
-	postimage.buf = newlines;
-	postimage.len = new - newlines;
+	postimage.buf = newlines.buf;
+	postimage.len = newlines.len;
 	preimage.line = preimage.line_allocated;
 	postimage.line = postimage.line_allocated;
 
@@ -2462,7 +2459,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	}
 
 	free(oldlines);
-	free(newlines);
+	strbuf_release(&newlines);
 	free(preimage.line_allocated);
 	free(postimage.line_allocated);
 
diff --git a/cache.h b/cache.h
index 030af32..3b7f3b0 100644
--- a/cache.h
+++ b/cache.h
@@ -1049,7 +1049,7 @@ extern unsigned parse_whitespace_rule(const char *);
 extern unsigned ws_check(const char *line, int len, unsigned ws_rule);
 extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
 extern char *whitespace_error_string(unsigned ws);
-extern int ws_fix_copy(char *, const char *, int, unsigned, int *);
+extern void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
 extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 
 /* ls-files */
diff --git a/ws.c b/ws.c
index 0302ef5..897ff56 100644
--- a/ws.c
+++ b/ws.c
@@ -271,8 +271,8 @@ int ws_blank_line(const char *line, int len, unsigned ws_rule)
 	return 1;
 }
 
-/* Copy the line to the buffer while fixing whitespaces */
-int ws_fix_copy(char *dst, const char *src, int len, unsigned ws_rule, int *error_count)
+/* Copy the line onto the end of the strbuf while fixing whitespaces */
+void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule, int *error_count)
 {
 	/*
 	 * len is number of bytes to be copied from src, starting
@@ -286,7 +286,6 @@ int ws_fix_copy(char *dst, const char *src, int len, unsigned ws_rule, int *erro
 	int last_tab_in_indent = -1;
 	int last_space_in_indent = -1;
 	int need_fix_leading_space = 0;
-	char *buf;
 
 	/*
 	 * Strip trailing whitespace
@@ -326,7 +325,6 @@ int ws_fix_copy(char *dst, const char *src, int len, unsigned ws_rule, int *erro
 			break;
 	}
 
-	buf = dst;
 	if (need_fix_leading_space) {
 		/* Process indent ourselves */
 		int consecutive_spaces = 0;
@@ -348,28 +346,27 @@ int ws_fix_copy(char *dst, const char *src, int len, unsigned ws_rule, int *erro
 			char ch = src[i];
 			if (ch != ' ') {
 				consecutive_spaces = 0;
-				*dst++ = ch;
+				strbuf_addch(dst, ch);
 			} else {
 				consecutive_spaces++;
 				if (consecutive_spaces == 8) {
-					*dst++ = '\t';
+					strbuf_addch(dst, '\t');
 					consecutive_spaces = 0;
 				}
 			}
 		}
 		while (0 < consecutive_spaces--)
-			*dst++ = ' ';
+			strbuf_addch(dst, ' ');
 		len -= last;
 		src += last;
 		fixed = 1;
 	}
 
-	memcpy(dst, src, len);
+	strbuf_add(dst, src, len);
 	if (add_cr_to_tail)
-		dst[len++] = '\r';
+		strbuf_addch(dst, '\r');
 	if (add_nl_to_tail)
-		dst[len++] = '\n';
+		strbuf_addch(dst, '\n');
 	if (fixed && error_count)
 		(*error_count)++;
-	return dst + len - buf;
 }
-- 
1.7.0.3
