From: Jeff King <peff@peff.net>
Subject: [PATCHv2 06/10] pkt-line: share buffer/descriptor reading
 implementation
Date: Mon, 18 Feb 2013 04:26:12 -0500
Message-ID: <20130218092612.GF5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Mzf-00033P-Lz
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976Ab3BRJ0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:26:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51685 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab3BRJ0O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:26:14 -0500
Received: (qmail 17683 invoked by uid 107); 18 Feb 2013 09:27:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:27:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:26:12 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216452>

The packet_read function reads from a descriptor. The
packet_get_line function is similar, but reads from an
in-memory buffer, and uses a completely separate
implementation. This patch teaches the internal function
backing packet_read to accept either source, and use the
appropriate one. As a result:

  1. The function has been renamed to packet_read_from_buf,
     which more clearly indicates its relationship to the
     packet_read function.

  2. The original packet_get_line wrote to a strbuf; the new
     function, like its descriptor counterpart, reads into a
     buffer provided by the caller.

  3. The original function did not die on any errors, but
     instead returned an error code. Now we have the usual
     "normal" and "gently" forms.

There are only two existing calls to packet_get_line which
have to be converted, and both are in remote-curl. The first
reads and checks the "# service=git-foo" line from a smart
http server.  The second just reads past any additional
smart headers, without bothering to look at them.

This patch converts both to the new form, with a few
implications:

  1. Because we use the non-gentle form, the first caller
     can drop its own error checking. As a result, we will get
     more accurate error reporting about protocol breakage,
     since the errors come from inside the protocol code. We
     will no longer print the URL as part of the error, but
     that's OK. Protocol breakages should be rare (and we
     are pretty sure at this point in the code that it is a
     real smart server, so we won't be confused by dumb
     servers), and the first debugging step would probably
     be GIT_CURL_VERBOSE, anyway.

  2. The second caller did not error check at all, and now
     does. This can help us catch broken or truncated input
     close to the source.

  3. Since we are no longer using a strbuf, we now have a
     1000-byte limit on the smart-http headers. That should
     be fine, as the only header that has ever been sent
     here is the short "service=git-foo" header.

Signed-off-by: Jeff King <peff@peff.net>
---
The diffstat shows more lines appearing, but it is mainly from comments
and from the various parse_line{_from_buf,}{,_gently} variants; we
really do get rid of a duplicate parsing implementation, and we
harmonize all of the error conditions and messages.

We can also make "gently" a parameter to avoid the proliferation of
related functions, but would mean all but one callsite would have to
pass an extra "0". Choose your poison, I guess.

 pkt-line.c    | 69 ++++++++++++++++++++++++++++-------------------------------
 pkt-line.h    | 11 +++++++++-
 remote-curl.c | 19 ++++++++--------
 3 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 85faf73..7ee91e0 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -103,12 +103,26 @@ static int safe_read(int fd, void *buffer, unsigned size, int gently)
 	strbuf_add(buf, buffer, n);
 }
 
-static int safe_read(int fd, void *buffer, unsigned size, int gently)
+static int get_packet_data(int fd, char **src_buf, size_t *src_size,
+			   void *dst, unsigned size, int gently)
 {
-	ssize_t ret = read_in_full(fd, buffer, size);
-	if (ret < 0)
-		die_errno("read error");
-	else if (ret < size) {
+	ssize_t ret;
+
+	/* Read up to "size" bytes from our source, whatever it is. */
+	if (src_buf) {
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
 		if (gently)
 			return -1;
 
@@ -143,12 +157,13 @@ static int packet_read_internal(int fd, char *buffer, unsigned size, int gently)
 	return len;
 }
 
-static int packet_read_internal(int fd, char *buffer, unsigned size, int gently)
+static int packet_read_internal(int fd, char **src_buf, size_t *src_len,
+				char *buffer, unsigned size, int gently)
 {
 	int len, ret;
 	char linelen[4];
 
-	ret = safe_read(fd, linelen, 4, gently);
+	ret = get_packet_data(fd, src_buf, src_len, linelen, 4, gently);
 	if (ret < 0)
 		return ret;
 	len = packet_length(linelen);
@@ -162,7 +177,7 @@ static int packet_read_internal(int fd, char *buffer, unsigned size, int gently)
 	if (len >= size)
 		die("protocol error: line too large: (expected %u, got %d)",
 		    size, len);
-	ret = safe_read(fd, buffer, len, gently);
+	ret = get_packet_data(fd, src_buf, src_len, buffer, len, gently);
 	if (ret < 0)
 		return ret;
 	buffer[len] = 0;
@@ -172,40 +187,22 @@ int packet_get_line(struct strbuf *out,
 
 int packet_read_gently(int fd, char *buffer, unsigned size)
 {
-	return packet_read_internal(fd, buffer, size, 1);
+	return packet_read_internal(fd, NULL, 0, buffer, size, 1);
 }
 
 int packet_read(int fd, char *buffer, unsigned size)
 {
-	return packet_read_internal(fd, buffer, size, 0);
+	return packet_read_internal(fd, NULL, 0, buffer, size, 0);
 }
 
-int packet_get_line(struct strbuf *out,
-	char **src_buf, size_t *src_len)
+int packet_read_from_buf(char *dst, unsigned dst_len,
+			 char **src_buf, size_t *src_len)
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
+	return packet_read_internal(-1, src_buf, src_len, dst, dst_len, 0);
+}
 
-	strbuf_add(out, *src_buf, len);
-	*src_buf += len;
-	*src_len -= len;
-	packet_trace(out->buf, out->len, 0);
-	return len;
+int packet_read_from_buf_gently(char *dst, unsigned dst_len,
+				char **src_buf, size_t *src_len)
+{
+	return packet_read_internal(-1, src_buf, src_len, dst, dst_len, 1);
 }
diff --git a/pkt-line.h b/pkt-line.h
index 2dc4941..287a391 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -45,7 +45,16 @@ int packet_read_gently(int fd, char *buffer, unsigned size);
  */
 int packet_read_gently(int fd, char *buffer, unsigned size);
 
-int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
+/*
+ * Same as packet_read above, but read from an in-memory buffer
+ * instead of a file descriptor. The src_buf and src_len are modified
+ * to iterate past the consumed data.
+ */
+int packet_read_from_buf(char *dst, unsigned dst_len,
+			 char **src_buf, size_t *src_len);
+int packet_read_from_buf_gently(char *dst, unsigned dst_len,
+				char **src_buf, size_t *src_len);
+
 ssize_t safe_write(int, const void *, ssize_t);
 
 #endif
diff --git a/remote-curl.c b/remote-curl.c
index 99cc016..2ec5854 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -138,28 +138,29 @@ static struct discovery* discover_refs(const char *service)
 	if (maybe_smart &&
 	    (5 <= last->len && last->buf[4] == '#') &&
 	    !strbuf_cmp(&exp, &type)) {
+		char line[1000];
+		int len;
+
 		/*
 		 * smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
-			die("%s has invalid packet header", refs_url);
-		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
-			strbuf_setlen(&buffer, buffer.len - 1);
+		len = packet_read_from_buf(line, sizeof(line), &last->buf, &last->len);
+		if (len && line[len - 1] == '\n')
+			len--;
 
 		strbuf_reset(&exp);
 		strbuf_addf(&exp, "# service=%s", service);
-		if (strbuf_cmp(&exp, &buffer))
-			die("invalid server response; got '%s'", buffer.buf);
+		if (len != exp.len || memcmp(exp.buf, line, len))
+			die("invalid server response; got '%s'", line);
 		strbuf_release(&exp);
 
 		/* The header can include additional metadata lines, up
 		 * until a packet flush marker.  Ignore these now, but
 		 * in the future we might start to scan them.
 		 */
-		strbuf_reset(&buffer);
-		while (packet_get_line(&buffer, &last->buf, &last->len) > 0)
-			strbuf_reset(&buffer);
+		while (packet_read_from_buf(line, sizeof(line), &last->buf, &last->len) > 0)
+			;
 
 		last->proto_git = 1;
 	}
-- 
1.8.1.20.g7078b03
