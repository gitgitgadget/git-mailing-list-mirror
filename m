Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AE0220248
	for <e@80x24.org>; Sun,  3 Mar 2019 16:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfCCQzj (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 11:55:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:36536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726293AbfCCQzj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 11:55:39 -0500
Received: (qmail 13214 invoked by uid 109); 3 Mar 2019 16:55:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 16:55:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16324 invoked by uid 111); 3 Mar 2019 16:55:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 11:55:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 11:55:37 -0500
Date:   Sun, 3 Mar 2019 11:55:37 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: [PATCH 1/2] fetch: avoid calling write_or_die()
Message-ID: <20190303165537.GA23755@sigill.intra.peff.net>
References: <20190303165447.GA31116@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190303165447.GA31116@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The write_or_die() function has one quirk that a caller might not
expect: when it sees EPIPE from the write() call, it translates that
into a death by SIGPIPE. This doesn't change the overall behavior (the
program exits either way), but it does potentially confuse test scripts
looking for a non-signal exit code.

Let's switch away from using write_or_die() in a few code paths, which
will give us more consistent exit codes. It also gives us the
opportunity to write more descriptive error messages, since we have
context that write_or_die() does not.

Note that this won't do much by itself, since we'd typically be killed
by SIGPIPE before write_or_die() even gets a chance to do its thing.
That will be addressed in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 9 ++++++---
 pkt-line.c   | 6 ++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 812be15d7e..dca249e9d7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -191,8 +191,10 @@ static void send_request(struct fetch_pack_args *args,
 	if (args->stateless_rpc) {
 		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
-	} else
-		write_or_die(fd, buf->buf, buf->len);
+	} else {
+		if (write_in_full(fd, buf->buf, buf->len) < 0)
+			die_errno("unable to write to remote");
+	}
 }
 
 static void insert_one_alternate_object(struct fetch_negotiator *negotiator,
@@ -1163,7 +1165,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 
 	/* Send request */
 	packet_buf_flush(&req_buf);
-	write_or_die(fd_out, req_buf.buf, req_buf.len);
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno("unable to write request to remote");
 
 	strbuf_release(&req_buf);
 	return ret;
diff --git a/pkt-line.c b/pkt-line.c
index d4b71d3e82..093b2f3976 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -88,13 +88,15 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 void packet_flush(int fd)
 {
 	packet_trace("0000", 4, 1);
-	write_or_die(fd, "0000", 4);
+	if (write_in_full(fd, "0000", 4) < 0)
+		die_errno("unable to write flush packet");
 }
 
 void packet_delim(int fd)
 {
 	packet_trace("0001", 4, 1);
-	write_or_die(fd, "0001", 4);
+	if (write_in_full(fd, "0001", 4) < 0)
+		die_errno("unable to write delim packet");
 }
 
 int packet_flush_gently(int fd)
-- 
2.21.0.675.g01c085a870

