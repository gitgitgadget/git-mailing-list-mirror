From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Rework strbuf API and semantics.
Date: Wed,  5 Sep 2007 21:18:36 +0200
Message-ID: <11890199232110-git-send-email-madcoder@debian.org>
References: <20070905085720.GD31750@artemis.corp>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 21:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0PN-00046W-SL
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbXIETS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755717AbXIETS5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:18:57 -0400
Received: from pan.madism.org ([88.191.52.104]:46553 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755803AbXIETSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:18:54 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1078C1DC0E;
	Wed,  5 Sep 2007 21:18:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AE05B1AB93; Wed,  5 Sep 2007 21:18:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <20070905085720.GD31750@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57746>

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
 strbuf.c      |  103 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 strbuf.h      |   42 ++++++++++++++++++++++-
 5 files changed, 138 insertions(+), 28 deletions(-)

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
index e33d06b..7866fbe 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -2,40 +2,115 @@
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
+		sb->buf[sb->len = 0] = '\0';
+}
+
+char *strbuf_detach(struct strbuf *sb) {
+	char *res = sb->buf;
 	strbuf_init(sb);
+	return res;
+}
+
+void strbuf_grow(struct strbuf *sb, size_t extra) {
+	if (sb->len + extra + 1 < sb->len)
+		die("you want to use way too much memory");
+	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+}
+
+void strbuf_add(struct strbuf *sb, const void *data, size_t len) {
+	strbuf_grow(sb, len);
+	memcpy(sb->buf + sb->len, data, len);
+	sb->len += len;
+	sb->buf[sb->len] = '\0';
+}
+
+void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
+{
+	size_t len;
+	va_list ap2;
+
+	va_copy(ap2, ap);
+
+	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+	if (len < 0) {
+		len = 0;
+	}
+	if (len >= sb->alloc - sb->len) {
+		strbuf_grow(sb, len);
+		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap2);
+		if (len >= sb->alloc - sb->len) {
+			len = sb->alloc - sb->len - 1;
+		}
+	}
+	sb->len = sb->len + len;
+	sb->buf[sb->len] = '\0';
 }
 
-static void inline strbuf_add(struct strbuf *sb, int ch) {
-	if (sb->alloc <= sb->len) {
-		sb->alloc = sb->alloc * 3 / 2 + 16;
-		sb->buf = xrealloc(sb->buf, sb->alloc);
+size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f) {
+	size_t res;
+
+	strbuf_grow(sb, size);
+	res = fread(sb->buf + sb->len, 1, size, f);
+	if (res > 0) {
+		sb->len += res;
+		sb->buf[sb->len] = '\0';
 	}
-	sb->buf[sb->len++] = ch;
+	return res;
 }
 
-static void strbuf_end(struct strbuf *sb) {
-	strbuf_add(sb, 0);
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
+			sb->buf[sb->len = oldlen] = '\0';
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
index 74cc012..db1e438 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,13 +1,51 @@
 #ifndef STRBUF_H
 #define STRBUF_H
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
+/* strbuf life cycle */
 extern void strbuf_init(struct strbuf *);
+extern void strbuf_release(struct strbuf *);
+extern void strbuf_reset(struct strbuf *);
+extern char *strbuf_detach(struct strbuf *);
+
+
+extern void strbuf_grow(struct strbuf *, size_t);
+extern void strbuf_add(struct strbuf *, const void *, size_t);
+
+static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
+	strbuf_add(sb, s, strlen(s));
+}
+static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
+	strbuf_add(sb, sb2->buf, sb2->len);
+}
+static inline void strbuf_addch(struct strbuf *sb, size_t c) {
+	strbuf_grow(sb, 1);
+	sb->buf[sb->len++] = c;
+	sb->buf[sb->len] = '\0';
+}
+
+__attribute__((format(printf,2,0)))
+extern void strbuf_addvf(struct strbuf *, const char *, va_list);
+
+static inline __attribute__((format(printf,2,3)))
+void strbuf_addf(struct strbuf *sb, const char *fmt, ...) {
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_addvf(sb, fmt, ap);
+	va_end(ap);
+}
+
+
+extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
+extern ssize_t strbuf_read(struct strbuf *, int fd);
+
 extern void read_line(struct strbuf *, FILE *, int);
 
 #endif /* STRBUF_H */
-- 
1.5.3
