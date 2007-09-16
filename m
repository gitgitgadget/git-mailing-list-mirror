From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Rewrite convert_to_{git,working_tree} to use strbuf's.
Date: Sun, 16 Sep 2007 15:51:04 +0200
Message-ID: <20070916172233.90C9E1835B@madism.org>
References: <20070916172134.GA26457@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:23:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxpr-00082n-J6
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbXIPRWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbXIPRWm
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:22:42 -0400
Received: from pan.madism.org ([88.191.52.104]:35176 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375AbXIPRWf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:22:35 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E94F2202AB;
	Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 90C9E1835B; Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
In-Reply-To: <20070916172134.GA26457@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58330>

* Now, those functions take an "out" strbuf argument, where they store their
  result if any. In that case, it also returns 1, else it returns 0.
* those functions support "in place" editing, in the sense that it's OK to
  call them this way:
    convert_to_git(path, sb->buf, sb->len, sb);
  When doable, conversions are done in place for real, else the strbuf
  content is just replaced with the new one, transparentely for the caller.

If you want to create a new filter working this way, being the accumulation
of filter1, filter2, ... filtern, then your meta_filter would be:

    int meta_filter(..., const char *src, size_t len, struct strbuf *sb)
    {
        int ret = 0;
        ret |= filter1(...., src, len, sb);
        if (ret) {
            src = sb->buf;
            len = sb->len;
        }
        ret |= filter2(...., src, len, sb);
        if (ret) {
            src = sb->buf;
            len = sb->len;
        }
        ....
        return ret | filtern(..., src, len, sb);
    }

That's why subfilters the convert_to_* functions called were also rewritten
to work this way.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c   |   27 ++--
 builtin-archive.c |   78 +++++------
 cache.h           |    6 +-
 convert.c         |  414 ++++++++++++++++++++++-------------------------------
 diff.c            |   12 +-
 entry.c           |   10 +-
 sha1_file.c       |   10 +-
 7 files changed, 240 insertions(+), 317 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 7057d0d..9735b47 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1446,8 +1446,7 @@ static int read_old_data(struct stat *st, const char *path, char **buf_p, unsign
 {
 	int fd;
 	unsigned long got;
-	unsigned long nsize;
-	char *nbuf;
+	struct strbuf nbuf;
 	unsigned long size = *size_p;
 	char *buf = *buf_p;
 
@@ -1466,13 +1465,12 @@ static int read_old_data(struct stat *st, const char *path, char **buf_p, unsign
 			got += ret;
 		}
 		close(fd);
-		nsize = got;
-		nbuf = convert_to_git(path, buf, &nsize);
-		if (nbuf) {
+		strbuf_init(&nbuf, 0);
+		if (convert_to_git(path, buf, size, &nbuf)) {
 			free(buf);
-			*buf_p = nbuf;
-			*alloc_p = nsize;
-			*size_p = nsize;
+			*buf_p = nbuf.buf;
+			*alloc_p = nbuf.alloc;
+			*size_p = nbuf.len;
 		}
 		return got != size;
 	default:
@@ -2438,7 +2436,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
 	int fd;
-	char *nbuf;
+	struct strbuf nbuf;
 
 	if (S_ISGITLINK(mode)) {
 		struct stat st;
@@ -2457,9 +2455,11 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	if (fd < 0)
 		return -1;
 
-	nbuf = convert_to_working_tree(path, buf, &size);
-	if (nbuf)
-		buf = nbuf;
+	strbuf_init(&nbuf, 0);
+	if (convert_to_working_tree(path, buf, size, &nbuf)) {
+		size = nbuf.len;
+		buf  = nbuf.buf;
+	}
 
 	while (size) {
 		int written = xwrite(fd, buf, size);
@@ -2472,8 +2472,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	}
 	if (close(fd) < 0)
 		die("closing file %s: %s", path, strerror(errno));
-	if (nbuf)
-		free(nbuf);
+	strbuf_release(&nbuf);
 	return 0;
 }
 
diff --git a/builtin-archive.c b/builtin-archive.c
index 6fa424d..843a9e3 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -81,22 +81,21 @@ static int run_remote_archiver(const char *remote, int argc,
 	return !!rv;
 }
 
-static void *format_subst(const struct commit *commit, const char *format,
-                          unsigned long *sizep)
+static void format_subst(const struct commit *commit,
+                         const char *src, size_t len,
+                         struct strbuf *buf)
 {
-	unsigned long len = *sizep;
-	const char *a = format;
-	struct strbuf result;
+	char *to_free = NULL;
 	struct strbuf fmt;
 
-	strbuf_init(&result, 0);
+	if (src == buf->buf)
+		to_free = strbuf_detach(buf);
 	strbuf_init(&fmt, 0);
-
 	for (;;) {
 		const char *b, *c;
 
-		b = memmem(a, len, "$Format:", 8);
-		if (!b || a + len < b + 9)
+		b = memmem(src, len, "$Format:", 8);
+		if (!b || src + len < b + 9)
 			break;
 		c = memchr(b + 8, '$', len - 8);
 		if (!c)
@@ -105,62 +104,57 @@ static void *format_subst(const struct commit *commit, const char *format,
 		strbuf_reset(&fmt);
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
-		strbuf_add(&result, a, b - a);
-		format_commit_message(commit, fmt.buf, &result);
-		len -= c + 1 - a;
-		a = c + 1;
+		strbuf_add(buf, src, b - src);
+		format_commit_message(commit, fmt.buf, buf);
+		len -= c + 1 - src;
+		src  = c + 1;
 	}
-
-	strbuf_add(&result, a, len);
-
-	*sizep = result.len;
-
+	strbuf_add(buf, src, len);
 	strbuf_release(&fmt);
-	return strbuf_detach(&result);
+	free(to_free);
 }
 
-static void *convert_to_archive(const char *path,
-                                const void *src, unsigned long *sizep,
-                                const struct commit *commit)
+static int convert_to_archive(const char *path,
+                              const void *src, size_t len,
+                              struct strbuf *buf,
+                              const struct commit *commit)
 {
 	static struct git_attr *attr_export_subst;
 	struct git_attr_check check[1];
 
 	if (!commit)
-		return NULL;
+		return 0;
 
-        if (!attr_export_subst)
-                attr_export_subst = git_attr("export-subst", 12);
+	if (!attr_export_subst)
+		attr_export_subst = git_attr("export-subst", 12);
 
 	check[0].attr = attr_export_subst;
 	if (git_checkattr(path, ARRAY_SIZE(check), check))
-		return NULL;
+		return 0;
 	if (!ATTR_TRUE(check[0].value))
-		return NULL;
+		return 0;
 
-	return format_subst(commit, src, sizep);
+	format_subst(commit, src, len, buf);
+	return 1;
 }
 
 void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
                            unsigned int mode, enum object_type *type,
-                           unsigned long *size,
+                           unsigned long *sizep,
                            const struct commit *commit)
 {
-	void *buffer, *converted;
+	void *buffer;
 
-	buffer = read_sha1_file(sha1, type, size);
+	buffer = read_sha1_file(sha1, type, sizep);
 	if (buffer && S_ISREG(mode)) {
-		converted = convert_to_working_tree(path, buffer, size);
-		if (converted) {
-			free(buffer);
-			buffer = converted;
-		}
-
-		converted = convert_to_archive(path, buffer, size, commit);
-		if (converted) {
-			free(buffer);
-			buffer = converted;
-		}
+		struct strbuf buf;
+
+		strbuf_init(&buf, 0);
+		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
+		convert_to_working_tree(path, buf.buf, buf.len, &buf);
+		convert_to_archive(path, buf.buf, buf.len, &buf, commit);
+		*sizep = buf.len;
+		buffer = buf.buf;
 	}
 
 	return buffer;
diff --git a/cache.h b/cache.h
index b9a461a..8650d62 100644
--- a/cache.h
+++ b/cache.h
@@ -2,6 +2,7 @@
 #define CACHE_H
 
 #include "git-compat-util.h"
+#include "strbuf.h"
 
 #include SHA1_HEADER
 #include <zlib.h>
@@ -590,8 +591,9 @@ extern void trace_printf(const char *format, ...);
 extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
 
 /* convert.c */
-extern char *convert_to_git(const char *path, const char *src, unsigned long *sizep);
-extern char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep);
+/* returns 1 if *dst was used */
+extern int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst);
+extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/convert.c b/convert.c
index d77c8eb..00a341c 100644
--- a/convert.c
+++ b/convert.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "attr.h"
 #include "run-command.h"
+#include "strbuf.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -80,24 +81,19 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep, int action)
+static int crlf_to_git(const char *path, const char *src, size_t len,
+                       struct strbuf *buf, int action)
 {
-	char *buffer, *dst;
-	unsigned long size, nsize;
 	struct text_stat stats;
+	char *dst;
 
-	if ((action == CRLF_BINARY) || !auto_crlf)
-		return NULL;
-
-	size = *sizep;
-	if (!size)
-		return NULL;
-
-	gather_stats(src, size, &stats);
+	if ((action == CRLF_BINARY) || !auto_crlf || !len)
+		return 0;
 
+	gather_stats(src, len, &stats);
 	/* No CR? Nothing to convert, regardless. */
 	if (!stats.cr)
-		return NULL;
+		return 0;
 
 	if (action == CRLF_GUESS) {
 		/*
@@ -106,24 +102,17 @@ static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep
 		 * stuff?
 		 */
 		if (stats.cr != stats.crlf)
-			return NULL;
+			return 0;
 
 		/*
 		 * And add some heuristics for binary vs text, of course...
 		 */
-		if (is_binary(size, &stats))
-			return NULL;
+		if (is_binary(len, &stats))
+			return 0;
 	}
 
-	/*
-	 * Ok, allocate a new buffer, fill it in, and return it
-	 * to let the caller know that we switched buffers.
-	 */
-	nsize = size - stats.crlf;
-	buffer = xmalloc(nsize);
-	*sizep = nsize;
-
-	dst = buffer;
+	strbuf_grow(buf, len);
+	dst = buf->buf;
 	if (action == CRLF_GUESS) {
 		/*
 		 * If we guessed, we already know we rejected a file with
@@ -134,71 +123,72 @@ static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep
 			unsigned char c = *src++;
 			if (c != '\r')
 				*dst++ = c;
-		} while (--size);
+		} while (--len);
 	} else {
 		do {
 			unsigned char c = *src++;
-			if (! (c == '\r' && (1 < size && *src == '\n')))
+			if (! (c == '\r' && (1 < len && *src == '\n')))
 				*dst++ = c;
-		} while (--size);
+		} while (--len);
 	}
-
-	return buffer;
+	strbuf_setlen(buf, dst - buf->buf);
+	return 1;
 }
 
-static char *crlf_to_worktree(const char *path, const char *src, unsigned long *sizep, int action)
+static int crlf_to_worktree(const char *path, const char *src, size_t len,
+                            struct strbuf *buf, int action)
 {
-	char *buffer, *dst;
-	unsigned long size, nsize;
+	char *to_free = NULL;
 	struct text_stat stats;
-	unsigned char last;
 
 	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
 	    auto_crlf <= 0)
-		return NULL;
+		return 0;
 
-	size = *sizep;
-	if (!size)
-		return NULL;
+	if (!len)
+		return 0;
 
-	gather_stats(src, size, &stats);
+	gather_stats(src, len, &stats);
 
 	/* No LF? Nothing to convert, regardless. */
 	if (!stats.lf)
-		return NULL;
+		return 0;
 
 	/* Was it already in CRLF format? */
 	if (stats.lf == stats.crlf)
-		return NULL;
+		return 0;
 
 	if (action == CRLF_GUESS) {
 		/* If we have any bare CR characters, we're not going to touch it */
 		if (stats.cr != stats.crlf)
-			return NULL;
+			return 0;
 
-		if (is_binary(size, &stats))
-			return NULL;
+		if (is_binary(len, &stats))
+			return 0;
 	}
 
-	/*
-	 * Ok, allocate a new buffer, fill it in, and return it
-	 * to let the caller know that we switched buffers.
-	 */
-	nsize = size + stats.lf - stats.crlf;
-	buffer = xmalloc(nsize);
-	*sizep = nsize;
-	last = 0;
-
-	dst = buffer;
-	do {
-		unsigned char c = *src++;
-		if (c == '\n' && last != '\r')
-			*dst++ = '\r';
-		*dst++ = c;
-		last = c;
-	} while (--size);
-
-	return buffer;
+	/* are we "faking" in place editing ? */
+	if (src == buf->buf)
+		to_free = strbuf_detach(buf);
+
+	strbuf_grow(buf, len + stats.lf - stats.crlf);
+	for (;;) {
+		const char *nl = memchr(src, '\n', len);
+		if (!nl)
+			break;
+		if (nl > src && nl[-1] == '\r') {
+			strbuf_add(buf, src, nl + 1 - src);
+		} else {
+			strbuf_add(buf, src, nl - src);
+			strbuf_addstr(buf, "\r\n");
+		}
+		len -= nl + 1 - src;
+		src  = nl + 1;
+	}
+	strbuf_add(buf, src, len);
+
+	free(to_free);
+	return 1;
 }
 
 static int filter_buffer(const char *path, const char *src,
@@ -246,8 +236,8 @@ static int filter_buffer(const char *path, const char *src,
 	return (write_err || status);
 }
 
-static char *apply_filter(const char *path, const char *src,
-			  unsigned long *sizep, const char *cmd)
+static int apply_filter(const char *path, const char *src, size_t len,
+                        struct strbuf *dst, const char *cmd)
 {
 	/*
 	 * Create a pipeline to have the command filter the buffer's
@@ -255,21 +245,19 @@ static char *apply_filter(const char *path, const char *src,
 	 *
 	 * (child --> cmd) --> us
 	 */
-	const int SLOP = 4096;
 	int pipe_feed[2];
-	int status;
-	char *dst;
-	unsigned long dstsize, dstalloc;
+	int status, ret = 1;
 	struct child_process child_process;
+	struct strbuf nbuf;
 
 	if (!cmd)
-		return NULL;
+		return 0;
 
 	memset(&child_process, 0, sizeof(child_process));
 
 	if (pipe(pipe_feed) < 0) {
 		error("cannot create pipe to run external filter %s", cmd);
-		return NULL;
+		return 0;
 	}
 
 	fflush(NULL);
@@ -278,54 +266,37 @@ static char *apply_filter(const char *path, const char *src,
 		error("cannot fork to run external filter %s", cmd);
 		close(pipe_feed[0]);
 		close(pipe_feed[1]);
-		return NULL;
+		return 0;
 	}
 	if (!child_process.pid) {
 		dup2(pipe_feed[1], 1);
 		close(pipe_feed[0]);
 		close(pipe_feed[1]);
-		exit(filter_buffer(path, src, *sizep, cmd));
+		exit(filter_buffer(path, src, len, cmd));
 	}
 	close(pipe_feed[1]);
 
-	dstalloc = *sizep;
-	dst = xmalloc(dstalloc);
-	dstsize = 0;
-
-	while (1) {
-		ssize_t numread = xread(pipe_feed[0], dst + dstsize,
-					dstalloc - dstsize);
-
-		if (numread <= 0) {
-			if (!numread)
-				break;
-			error("read from external filter %s failed", cmd);
-			free(dst);
-			dst = NULL;
-			break;
-		}
-		dstsize += numread;
-		if (dstalloc <= dstsize + SLOP) {
-			dstalloc = dstsize + SLOP;
-			dst = xrealloc(dst, dstalloc);
-		}
+	strbuf_init(&nbuf, 0);
+	if (strbuf_read(&nbuf, pipe_feed[0], len) < 0) {
+		error("read from external filter %s failed", cmd);
+		ret = 0;
 	}
 	if (close(pipe_feed[0])) {
-		error("read from external filter %s failed", cmd);
-		free(dst);
-		dst = NULL;
+		ret = error("read from external filter %s failed", cmd);
+		ret = 0;
 	}
-
 	status = finish_command(&child_process);
 	if (status) {
-		error("external filter %s failed %d", cmd, -status);
-		free(dst);
-		dst = NULL;
+		ret = error("external filter %s failed %d", cmd, -status);
+		ret = 0;
 	}
 
-	if (dst)
-		*sizep = dstsize;
-	return dst;
+	if (ret) {
+		*dst = nbuf;
+	} else {
+		strbuf_release(&nbuf);
+	}
+	return ret;
 }
 
 static struct convert_driver {
@@ -449,137 +420,104 @@ static int count_ident(const char *cp, unsigned long size)
 	return cnt;
 }
 
-static char *ident_to_git(const char *path, const char *src, unsigned long *sizep, int ident)
+static int ident_to_git(const char *path, const char *src, size_t len,
+                        struct strbuf *buf, int ident)
 {
-	int cnt;
-	unsigned long size;
-	char *dst, *buf;
+	char *dst, *dollar;
 
-	if (!ident)
-		return NULL;
-	size = *sizep;
-	cnt = count_ident(src, size);
-	if (!cnt)
-		return NULL;
-	buf = xmalloc(size);
-
-	for (dst = buf; size; size--) {
-		char ch = *src++;
-		*dst++ = ch;
-		if ((ch == '$') && (3 <= size) &&
-		    !memcmp("Id:", src, 3)) {
-			unsigned long rem = size - 3;
-			const char *cp = src + 3;
-			do {
-				ch = *cp++;
-				if (ch == '$')
-					break;
-				rem--;
-			} while (rem);
-			if (!rem)
-				continue;
+	if (!ident || !count_ident(src, len))
+		return 0;
+
+	strbuf_grow(buf, len);
+	dst = buf->buf;
+	for (;;) {
+		dollar = memchr(src, '$', len);
+		if (!dollar)
+			break;
+		memcpy(dst, src, dollar + 1 - src);
+		dst += dollar + 1 - src;
+		len -= dollar + 1 - src;
+		src  = dollar + 1;
+
+		if (len > 3 && !memcmp(src, "Id:", 3)) {
+			dollar = memchr(src + 3, '$', len - 3);
+			if (!dollar)
+				break;
 			memcpy(dst, "Id$", 3);
 			dst += 3;
-			size -= (cp - src);
-			src = cp;
+			len -= dollar + 1 - src;
+			src  = dollar + 1;
 		}
 	}
-
-	*sizep = dst - buf;
-	return buf;
+	memcpy(dst, src, len);
+	strbuf_setlen(buf, dst + len - buf->buf);
+	return 1;
 }
 
-static char *ident_to_worktree(const char *path, const char *src, unsigned long *sizep, int ident)
+static int ident_to_worktree(const char *path, const char *src, size_t len,
+                             struct strbuf *buf, int ident)
 {
-	int cnt;
-	unsigned long size;
-	char *dst, *buf;
 	unsigned char sha1[20];
+	char *to_free = NULL, *dollar;
+	int cnt;
 
 	if (!ident)
-		return NULL;
+		return 0;
 
-	size = *sizep;
-	cnt = count_ident(src, size);
+	cnt = count_ident(src, len);
 	if (!cnt)
-		return NULL;
+		return 0;
 
-	hash_sha1_file(src, size, "blob", sha1);
-	buf = xmalloc(size + cnt * 43);
-
-	for (dst = buf; size; size--) {
-		const char *cp;
-		/* Fetch next source character, move the pointer on */
-		char ch = *src++;
-		/* Copy the current character to the destination */
-		*dst++ = ch;
-		/* If the current character is "$" or there are less than three
-		 * remaining bytes or the two bytes following this one are not
-		 * "Id", then simply read the next character */
-		if ((ch != '$') || (size < 3) || memcmp("Id", src, 2))
-			continue;
-		/*
-		 * Here when
-		 *  - There are more than 2 bytes remaining
-		 *  - The current three bytes are "$Id"
-		 * with
-		 *  - ch == "$"
-		 *  - src[0] == "I"
-		 */
+	/* are we "faking" in place editing ? */
+	if (src == buf->buf)
+		to_free = strbuf_detach(buf);
+	hash_sha1_file(src, len, "blob", sha1);
 
-		/*
-		 * It's possible that an expanded Id has crept its way into the
-		 * repository, we cope with that by stripping the expansion out
-		 */
-		if (src[2] == ':') {
-			/* Expanded keywords have "$Id:" at the front */
+	strbuf_grow(buf, len + cnt * 43);
+	for (;;) {
+		/* step 1: run to the next '$' */
+		dollar = memchr(src, '$', len);
+		if (!dollar)
+			break;
+		strbuf_add(buf, src, dollar + 1 - src);
+		len -= dollar + 1 - src;
+		src  = dollar + 1;
 
-			/* discard up to but not including the closing $ */
-			unsigned long rem = size - 3;
-			/* Point at first byte after the ":" */
-			cp = src + 3;
-			/*
-			 * Throw away characters until either
-			 *  - we reach a "$"
-			 *  - we run out of bytes (rem == 0)
-			 */
-			do {
-				ch = *cp;
-				if (ch == '$')
-					break;
-				cp++;
-				rem--;
-			} while (rem);
-			/* If the above finished because it ran out of characters, then
-			 * this is an incomplete keyword, so don't run the expansion */
-			if (!rem)
-				continue;
-		} else if (src[2] == '$')
-			cp = src + 2;
-		else
-			/* Anything other than "$Id:XXX$" or $Id$ and we skip the
-			 * expansion */
+		/* step 2: does it looks like a bit like Id:xxx$ or Id$ ? */
+		if (len < 3 || memcmp("Id", src, 2))
 			continue;
 
-		/* cp is now pointing at the last $ of the keyword */
-
-		memcpy(dst, "Id: ", 4);
-		dst += 4;
-		memcpy(dst, sha1_to_hex(sha1), 40);
-		dst += 40;
-		*dst++ = ' ';
+		/* step 3: skip over Id$ or Id:xxxxx$ */
+		if (src[2] == '$') {
+			src += 3;
+			len -= 3;
+		} else if (src[2] == ':') {
+			/*
+			 * It's possible that an expanded Id has crept its way into the
+			 * repository, we cope with that by stripping the expansion out
+			 */
+			dollar = memchr(src + 3, '$', len - 3);
+			if (!dollar) {
+				/* incomplete keyword, no more '$', so just quit the loop */
+				break;
+			}
 
-		/* Adjust for the characters we've discarded */
-		size -= (cp - src);
-		src = cp;
+			len -= dollar + 1 - src;
+			src  = dollar + 1;
+		} else {
+			/* it wasn't a "Id$" or "Id:xxxx$" */
+			continue;
+		}
 
-		/* Copy the final "$" */
-		*dst++ = *src++;
-		size--;
+		/* step 4: substitute */
+		strbuf_addstr(buf, "Id: ");
+		strbuf_add(buf, sha1_to_hex(sha1), 40);
+		strbuf_addstr(buf, " $");
 	}
+	strbuf_add(buf, src, len);
 
-	*sizep = dst - buf;
-	return buf;
+	free(to_free);
+	return 1;
 }
 
 static int git_path_check_crlf(const char *path, struct git_attr_check *check)
@@ -618,13 +556,12 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
 
-char *convert_to_git(const char *path, const char *src, unsigned long *sizep)
+int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
 	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
-	int ident = 0;
+	int ident = 0, ret = 0;
 	char *filter = NULL;
-	char *buf, *buf2;
 
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
@@ -636,30 +573,25 @@ char *convert_to_git(const char *path, const char *src, unsigned long *sizep)
 			filter = drv->clean;
 	}
 
-	buf = apply_filter(path, src, sizep, filter);
-
-	buf2 = crlf_to_git(path, buf ? buf : src, sizep, crlf);
-	if (buf2) {
-		free(buf);
-		buf = buf2;
+	ret |= apply_filter(path, src, len, dst, filter);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
 	}
-
-	buf2 = ident_to_git(path, buf ? buf : src, sizep, ident);
-	if (buf2) {
-		free(buf);
-		buf = buf2;
+	ret |= crlf_to_git(path, src, len, dst, crlf);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
 	}
-
-	return buf;
+	return ret | ident_to_git(path, src, len, dst, ident);
 }
 
-char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep)
+int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
 	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
-	int ident = 0;
+	int ident = 0, ret = 0;
 	char *filter = NULL;
-	char *buf, *buf2;
 
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
@@ -671,19 +603,15 @@ char *convert_to_working_tree(const char *path, const char *src, unsigned long *
 			filter = drv->smudge;
 	}
 
-	buf = ident_to_worktree(path, src, sizep, ident);
-
-	buf2 = crlf_to_worktree(path, buf ? buf : src, sizep, crlf);
-	if (buf2) {
-		free(buf);
-		buf = buf2;
+	ret |= ident_to_worktree(path, src, len, dst, ident);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
 	}
-
-	buf2 = apply_filter(path, buf ? buf : src, sizep, filter);
-	if (buf2) {
-		free(buf);
-		buf = buf2;
+	ret |= crlf_to_worktree(path, src, len, dst, crlf);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
 	}
-
-	return buf;
+	return ret | apply_filter(path, src, len, dst, filter);
 }
diff --git a/diff.c b/diff.c
index 693140b..d46dd11 100644
--- a/diff.c
+++ b/diff.c
@@ -1600,10 +1600,9 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 
 	if (!s->sha1_valid ||
 	    reuse_worktree_file(s->path, s->sha1, 0)) {
+		struct strbuf buf;
 		struct stat st;
 		int fd;
-		char *buf;
-		unsigned long size;
 
 		if (!strcmp(s->path, "-"))
 			return populate_from_stdin(s);
@@ -1644,13 +1643,12 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		size = s->size;
-		buf = convert_to_git(s->path, s->data, &size);
-		if (buf) {
+		strbuf_init(&buf, 0);
+		if (convert_to_git(s->path, s->data, s->size, &buf)) {
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
-			s->data = buf;
-			s->size = size;
+			s->data = buf.buf;
+			s->size = buf.len;
 			s->should_free = 1;
 		}
 	}
diff --git a/entry.c b/entry.c
index fc3a506..4a8c73b 100644
--- a/entry.c
+++ b/entry.c
@@ -104,7 +104,8 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	long wrote;
 
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
-		char *buf, *new;
+		char *new;
+		struct strbuf buf;
 		unsigned long size;
 
 	case S_IFREG:
@@ -116,10 +117,11 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		/*
 		 * Convert from git internal format to working tree format
 		 */
-		buf = convert_to_working_tree(ce->name, new, &size);
-		if (buf) {
+		strbuf_init(&buf, 0);
+		if (convert_to_working_tree(ce->name, new, size, &buf)) {
 			free(new);
-			new = buf;
+			new = buf.buf;
+			size = buf.len;
 		}
 
 		if (to_tempfile) {
diff --git a/sha1_file.c b/sha1_file.c
index aea1096..64b5b46 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2343,12 +2343,12 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	 * Convert blobs to git internal format
 	 */
 	if ((type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
-		unsigned long nsize = size;
-		char *nbuf = convert_to_git(path, buf, &nsize);
-		if (nbuf) {
+		struct strbuf nbuf;
+		strbuf_init(&nbuf, 0);
+		if (convert_to_git(path, buf, size, &nbuf)) {
 			munmap(buf, size);
-			size = nsize;
-			buf = nbuf;
+			size = nbuf.len;
+			buf = nbuf.buf;
 			re_allocated = 1;
 		}
 	}
-- 
1.5.3.1
