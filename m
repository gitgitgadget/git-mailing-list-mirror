Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3CC1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeKPS6t (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:58:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:41812 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727398AbeKPS6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 13:58:49 -0500
Received: (qmail 29127 invoked by uid 109); 16 Nov 2018 08:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Nov 2018 08:47:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24914 invoked by uid 111); 16 Nov 2018 08:46:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Nov 2018 03:46:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2018 03:47:25 -0500
Date:   Fri, 16 Nov 2018 03:47:25 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] remote-curl: refactor smart-http discovery
Message-ID: <20181116084725.GA31603@sigill.intra.peff.net>
References: <20181116084427.GA31493@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116084427.GA31493@sigill.intra.peff.net>
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

     and the http spec is clear that for a smart-http[3]:

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
 remote-curl.c | 93 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 762a55a75f..dd9bc41aa1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -330,9 +330,65 @@ static int get_protocol_http_header(enum protocol_version version,
 	return 0;
 }
 
+static void check_smart_http(struct discovery *d, const char *service,
+			     struct strbuf *type)
+{
+	char *src_buf;
+	size_t src_len;
+	char *line;
+	const char *p;
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
+	/*
+	 * "Peek" at the first packet by using a separate buf/len pair; some
+	 * cases below require us leaving the originals intact.
+	 */
+	src_buf = d->buf;
+	src_len = d->len;
+	line = packet_read_line_buf(&src_buf, &src_len, NULL);
+	if (!line)
+		die("invalid server response; expected service, got flush packet");
+
+	if (skip_prefix(line, "# service=", &p) && !strcmp(p, service)) {
+		/*
+		 * The header can include additional metadata lines, up
+		 * until a packet flush marker.  Ignore these now, but
+		 * in the future we might start to scan them.
+		 */
+		while (packet_read_line_buf(&src_buf, &src_len, NULL))
+			;
+
+		/*
+		 * v0 smart http; callers expect us to soak up the
+		 * service and header packets
+		 */
+		d->buf = src_buf;
+		d->len = src_len;
+		d->proto_git = 1;
+
+	} else if (starts_with(line, "version 2")) {
+		/*
+		 * v2 smart http; do not consume version packet, which will
+		 * be handled elsewhere.
+		 */
+		d->proto_git = 1;
+
+	} else {
+		die("invalid server response; got '%s'", line);
+	}
+}
+
 static struct discovery *discover_refs(const char *service, int for_push)
 {
-	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
 	struct strbuf charset = STRBUF_INIT;
 	struct strbuf buffer = STRBUF_INIT;
@@ -405,38 +461,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
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
@@ -444,7 +470,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		last->refs = parse_info_refs(last);
 
 	strbuf_release(&refs_url);
-	strbuf_release(&exp);
 	strbuf_release(&type);
 	strbuf_release(&charset);
 	strbuf_release(&effective_url);
-- 
2.19.1.1636.gc7a073d580

