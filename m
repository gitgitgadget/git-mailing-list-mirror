From: Jeff King <peff@peff.net>
Subject: [PATCH v3 11/19] pkt-line: provide a generic reading function with
 options
Date: Wed, 20 Feb 2013 15:02:10 -0500
Message-ID: <20130220200210.GK25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:02:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FsD-0004iu-9N
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935123Ab3BTUCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:02:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54605 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935071Ab3BTUCM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:02:12 -0500
Received: (qmail 17773 invoked by uid 107); 20 Feb 2013 20:03:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:03:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:02:10 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216725>

Originally we had a single function for reading packetized
data: packet_read_line. Commit 46284dd grew a more "gentle"
form, packet_read, that returns an error instead of dying
upon reading a truncated input stream. However, it is not
clear from the names which should be called, or what the
difference is.

Let's instead make packet_read be a generic public interface
that can take option flags, and update the single callsite
that uses it. This is less code, more clear, and paves the
way for introducing more options into the generic interface
later. The function signature is changed, so there should be
no hidden conflicts with topics in flight.

While we're at it, we'll document how error conditions are
handled based on the options, and rename the confusing
"return_line_fail" option to "gentle_on_eof".  While we are
cleaning up the names, we can drop the "return_line_fail"
checks in packet_read_internal entirely.  They look like
this:

  ret = safe_read(..., return_line_fail);
  if (return_line_fail && ret < 0)
	  ...

The check for return_line_fail is a no-op; safe_read will
only ever return an error value if return_line_fail was true
in the first place.

Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c  |  3 ++-
 pkt-line.c | 21 ++++++++-------------
 pkt-line.h | 27 ++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/connect.c b/connect.c
index 49e56ba..0aa202f 100644
--- a/connect.c
+++ b/connect.c
@@ -76,7 +76,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		char *name;
 		int len, name_len;
 
-		len = packet_read(in, buffer, sizeof(buffer));
+		len = packet_read(in, buffer, sizeof(buffer),
+				  PACKET_READ_GENTLE_ON_EOF);
 		if (len < 0)
 			die_initial_contact(got_at_least_one_head);
 
diff --git a/pkt-line.c b/pkt-line.c
index 699c2dd..8700cf8 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -103,13 +103,13 @@ static int safe_read(int fd, void *buffer, unsigned size, int return_line_fail)
 	strbuf_add(buf, buffer, n);
 }
 
-static int safe_read(int fd, void *buffer, unsigned size, int return_line_fail)
+static int safe_read(int fd, void *buffer, unsigned size, int options)
 {
 	ssize_t ret = read_in_full(fd, buffer, size);
 	if (ret < 0)
 		die_errno("read error");
 	else if (ret < size) {
-		if (return_line_fail)
+		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
 		die("The remote end hung up unexpectedly");
@@ -143,13 +143,13 @@ static int packet_read_internal(int fd, char *buffer, unsigned size, int return_
 	return len;
 }
 
-static int packet_read_internal(int fd, char *buffer, unsigned size, int return_line_fail)
+int packet_read(int fd, char *buffer, unsigned size, int options)
 {
 	int len, ret;
 	char linelen[4];
 
-	ret = safe_read(fd, linelen, 4, return_line_fail);
-	if (return_line_fail && ret < 0)
+	ret = safe_read(fd, linelen, 4, options);
+	if (ret < 0)
 		return ret;
 	len = packet_length(linelen);
 	if (len < 0)
@@ -161,22 +161,17 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	len -= 4;
 	if (len >= size)
 		die("protocol error: bad line length %d", len);
-	ret = safe_read(fd, buffer, len, return_line_fail);
-	if (return_line_fail && ret < 0)
+	ret = safe_read(fd, buffer, len, options);
+	if (ret < 0)
 		return ret;
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
 	return len;
 }
 
-int packet_read(int fd, char *buffer, unsigned size)
-{
-	return packet_read_internal(fd, buffer, size, 1);
-}
-
 int packet_read_line(int fd, char *buffer, unsigned size)
 {
-	return packet_read_internal(fd, buffer, size, 0);
+	return packet_read(fd, buffer, size, 0);
 }
 
 int packet_get_line(struct strbuf *out,
diff --git a/pkt-line.h b/pkt-line.h
index 3b6c19c..8cd326c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -24,8 +24,33 @@ int packet_read_line(int fd, char *buffer, unsigned size);
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
+/*
+ * Read a packetized line from the descriptor into the buffer, which must be at
+ * least size bytes long. The return value specifies the number of bytes read
+ * into the buffer.
+ *
+ * If options does not contain PACKET_READ_GENTLE_ON_EOF, we will die under any
+ * of the following conditions:
+ *
+ *   1. Read error from descriptor.
+ *
+ *   2. Protocol error from the remote (e.g., bogus length characters).
+ *
+ *   3. Receiving a packet larger than "size" bytes.
+ *
+ *   4. Truncated output from the remote (e.g., we expected a packet but got
+ *      EOF, or we got a partial packet followed by EOF).
+ *
+ * If options does contain PACKET_READ_GENTLE_ON_EOF, we will not die on
+ * condition 4 (truncated input), but instead return -1. However, we will still
+ * die for the other 3 conditions.
+ */
+#define PACKET_READ_GENTLE_ON_EOF (1u<<0)
+int packet_read(int fd, char *buffer, unsigned size, int options);
+
+/* Historical convenience wrapper for packet_read that sets no options */
 int packet_read_line(int fd, char *buffer, unsigned size);
-int packet_read(int fd, char *buffer, unsigned size);
+
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 
 #endif
-- 
1.8.2.rc0.9.g352092c
