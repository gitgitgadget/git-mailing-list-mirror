From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/2] strbuf change: be sure ->buf is never ever NULL.
Date: Thu, 27 Sep 2007 12:58:23 +0200
Message-ID: <20070927110940.F2C9D930B@madism.org>
References: <20070927101300.GD10289@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 13:09:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IarFf-00089C-47
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbXI0LJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbXI0LJo
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:09:44 -0400
Received: from pan.madism.org ([88.191.52.104]:35639 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbXI0LJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:09:42 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 49E7E21CCC;
	Thu, 27 Sep 2007 13:09:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id F2C9D930B; Thu, 27 Sep 2007 13:09:40 +0200 (CEST)
In-Reply-To: <20070927101300.GD10289@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59283>

For that purpose, the ->buf is always initialized with a char * buf living
in the strbuf module. It is made a char * so that we can sloppily accept
things that perform: sb->buf[0] = '\0', and because you can't pass "" as an
initializer for ->buf without making gcc unhappy for very good reasons.

strbuf_init/_detach/_grow have been fixed to trust ->alloc and not ->buf
anymore.

as a consequence strbuf_detach is _mandatory_ to detach a buffer, copying
->buf isn't an option anymore, if ->buf is going to escape from the scope,
and eventually be free'd.

API changes:
  * strbuf_setlen now always works, so just make strbuf_reset a convenience
    macro.
  * strbuf_detatch takes a size_t* optional argument (meaning it can be
    NULL) to copy the buffer's len, as it was needed for this refactor to
    make the code more readable, and working like the callers.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

I've written this patch using the following method:

(1) I've renamed the ->buf member into sb_buf (I grepped before it wasn't
    a string used in the project) and made the changes I describe in
    strbuf.[hc]

(2) I've built the project, and renamed every ->buf into sb_buf, and
    applied the needed semantics changes. It's doing that that I found the
    issue I fix in the patch 1/2.

(3) I've then run the testsuite, it passes.

(4) I've sed -i -e 's/\<sb_buf\>/buf/g' *.h *.c


Nobody was directly using the fact that a strbuf that wasn't touched had
its pointer NULL, though people detach'ing them do, and strbuf_detach
complies with that. That's why I think, despite the somehow tasteless
"strbuf_slopbuf" it's the best way to go.

 builtin-apply.c       |   16 +++++++---------
 builtin-archive.c     |    5 ++---
 builtin-fetch--tool.c |    2 +-
 commit.c              |    2 +-
 convert.c             |    4 ++--
 diff.c                |   14 ++++++--------
 entry.c               |    3 +--
 fast-import.c         |    2 +-
 imap-send.c           |    2 +-
 quote.c               |    2 +-
 sha1_file.c           |    3 +--
 strbuf.c              |   27 ++++++++++++++++-----------
 strbuf.h              |   10 +++++-----
 13 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 450f0a8..833b142 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -178,14 +178,13 @@ static void say_patch_name(FILE *output, const char *pre, struct patch *patch, c
 #define CHUNKSIZE (8192)
 #define SLOP (16)
 
-static void *read_patch_file(int fd, unsigned long *sizep)
+static void *read_patch_file(int fd, size_t *sizep)
 {
 	struct strbuf buf;
 
 	strbuf_init(&buf, 0);
 	if (strbuf_read(&buf, fd, 0) < 0)
 		die("git-apply: read returned %s", strerror(errno));
-	*sizep = buf.len;
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -194,7 +193,7 @@ static void *read_patch_file(int fd, unsigned long *sizep)
 	 */
 	strbuf_grow(&buf, SLOP);
 	memset(buf.buf + buf.len, 0, SLOP);
-	return strbuf_detach(&buf);
+	return strbuf_detach(&buf, sizep);
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -253,7 +252,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 				 */
 				strbuf_remove(&name, 0, cp - name.buf);
 				free(def);
-				return name.buf;
+				return strbuf_detach(&name, NULL);
 			}
 		}
 		strbuf_release(&name);
@@ -607,7 +606,7 @@ static char *git_header_name(char *line, int llen)
 			if (strcmp(cp + 1, first.buf))
 				goto free_and_fail1;
 			strbuf_release(&sp);
-			return first.buf;
+			return strbuf_detach(&first, NULL);
 		}
 
 		/* unquoted second */
@@ -618,7 +617,7 @@ static char *git_header_name(char *line, int llen)
 		if (line + llen - cp != first.len + 1 ||
 		    memcmp(first.buf, cp, first.len))
 			goto free_and_fail1;
-		return first.buf;
+		return strbuf_detach(&first, NULL);
 
 	free_and_fail1:
 		strbuf_release(&first);
@@ -655,7 +654,7 @@ static char *git_header_name(char *line, int llen)
 			    isspace(name[len])) {
 				/* Good */
 				strbuf_remove(&sp, 0, np - sp.buf);
-				return sp.buf;
+				return strbuf_detach(&sp, NULL);
 			}
 
 		free_and_fail2:
@@ -1968,8 +1967,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 
 	if (apply_fragments(&buf, patch) < 0)
 		return -1; /* note with --reject this succeeds. */
-	patch->result = buf.buf;
-	patch->resultsize = buf.len;
+	patch->result = strbuf_detach(&buf, &patch->resultsize);
 
 	if (0 < patch->is_delete && patch->resultsize)
 		return error("removal patch leaves file contents");
diff --git a/builtin-archive.c b/builtin-archive.c
index 843a9e3..04385de 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -89,7 +89,7 @@ static void format_subst(const struct commit *commit,
 	struct strbuf fmt;
 
 	if (src == buf->buf)
-		to_free = strbuf_detach(buf);
+		to_free = strbuf_detach(buf, NULL);
 	strbuf_init(&fmt, 0);
 	for (;;) {
 		const char *b, *c;
@@ -153,8 +153,7 @@ void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
 		convert_to_working_tree(path, buf.buf, buf.len, &buf);
 		convert_to_archive(path, buf.buf, buf.len, &buf, commit);
-		*sizep = buf.len;
-		buffer = buf.buf;
+		buffer = strbuf_detach(&buf, sizep);
 	}
 
 	return buffer;
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 349b59c..1e43d79 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -10,7 +10,7 @@ static char *get_stdin(void)
 	if (strbuf_read(&buf, 0, 1024) < 0) {
 		die("error reading standard input: %s", strerror(errno));
 	}
-	return strbuf_detach(&buf);
+	return strbuf_detach(&buf, NULL);
 }
 
 static void show_new(enum object_type type, unsigned char *sha1_new)
diff --git a/commit.c b/commit.c
index 1e391e6..20fb220 100644
--- a/commit.c
+++ b/commit.c
@@ -663,7 +663,7 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 					  len - strlen("encoding \n"),
 					  encoding, strlen(encoding));
 	}
-	return tmp.buf;
+	return strbuf_detach(&tmp, NULL);
 }
 
 static char *logmsg_reencode(const struct commit *commit,
diff --git a/convert.c b/convert.c
index 79c9df2..0d5e909 100644
--- a/convert.c
+++ b/convert.c
@@ -168,7 +168,7 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
-		to_free = strbuf_detach(buf);
+		to_free = strbuf_detach(buf, NULL);
 
 	strbuf_grow(buf, len + stats.lf - stats.crlf);
 	for (;;) {
@@ -464,7 +464,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
-		to_free = strbuf_detach(buf);
+		to_free = strbuf_detach(buf, NULL);
 	hash_sha1_file(src, len, "blob", sha1);
 
 	strbuf_grow(buf, len + cnt * 43);
diff --git a/diff.c b/diff.c
index 4a7f1e1..0bd7e24 100644
--- a/diff.c
+++ b/diff.c
@@ -197,7 +197,7 @@ static char *quote_two(const char *one, const char *two)
 		strbuf_addstr(&res, one);
 		strbuf_addstr(&res, two);
 	}
-	return res.buf;
+	return strbuf_detach(&res, NULL);
 }
 
 static const char *external_diff(void)
@@ -662,7 +662,7 @@ static char *pprint_rename(const char *a, const char *b)
 		quote_c_style(a, &name, NULL, 0);
 		strbuf_addstr(&name, " => ");
 		quote_c_style(b, &name, NULL, 0);
-		return name.buf;
+		return strbuf_detach(&name, NULL);
 	}
 
 	/* Find common prefix */
@@ -710,7 +710,7 @@ static char *pprint_rename(const char *a, const char *b)
 		strbuf_addch(&name, '}');
 		strbuf_add(&name, a + len_a - sfx_length, sfx_length);
 	}
-	return name.buf;
+	return strbuf_detach(&name, NULL);
 }
 
 struct diffstat_t {
@@ -827,7 +827,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 			strbuf_init(&buf, 0);
 			if (quote_c_style(file->name, &buf, NULL, 0)) {
 				free(file->name);
-				file->name = buf.buf;
+				file->name = strbuf_detach(&buf, NULL);
 			} else {
 				strbuf_release(&buf);
 			}
@@ -1519,8 +1519,7 @@ static int populate_from_stdin(struct diff_filespec *s)
 				     strerror(errno));
 
 	s->should_munmap = 0;
-	s->size = buf.len;
-	s->data = strbuf_detach(&buf);
+	s->data = strbuf_detach(&buf, &s->size);
 	s->should_free = 1;
 	return 0;
 }
@@ -1612,8 +1611,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		if (convert_to_git(s->path, s->data, s->size, &buf)) {
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
-			s->data = buf.buf;
-			s->size = buf.len;
+			s->data = strbuf_detach(&buf, &s->size);
 			s->should_free = 1;
 		}
 	}
diff --git a/entry.c b/entry.c
index 4a8c73b..98f5f6d 100644
--- a/entry.c
+++ b/entry.c
@@ -120,8 +120,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		strbuf_init(&buf, 0);
 		if (convert_to_working_tree(ce->name, new, size, &buf)) {
 			free(new);
-			new = buf.buf;
-			size = buf.len;
+			new = strbuf_detach(&buf, &size);
 		}
 
 		if (to_tempfile) {
diff --git a/fast-import.c b/fast-import.c
index a870a44..e9c80be 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1562,7 +1562,7 @@ static int read_next_command(void)
 		} else {
 			struct recent_command *rc;
 
-			strbuf_detach(&command_buf);
+			strbuf_detach(&command_buf, NULL);
 			stdin_eof = strbuf_getline(&command_buf, stdin, '\n');
 			if (stdin_eof)
 				return EOF;
diff --git a/imap-send.c b/imap-send.c
index e95cdde..a429a76 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1180,7 +1180,7 @@ read_message( FILE *f, msg_data_t *msg )
 	} while (!feof(f));
 
 	msg->len  = buf.len;
-	msg->data = strbuf_detach(&buf);
+	msg->data = strbuf_detach(&buf, NULL);
 	return msg->len;
 }
 
diff --git a/quote.c b/quote.c
index 800fd88..482be05 100644
--- a/quote.c
+++ b/quote.c
@@ -22,7 +22,7 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 	char *to_free = NULL;
 
 	if (dst->buf == src)
-		to_free = strbuf_detach(dst);
+		to_free = strbuf_detach(dst, NULL);
 
 	strbuf_addch(dst, '\'');
 	while (*src) {
diff --git a/sha1_file.c b/sha1_file.c
index f1377fb..83a06a7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2340,8 +2340,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 		strbuf_init(&nbuf, 0);
 		if (convert_to_git(path, buf, size, &nbuf)) {
 			munmap(buf, size);
-			size = nbuf.len;
-			buf = nbuf.buf;
+			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
 	}
diff --git a/strbuf.c b/strbuf.c
index d5e92ee..450110d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,27 +1,30 @@
 #include "cache.h"
 
+/* used as the default ->buf value, so that people can always assume buf is
+   non NULL and ->buf[0] is '\0' */
+char strbuf_slopbuf[32];
+
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
-	memset(sb, 0, sizeof(*sb));
+	sb->alloc = sb->len = 0;
+	sb->buf = strbuf_slopbuf;
 	if (hint)
 		strbuf_grow(sb, hint);
 }
 
 void strbuf_release(struct strbuf *sb)
 {
-	free(sb->buf);
-	memset(sb, 0, sizeof(*sb));
-}
-
-void strbuf_reset(struct strbuf *sb)
-{
-	if (sb->len)
-		strbuf_setlen(sb, 0);
+	if (sb->alloc) {
+		free(sb->buf);
+		strbuf_init(sb, 0);
+	}
 }
 
-char *strbuf_detach(struct strbuf *sb)
+char *strbuf_detach(struct strbuf *sb, size_t *sz)
 {
-	char *res = sb->buf;
+	char *res = sb->alloc ? sb->buf : NULL;
+	if (sz)
+		*sz = sb->len;
 	strbuf_init(sb, 0);
 	return res;
 }
@@ -40,6 +43,8 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	if (sb->len + extra + 1 <= sb->len)
 		die("you want to use way too much memory");
+	if (!sb->alloc)
+		sb->buf = NULL;
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
 }
 
diff --git a/strbuf.h b/strbuf.h
index fd68389..a92222b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -10,8 +10,7 @@
  * 1. the ->buf member is always malloc-ed, hence strbuf's can be used to
  *    build complex strings/buffers whose final size isn't easily known.
  *
- *    It is legal to copy the ->buf pointer away. Though if you want to reuse
- *    the strbuf after that, setting ->buf to NULL isn't legal.
+ *    It is NOT legal to copy the ->buf pointer away.
  *    `strbuf_detach' is the operation that detachs a buffer from its shell
  *    while keeping the shell valid wrt its invariants.
  *
@@ -41,19 +40,19 @@
 
 #include <assert.h>
 
+extern char strbuf_slopbuf[];
 struct strbuf {
 	size_t alloc;
 	size_t len;
 	char *buf;
 };
 
-#define STRBUF_INIT  { 0, 0, NULL }
+#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
 
 /*----- strbuf life cycle -----*/
 extern void strbuf_init(struct strbuf *, size_t);
 extern void strbuf_release(struct strbuf *);
-extern void strbuf_reset(struct strbuf *);
-extern char *strbuf_detach(struct strbuf *);
+extern char *strbuf_detach(struct strbuf *, size_t *);
 extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
 static inline void strbuf_swap(struct strbuf *a, struct strbuf *b) {
 	struct strbuf tmp = *a;
@@ -75,6 +74,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 	sb->len = len;
 	sb->buf[len] = '\0';
 }
+#define strbuf_reset(sb)  strbuf_setlen(sb, 0)
 
 /*----- content related -----*/
 extern void strbuf_rtrim(struct strbuf *);
-- 
1.5.3.2.1100.g015a-dirty
