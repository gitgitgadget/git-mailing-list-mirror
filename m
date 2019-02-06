Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9991A1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 19:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBFTRA (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 14:17:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:34938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726666AbfBFTRA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 14:17:00 -0500
Received: (qmail 12670 invoked by uid 109); 6 Feb 2019 19:16:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 19:16:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4541 invoked by uid 111); 6 Feb 2019 19:17:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 14:17:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 14:16:57 -0500
Date:   Wed, 6 Feb 2019 14:16:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] remote-curl: refactor smart-http discovery
Message-ID: <20190206191657.GE10231@sigill.intra.peff.net>
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <20181116084725.GA31603@sigill.intra.peff.net>
 <xmqq5ztxstkh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5ztxstkh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 03:29:18PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > After making initial contact with an http server, we have to decide if
> > the server supports smart-http, and if so, which version. Our rules are
> > a bit inconsistent:
> > ...
> >
> >  - we now predicate the smart/dumb decision entirely on the presence of
> >    the correct content-type
> >
> >  - we do a real pkt-line parse before deciding how to proceed (and die
> >    if it isn't valid)
> >
> >  - use skip_prefix() for comparing service strings, instead of
> >    constructing expected output in a strbuf; this avoids dealing with
> >    memory cleanup
> >
> > Note that this _is_ tightening what the client will allow. It's all
> > according to the spec, but it's possible that other implementations
> > might violate these. However, violating these particular rules seems
> > like an odd choice for a server to make.
> >
> > [1] Documentation/technical/http-protocol.txt, l. 166-167
> > [2] Documentation/technical/protocol-v2.txt, l. 63-64
> > [3] Documentation/technical/http-protocol.txt, l. 247
> >
> > Helped-by: Josh Steadmon <steadmon@google.com>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  remote-curl.c | 93 ++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 59 insertions(+), 34 deletions(-)
> 
> It turns out that this has interactions with 01f9ec64 ("Use
> packet_reader instead of packet_read_line", 2018-12-29) on the
> ms/packet-err-check branch.  Can we get this rebased on top of
> a more recent 'master'?

Yep. Here it is.

Rather than a range-diff, which is quite large due to the code movement,
I'll include below the interesting hunk of a diff between the two
endpoints (i.e., what we would have seen applying the packet-err-check
changes on top of my code movement, which is more or less what I did to
generate it).

Josh's original 3/3 isn't needed anymore, since ms/packet-err-check
covers that case already. However, he did write tests, which
ms/packet-err-check does not have. So I've converted his final patch
into just a test addition.

  [1/3]: remote-curl: refactor smart-http discovery
  [2/3]: remote-curl: tighten "version 2" check for smart-http
  [3/3]: t5551: test server-side ERR packet

 remote-curl.c                   | 100 ++++++++++++++++++--------------
 t/lib-httpd.sh                  |   1 +
 t/lib-httpd/apache.conf         |   4 ++
 t/lib-httpd/error-smart-http.sh |   3 +
 t/t5551-http-fetch-smart.sh     |   5 ++
 5 files changed, 70 insertions(+), 43 deletions(-)
 create mode 100644 t/lib-httpd/error-smart-http.sh

Here's that hunk:

diff --git a/remote-curl.c b/remote-curl.c
index b1309f2bdc..bb7421023b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -333,10 +334,8 @@ static int get_protocol_http_header(enum protocol_version version,
 static void check_smart_http(struct discovery *d, const char *service,
 			     struct strbuf *type)
 {
-	char *src_buf;
-	size_t src_len;
-	char *line;
 	const char *p;
+	struct packet_reader reader;
 
 	/*
 	 * If we don't see x-$service-advertisement, then it's not smart-http.
@@ -348,45 +347,42 @@ static void check_smart_http(struct discovery *d, const char *service,
 	    strcmp(p, "-advertisement"))
 		return;
 
-	/*
-	 * "Peek" at the first packet by using a separate buf/len pair; some
-	 * cases below require us leaving the originals intact.
-	 */
-	src_buf = d->buf;
-	src_len = d->len;
-	line = packet_read_line_buf(&src_buf, &src_len, NULL);
-	if (!line)
+	packet_reader_init(&reader, -1, d->buf, d->len,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
+	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
 		die("invalid server response; expected service, got flush packet");
 
-	if (skip_prefix(line, "# service=", &p) && !strcmp(p, service)) {
+	if (skip_prefix(reader.line, "# service=", &p) && !strcmp(p, service)) {
 		/*
 		 * The header can include additional metadata lines, up
 		 * until a packet flush marker.  Ignore these now, but
 		 * in the future we might start to scan them.
 		 */
-		while (packet_read_line_buf(&src_buf, &src_len, NULL))
-			;
+		for (;;) {
+			packet_reader_read(&reader);
+			if (reader.pktlen <= 0) {
+				break;
+			}
+		}
 
 		/*
 		 * v0 smart http; callers expect us to soak up the
 		 * service and header packets
 		 */
-		d->buf = src_buf;
-		d->len = src_len;
+		d->buf = reader.src_buffer;
+		d->len = reader.src_len;
 		d->proto_git = 1;
 
-	} else if (!strcmp(line, "version 2")) {
+	} else if (!strcmp(reader.line, "version 2")) {
 		/*
 		 * v2 smart http; do not consume version packet, which will
 		 * be handled elsewhere.
 		 */
 		d->proto_git = 1;
 
-	} else if (skip_prefix(line, "ERR ", &p)) {
-		die(_("remote error: %s"), p);
-
 	} else {
-		die("invalid server response; got '%s'", line);
+		die("invalid server response; got '%s'", reader.line);
 	}
 }
 
