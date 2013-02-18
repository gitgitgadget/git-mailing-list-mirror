From: Jeff King <peff@peff.net>
Subject: [PATCHv2 03/10] pkt-line: clean up "gentle" reading function
Date: Mon, 18 Feb 2013 04:16:19 -0500
Message-ID: <20130218091619.GC5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:16:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Mq8-00077h-9E
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262Ab3BRJQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:16:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757260Ab3BRJQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:16:22 -0500
Received: (qmail 17596 invoked by uid 107); 18 Feb 2013 09:17:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:17:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:16:19 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216448>

Originally we had a single function for reading packetized
data: packet_read_line. Commit 46284dd grew a more "gentle"
form that would return an error instead of dying upon
reading a truncated input stream. However:

  1. The two functions were called "packet_read" and
     "packet_read_line", with no indication that the only
     difference is in the error handling.

  2. There was no documentation about which error conditions
     were handled in the gentle form, and which still caused
     a death.

  3. The internal variable to trigger the gentle mode was
     called "return_line_fail", which was not very
     expressive.

This patch converts packet_line to packet_read_line_gently
to more clearly indicate its relationship to
packet_read_line, and renames the internal variable to
"gently". This is also not incredibly expressive, but it is
at least a convention within the git code. And finally, we
document the exact behavior for the gentle and non-gentle
modes.

While we are cleaning up the names, we can drop the
"return_line_fail" checks in packet_read_internal entirely.
They look like this:

  ret = safe_read(..., return_line_fail);
  if (return_line_fail && ret < 0)
	  ...

The check for return_line_fail is a no-op; safe_read will
only ever return an error value if we passed it
return_line_fail in the first place.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously this one is a matter of taste, but I think the result is much
better. Certainly the documentation bits are hard to argue with. :)

 connect.c  |  2 +-
 pkt-line.c | 16 ++++++++--------
 pkt-line.h | 21 ++++++++++++++++++++-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index 49e56ba..7e0920d 100644
--- a/connect.c
+++ b/connect.c
@@ -76,7 +76,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		char *name;
 		int len, name_len;
 
-		len = packet_read(in, buffer, sizeof(buffer));
+		len = packet_read_line_gently(in, buffer, sizeof(buffer));
 		if (len < 0)
 			die_initial_contact(got_at_least_one_head);
 
diff --git a/pkt-line.c b/pkt-line.c
index 699c2dd..62479d3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -103,13 +103,13 @@ static int safe_read(int fd, void *buffer, unsigned size, int return_line_fail)
 	strbuf_add(buf, buffer, n);
 }
 
-static int safe_read(int fd, void *buffer, unsigned size, int return_line_fail)
+static int safe_read(int fd, void *buffer, unsigned size, int gently)
 {
 	ssize_t ret = read_in_full(fd, buffer, size);
 	if (ret < 0)
 		die_errno("read error");
 	else if (ret < size) {
-		if (return_line_fail)
+		if (gently)
 			return -1;
 
 		die("The remote end hung up unexpectedly");
@@ -143,13 +143,13 @@ static int packet_read_internal(int fd, char *buffer, unsigned size, int return_
 	return len;
 }
 
-static int packet_read_internal(int fd, char *buffer, unsigned size, int return_line_fail)
+static int packet_read_internal(int fd, char *buffer, unsigned size, int gently)
 {
 	int len, ret;
 	char linelen[4];
 
-	ret = safe_read(fd, linelen, 4, return_line_fail);
-	if (return_line_fail && ret < 0)
+	ret = safe_read(fd, linelen, 4, gently);
+	if (ret < 0)
 		return ret;
 	len = packet_length(linelen);
 	if (len < 0)
@@ -161,15 +161,15 @@ static int packet_read_internal(int fd, char *buffer, unsigned size, int return_
 	len -= 4;
 	if (len >= size)
 		die("protocol error: bad line length %d", len);
-	ret = safe_read(fd, buffer, len, return_line_fail);
-	if (return_line_fail && ret < 0)
+	ret = safe_read(fd, buffer, len, gently);
+	if (ret < 0)
 		return ret;
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
 	return len;
 }
 
-int packet_read(int fd, char *buffer, unsigned size)
+int packet_read_line_gently(int fd, char *buffer, unsigned size)
 {
 	return packet_read_internal(fd, buffer, size, 1);
 }
diff --git a/pkt-line.h b/pkt-line.h
index 7a67e9c..31bd069 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -24,8 +24,27 @@ int packet_read_line(int fd, char *buffer, unsigned size);
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
+/*
+ * Read a packetized line from the descriptor into the buffer. We will die
+ * under any of the following conditions:
+ *
+ *   1. Read error from descriptor.
+ *
+ *   2. Protocol error from the remote (e.g., bogus length characters).
+ *
+ *   3. Receiving a packet larger than "size" bytes.
+ *
+ *   4. Truncated output from the remote (e.g., we expected a packet but got
+ *      EOF, or we got a partial packet followed by EOF).
+ */
 int packet_read_line(int fd, char *buffer, unsigned size);
-int packet_read(int fd, char *buffer, unsigned size);
+
+/*
+ * Same as packet_read_line, but do not die on condition 4 (truncated input);
+ * instead return -1.  We still die for the other conditions.
+ */
+int packet_read_line_gently(int fd, char *buffer, unsigned size);
+
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 ssize_t safe_write(int, const void *, ssize_t);
 
-- 
1.8.1.20.g7078b03
