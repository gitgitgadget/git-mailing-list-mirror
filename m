From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] builtin-apply: use strbuf's instead of buffer_desc's.
Date: Sun, 16 Sep 2007 18:54:42 +0200
Message-ID: <20070916172233.9C1F818364@madism.org>
References: <20070916172134.GA26457@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxps-00082n-Hc
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbXIPRWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbXIPRWo
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:22:44 -0400
Received: from pan.madism.org ([88.191.52.104]:35177 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbXIPRWf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:22:35 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F251E202AF;
	Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9C1F818364; Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
In-Reply-To: <20070916172134.GA26457@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58331>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c |  212 +++++++++++++++++++------------------------------------
 1 files changed, 72 insertions(+), 140 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index ae708d7..05011bb 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1441,37 +1441,28 @@ static void show_stats(struct patch *patch)
 	free(qname);
 }
 
-static int read_old_data(struct stat *st, const char *path, char **buf_p, unsigned long *alloc_p, unsigned long *size_p)
+static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 {
 	int fd;
-	unsigned long got;
-	struct strbuf nbuf;
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
-		strbuf_init(&nbuf, 0);
-		if (convert_to_git(path, buf, size, &nbuf)) {
-			free(buf);
-			*buf_p = nbuf.buf;
-			*alloc_p = nbuf.alloc;
-			*size_p = nbuf.len;
-		}
-		return got != size;
+		convert_to_git(path, buf->buf, buf->len, buf);
+		return 0;
 	default:
 		return -1;
 	}
@@ -1576,12 +1567,6 @@ static void remove_last_line(const char **rbuf, int *rsize)
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
@@ -1651,10 +1636,9 @@ static int apply_line(char *output, const char *patch, int plen)
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
@@ -1765,24 +1749,17 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
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
@@ -1792,19 +1769,8 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
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
 
@@ -1840,12 +1806,11 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
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
@@ -1856,29 +1821,24 @@ static int apply_binary_fragment(struct buffer_desc *desc, struct patch *patch)
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
+		strbuf_attach(buf, dst, len, len + 1);
+		return 0;
 	case BINARY_LITERAL_DEFLATED:
-		free(desc->buffer);
-		desc->buffer = data;
-		dst_size = fragment->size;
-		break;
+		strbuf_reset(buf);
+		strbuf_add(buf, fragment->patch, fragment->size);
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
@@ -1897,7 +1857,7 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 		/* See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);
+		hash_sha1_file(buf->buf, buf->len, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
 			return error("the patch applies to '%s' (%s), "
 				     "which does not match the "
@@ -1906,16 +1866,14 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
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
 
@@ -1923,43 +1881,44 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
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
+		strbuf_attach(buf, result, size, size + 1);
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
@@ -1970,76 +1929,57 @@ static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
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
+		strbuf_attach(buf, result, sz, sz + 1);
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
@@ -2459,19 +2399,11 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
+	write_or_die(fd, buf, size);
+	strbuf_release(&nbuf);
 
-	while (size) {
-		int written = xwrite(fd, buf, size);
-		if (written < 0)
-			die("writing file %s: %s", path, strerror(errno));
-		if (!written)
-			die("out of space writing file %s", path);
-		buf += written;
-		size -= written;
-	}
 	if (close(fd) < 0)
 		die("closing file %s: %s", path, strerror(errno));
-	strbuf_release(&nbuf);
 	return 0;
 }
 
-- 
1.5.3.1
