From: Jeff King <peff@peff.net>
Subject: [PATCH v3 15/19] pkt-line: share buffer/descriptor reading
 implementation
Date: Wed, 20 Feb 2013 15:04:30 -0500
Message-ID: <20130220200430.GO25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FuT-0006Ik-EB
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935195Ab3BTUEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:04:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54680 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935190Ab3BTUEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:04:32 -0500
Received: (qmail 17868 invoked by uid 107); 20 Feb 2013 20:06:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:06:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:04:30 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216730>

The packet_read function reads from a descriptor. The
packet_get_line function is similar, but reads from an
in-memory buffer, and uses a completely separate
implementation. This patch teaches the generic packet_read
function to accept either source, and we can do away with
packet_get_line's implementation.

There are two other differences to account for between the
old and new functions. The first is that we used to read
into a strbuf, but now read into a fixed size buffer. The
only two callers are fine with that, and in fact it
simplifies their code, since they can use the same
static-buffer interface as the rest of the packet_read_line
callers (and we provide a similar convenience wrapper for
reading from a buffer rather than a descriptor).

This is technically an externally-visible behavior change in
that we used to accept arbitrary sized packets up to 65532
bytes, and now cap out at LARGE_PACKET_MAX, 65520. In
practice this doesn't matter, as we use it only for parsing
smart-http headers (of which there is exactly one defined,
and it is small and fixed-size). And any extension headers
would be breaking the protocol to go over LARGE_PACKET_MAX
anyway.

The other difference is that packet_get_line would return
on error rather than dying. However, both callers of
strbuf_get_line are actually improved by dying.

The first caller does its own error checking, but we can
drop that; as a result, we'll actually get more specific
reporting about protocol breakage when packet_read dies
internally. The only downside is that packet_read will not
print the smart-http URL that failed, but that's not a big
deal; anybody not debugging can already see the remote's URL
already, and anybody debugging would want to run with
GIT_CURL_VERBOSE anyway to see way more information.

The second caller, which is just trying to skip past any
extra smart-http headers (of which there are none defined,
but which we allow to keep room for future expansion), did
not error check at all. As a result, it would treat an error
just like a flush packet. The resulting mess would generally
cause an error later in get_remote_heads, but now we get
error reporting much closer to the source of the problem.

Signed-off-by: Jeff King <peff@peff.net>
---
This adds two options to the generic packet_read interface for which
many callers will just pass (NULL, 0).  We can hide that behind a
wrapper, but I was annoyed with the proliferation of wrappers from the
last round. Pick your poison.

 connect.c     |  3 ++-
 daemon.c      |  2 +-
 pkt-line.c    | 77 ++++++++++++++++++++++++++++++-----------------------------
 pkt-line.h    | 23 +++++++++++++-----
 remote-curl.c | 22 ++++++++---------
 sideband.c    |  2 +-
 6 files changed, 70 insertions(+), 59 deletions(-)

diff --git a/connect.c b/connect.c
index 611ffb4..061aa5b 100644
--- a/connect.c
+++ b/connect.c
@@ -76,7 +76,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		int len, name_len;
 		char *buffer = packet_buffer;
 
-		len = packet_read(in, packet_buffer, sizeof(packet_buffer),
+		len = packet_read(in, NULL, 0,
+				  packet_buffer, sizeof(packet_buffer),
 				  PACKET_READ_GENTLE_ON_EOF |
 				  PACKET_READ_CHOMP_NEWLINE);
 		if (len < 0)
diff --git a/daemon.c b/daemon.c
index 3f70e79..9a241d9 100644
--- a/daemon.c
+++ b/daemon.c
@@ -612,7 +612,7 @@ static int execute(void)
 		loginfo("Connection from %s:%s", addr, port);
 
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read(0, packet_buffer, sizeof(packet_buffer), 0);
+	pktlen = packet_read(0, NULL, 0, packet_buffer, sizeof(packet_buffer), 0);
 	alarm(0);
 
 	len = strlen(line);
diff --git a/pkt-line.c b/pkt-line.c
index 55fb688..2c47052 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -104,12 +104,29 @@ static int safe_read(int fd, void *buffer, unsigned size, int options)
 	strbuf_add(buf, buffer, n);
 }
 
-static int safe_read(int fd, void *buffer, unsigned size, int options)
+static int get_packet_data(int fd, char **src_buf, size_t *src_size,
+			   void *dst, unsigned size, int options)
 {
-	ssize_t ret = read_in_full(fd, buffer, size);
-	if (ret < 0)
-		die_errno("read error");
-	else if (ret < size) {
+	ssize_t ret;
+
+	if (fd >= 0 && src_buf && *src_buf)
+		die("BUG: multiple sources given to packet_read");
+
+	/* Read up to "size" bytes from our source, whatever it is. */
+	if (src_buf && *src_buf) {
+		ret = size < *src_size ? size : *src_size;
+		memcpy(dst, *src_buf, ret);
+		*src_buf += size;
+		*src_size -= size;
+	}
+	else {
+		ret = read_in_full(fd, dst, size);
+		if (ret < 0)
+			die_errno("read error");
+	}
+
+	/* And complain if we didn't get enough bytes to satisfy the read. */
+	if (ret < size) {
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
@@ -144,12 +161,13 @@ int packet_read(int fd, char *buffer, unsigned size, int options)
 	return len;
 }
 
-int packet_read(int fd, char *buffer, unsigned size, int options)
+int packet_read(int fd, char **src_buf, size_t *src_len,
+		char *buffer, unsigned size, int options)
 {
 	int len, ret;
 	char linelen[4];
 
-	ret = safe_read(fd, linelen, 4, options);
+	ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
 	if (ret < 0)
 		return ret;
 	len = packet_length(linelen);
@@ -162,7 +180,7 @@ int packet_read(int fd, char *buffer, unsigned size, int options)
 	len -= 4;
 	if (len >= size)
 		die("protocol error: bad line length %d", len);
-	ret = safe_read(fd, buffer, len, options);
+	ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
 	if (ret < 0)
 		return ret;
 
@@ -175,41 +193,24 @@ int packet_get_line(struct strbuf *out,
 	return len;
 }
 
-char *packet_read_line(int fd, int *len_p)
+static char *packet_read_line_generic(int fd,
+				      char **src, size_t *src_len,
+				      int *dst_len)
 {
-	int len = packet_read(fd, packet_buffer, sizeof(packet_buffer),
+	int len = packet_read(fd, src, src_len,
+			      packet_buffer, sizeof(packet_buffer),
 			      PACKET_READ_CHOMP_NEWLINE);
-	if (len_p)
-		*len_p = len;
+	if (dst_len)
+		*dst_len = len;
 	return len ? packet_buffer : NULL;
 }
 
-int packet_get_line(struct strbuf *out,
-	char **src_buf, size_t *src_len)
+char *packet_read_line(int fd, int *len_p)
 {
-	int len;
-
-	if (*src_len < 4)
-		return -1;
-	len = packet_length(*src_buf);
-	if (len < 0)
-		return -1;
-	if (!len) {
-		*src_buf += 4;
-		*src_len -= 4;
-		packet_trace("0000", 4, 0);
-		return 0;
-	}
-	if (*src_len < len)
-		return -2;
-
-	*src_buf += 4;
-	*src_len -= 4;
-	len -= 4;
+	return packet_read_line_generic(fd, NULL, 0, len_p);
+}
 
-	strbuf_add(out, *src_buf, len);
-	*src_buf += len;
-	*src_len -= len;
-	packet_trace(out->buf, out->len, 0);
-	return len;
+char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
+{
+	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
diff --git a/pkt-line.h b/pkt-line.h
index fa93e32..47361f5 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,9 +25,16 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 /*
- * Read a packetized line from the descriptor into the buffer, which must be at
- * least size bytes long. The return value specifies the number of bytes read
- * into the buffer.
+ * Read a packetized line into the buffer, which must be at least size bytes
+ * long. The return value specifies the number of bytes read into the buffer.
+ *
+ * If src_buffer is not NULL (and nor is *src_buffer), it should point to a
+ * buffer containing the packet data to parse, of at least *src_len bytes.
+ * After the function returns, src_buf will be increments and src_len
+ * decremented by the number of bytes consumed.
+ *
+ * If src_buffer (or *src_buffer) is NULL, then data is read from the
+ * descriptor "fd".
  *
  * If options does not contain PACKET_READ_GENTLE_ON_EOF, we will die under any
  * of the following conditions:
@@ -50,7 +57,8 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
  */
 #define PACKET_READ_GENTLE_ON_EOF (1u<<0)
 #define PACKET_READ_CHOMP_NEWLINE (1u<<1)
-int packet_read(int fd, char *buffer, unsigned size, int options);
+int packet_read(int fd, char **src_buffer, size_t *src_len, char
+		*buffer, unsigned size, int options);
 
 /*
  * Convenience wrapper for packet_read that is not gentle, and sets the
@@ -61,11 +69,14 @@ extern char packet_buffer[LARGE_PACKET_MAX];
  */
 char *packet_read_line(int fd, int *size);
 
+/*
+ * Same as packet_read_line, but read from a buf rather than a descriptor;
+ * see packet_read for details on how src_* is used.
+ */
+char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 extern char packet_buffer[LARGE_PACKET_MAX];
 
-int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
-
 #endif
diff --git a/remote-curl.c b/remote-curl.c
index b28f965..c0edd4c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -138,28 +138,26 @@ static struct discovery* discover_refs(const char *service)
 	if (maybe_smart &&
 	    (5 <= last->len && last->buf[4] == '#') &&
 	    !strbuf_cmp(&exp, &type)) {
+		char *line;
+
 		/*
 		 * smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
-			die("%s has invalid packet header", refs_url);
-		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
-			strbuf_setlen(&buffer, buffer.len - 1);
+		line = packet_read_line_buf(&last->buf, &last->len, NULL);
 
 		strbuf_reset(&exp);
 		strbuf_addf(&exp, "# service=%s", service);
-		if (strbuf_cmp(&exp, &buffer))
-			die("invalid server response; got '%s'", buffer.buf);
+		if (strcmp(line, exp.buf))
+			die("invalid server response; got '%s'", line);
 		strbuf_release(&exp);
 
 		/* The header can include additional metadata lines, up
 		 * until a packet flush marker.  Ignore these now, but
 		 * in the future we might start to scan them.
 		 */
-		strbuf_reset(&buffer);
-		while (packet_get_line(&buffer, &last->buf, &last->len) > 0)
-			strbuf_reset(&buffer);
+		while (packet_read_line_buf(&last->buf, &last->len, NULL) > 0)
+			;
 
 		last->proto_git = 1;
 	}
@@ -308,7 +306,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 
 	if (!avail) {
 		rpc->initial_buffer = 0;
-		avail = packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
+		avail = packet_read(rpc->out, NULL, 0, rpc->buf, rpc->alloc, 0);
 		if (!avail)
 			return 0;
 		rpc->pos = 0;
@@ -425,7 +423,7 @@ static int post_rpc(struct rpc_state *rpc)
 			break;
 		}
 
-		n = packet_read(rpc->out, buf, left, 0);
+		n = packet_read(rpc->out, 0, NULL, buf, left, 0);
 		if (!n)
 			break;
 		rpc->len += n;
@@ -579,7 +577,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->hdr_accept = strbuf_detach(&buf, NULL);
 
 	while (!err) {
-		int n = packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
+		int n = packet_read(rpc->out, 0, NULL, rpc->buf, rpc->alloc, 0);
 		if (!n)
 			break;
 		rpc->pos = 0;
diff --git a/sideband.c b/sideband.c
index 15cc1ae..857954c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -38,7 +38,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	while (1) {
 		int band, len;
-		len = packet_read(in_stream, buf + pf, LARGE_PACKET_MAX, 0);
+		len = packet_read(in_stream, NULL, 0, buf + pf, LARGE_PACKET_MAX, 0);
 		if (len == 0)
 			break;
 		if (len < 1) {
-- 
1.8.2.rc0.9.g352092c
