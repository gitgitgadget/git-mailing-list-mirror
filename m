From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Add strbuf_fread, use it in fast-import.c.
Date: Tue,  4 Sep 2007 10:48:00 +0200
Message-ID: <11888956801971-git-send-email-madcoder@debian.org>
References: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 10:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISU50-00087Y-8E
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 10:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbXIDIsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 04:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbXIDIsG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 04:48:06 -0400
Received: from pan.madism.org ([88.191.52.104]:44243 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbXIDIsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 04:48:03 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3ABF21DD87;
	Tue,  4 Sep 2007 10:48:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3517A145D75; Tue,  4 Sep 2007 10:48:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57541>

  This is a good proof of concept that combined with strbuf_detach it often
helps improving readability a lot, while remaining as efficient as before.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 fast-import.c |   26 ++++++++++----------------
 strbuf.c      |   12 ++++++++++++
 strbuf.h      |    3 +++
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ab3927b..2d8daeb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1638,20 +1638,15 @@ static void cmd_mark(void)
 
 static void *cmd_data (size_t *size)
 {
-	size_t length;
-	char *buffer;
+	struct strbuf buffer = STRBUF_INIT;
 
 	if (prefixcmp(command_buf.buf, "data "))
 		die("Expected 'data n' command, found: %s", command_buf.buf);
 
 	if (!prefixcmp(command_buf.buf + 5, "<<")) {
 		char *term = xstrdup(command_buf.buf + 5 + 2);
-		size_t sz = 8192, term_len = command_buf.len - 5 - 2;
-		length = 0;
-		buffer = xmalloc(sz);
+		size_t term_len = command_buf.len - 5 - 2;
 
-		/* XXX possible memory leak ? */
-		strbuf_detach(&command_buf);
 		for (;;) {
 			read_line(&command_buf, stdin, '\n');
 			if (command_buf.eof)
@@ -1659,19 +1654,18 @@ static void *cmd_data (size_t *size)
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
 				break;
-			ALLOC_GROW(buffer, length + command_buf.len + 1, sz);
-			memcpy(buffer + length, command_buf.buf, command_buf.len);
-			length += command_buf.len;
-			buffer[length++] = '\n';
+			strbuf_addbuf(&buffer, &command_buf);
+			strbuf_addch(&buffer, '\n');
 		}
 		free(term);
 	}
 	else {
-		size_t n = 0;
+		size_t n = 0, length;
+
 		length = strtoul(command_buf.buf + 5, NULL, 10);
-		buffer = xmalloc(length);
+
 		while (n < length) {
-			size_t s = fread(buffer + n, 1, length - n, stdin);
+			size_t s = strbuf_fread(&buffer, length - n, stdin);
 			if (!s && feof(stdin))
 				die("EOF in data (%lu bytes remaining)",
 					(unsigned long)(length - n));
@@ -1680,8 +1674,8 @@ static void *cmd_data (size_t *size)
 	}
 
 	skip_optional_lf();
-	*size = length;
-	return buffer;
+	*size = buffer.len;
+	return strbuf_detach(&buffer);
 }
 
 static int validate_raw_date(const char *src, char *result, int maxlen)
diff --git a/strbuf.c b/strbuf.c
index 86d5965..693fbcf 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -58,6 +58,18 @@ void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
 	sb->buf[sb->len] = '\0';
 }
 
+size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f) {
+	size_t res;
+
+	strbuf_ensure(sb, size);
+	res = fread(sb->buf + sb->len, 1, size, f);
+	if (res > 0) {
+		sb->len += res;
+		sb->buf[sb->len] = '\0';
+	}
+	return res;
+}
+
 void read_line(struct strbuf *sb, FILE *fp, int term) {
 	int ch;
 	if (feof(fp)) {
diff --git a/strbuf.h b/strbuf.h
index ee72419..20c5255 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -42,6 +42,9 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...) {
 	va_end(ap);
 }
 
+
+extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
+
 extern void read_line(struct strbuf *, FILE *, int);
 
 #endif /* STRBUF_H */
-- 
1.5.3
