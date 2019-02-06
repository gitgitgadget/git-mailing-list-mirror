Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812DD1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 19:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBFTSv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 14:18:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:34944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726792AbfBFTSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 14:18:51 -0500
Received: (qmail 12838 invoked by uid 109); 6 Feb 2019 19:18:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 19:18:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4566 invoked by uid 111); 6 Feb 2019 19:18:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 14:18:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 14:18:48 -0500
Date:   Wed, 6 Feb 2019 14:18:48 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: [PATCH 1/3] remote-curl: refactor smart-http discovery
Message-ID: <20190206191848.GA10893@sigill.intra.peff.net>
References: <20190206191657.GE10231@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206191657.GE10231@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After making initial contact with an http server, we have to decide if
the server supports smart-http, and if so, which version. Our rules are
a bit inconsistent:

  1. For v0, we require that the content-type indicates a smart-http
     response. We also require the response to look vaguely like a
     pkt-line starting with "#". If one of those does not match, we fall
     back to dumb-http.

     But according to our http protocol spec[1]:

       Dumb servers MUST NOT return a return type starting with
       `application/x-git-`.

     If we see the expected content-type, we should consider it
     smart-http. At that point we can parse the pkt-line for real, and
     complain if it is not syntactically valid.

  2. For v2, we do not actually check the content-type. Our v2 protocol
     spec says[2]:

       When using the http:// or https:// transport a client makes a
       "smart" info/refs request as described in `http-protocol.txt`[...]

     and the http spec is clear that for a smart-http response[3]:

       The Content-Type MUST be `application/x-$servicename-advertisement`.

     So it is required according to the spec.

These inconsistencies were easy to miss because of the way the original
code was written as an inline conditional. Let's pull it out into its
own function for readability, and improve a few things:

 - we now predicate the smart/dumb decision entirely on the presence of
   the correct content-type

 - we do a real pkt-line parse before deciding how to proceed (and die
   if it isn't valid)

 - use skip_prefix() for comparing service strings, instead of
   constructing expected output in a strbuf; this avoids dealing with
   memory cleanup

Note that this _is_ tightening what the client will allow. It's all
according to the spec, but it's possible that other implementations
might violate these. However, violating these particular rules seems
like an odd choice for a server to make.

[1] Documentation/technical/http-protocol.txt, l. 166-167
[2] Documentation/technical/protocol-v2.txt, l. 63-64
[3] Documentation/technical/http-protocol.txt, l. 247

Helped-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 100 ++++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 2e04d53ac8..c78ba83744 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -331,9 +331,63 @@ static int get_protocol_http_header(enum protocol_version version,
 	return 0;
 }
 
+static void check_smart_http(struct discovery *d, const char *service,
+			     struct strbuf *type)
+{
+	const char *p;
+	struct packet_reader reader;
+
+	/*
+	 * If we don't see x-$service-advertisement, then it's not smart-http.
+	 * But once we do, we commit to it and assume any other protocol
+	 * violations are hard errors.
+	 */
+	if (!skip_prefix(type->buf, "application/x-", &p) ||
+	    !skip_prefix(p, service, &p) ||
+	    strcmp(p, "-advertisement"))
+		return;
+
+	packet_reader_init(&reader, -1, d->buf, d->len,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
+	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
+		die("invalid server response; expected service, got flush packet");
+
+	if (skip_prefix(reader.line, "# service=", &p) && !strcmp(p, service)) {
+		/*
+		 * The header can include additional metadata lines, up
+		 * until a packet flush marker.  Ignore these now, but
+		 * in the future we might start to scan them.
+		 */
+		for (;;) {
+			packet_reader_read(&reader);
+			if (reader.pktlen <= 0) {
+				break;
+			}
+		}
+
+		/*
+		 * v0 smart http; callers expect us to soak up the
+		 * service and header packets
+		 */
+		d->buf = reader.src_buffer;
+		d->len = reader.src_len;
+		d->proto_git = 1;
+
+	} else if (starts_with(reader.line, "version 2")) {
+		/*
+		 * v2 smart http; do not consume version packet, which will
+		 * be handled elsewhere.
+		 */
+		d->proto_git = 1;
+
+	} else {
+		die("invalid server response; got '%s'", reader.line);
+	}
+}
+
 static struct discovery *discover_refs(const char *service, int for_push)
 {
-	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
 	struct strbuf charset = STRBUF_INIT;
 	struct strbuf buffer = STRBUF_INIT;
@@ -405,47 +459,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-	strbuf_addf(&exp, "application/x-%s-advertisement", service);
-	if (maybe_smart &&
-	    (5 <= last->len && last->buf[4] == '#') &&
-	    !strbuf_cmp(&exp, &type)) {
-		struct packet_reader reader;
-		packet_reader_init(&reader, -1, last->buf, last->len,
-				   PACKET_READ_CHOMP_NEWLINE |
-				   PACKET_READ_DIE_ON_ERR_PACKET);
-
-		/*
-		 * smart HTTP response; validate that the service
-		 * pkt-line matches our request.
-		 */
-		if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
-			die("invalid server response; expected service, got flush packet");
-
-		strbuf_reset(&exp);
-		strbuf_addf(&exp, "# service=%s", service);
-		if (strcmp(reader.line, exp.buf))
-			die("invalid server response; got '%s'", reader.line);
-		strbuf_release(&exp);
-
-		/* The header can include additional metadata lines, up
-		 * until a packet flush marker.  Ignore these now, but
-		 * in the future we might start to scan them.
-		 */
-		for (;;) {
-			packet_reader_read(&reader);
-			if (reader.pktlen <= 0) {
-				break;
-			}
-		}
-
-		last->buf = reader.src_buffer;
-		last->len = reader.src_len;
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
@@ -453,7 +468,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		last->refs = parse_info_refs(last);
 
 	strbuf_release(&refs_url);
-	strbuf_release(&exp);
 	strbuf_release(&type);
 	strbuf_release(&charset);
 	strbuf_release(&effective_url);
-- 
2.20.1.1122.g2972e48916

