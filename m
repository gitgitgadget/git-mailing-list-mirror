Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9441F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbeKNKuH (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:50:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:38318 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726193AbeKNKuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:50:07 -0500
Received: (qmail 16211 invoked by uid 109); 14 Nov 2018 00:49:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 00:49:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28828 invoked by uid 111); 14 Nov 2018 00:48:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Nov 2018 19:48:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2018 19:49:15 -0500
Date:   Tue, 13 Nov 2018 19:49:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
Message-ID: <20181114004915.GA5059@sigill.intra.peff.net>
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
 <20181113142624.GA17128@sigill.intra.peff.net>
 <20181113222540.GE126896@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181113222540.GE126896@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 02:25:40PM -0800, Josh Steadmon wrote:

> > The magic "4" here and in the existing "version 2" check is because we
> > are expecting pkt-lines. The original conditional always calls
> > packed_read_line_buf() and will complain if we didn't actually get a
> > pkt-line.
> > 
> > Should we confirm that we got a real packet-line? Or at least that those
> > first four are even plausible hex chars?
> > 
> > I admit that it's pretty unlikely that the server is going to fool us
> > here. It would need something like "foo ERRORS ARE FUN!". And even then
> > we'd report an error (whereas the correct behavior is falling back to
> > dumb http, but we know that won't work anyway because that's not a valid
> > ref advertisement). So I doubt this is really a bug per se, but it might
> > make it easier to understand what's going on if we actually parsed the
> > packet.
> 
> Unfortunately we can't just directly parse the data in last->buf,
> because other parts of the code are expecting to see the raw pkt-line
> data there. I tried adding a duplicate pointer and length variable for
> this data and parsing that through packet_read_line_buf(), but even
> without using the results this apparently has side-effects that break
> all of t5550 (and probably other tests as well). It also fails if I
> completely duplicate last->buf into a new char* and call
> packet_readline_buf() on that, so there's clearly some interaction in
> the pkt-line guts that I'm not properly accounting for.

Yes, the packet_read_line_buf() interface will both advance the buf
pointer and decrement the length.  So if we want to "peek", we have to
do so with a copy (there's a peek function if you use the packet_reader
interface, but that might be overkill here).

You can rewrite it like this, which is a pretty faithful conversion and
passes the tests (but see below).

diff --git a/remote-curl.c b/remote-curl.c
index 762a55a75f..66c57c9d62 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -330,9 +330,78 @@ static int get_protocol_http_header(enum protocol_version version,
 	return 0;
 }
 
+static void check_smart_http(struct discovery *d, const char *service,
+			     struct strbuf *type)
+{
+	char *src_buf;
+	size_t src_len;
+	char pkt[LARGE_PACKET_MAX];
+	int pkt_len;
+	enum packet_read_status r;
+
+	/*
+	 * We speculatively try to read a packet, which means we must preserve
+	 * the original buf/len pair in some cases.
+	 */
+	src_buf = d->buf;
+	src_len = d->len;
+	r = packet_read_with_status(-1, &src_buf, &src_len,
+				    pkt, sizeof(pkt), &pkt_len,
+				    PACKET_READ_GENTLE |
+				    PACKET_READ_CHOMP_NEWLINE);
+
+	/*
+	 * This could probably just be handled as "not smart" like all the
+	 * other pkt-line error cases, but traditionally we've complained
+	 * about it (technically we used to do so only when we got the right
+	 * content-type, but it probably doesn't matter).
+	 */
+	if (r == PACKET_READ_FLUSH)
+		die("invalid server response; expected service, got flush packet");
+	if (r != PACKET_READ_NORMAL)
+		return; /* not smart */
+
+	if (pkt[0] == '#') {
+		/* v0 smart http */
+		struct strbuf exp = STRBUF_INIT;
+
+		strbuf_addf(&exp, "application/x-%s-advertisement", service);
+		if (strbuf_cmp(&exp, type)) {
+			strbuf_release(&exp);
+			return;
+		}
+
+		strbuf_reset(&exp);
+		strbuf_addf(&exp, "# service=%s", service);
+		if (strcmp(pkt, exp.buf))
+			die("invalid server response; got '%s'", pkt);
+
+		strbuf_release(&exp);
+
+		/*
+		 * The header can include additional metadata lines, up
+		 * until a packet flush marker.  Ignore these now, but
+		 * in the future we might start to scan them.
+		 */
+		while (packet_read_line_buf(&src_buf, &src_len, NULL))
+			;
+
+		d->buf = src_buf;
+		d->len = src_len;
+		d->proto_git = 1;
+
+	} else if (starts_with(pkt, "version 2")) {
+		/*
+		 * v2 smart http; do not consume version packet, which will
+		 * be handled elsewhere. Should we be checking the content-type
+		 * in this code-path, too?
+		 */
+		d->proto_git = 1;
+	}
+}
+
 static struct discovery *discover_refs(const char *service, int for_push)
 {
-	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
 	struct strbuf charset = STRBUF_INIT;
 	struct strbuf buffer = STRBUF_INIT;
@@ -405,38 +474,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-	strbuf_addf(&exp, "application/x-%s-advertisement", service);
-	if (maybe_smart &&
-	    (5 <= last->len && last->buf[4] == '#') &&
-	    !strbuf_cmp(&exp, &type)) {
-		char *line;
-
-		/*
-		 * smart HTTP response; validate that the service
-		 * pkt-line matches our request.
-		 */
-		line = packet_read_line_buf(&last->buf, &last->len, NULL);
-		if (!line)
-			die("invalid server response; expected service, got flush packet");
-
-		strbuf_reset(&exp);
-		strbuf_addf(&exp, "# service=%s", service);
-		if (strcmp(line, exp.buf))
-			die("invalid server response; got '%s'", line);
-		strbuf_release(&exp);
-
-		/* The header can include additional metadata lines, up
-		 * until a packet flush marker.  Ignore these now, but
-		 * in the future we might start to scan them.
-		 */
-		while (packet_read_line_buf(&last->buf, &last->len, NULL))
-			;
-
-		last->proto_git = 1;
-	} else if (maybe_smart &&
-		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
-		last->proto_git = 1;
-	}
+	if (maybe_smart)
+		check_smart_http(last, service, &type);
 
 	if (last->proto_git)
 		last->refs = parse_git_refs(last, for_push);
@@ -444,7 +483,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		last->refs = parse_info_refs(last);
 
 	strbuf_release(&refs_url);
-	strbuf_release(&exp);
 	strbuf_release(&type);
 	strbuf_release(&charset);
 	strbuf_release(&effective_url);

So the few tricky things are:

  - the ordering with respect to checking the packet and the
    content-type is a little different here. Should v2 protocol be
    expecting that content-type, too? If so, then I think it would make
    sense to check that first, before even considering if there's a
    packet to read (and the current code is overly-permissive in that
    case).

  - there is no way to speculatively read a packet and not die() if the
    buffer doesn't have pkt-lines in it. So we'd additionally need the
    patch below (which annoyingly has to touch a bunch of switch
    statements to keep the compiler happy). If we _can_ check the
    content-type first, then all of that could go away (i.e., once we
    see the right content-type, we're confident enough in expecting
    packets to die() in the existing packet code-paths).

diff --git a/connect.c b/connect.c
index 24281b6082..1caafc3ce7 100644
--- a/connect.c
+++ b/connect.c
@@ -125,6 +125,8 @@ enum protocol_version discover_version(struct packet_reader *reader)
 	switch (packet_reader_peek(reader)) {
 	case PACKET_READ_EOF:
 		die_initial_contact(0);
+	case PACKET_READ_FORMAT_ERROR:
+		BUG("format error from non-gentle packet read");
 	case PACKET_READ_FLUSH:
 	case PACKET_READ_DELIM:
 		version = protocol_v0;
@@ -304,6 +306,8 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 		switch (packet_reader_read(reader)) {
 		case PACKET_READ_EOF:
 			die_initial_contact(1);
+		case PACKET_READ_FORMAT_ERROR:
+			BUG("format error from non-gentle packet read");
 		case PACKET_READ_NORMAL:
 			len = reader->pktlen;
 			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
diff --git a/pkt-line.c b/pkt-line.c
index 04d10bbd03..2daacc6188 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -293,7 +293,8 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
 	if (ret != size) {
-		if (options & PACKET_READ_GENTLE_ON_EOF)
+		if ((options & PACKET_READ_GENTLE_ON_EOF) ||
+		    (options & PACKET_READ_GENTLE))
 			return -1;
 
 		die(_("the remote end hung up unexpectedly"));
@@ -324,6 +325,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	len = packet_length(linelen);
 
 	if (len < 0) {
+		if (options & PACKET_READ_GENTLE) {
+			*pktlen = -1;
+			return PACKET_READ_FORMAT_ERROR;
+		}
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
@@ -334,12 +339,21 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		*pktlen = 0;
 		return PACKET_READ_DELIM;
 	} else if (len < 4) {
+		if (options & PACKET_READ_GENTLE) {
+			*pktlen = -1;
+			return PACKET_READ_FORMAT_ERROR;
+		}
 		die(_("protocol error: bad line length %d"), len);
 	}
 
 	len -= 4;
-	if ((unsigned)len >= size)
+	if ((unsigned)len >= size) {
+		if (options & PACKET_READ_GENTLE) {
+			*pktlen = -1;
+			return PACKET_READ_FORMAT_ERROR;
+		}
 		die(_("protocol error: bad line length %d"), len);
+	}
 
 	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
 		*pktlen = -1;
diff --git a/pkt-line.h b/pkt-line.h
index 5b28d43472..7580f83cdc 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -44,7 +44,7 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
  * If src_buffer (or *src_buffer) is NULL, then data is read from the
  * descriptor "fd".
  *
- * If options does not contain PACKET_READ_GENTLE_ON_EOF, we will die under any
+ * If options does not contain PACKET_READ_GENTLE, we will die under any
  * of the following conditions:
  *
  *   1. Read error from descriptor.
@@ -56,6 +56,8 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
  *   4. Truncated output from the remote (e.g., we expected a packet but got
  *      EOF, or we got a partial packet followed by EOF).
  *
+ * If options does contain PACKET_READ_GENTLE, we'll instead return -1.
+ *
  * If options does contain PACKET_READ_GENTLE_ON_EOF, we will not die on
  * condition 4 (truncated input), but instead return -1. However, we will still
  * die for the other 3 conditions.
@@ -65,6 +67,7 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
  */
 #define PACKET_READ_GENTLE_ON_EOF (1u<<0)
 #define PACKET_READ_CHOMP_NEWLINE (1u<<1)
+#define PACKET_READ_GENTLE        (1u<<2)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
@@ -79,6 +82,7 @@ enum packet_read_status {
 	PACKET_READ_NORMAL,
 	PACKET_READ_FLUSH,
 	PACKET_READ_DELIM,
+	PACKET_READ_FORMAT_ERROR,
 };
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						size_t *src_len, char *buffer,
diff --git a/remote-curl.c b/remote-curl.c
index 762a55a75f..66c57c9d62 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1214,6 +1252,8 @@ static size_t proxy_in(char *buffer, size_t eltsize,
 		switch (packet_reader_read(&p->reader)) {
 		case PACKET_READ_EOF:
 			die("unexpected EOF when reading from parent process");
+		case PACKET_READ_FORMAT_ERROR:
+			BUG("format error from non-gentle packet read");
 		case PACKET_READ_NORMAL:
 			packet_buf_write_len(&p->request_buffer, p->reader.line,
 					     p->reader.pktlen);
diff --git a/serve.c b/serve.c
index bda085f09c..e88936262b 100644
--- a/serve.c
+++ b/serve.c
@@ -181,6 +181,8 @@ static int process_request(void)
 		switch (packet_reader_peek(&reader)) {
 		case PACKET_READ_EOF:
 			BUG("Should have already died when seeing EOF");
+		case PACKET_READ_FORMAT_ERROR:
+			BUG("format error from non-gentle packet read");
 		case PACKET_READ_NORMAL:
 			/* collect request; a sequence of keys and values */
 			if (is_command(reader.line, &command) ||
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 282d536384..1522176a2f 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -37,6 +37,8 @@ static void unpack(void)
 		switch (reader.status) {
 		case PACKET_READ_EOF:
 			break;
+		case PACKET_READ_FORMAT_ERROR:
+			BUG("format error from non-gentle packet read");
 		case PACKET_READ_NORMAL:
 			printf("%s\n", reader.line);
 			break;
@@ -64,6 +66,8 @@ static void unpack_sideband(void)
 		switch (reader.status) {
 		case PACKET_READ_EOF:
 			break;
+		case PACKET_READ_FORMAT_ERROR:
+			BUG("format error from non-gentle packet read");
 		case PACKET_READ_NORMAL:
 			band = reader.line[0] & 0xff;
 			if (band < 1 || band > 2)

