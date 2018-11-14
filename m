Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178E11F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeKNRCt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:02:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:38610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727528AbeKNRCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:02:49 -0500
Received: (qmail 1986 invoked by uid 109); 14 Nov 2018 07:00:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 07:00:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31277 invoked by uid 111); 14 Nov 2018 07:00:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 02:00:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 02:00:52 -0500
Date:   Wed, 14 Nov 2018 02:00:52 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
Message-ID: <20181114070052.GA19904@sigill.intra.peff.net>
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
 <20181113142624.GA17128@sigill.intra.peff.net>
 <20181113222540.GE126896@google.com>
 <20181114004915.GA5059@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114004915.GA5059@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 07:49:15PM -0500, Jeff King wrote:

> Yes, the packet_read_line_buf() interface will both advance the buf
> pointer and decrement the length.  So if we want to "peek", we have to
> do so with a copy (there's a peek function if you use the packet_reader
> interface, but that might be overkill here).
> 
> You can rewrite it like this, which is a pretty faithful conversion and
> passes the tests (but see below).
> [...]

Here's a version which is less faithful, but I think does sensible
things in all cases, and is much easier to follow. I get a little
nervous just because it tightens some cases, and one never knows if
other implementations might be relying on the looseness. E.g.:

  - in the current code we'd still drop back to dumb http if the server
    tells us "application/x-git-upload-pack" but the initial pktline
    doesn't start with "#" (even though if it _does_ have "#" at
    position 5 but isn't a valid pktline, we'd complain!)

  - right now the v2 protocol does not require the server to say
    "application/x-git-upload-pack" for the content-type

This patch tightens both of those (I also made a few stylistic tweaks,
and added the ERR condition to show where it would go). I dunno. Part of
me sees this as a nice cleanup, but maybe it is better to just leave it
alone. A lot of these behaviors are just how it happens to work now, and
not part of the spec, but we don't know what might be relying on them.

diff --git a/remote-curl.c b/remote-curl.c
index 762a55a75f..1adb96311b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -330,9 +330,61 @@ static int get_protocol_http_header(enum protocol_version version,
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
+	if (!skip_prefix(type->buf, "application/x-", &p) ||
+	    !skip_prefix(p, service, &p) ||
+	    strcmp(p, "-advertisement"))
+		return;
+
+	/*
+	 * We speculatively try to read a packet, which means we must preserve
+	 * the original buf/len pair in some cases.
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
+	} else if (starts_with(line, "version 2")) { /* should be strcmp()? */
+		/*
+		 * v2 smart http; do not consume version packet, which will
+		 * be handled elsewhere.
+		 */
+		d->proto_git = 1;
+	} else if (skip_prefix(line, "ERR ", &p)) {
+		die(_("remote error: %s"), p);
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
@@ -405,38 +457,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
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
@@ -444,7 +466,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		last->refs = parse_info_refs(last);
 
 	strbuf_release(&refs_url);
-	strbuf_release(&exp);
 	strbuf_release(&type);
 	strbuf_release(&charset);
 	strbuf_release(&effective_url);
