From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/13] builtin-apply.c: make it more line oriented
Date: Sat,  2 Feb 2008 02:54:10 -0800
Message-ID: <1201949659-27725-5-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2o-0005Ue-Ql
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762549AbYBBKyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762252AbYBBKys
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762223AbYBBKye (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A32D50F0
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 60B0E50EF
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:31 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72250>

This changes the way git-apply internally works to be more line
oriented.  The logic to find where the patch applies with offset
used to count line numbers by always counting LF from the
beginning of the buffer, but it is simplified because we count
the line length of the target file and the preimage snippet
upfront now.

The ultimate motivation is to allow applying patches
whose preimage context has whitespace corruption that has
already been corrected in the local copy.  For that purpose, we
introduce a table of line-hash that allows us to match lines
that differ only in whitespaces.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |  403 ++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 280 insertions(+), 123 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index f84a405..e046e87 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -161,6 +161,92 @@ struct patch {
 	struct patch *next;
 };
 
+/*
+ * A line in a file, len-bytes long (includes the terminating LF,
+ * except for an incomplete line at the end if the file ends with
+ * one), and its contents hashes to 'hash'.
+ */
+struct line {
+	size_t len;
+	unsigned hash : 24;
+	unsigned flag : 8;
+};
+
+/*
+ * This represents a "file", which is an array of "lines".
+ */
+struct image {
+	char *buf;
+	size_t len;
+	size_t nr;
+	struct line *line_allocated;
+	struct line *line;
+};
+
+static uint32_t hash_line(const char *cp, size_t len)
+{
+	size_t i;
+	uint32_t h;
+	for (i = 0, h = 0; i < len; i++) {
+		if (!isspace(cp[i])) {
+			h = h * 3 + (cp[i] & 0xff);
+		}
+	}
+	return h;
+}
+
+static void prepare_image(struct image *image, char *buf, size_t len,
+			  int prepare_linetable)
+{
+	const char *cp, *ep;
+	int n;
+
+	image->buf = buf;
+	image->len = len;
+
+	if (!prepare_linetable) {
+		image->line = NULL;
+		image->line_allocated = NULL;
+		image->nr = 0;
+		return;
+	}
+
+	ep = image->buf + image->len;
+
+	/* First count lines */
+	cp = image->buf;
+	n = 0;
+	while (cp < ep) {
+		cp = strchrnul(cp, '\n');
+		n++;
+		cp++;
+	}
+
+	image->line_allocated = xcalloc(n, sizeof(struct line));
+	image->line = image->line_allocated;
+	image->nr = n;
+	cp = image->buf;
+	n = 0;
+	while (cp < ep) {
+		const char *next;
+		for (next = cp; next < ep && *next != '\n'; next++)
+			;
+		if (next < ep)
+			next++;
+		image->line[n].len = next - cp;
+		image->line[n].hash = hash_line(cp, next - cp);
+		cp = next;
+		n++;
+	}
+}
+
+static void clear_image(struct image *image)
+{
+	free(image->buf);
+	image->buf = NULL;
+	image->len = 0;
+}
+
 static void say_patch_name(FILE *output, const char *pre,
 			   struct patch *patch, const char *post)
 {
@@ -1437,14 +1523,29 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	}
 }
 
-static int match_fragment(const char *buf, unsigned long size,
+static int match_fragment(struct image *img,
+			  struct image *preimage,
+			  struct image *postimage,
 			  unsigned long try,
-			  const char *fragment, unsigned long fragsize,
+			  int try_lno,
 			  int match_beginning, int match_end)
 {
-	if (match_beginning && try)
+	int i;
+
+	if (preimage->nr + try_lno > img->nr)
+		return 0;
+
+	if (match_beginning && try_lno)
+		return 0;
+
+	if (match_end && preimage->nr + try_lno != img->nr)
 		return 0;
 
+	/* Quick hash check */
+	for (i = 0; i < preimage->nr; i++)
+		if (preimage->line[i].hash != img->line[try_lno + i].hash)
+			return 0;
+
 	/*
 	 * Do we have an exact match?  If we were told to match
 	 * at the end, size must be exactly at try+fragsize,
@@ -1453,9 +1554,9 @@ static int match_fragment(const char *buf, unsigned long size,
 	 * exactly.
 	 */
 	if ((match_end
-	     ? (try + fragsize == size)
-	     : (try + fragsize <= size)) &&
-	    !memcmp(buf + try, fragment, fragsize))
+	     ? (try + preimage->len == img->len)
+	     : (try + preimage->len <= img->len)) &&
+	    !memcmp(img->buf + try, preimage->buf, preimage->len))
 		return 1;
 
 	/*
@@ -1465,105 +1566,78 @@ static int match_fragment(const char *buf, unsigned long size,
 	return 0;
 }
 
-static int find_offset(const char *buf, unsigned long size,
-		       const char *fragment, unsigned long fragsize,
-		       int line, int *lines,
-		       int match_beginning, int match_end)
+static int find_pos(struct image *img,
+		    struct image *preimage,
+		    struct image *postimage,
+		    int line,
+		    int match_beginning, int match_end)
 {
-	int i, no_more_backwards, no_more_forwards;
-	unsigned long start, backwards, forwards, try;
+	int i;
+	unsigned long backwards, forwards, try;
+	int backwards_lno, forwards_lno, try_lno;
 
-	if (fragsize > size)
+	if (preimage->nr > img->nr)
 		return -1;
 
-	start = 0;
-	if (line > 1) {
-		unsigned long offset = 0;
-		i = line-1;
-		while (offset + fragsize <= size) {
-			if (buf[offset++] == '\n') {
-				start = offset;
-				if (!--i)
-					break;
-			}
-		}
-	}
+	try = 0;
+	for (i = 0; i < line; i++)
+		try += img->line[i].len;
 
 	/*
 	 * There's probably some smart way to do this, but I'll leave
 	 * that to the smart and beautiful people. I'm simple and stupid.
 	 */
-	backwards = start;
-	forwards = start;
-	try = start;
+	backwards = try;
+	backwards_lno = line;
+	forwards = try;
+	forwards_lno = line;
+	try_lno = line;
 
 	for (i = 0; ; i++) {
-		no_more_backwards = !backwards;
-		no_more_forwards = (forwards + fragsize > size);
-
-		if (match_fragment(buf, size, try, fragment, fragsize,
-				   match_beginning, match_end)) {
-			int shift = ((i+1) >> 1);
-			if (i & 1)
-				shift = -shift;
-			*lines = shift;
-			return try;
-		}
+		if (match_fragment(img, preimage, postimage,
+				   try, try_lno,
+				   match_beginning, match_end))
+			return try_lno;
 
 	again:
-		if (no_more_backwards && no_more_forwards)
+		if (backwards_lno == 0 && forwards_lno == img->nr)
 			break;
 
 		if (i & 1) {
-			if (no_more_backwards) {
+			if (backwards_lno == 0) {
 				i++;
 				goto again;
 			}
-			do {
-				--backwards;
-			} while (backwards && buf[backwards-1] != '\n');
+			backwards_lno--;
+			backwards -= img->line[backwards_lno].len;
 			try = backwards;
+			try_lno = backwards_lno;
 		} else {
-			if (no_more_forwards) {
+			if (forwards_lno == img->nr) {
 				i++;
 				goto again;
 			}
-			while (forwards + fragsize <= size) {
-				if (buf[forwards++] == '\n')
-					break;
-			}
+			forwards += img->line[forwards_lno].len;
+			forwards_lno++;
 			try = forwards;
+			try_lno = forwards_lno;
 		}
 
 	}
 	return -1;
 }
 
-static void remove_first_line(const char **rbuf, int *rsize)
+static void remove_first_line(struct image *img)
 {
-	const char *buf = *rbuf;
-	int size = *rsize;
-	unsigned long offset;
-	offset = 0;
-	while (offset <= size) {
-		if (buf[offset++] == '\n')
-			break;
-	}
-	*rsize = size - offset;
-	*rbuf = buf + offset;
+	img->buf += img->line[0].len;
+	img->len -= img->line[0].len;
+	img->line++;
+	img->nr--;
 }
 
-static void remove_last_line(const char **rbuf, int *rsize)
+static void remove_last_line(struct image *img)
 {
-	const char *buf = *rbuf;
-	int size = *rsize;
-	unsigned long offset;
-	offset = size - 1;
-	while (offset > 0) {
-		if (buf[--offset] == '\n')
-			break;
-	}
-	*rsize = offset + 1;
+	img->len -= img->line[--img->nr].len;
 }
 
 static int apply_line(char *output, const char *patch, int plen,
@@ -1668,19 +1742,75 @@ static int apply_line(char *output, const char *patch, int plen,
 	return output + plen - buf;
 }
 
-static int apply_one_fragment(struct strbuf *buf, struct fragment *frag,
+static void update_image(struct image *img,
+			 int applied_pos,
+			 struct image *preimage,
+			 struct image *postimage)
+{
+	/*
+	 * remove the copy of preimage at offset in img
+	 * and replace it with postimage
+	 */
+	int i, nr;
+	size_t remove_count, insert_count, applied_at = 0;
+	char *result;
+
+	for (i = 0; i < applied_pos; i++)
+		applied_at += img->line[i].len;
+
+	remove_count = 0;
+	for (i = 0; i < preimage->nr; i++)
+		remove_count += img->line[applied_pos + i].len;
+	insert_count = postimage->len;
+
+	/* Adjust the contents */
+	result = xmalloc(img->len + insert_count - remove_count + 1);
+	memcpy(result, img->buf, applied_at);
+	memcpy(result + applied_at, postimage->buf, postimage->len);
+	memcpy(result + applied_at + postimage->len,
+	       img->buf + (applied_at + remove_count),
+	       img->len - (applied_at + remove_count));
+	free(img->buf);
+	img->buf = result;
+	img->len += insert_count - remove_count;
+	result[img->len] = '\0';
+
+	/* Adjust the line table */
+	nr = img->nr + postimage->nr - preimage->nr;
+	if (preimage->nr < postimage->nr) {
+		/*
+		 * NOTE: this knows that we never call remove_first_line()
+		 * on anything other than pre/post image.
+		 */
+		img->line = xrealloc(img->line, nr * sizeof(*img->line));
+		img->line_allocated = img->line;
+	}
+	if (preimage->nr != postimage->nr)
+		memmove(img->line + applied_pos + postimage->nr,
+			img->line + applied_pos + preimage->nr,
+			(img->nr - (applied_pos + preimage->nr)) *
+			sizeof(*img->line));
+	memcpy(img->line + applied_pos,
+	       postimage->line,
+	       postimage->nr * sizeof(*img->line));
+	img->nr = nr;
+}
+
+static int apply_one_fragment(struct image *img, struct fragment *frag,
 			      int inaccurate_eof, unsigned ws_rule)
 {
 	int match_beginning, match_end;
 	const char *patch = frag->patch;
-	int offset, size = frag->size;
+	int size = frag->size;
 	char *old = xmalloc(size);
 	char *new = xmalloc(size);
-	const char *oldlines, *newlines;
+	char *oldlines, *newlines;
 	int oldsize = 0, newsize = 0;
 	int new_blank_lines_at_end = 0;
 	unsigned long leading, trailing;
-	int pos, lines;
+	int pos, applied_pos;
+	struct image preimage;
+	struct image postimage;
 
 	while (size > 0) {
 		char first;
@@ -1780,32 +1910,16 @@ static int apply_one_fragment(struct strbuf *buf, struct fragment *frag,
 		match_end = !trailing;
 	}
 
-	lines = 0;
-	pos = frag->newpos;
+	pos = frag->newpos ? (frag->newpos - 1) : 0;
+	prepare_image(&preimage, oldlines, oldsize, 1);
+	prepare_image(&postimage, newlines, newsize, 1);
 	for (;;) {
-		offset = find_offset(buf->buf, buf->len,
-				     oldlines, oldsize, pos, &lines,
-				     match_beginning, match_end);
-		if (offset >= 0) {
-			if (ws_error_action == correct_ws_error &&
-			    (buf->len - oldsize - offset == 0))
-				/* end of file? */
-				newsize -= new_blank_lines_at_end;
 
-			/*
-			 * Warn if it was necessary to reduce the number
-			 * of context lines.
-			 */
-			if ((leading != frag->leading) ||
-			    (trailing != frag->trailing))
-				fprintf(stderr, "Context reduced to (%ld/%ld)"
-					" to apply fragment at %d\n",
-					leading, trailing, pos + lines);
-
-			strbuf_splice(buf, offset, oldsize, newlines, newsize);
-			offset = 0;
+		applied_pos = find_pos(img, &preimage, &postimage,
+				       pos, match_beginning, match_end);
+
+		if (applied_pos >= 0)
 			break;
-		}
 
 		/* Am I at my context limits? */
 		if ((leading <= p_context) && (trailing <= p_context))
@@ -1814,33 +1928,63 @@ static int apply_one_fragment(struct strbuf *buf, struct fragment *frag,
 			match_beginning = match_end = 0;
 			continue;
 		}
+
 		/*
 		 * Reduce the number of context lines; reduce both
 		 * leading and trailing if they are equal otherwise
 		 * just reduce the larger context.
 		 */
 		if (leading >= trailing) {
-			remove_first_line(&oldlines, &oldsize);
-			remove_first_line(&newlines, &newsize);
+			remove_first_line(&preimage);
+			remove_first_line(&postimage);
 			pos--;
 			leading--;
 		}
 		if (trailing > leading) {
-			remove_last_line(&oldlines, &oldsize);
-			remove_last_line(&newlines, &newsize);
+			remove_last_line(&preimage);
+			remove_last_line(&postimage);
 			trailing--;
 		}
 	}
 
-	if (offset && apply_verbosely)
-		error("while searching for:\n%.*s", oldsize, oldlines);
+	if (applied_pos >= 0) {
+		if (ws_error_action == correct_ws_error &&
+		    new_blank_lines_at_end &&
+		    postimage.nr + applied_pos == img->nr) {
+			/*
+			 * If the patch application adds blank lines
+			 * at the end, and if the patch applies at the
+			 * end of the image, remove those added blank
+			 * lines.
+			 */
+			while (new_blank_lines_at_end--)
+				remove_last_line(&postimage);
+		}
+
+		/*
+		 * Warn if it was necessary to reduce the number
+		 * of context lines.
+		 */
+		if ((leading != frag->leading) ||
+		    (trailing != frag->trailing))
+			fprintf(stderr, "Context reduced to (%ld/%ld)"
+				" to apply fragment at %d\n",
+				leading, trailing, applied_pos+1);
+		update_image(img, applied_pos, &preimage, &postimage);
+	} else {
+		if (apply_verbosely)
+			error("while searching for:\n%.*s", oldsize, oldlines);
+	}
 
 	free(old);
 	free(new);
-	return offset;
+	free(preimage.line_allocated);
+	free(postimage.line_allocated);
+
+	return (applied_pos < 0);
 }
 
-static int apply_binary_fragment(struct strbuf *buf, struct patch *patch)
+static int apply_binary_fragment(struct image *img, struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
 	unsigned long len;
@@ -1857,22 +2001,26 @@ static int apply_binary_fragment(struct strbuf *buf, struct patch *patch)
 	}
 	switch (fragment->binary_patch_method) {
 	case BINARY_DELTA_DEFLATED:
-		dst = patch_delta(buf->buf, buf->len, fragment->patch,
+		dst = patch_delta(img->buf, img->len, fragment->patch,
 				  fragment->size, &len);
 		if (!dst)
 			return -1;
-		/* XXX patch_delta NUL-terminates */
-		strbuf_attach(buf, dst, len, len + 1);
+		clear_image(img);
+		img->buf = dst;
+		img->len = len;
 		return 0;
 	case BINARY_LITERAL_DEFLATED:
-		strbuf_reset(buf);
-		strbuf_add(buf, fragment->patch, fragment->size);
+		clear_image(img);
+		img->len = fragment->size;
+		img->buf = xmalloc(img->len+1);
+		memcpy(img->buf, fragment->patch, img->len);
+		img->buf[img->len] = '\0';
 		return 0;
 	}
 	return -1;
 }
 
-static int apply_binary(struct strbuf *buf, struct patch *patch)
+static int apply_binary(struct image *img, struct patch *patch)
 {
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 	unsigned char sha1[20];
@@ -1893,7 +2041,7 @@ static int apply_binary(struct strbuf *buf, struct patch *patch)
 		 * See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_sha1_file(buf->buf, buf->len, blob_type, sha1);
+		hash_sha1_file(img->buf, img->len, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
 			return error("the patch applies to '%s' (%s), "
 				     "which does not match the "
@@ -1902,14 +2050,14 @@ static int apply_binary(struct strbuf *buf, struct patch *patch)
 	}
 	else {
 		/* Otherwise, the old one must be empty. */
-		if (buf->len)
+		if (img->len)
 			return error("the patch applies to an empty "
 				     "'%s' but it is not empty", name);
 	}
 
 	get_sha1_hex(patch->new_sha1_prefix, sha1);
 	if (is_null_sha1(sha1)) {
-		strbuf_release(buf);
+		clear_image(img);
 		return 0; /* deletion patch */
 	}
 
@@ -1924,20 +2072,21 @@ static int apply_binary(struct strbuf *buf, struct patch *patch)
 			return error("the necessary postimage %s for "
 				     "'%s' cannot be read",
 				     patch->new_sha1_prefix, name);
-		/* XXX read_sha1_file NUL-terminates */
-		strbuf_attach(buf, result, size, size + 1);
+		clear_image(img);
+		img->buf = result;
+		img->len = size;
 	} else {
 		/*
 		 * We have verified buf matches the preimage;
 		 * apply the patch data to it, which is stored
 		 * in the patch->fragments->{patch,size}.
 		 */
-		if (apply_binary_fragment(buf, patch))
+		if (apply_binary_fragment(img, patch))
 			return error("binary patch does not apply to '%s'",
 				     name);
 
 		/* verify that the result matches */
-		hash_sha1_file(buf->buf, buf->len, blob_type, sha1);
+		hash_sha1_file(img->buf, img->len, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->new_sha1_prefix))
 			return error("binary patch to '%s' creates incorrect result (expecting %s, got %s)",
 				name, patch->new_sha1_prefix, sha1_to_hex(sha1));
@@ -1946,7 +2095,7 @@ static int apply_binary(struct strbuf *buf, struct patch *patch)
 	return 0;
 }
 
-static int apply_fragments(struct strbuf *buf, struct patch *patch)
+static int apply_fragments(struct image *img, struct patch *patch)
 {
 	struct fragment *frag = patch->fragments;
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
@@ -1954,10 +2103,10 @@ static int apply_fragments(struct strbuf *buf, struct patch *patch)
 	unsigned inaccurate_eof = patch->inaccurate_eof;
 
 	if (patch->is_binary)
-		return apply_binary(buf, patch);
+		return apply_binary(img, patch);
 
 	while (frag) {
-		if (apply_one_fragment(buf, frag, inaccurate_eof, ws_rule)) {
+		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule)) {
 			error("patch failed: %s:%ld", name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
@@ -1993,6 +2142,9 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf;
+	struct image image;
+	size_t len;
+	char *img;
 
 	strbuf_init(&buf, 0);
 	if (cached) {
@@ -2015,9 +2167,14 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 		}
 	}
 
-	if (apply_fragments(&buf, patch) < 0)
+	img = strbuf_detach(&buf, &len);
+	prepare_image(&image, img, len, !patch->is_binary);
+
+	if (apply_fragments(&image, patch) < 0)
 		return -1; /* note with --reject this succeeds. */
-	patch->result = strbuf_detach(&buf, &patch->resultsize);
+	patch->result = image.buf;
+	patch->resultsize = image.len;
+	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
 		return error("removal patch leaves file contents");
-- 
1.5.4.2.g41ac4
