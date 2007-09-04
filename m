From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Rework strbuf API and semantics.
Date: Tue,  4 Sep 2007 10:47:59 +0200
Message-ID: <11888956802504-git-send-email-madcoder@debian.org>
References: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 10:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISU50-00087Y-RA
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 10:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbXIDIsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 04:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbXIDIsI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 04:48:08 -0400
Received: from pan.madism.org ([88.191.52.104]:44245 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbXIDIsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 04:48:03 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3E83A1DD88;
	Tue,  4 Sep 2007 10:48:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2F3A6145D74; Tue,  4 Sep 2007 10:48:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57542>

  A strbuf can be used to store byte arrays, or as an extended string
library. The `buf' member can be passed to any C legacy string function,
because strbuf operations always ensure there is a terminating \0 at the end
of the buffer, not accounted in the `len' field of the structure.

  A strbuf can be used to generate a string/buffer whose final size is not
really known, and then "strbuf_detach" can be used to get the built buffer,
and keep the wrapping "strbuf" structure usable for further work again.

  Other interesting feature: buffer_ensure(sb, size) ensure that there is
enough allocated space in `sb' to put `size' new octets of data in the
buffer. It helps avoiding reallocating data for nothing when the problem the
strbuf helps to solve has a known typical size.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 archive-tar.c |   65 +++++++++++++---------------------------------------
 fast-import.c |   24 +++++++++---------
 mktree.c      |    4 +--
 strbuf.c      |   71 +++++++++++++++++++++++++++++++++++++++++++++-----------
 strbuf.h      |   34 +++++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 78 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 66fe3e3..ccdd7d5 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -78,19 +78,6 @@ static void write_trailer(void)
 	}
 }
 
-static void strbuf_append_string(struct strbuf *sb, const char *s)
-{
-	int slen = strlen(s);
-	int total = sb->len + slen;
-	if (total + 1 > sb->alloc) {
-		sb->buf = xrealloc(sb->buf, total + 1);
-		sb->alloc = total + 1;
-	}
-	memcpy(sb->buf + sb->len, s, slen);
-	sb->len = total;
-	sb->buf[total] = '\0';
-}
-
 /*
  * pax extended header records have the format "%u %s=%s\n".  %u contains
  * the size of the whole string (including the %u), the first %s is the
@@ -100,26 +87,17 @@ static void strbuf_append_string(struct strbuf *sb, const char *s)
 static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
                                      const char *value, unsigned int valuelen)
 {
-	char *p;
-	int len, total, tmp;
+	int len, tmp;
 
 	/* "%u %s=%s\n" */
 	len = 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
 	for (tmp = len; tmp > 9; tmp /= 10)
 		len++;
 
-	total = sb->len + len;
-	if (total > sb->alloc) {
-		sb->buf = xrealloc(sb->buf, total);
-		sb->alloc = total;
-	}
-
-	p = sb->buf;
-	p += sprintf(p, "%u %s=", len, keyword);
-	memcpy(p, value, valuelen);
-	p += valuelen;
-	*p = '\n';
-	sb->len = total;
+	strbuf_ensure(sb, len);
+	strbuf_addf(sb, "%u %s=", len, keyword);
+	strbuf_add(sb, value, valuelen);
+	strbuf_addch(sb, '\n');
 }
 
 static unsigned int ustar_header_chksum(const struct ustar_header *header)
@@ -153,8 +131,7 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 	struct strbuf ext_header;
 
 	memset(&header, 0, sizeof(header));
-	ext_header.buf = NULL;
-	ext_header.len = ext_header.alloc = 0;
+	strbuf_init(&ext_header);
 
 	if (!sha1) {
 		*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
@@ -225,8 +202,8 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 
 	if (ext_header.len > 0) {
 		write_entry(sha1, NULL, 0, ext_header.buf, ext_header.len);
-		free(ext_header.buf);
 	}
+	strbuf_wipe(&ext_header);
 	write_blocked(&header, sizeof(header));
 	if (S_ISREG(mode) && buffer && size > 0)
 		write_blocked(buffer, size);
@@ -235,11 +212,11 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 static void write_global_extended_header(const unsigned char *sha1)
 {
 	struct strbuf ext_header;
-	ext_header.buf = NULL;
-	ext_header.len = ext_header.alloc = 0;
+
+	strbuf_init(&ext_header);
 	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
 	write_entry(NULL, NULL, 0, ext_header.buf, ext_header.len);
-	free(ext_header.buf);
+	strbuf_wipe(&ext_header);
 }
 
 static int git_tar_config(const char *var, const char *value)
@@ -260,28 +237,18 @@ static int write_tar_entry(const unsigned char *sha1,
                            const char *base, int baselen,
                            const char *filename, unsigned mode, int stage)
 {
-	static struct strbuf path;
+	static struct strbuf path = STRBUF_INIT;
 	int filenamelen = strlen(filename);
 	void *buffer;
 	enum object_type type;
 	unsigned long size;
 
-	if (!path.alloc) {
-		path.buf = xmalloc(PATH_MAX);
-		path.alloc = PATH_MAX;
-		path.len = path.eof = 0;
-	}
-	if (path.alloc < baselen + filenamelen + 1) {
-		free(path.buf);
-		path.buf = xmalloc(baselen + filenamelen + 1);
-		path.alloc = baselen + filenamelen + 1;
-	}
-	memcpy(path.buf, base, baselen);
-	memcpy(path.buf + baselen, filename, filenamelen);
-	path.len = baselen + filenamelen;
-	path.buf[path.len] = '\0';
+	strbuf_ensure(&path, MAX(PATH_MAX, baselen + filenamelen + 1));
+	strbuf_reset(&path);
+	strbuf_add(&path, base, baselen);
+	strbuf_add(&path, filename, filenamelen);
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-		strbuf_append_string(&path, "/");
+		strbuf_addch(&path, '/');
 		buffer = NULL;
 		size = 0;
 	} else {
diff --git a/fast-import.c b/fast-import.c
index 078079d..ab3927b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -340,7 +340,7 @@ static struct tag *last_tag;
 
 /* Input stream parsing */
 static whenspec_type whenspec = WHENSPEC_RAW;
-static struct strbuf command_buf;
+static struct strbuf command_buf = STRBUF_INIT;
 static int unread_command_buf;
 static struct recent_command cmd_hist = {&cmd_hist, &cmd_hist, NULL};
 static struct recent_command *cmd_tail = &cmd_hist;
@@ -1595,7 +1595,7 @@ static void read_next_command(void)
 		} else {
 			struct recent_command *rc;
 
-			command_buf.buf = NULL;
+			strbuf_detach(&command_buf);
 			read_line(&command_buf, stdin, '\n');
 			if (command_buf.eof)
 				return;
@@ -1610,7 +1610,7 @@ static void read_next_command(void)
 				free(rc->buf);
 			}
 
-			rc->buf = command_buf.buf;
+			rc->buf  = command_buf.buf;
 			rc->prev = cmd_tail;
 			rc->next = cmd_hist.prev;
 			rc->prev->next = rc;
@@ -1649,7 +1649,9 @@ static void *cmd_data (size_t *size)
 		size_t sz = 8192, term_len = command_buf.len - 5 - 2;
 		length = 0;
 		buffer = xmalloc(sz);
-		command_buf.buf = NULL;
+
+		/* XXX possible memory leak ? */
+		strbuf_detach(&command_buf);
 		for (;;) {
 			read_line(&command_buf, stdin, '\n');
 			if (command_buf.eof)
@@ -1657,11 +1659,9 @@ static void *cmd_data (size_t *size)
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
 				break;
-			ALLOC_GROW(buffer, length + command_buf.len, sz);
-			memcpy(buffer + length,
-				command_buf.buf,
-				command_buf.len - 1);
-			length += command_buf.len - 1;
+			ALLOC_GROW(buffer, length + command_buf.len + 1, sz);
+			memcpy(buffer + length, command_buf.buf, command_buf.len);
+			length += command_buf.len;
 			buffer[length++] = '\n';
 		}
 		free(term);
@@ -2101,7 +2101,7 @@ static void cmd_new_commit(void)
 	}
 
 	/* file_change* */
-	while (!command_buf.eof && command_buf.len > 1) {
+	while (!command_buf.eof && command_buf.len > 0) {
 		if (!prefixcmp(command_buf.buf, "M "))
 			file_change_m(b);
 		else if (!prefixcmp(command_buf.buf, "D "))
@@ -2256,7 +2256,7 @@ static void cmd_reset_branch(void)
 	else
 		b = new_branch(sp);
 	read_next_command();
-	if (!cmd_from(b) && command_buf.len > 1)
+	if (!cmd_from(b) && command_buf.len > 0)
 		unread_command_buf = 1;
 }
 
@@ -2273,7 +2273,7 @@ static void cmd_checkpoint(void)
 
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
index e33d06b..86d5965 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -2,40 +2,83 @@
 #include "strbuf.h"
 
 void strbuf_init(struct strbuf *sb) {
-	sb->buf = NULL;
-	sb->eof = sb->alloc = sb->len = 0;
+	memset(sb, 0, sizeof(*sb));
 }
 
-static void strbuf_begin(struct strbuf *sb) {
+void strbuf_wipe(struct strbuf *sb) {
 	free(sb->buf);
-	strbuf_init(sb);
+	memset(sb, 0, sizeof(*sb));
 }
 
-static void inline strbuf_add(struct strbuf *sb, int ch) {
-	if (sb->alloc <= sb->len) {
-		sb->alloc = sb->alloc * 3 / 2 + 16;
+void strbuf_reset(struct strbuf *sb) {
+	if (sb->len)
+		sb->buf[sb->len = 0] = '\0';
+}
+
+char *strbuf_detach(struct strbuf *sb) {
+    char *res = sb->buf;
+    strbuf_init(sb);
+    return res;
+}
+
+void strbuf_ensure(struct strbuf *sb, int extra) {
+	if (sb->len + extra >= sb->alloc) {
+		while (sb->len + extra >= sb->alloc)
+			sb->alloc = sb->alloc * 3 / 2 + 16;
 		sb->buf = xrealloc(sb->buf, sb->alloc);
 	}
-	sb->buf[sb->len++] = ch;
 }
 
-static void strbuf_end(struct strbuf *sb) {
-	strbuf_add(sb, 0);
+void strbuf_add(struct strbuf *sb, const void *data, int len) {
+	strbuf_ensure(sb, len);
+	memcpy(sb->buf + sb->len, data, len);
+	sb->len += len;
+	sb->buf[sb->len] = '\0';
+}
+
+void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
+{
+	int len;
+	va_list ap2;
+
+	va_copy(ap2, ap);
+
+	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+	if (len < 0) {
+		len = 0;
+	}
+	if (len >= sb->alloc - sb->len) {
+		strbuf_ensure(sb, len);
+		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap2);
+		if (len >= sb->alloc - sb->len) {
+			len = sb->alloc - sb->len - 1;
+		}
+	}
+	sb->len = sb->len + len;
+	sb->buf[sb->len] = '\0';
 }
 
 void read_line(struct strbuf *sb, FILE *fp, int term) {
 	int ch;
-	strbuf_begin(sb);
 	if (feof(fp)) {
+		strbuf_wipe(sb);
 		sb->eof = 1;
 		return;
 	}
+
+	strbuf_reset(sb);
 	while ((ch = fgetc(fp)) != EOF) {
 		if (ch == term)
 			break;
-		strbuf_add(sb, ch);
+		strbuf_ensure(sb, 1);
+		sb->buf[sb->len++] = ch;
 	}
-	if (ch == EOF && sb->len == 0)
+	if (ch == EOF && sb->len == 0) {
+		strbuf_wipe(sb);
 		sb->eof = 1;
-	strbuf_end(sb);
+	}
+
+	strbuf_ensure(sb, 1);
+	sb->buf[sb->len] = '\0';
 }
+
diff --git a/strbuf.h b/strbuf.h
index 74cc012..ee72419 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -7,7 +7,41 @@ struct strbuf {
 	char *buf;
 };
 
+#define STRBUF_INIT  { 0, 0, 0, NULL }
+
+/* strbuf life cycle */
 extern void strbuf_init(struct strbuf *);
+extern void strbuf_wipe(struct strbuf *);
+extern void strbuf_reset(struct strbuf *);
+extern char *strbuf_detach(struct strbuf *);
+
+
+extern void strbuf_ensure(struct strbuf *, int);
+extern void strbuf_add(struct strbuf *, const void *data, int len);
+
+static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
+	strbuf_add(sb, s, strlen(s));
+}
+static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
+	strbuf_add(sb, sb2->buf, sb2->len);
+}
+static inline void strbuf_addch(struct strbuf *sb, int c) {
+	strbuf_ensure(sb, 1);
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
 extern void read_line(struct strbuf *, FILE *, int);
 
 #endif /* STRBUF_H */
-- 
1.5.3
