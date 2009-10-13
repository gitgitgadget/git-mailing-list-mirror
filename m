From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 01/16] pkt-line: Add strbuf based functions
Date: Mon, 12 Oct 2009 19:25:00 -0700
Message-ID: <1255400715-10508-2-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXD9-0004cs-Kq
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758826AbZJMC0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758814AbZJMCZy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:25:54 -0400
Received: from george.spearce.org ([209.20.77.23]:35582 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758811AbZJMCZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:25:53 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3E410381FE; Tue, 13 Oct 2009 02:25:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8D669381FE
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 02:25:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130104>

These routines help to work with pkt-line values inside of a strbuf,
permitting simple formatting of buffered network messages.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 pkt-line.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 pkt-line.h |    4 +++
 2 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index b691abe..2333d96 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -42,17 +42,19 @@ void packet_flush(int fd)
 	safe_write(fd, "0000", 4);
 }
 
+void packet_buf_flush(struct strbuf *buf)
+{
+	strbuf_add(buf, "0000", 4);
+}
+
 #define hex(a) (hexchar[(a) & 15])
-void packet_write(int fd, const char *fmt, ...)
+static char buffer[1000];
+static unsigned format_packet(const char *fmt, va_list args)
 {
-	static char buffer[1000];
 	static char hexchar[] = "0123456789abcdef";
-	va_list args;
 	unsigned n;
 
-	va_start(args, fmt);
 	n = vsnprintf(buffer + 4, sizeof(buffer) - 4, fmt, args);
-	va_end(args);
 	if (n >= sizeof(buffer)-4)
 		die("protocol error: impossibly long line");
 	n += 4;
@@ -60,9 +62,31 @@ void packet_write(int fd, const char *fmt, ...)
 	buffer[1] = hex(n >> 8);
 	buffer[2] = hex(n >> 4);
 	buffer[3] = hex(n);
+	return n;
+}
+
+void packet_write(int fd, const char *fmt, ...)
+{
+	va_list args;
+	unsigned n;
+
+	va_start(args, fmt);
+	n = format_packet(fmt, args);
+	va_end(args);
 	safe_write(fd, buffer, n);
 }
 
+void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
+{
+	va_list args;
+	unsigned n;
+
+	va_start(args, fmt);
+	n = format_packet(fmt, args);
+	va_end(args);
+	strbuf_add(buf, buffer, n);
+}
+
 static void safe_read(int fd, void *buffer, unsigned size)
 {
 	ssize_t ret = read_in_full(fd, buffer, size);
@@ -72,15 +96,11 @@ static void safe_read(int fd, void *buffer, unsigned size)
 		die("The remote end hung up unexpectedly");
 }
 
-int packet_read_line(int fd, char *buffer, unsigned size)
+static int packet_length(unsigned *ret_len, const char *linelen)
 {
 	int n;
-	unsigned len;
-	char linelen[4];
-
-	safe_read(fd, linelen, 4);
+	unsigned len = 0;
 
-	len = 0;
 	for (n = 0; n < 4; n++) {
 		unsigned char c = linelen[n];
 		len <<= 4;
@@ -96,8 +116,20 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 			len += c - 'A' + 10;
 			continue;
 		}
-		die("protocol error: bad line length character");
+		return -1;
 	}
+	*ret_len = len;
+	return 0;
+}
+
+int packet_read_line(int fd, char *buffer, unsigned size)
+{
+	unsigned len;
+	char linelen[4];
+
+	safe_read(fd, linelen, 4);
+	if (packet_length(&len, linelen))
+		die("protocol error: bad line length character");
 	if (!len)
 		return 0;
 	len -= 4;
@@ -107,3 +139,28 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	buffer[len] = 0;
 	return len;
 }
+
+int packet_get_line(struct strbuf *out,
+	char **src_buf, size_t *src_len)
+{
+	unsigned len;
+
+	if (*src_len < 4 || packet_length(&len, *src_buf))
+		return -1;
+	if (!len) {
+		*src_buf += 4;
+		*src_len -= 4;
+		return 0;
+	}
+	if (*src_len < len)
+		return -2;
+
+	*src_buf += 4;
+	*src_len -= 4;
+	len -= 4;
+
+	strbuf_add(out, *src_buf, len);
+	*src_buf += len;
+	*src_len -= len;
+	return len;
+}
diff --git a/pkt-line.h b/pkt-line.h
index 9df653f..1e5dcfe 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -2,14 +2,18 @@
 #define PKTLINE_H
 
 #include "git-compat-util.h"
+#include "strbuf.h"
 
 /*
  * Silly packetized line writing interface
  */
 void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_buf_flush(struct strbuf *buf);
+void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 int packet_read_line(int fd, char *buffer, unsigned size);
+int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 ssize_t safe_write(int, const void *, ssize_t);
 
 #endif
-- 
1.6.5.52.g0ff2e
