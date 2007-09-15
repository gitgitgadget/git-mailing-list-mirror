From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] builtin-apply: use strbuf's instead of buffer_desc's.
Date: Sat, 15 Sep 2007 16:04:01 +0200
Message-ID: <20070915141340.334CA4C152@madism.org>
References: <20070915141210.GA27494@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYPJ-0000K7-7p
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbXIOONr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbXIOONq
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:13:46 -0400
Received: from pan.madism.org ([88.191.52.104]:33918 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbXIOONp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 10:13:45 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 768C578B;
	Sat, 15 Sep 2007 16:13:40 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 334CA4C152; Sat, 15 Sep 2007 16:13:40 +0200 (CEST)
In-Reply-To: <20070915141210.GA27494@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58247>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c |  203 ++++++++++++++++++++-----------------------------------
 1 files changed, 73 insertions(+), 130 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 7057d0d..6c24f40 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1442,39 +1442,34 @@ static void show_stats(struct patch *patch)
 	free(qname);
 }
 
-static int read_old_data(struct stat *st, const char *path, char **buf_p, unsigned long *alloc_p, unsigned long *size_p)
+static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 {
 	int fd;
-	unsigned long got;
 	unsigned long nsize;
 	char *nbuf;
-	unsigned long size = *size_p;
-	char *buf = *buf_p;
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
-		return readlink(path, buf, size) != size;
+		strbuf_grow(buf, st->st_size);
+		if (readlink(path, buf->buf, st->st_size) != st->st_size)
+			return -1;
+		strbuf_setlen(buf, st->st_size);
+		return 0;
 	case S_IFREG:
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error("unable to open %s", path);
-		got = 0;
-		for (;;) {
-			ssize_t ret = xread(fd, buf + got, size - got);
-			if (ret <= 0)
-				break;
-			got += ret;
+		if (strbuf_read(buf, fd, st->st_size) < 0) {
+			close(fd);
+			return -1;
 		}
 		close(fd);
-		nsize = got;
-		nbuf = convert_to_git(path, buf, &nsize);
-		if (nbuf) {
-			free(buf);
-			*buf_p = nbuf;
-			*alloc_p = nsize;
-			*size_p = nsize;
-		}
-		return got != size;
+
+		nsize = buf->len;
+		nbuf = convert_to_git(path, buf->buf, &nsize);
+		if (nbuf)
+			strbuf_embed(buf, nbuf, nsize, nsize);
+		return 0;
 	default:
 		return -1;
 	}
@@ -1579,12 +1574,6 @@ static void remove_last_line(const char **rbuf, int *rsize)
 	*rsize = offset + 1;
 }
 
-struct buffer_desc {
-	char *buffer;
-	unsigned long size;
-	unsigned long alloc;
-};
-
 static int apply_line(char *output, const char *patch, int plen)
 {
 	/* plen is number of bytes to be copied from patch,
@@ -1654,10 +1643,9 @@ static int apply_line(char *output, const char *patch, int plen)
 	return output + plen - buf;
 }
 
-static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, int inaccurate_eof)
+static int apply_one_fragment(struct strbuf *buf, struct fragment *frag, int inaccurate_eof)
 {
 	int match_beginning, match_end;
-	char *buf = desc->buffer;
 	const char *patch = frag->patch;
 	int offset, size = frag->size;
 	char *old = xmalloc(size);
@@ -1768,24 +1756,17 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 	lines = 0;
 	pos = frag->newpos;
 	for (;;) {
-		offset = find_offset(buf, desc->size,
+		offset = find_offset(buf->buf, buf->len,
 				     oldlines, oldsize, pos, &lines);
-		if (match_end && offset + oldsize != desc->size)
+		if (match_end && offset + oldsize != buf->len)
 			offset = -1;
 		if (match_beginning && offset)
 			offset = -1;
 		if (offset >= 0) {
-			int diff;
-			unsigned long size, alloc;
-
 			if (new_whitespace == strip_whitespace &&
-			    (desc->size - oldsize - offset == 0)) /* end of file? */
+			    (buf->len - oldsize - offset == 0)) /* end of file? */
 				newsize -= new_blank_lines_at_end;
 
-			diff = newsize - oldsize;
-			size = desc->size + diff;
-			alloc = desc->alloc;
-
 			/* Warn if it was necessary to reduce the number
 			 * of context lines.
 			 */
@@ -1795,19 +1776,8 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 					" to apply fragment at %d\n",
 					leading, trailing, pos + lines);
 
-			if (size > alloc) {
-				alloc = size + 8192;
-				desc->alloc = alloc;
-				buf = xrealloc(buf, alloc);
-				desc->buffer = buf;
-			}
-			desc->size = size;
-			memmove(buf + offset + newsize,
-				buf + offset + oldsize,
-				size - offset - newsize);
-			memcpy(buf + offset, newlines, newsize);
+			strbuf_splice(buf, offset, oldsize, newlines, newsize);
 			offset = 0;
-
 			break;
 		}
 
@@ -1843,12 +1813,11 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 	return offset;
 }
 
-static int apply_binary_fragment(struct buffer_desc *desc, struct patch *patch)
+static int apply_binary_fragment(struct strbuf *buf, struct patch *patch)
 {
-	unsigned long dst_size;
 	struct fragment *fragment = patch->fragments;
-	void *data;
-	void *result;
+	unsigned long len;
+	void *dst;
 
 	/* Binary patch is irreversible without the optional second hunk */
 	if (apply_in_reverse) {
@@ -1859,29 +1828,23 @@ static int apply_binary_fragment(struct buffer_desc *desc, struct patch *patch)
 				     ? patch->new_name : patch->old_name);
 		fragment = fragment->next;
 	}
-	data = (void*) fragment->patch;
 	switch (fragment->binary_patch_method) {
 	case BINARY_DELTA_DEFLATED:
-		result = patch_delta(desc->buffer, desc->size,
-				     data,
-				     fragment->size,
-				     &dst_size);
-		free(desc->buffer);
-		desc->buffer = result;
-		break;
+		dst = patch_delta(buf->buf, buf->len, fragment->patch,
+				  fragment->size, &len);
+		if (!dst)
+			return -1;
+		/* XXX patch_delta NUL-terminates */
+		strbuf_embed(buf, dst, len, len + 1);
+		return 0;
 	case BINARY_LITERAL_DEFLATED:
-		free(desc->buffer);
-		desc->buffer = data;
-		dst_size = fragment->size;
-		break;
+		strbuf_embed(buf, fragment->patch, fragment->size, fragment->size);
+		return 0;
 	}
-	if (!desc->buffer)
-		return -1;
-	desc->size = desc->alloc = dst_size;
-	return 0;
+	return -1;
 }
 
-static int apply_binary(struct buffer_desc *desc, struct patch *patch)
+static int apply_binary(struct strbuf *buf, struct patch *patch)
 {
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 	unsigned char sha1[20];
@@ -1900,7 +1863,7 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 		/* See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);
+		hash_sha1_file(buf->buf, buf->len, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
 			return error("the patch applies to '%s' (%s), "
 				     "which does not match the "
@@ -1909,16 +1872,14 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 	}
 	else {
 		/* Otherwise, the old one must be empty. */
-		if (desc->size)
+		if (buf->len)
 			return error("the patch applies to an empty "
 				     "'%s' but it is not empty", name);
 	}
 
 	get_sha1_hex(patch->new_sha1_prefix, sha1);
 	if (is_null_sha1(sha1)) {
-		free(desc->buffer);
-		desc->alloc = desc->size = 0;
-		desc->buffer = NULL;
+		strbuf_release(buf);
 		return 0; /* deletion patch */
 	}
 
@@ -1926,43 +1887,44 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
+		char *result;
 
-		free(desc->buffer);
-		desc->buffer = read_sha1_file(sha1, &type, &size);
-		if (!desc->buffer)
+		result = read_sha1_file(sha1, &type, &size);
+		if (!result)
 			return error("the necessary postimage %s for "
 				     "'%s' cannot be read",
 				     patch->new_sha1_prefix, name);
-		desc->alloc = desc->size = size;
-	}
-	else {
-		/* We have verified desc matches the preimage;
+		/* XXX read_sha1_file NUL-terminates */
+		strbuf_embed(buf, result, size, size + 1);
+	} else {
+		/* We have verified buf matches the preimage;
 		 * apply the patch data to it, which is stored
 		 * in the patch->fragments->{patch,size}.
 		 */
-		if (apply_binary_fragment(desc, patch))
+		if (apply_binary_fragment(buf, patch))
 			return error("binary patch does not apply to '%s'",
 				     name);
 
 		/* verify that the result matches */
-		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);
+		hash_sha1_file(buf->buf, buf->len, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->new_sha1_prefix))
-			return error("binary patch to '%s' creates incorrect result (expecting %s, got %s)", name, patch->new_sha1_prefix, sha1_to_hex(sha1));
+			return error("binary patch to '%s' creates incorrect result (expecting %s, got %s)",
+				name, patch->new_sha1_prefix, sha1_to_hex(sha1));
 	}
 
 	return 0;
 }
 
-static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
+static int apply_fragments(struct strbuf *buf, struct patch *patch)
 {
 	struct fragment *frag = patch->fragments;
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 
 	if (patch->is_binary)
-		return apply_binary(desc, patch);
+		return apply_binary(buf, patch);
 
 	while (frag) {
-		if (apply_one_fragment(desc, frag, patch->inaccurate_eof)) {
+		if (apply_one_fragment(buf, frag, patch->inaccurate_eof)) {
 			error("patch failed: %s:%ld", name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
@@ -1973,76 +1935,57 @@ static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
 	return 0;
 }
 
-static int read_file_or_gitlink(struct cache_entry *ce, char **buf_p,
-				unsigned long *size_p)
+static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
 {
 	if (!ce)
 		return 0;
 
 	if (S_ISGITLINK(ntohl(ce->ce_mode))) {
-		*buf_p = xmalloc(100);
-		*size_p = snprintf(*buf_p, 100,
-			"Subproject commit %s\n", sha1_to_hex(ce->sha1));
+		strbuf_grow(buf, 100);
+		strbuf_addf(buf, "Subproject commit %s\n", sha1_to_hex(ce->sha1));
 	} else {
 		enum object_type type;
-		*buf_p = read_sha1_file(ce->sha1, &type, size_p);
-		if (!*buf_p)
+		unsigned long sz;
+		char *result;
+
+		result = read_sha1_file(ce->sha1, &type, &sz);
+		if (!result)
 			return -1;
+		/* XXX read_sha1_file NUL-terminates */
+		strbuf_embed(buf, result, sz, sz + 1);
 	}
 	return 0;
 }
 
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
-	char *buf;
-	unsigned long size, alloc;
-	struct buffer_desc desc;
+	struct strbuf buf;
 
-	size = 0;
-	alloc = 0;
-	buf = NULL;
+	strbuf_init(&buf, 0);
 	if (cached) {
-		if (read_file_or_gitlink(ce, &buf, &size))
+		if (read_file_or_gitlink(ce, &buf))
 			return error("read of %s failed", patch->old_name);
-		alloc = size;
 	} else if (patch->old_name) {
 		if (S_ISGITLINK(patch->old_mode)) {
-			if (ce)
-				read_file_or_gitlink(ce, &buf, &size);
-			else {
+			if (ce) {
+				read_file_or_gitlink(ce, &buf);
+			} else {
 				/*
 				 * There is no way to apply subproject
 				 * patch without looking at the index.
 				 */
 				patch->fragments = NULL;
-				size = 0;
 			}
-		}
-		else {
-			size = xsize_t(st->st_size);
-			alloc = size + 8192;
-			buf = xmalloc(alloc);
-			if (read_old_data(st, patch->old_name,
-					  &buf, &alloc, &size))
-				return error("read of %s failed",
-					     patch->old_name);
+		} else {
+			if (read_old_data(st, patch->old_name, &buf))
+				return error("read of %s failed", patch->old_name);
 		}
 	}
 
-	desc.size = size;
-	desc.alloc = alloc;
-	desc.buffer = buf;
-
-	if (apply_fragments(&desc, patch) < 0)
+	if (apply_fragments(&buf, patch) < 0)
 		return -1; /* note with --reject this succeeds. */
-
-	/* NUL terminate the result */
-	if (desc.alloc <= desc.size)
-		desc.buffer = xrealloc(desc.buffer, desc.size + 1);
-	desc.buffer[desc.size] = 0;
-
-	patch->result = desc.buffer;
-	patch->resultsize = desc.size;
+	patch->result = buf.buf;
+	patch->resultsize = buf.len;
 
 	if (0 < patch->is_delete && patch->resultsize)
 		return error("removal patch leaves file contents");
-- 
1.5.3.1
