From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu,  6 Sep 2007 13:20:05 +0200
Message-ID: <118907761140-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11890776114037-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 13:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFPm-0008PZ-5J
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbXIFLUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 07:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbXIFLUY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:20:24 -0400
Received: from pan.madism.org ([88.191.52.104]:52611 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbXIFLUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 07:20:14 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C93EB1E401;
	Thu,  6 Sep 2007 13:20:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C7B0A1A3BA; Thu,  6 Sep 2007 13:20:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11890776114037-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57867>

  The gory details are explained in strbuf.h. The change of semantics this
patch enforces is that the embeded buffer has always a '\0' character after
its last byte, to always make it a C-string. The offs-by-one changes are all
related to that very change.

  A strbuf can be used to store byte arrays, or as an extended string
library. The `buf' member can be passed to any C legacy string function,
because strbuf operations always ensure there is a terminating \0 at the end
of the buffer, not accounted in the `len' field of the structure.

  A strbuf can be used to generate a string/buffer whose final size is not
really known, and then "strbuf_detach" can be used to get the built buffer,
and keep the wrapping "strbuf" structure usable for further work again.

  Other interesting feature: strbuf_grow(sb, size) ensure that there is
enough allocated space in `sb' to put `size' new octets of data in the
buffer. It helps avoiding reallocating data for nothing when the problem the
strbuf helps to solve has a known typical size.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 archive-tar.c |    2 +-
 fast-import.c |   15 ++++----
 mktree.c      |    4 +--
 strbuf.c      |  102 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 strbuf.h      |   86 +++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 181 insertions(+), 28 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 66fe3e3..a0763c5 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -166,7 +166,7 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 		sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
 	} else {
 		if (verbose)
-			fprintf(stderr, "%.*s\n", path->len, path->buf);
+			fprintf(stderr, "%.*s\n", (int)path->len, path->buf);
 		if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 			*header.typeflag = TYPEFLAG_DIR;
 			mode = (mode | 0777) & ~tar_umask;
diff --git a/fast-import.c b/fast-import.c
index 078079d..2f7baf4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1595,7 +1595,7 @@ static void read_next_command(void)
 		} else {
 			struct recent_command *rc;
 
-			command_buf.buf = NULL;
+			strbuf_detach(&command_buf);
 			read_line(&command_buf, stdin, '\n');
 			if (command_buf.eof)
 				return;
@@ -1649,7 +1649,6 @@ static void *cmd_data (size_t *size)
 		size_t sz = 8192, term_len = command_buf.len - 5 - 2;
 		length = 0;
 		buffer = xmalloc(sz);
-		command_buf.buf = NULL;
 		for (;;) {
 			read_line(&command_buf, stdin, '\n');
 			if (command_buf.eof)
@@ -1657,11 +1656,11 @@ static void *cmd_data (size_t *size)
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
 				break;
-			ALLOC_GROW(buffer, length + command_buf.len, sz);
+			ALLOC_GROW(buffer, length + command_buf.len + 1, sz);
 			memcpy(buffer + length,
 				command_buf.buf,
-				command_buf.len - 1);
-			length += command_buf.len - 1;
+				command_buf.len);
+			length += command_buf.len;
 			buffer[length++] = '\n';
 		}
 		free(term);
@@ -2101,7 +2100,7 @@ static void cmd_new_commit(void)
 	}
 
 	/* file_change* */
-	while (!command_buf.eof && command_buf.len > 1) {
+	while (!command_buf.eof && command_buf.len > 0) {
 		if (!prefixcmp(command_buf.buf, "M "))
 			file_change_m(b);
 		else if (!prefixcmp(command_buf.buf, "D "))
@@ -2256,7 +2255,7 @@ static void cmd_reset_branch(void)
 	else
 		b = new_branch(sp);
 	read_next_command();
-	if (!cmd_from(b) && command_buf.len > 1)
+	if (!cmd_from(b) && command_buf.len > 0)
 		unread_command_buf = 1;
 }
 
@@ -2273,7 +2272,7 @@ static void cmd_checkpoint(void)
 
 static void cmd_progress(void)
 {
-	fwrite(command_buf.buf, 1, command_buf.len - 1, stdout);
+	fwrite(command_buf.buf, 1, command_buf.len, stdout);
 	fputc('\n', stdout);
 	fflush(stdout);
 	skip_optional_lf();
diff --git a/mktree.c b/mktree.c
index d86dde8..86de5eb 100644
--- a/mktree.c
+++ b/mktree.c
@@ -92,7 +92,6 @@ int main(int ac, char **av)
 
 	strbuf_init(&sb);
 	while (1) {
-		int len;
 		char *ptr, *ntr;
 		unsigned mode;
 		enum object_type type;
@@ -101,7 +100,6 @@ int main(int ac, char **av)
 		read_line(&sb, stdin, line_termination);
 		if (sb.eof)
 			break;
-		len = sb.len;
 		ptr = sb.buf;
 		/* Input is non-recursive ls-tree output format
 		 * mode SP type SP sha1 TAB name
@@ -111,7 +109,7 @@ int main(int ac, char **av)
 			die("input format error: %s", sb.buf);
 		ptr = ntr + 1; /* type */
 		ntr = strchr(ptr, ' ');
-		if (!ntr || sb.buf + len <= ntr + 41 ||
+		if (!ntr || sb.buf + sb.len <= ntr + 40 ||
 		    ntr[41] != '\t' ||
 		    get_sha1_hex(ntr + 1, sha1))
 			die("input format error: %s", sb.buf);
diff --git a/strbuf.c b/strbuf.c
index e33d06b..acc7fc8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -2,40 +2,114 @@
 #include "strbuf.h"
 
 void strbuf_init(struct strbuf *sb) {
-	sb->buf = NULL;
-	sb->eof = sb->alloc = sb->len = 0;
+	memset(sb, 0, sizeof(*sb));
 }
 
-static void strbuf_begin(struct strbuf *sb) {
+void strbuf_release(struct strbuf *sb) {
 	free(sb->buf);
+	memset(sb, 0, sizeof(*sb));
+}
+
+void strbuf_reset(struct strbuf *sb) {
+	if (sb->len)
+		strbuf_setlen(sb, 0);
+	sb->eof = 0;
+}
+
+char *strbuf_detach(struct strbuf *sb) {
+	char *res = sb->buf;
 	strbuf_init(sb);
+	return res;
+}
+
+void strbuf_grow(struct strbuf *sb, size_t extra) {
+	if (sb->len + extra + 1 <= sb->len)
+		die("you want to use way too much memory");
+	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
 }
 
-static void inline strbuf_add(struct strbuf *sb, int ch) {
-	if (sb->alloc <= sb->len) {
-		sb->alloc = sb->alloc * 3 / 2 + 16;
-		sb->buf = xrealloc(sb->buf, sb->alloc);
+void strbuf_add(struct strbuf *sb, const void *data, size_t len) {
+	strbuf_grow(sb, len);
+	memcpy(sb->buf + sb->len, data, len);
+	strbuf_setlen(sb, sb->len + len);
+}
+
+void strbuf_addf(struct strbuf *sb, const char *fmt, ...) {
+	int len;
+	va_list ap;
+
+	va_start(ap, fmt);
+	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+	va_end(ap);
+	if (len < 0) {
+		len = 0;
 	}
-	sb->buf[sb->len++] = ch;
+	if (len >= strbuf_avail(sb)) {
+		strbuf_grow(sb, len);
+		va_start(ap, fmt);
+		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+		va_end(ap);
+		if (len >= strbuf_avail(sb)) {
+			die("this should not happen, your snprintf is broken");
+		}
+	}
+	strbuf_setlen(sb, sb->len + len);
 }
 
-static void strbuf_end(struct strbuf *sb) {
-	strbuf_add(sb, 0);
+size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f) {
+	size_t res;
+
+	strbuf_grow(sb, size);
+	res = fread(sb->buf + sb->len, 1, size, f);
+	if (res > 0) {
+		strbuf_setlen(sb, sb->len + res);
+	}
+	return res;
+}
+
+ssize_t strbuf_read(struct strbuf *sb, int fd)
+{
+	size_t oldlen = sb->len;
+
+	for (;;) {
+		ssize_t cnt;
+
+		strbuf_grow(sb, 8192);
+		cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+		if (cnt < 0) {
+			strbuf_setlen(sb, oldlen);
+			return -1;
+		}
+		if (!cnt)
+			break;
+		sb->len += cnt;
+	}
+
+	sb->buf[sb->len] = '\0';
+	return sb->len - oldlen;
 }
 
 void read_line(struct strbuf *sb, FILE *fp, int term) {
 	int ch;
-	strbuf_begin(sb);
 	if (feof(fp)) {
+		strbuf_release(sb);
 		sb->eof = 1;
 		return;
 	}
+
+	strbuf_reset(sb);
 	while ((ch = fgetc(fp)) != EOF) {
 		if (ch == term)
 			break;
-		strbuf_add(sb, ch);
+		strbuf_grow(sb, 1);
+		sb->buf[sb->len++] = ch;
 	}
-	if (ch == EOF && sb->len == 0)
+	if (ch == EOF && sb->len == 0) {
+		strbuf_release(sb);
 		sb->eof = 1;
-	strbuf_end(sb);
+	}
+
+	strbuf_grow(sb, 1);
+	sb->buf[sb->len] = '\0';
 }
+
diff --git a/strbuf.h b/strbuf.h
index 74cc012..b40dc99 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,13 +1,95 @@
 #ifndef STRBUF_H
 #define STRBUF_H
+
+/*
+ * Strbuf's can be use in many ways: as a byte array, or to store arbitrary
+ * long, overflow safe strings.
+ *
+ * Strbufs has some invariants that are very important to keep in mind:
+ *
+ * 1. the ->buf member is always malloc-ed, hence strbuf's can be used to
+ *    build complex strings/buffers whose final size isn't easily known.
+ *
+ *    It is legal to copy the ->buf pointer away. Though if you want to reuse
+ *    the strbuf after that, setting ->buf to NULL isn't legal.
+ *    `strbuf_detach' is the operation that detachs a buffer from its shell
+ *    while keeping the shell valid wrt its invariants.
+ *
+ * 2. the ->buf member is a byte array that has at least ->len + 1 bytes
+ *    allocated. The extra byte is used to store a '\0', allowing the ->buf
+ *    member to be a valid C-string. Every strbuf function ensure this
+ *    invariant is preserved.
+ *
+ *    Note that it is OK to "play" with the buffer directly if you work it
+ *    that way:
+ *
+ *    strbuf_grow(sb, SOME_SIZE);
+ *    // ... here the memory areay starting at sb->buf, and of length
+ *    // sb_avail(sb) is all yours, and you are sure that sb_avail(sb) is at
+ *    // least SOME_SIZE
+ *    strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+ *
+ *    Of course, SOME_OTHER_SIZE must be smaller or equal to sb_avail(sb).
+ *
+ *    Doing so is safe, though if it has to be done in many places, adding the
+ *    missing API to the strbuf module is the way to go.
+ *
+ *    XXX: do _not_ assume that the area that is yours is of size ->alloc - 1
+ *         even if it's true in the current implementation. Alloc is somehow a
+ *         "private" member that should not be messed with.
+ */
+
+#include <assert.h>
+
 struct strbuf {
-	int alloc;
-	int len;
+	size_t alloc;
+	size_t len;
 	int eof;
 	char *buf;
 };
 
+#define STRBUF_INIT  { 0, 0, 0, NULL }
+
+/*----- strbuf life cycle -----*/
 extern void strbuf_init(struct strbuf *);
+extern void strbuf_release(struct strbuf *);
+extern void strbuf_reset(struct strbuf *);
+extern char *strbuf_detach(struct strbuf *);
+
+/*----- strbuf size related -----*/
+static inline size_t strbuf_avail(struct strbuf *sb) {
+    return sb->alloc ? sb->alloc - sb->len - 1 : 0;
+}
+static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
+    assert (len < sb->alloc);
+    sb->len = len;
+    sb->buf[len] = '\0';
+}
+
+extern void strbuf_grow(struct strbuf *, size_t);
+
+/*----- add data in your buffer -----*/
+static inline void strbuf_addch(struct strbuf *sb, int c) {
+	strbuf_grow(sb, 1);
+	sb->buf[sb->len++] = c;
+	sb->buf[sb->len] = '\0';
+}
+
+extern void strbuf_add(struct strbuf *, const void *, size_t);
+static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
+	strbuf_add(sb, s, strlen(s));
+}
+static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
+	strbuf_add(sb, sb2->buf, sb2->len);
+}
+
+__attribute__((format(printf,2,3)))
+extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+
+extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
+/* XXX: if read fails, any partial read is undone */
+extern ssize_t strbuf_read(struct strbuf *, int fd);
+
 extern void read_line(struct strbuf *, FILE *, int);
 
 #endif /* STRBUF_H */
-- 
1.5.3.1
