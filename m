Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC3C20248
	for <e@80x24.org>; Sun,  3 Mar 2019 16:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCCQ6q (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 11:58:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:36550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726423AbfCCQ6p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 11:58:45 -0500
Received: (qmail 13255 invoked by uid 109); 3 Mar 2019 16:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 16:58:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16348 invoked by uid 111); 3 Mar 2019 16:59:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 11:59:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 11:58:43 -0500
Date:   Sun, 3 Mar 2019 11:58:43 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: [PATCH 2/2] fetch: ignore SIGPIPE during network operation
Message-ID: <20190303165843.GB23755@sigill.intra.peff.net>
References: <20190303165447.GA31116@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190303165447.GA31116@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default SIGPIPE behavior can be useful for a command that generates
a lot of output: if the receiver of our output goes away, we'll be
notified asynchronously to stop generating it (typically by killing the
program).

But for a command like fetch, which is primarily concerned with
receiving data and writing it to disk, an unexpected SIGPIPE can be
awkward. We're already checking the return value of all of our write()
calls, and dying due to the signal takes away our chance to gracefully
handle the error.

On Linux, we wouldn't generally see SIGPIPE at all during fetch. If the
other side of the network connection hangs up, we'll see ECONNRESET. But
on OS X, we get a SIGPIPE, and the process is killed. This causes t5570
to racily fail, as we sometimes die by signal (instead of the expected
die() call) when the server side hangs up.

Let's ignore SIGPIPE during the network portion of the fetch, which will
cause our write() to return EPIPE, giving us consistent behavior across
platforms.

This fixes the test flakiness, but note that it stops short of fixing
the larger problem. The server side hit a fatal error, sent us an "ERR"
packet, and then hung up. We notice the failure because we're trying to
write to a closed socket. But by dying immediately, we never actually
read the ERR packet and report its content to the user. This is a (racy)
problem on all platforms. So this patch lays the groundwork from which
that problem might be fixed consistently, but it doesn't actually fix
it.

Note the placement of the SIGPIPE handling. The absolute minimal change
would be to ignore SIGPIPE only when we're writing. But twiddling the
signal handler for each write call is inefficient and maintenance
burden. On the opposite end of the spectrum, we could simply declare
that fetch does not need SIGPIPE handling, since it doesn't generate a
lot of output, and we could just ignore it at the start of cmd_fetch().

This patch takes a middle ground. It ignores SIGPIPE during the network
operation (which is admittedly most of the program, since the actual
network operations are all done under the hood by the transport code).
So it's still pretty coarse.

Signed-off-by: Jeff King <peff@peff.net>
---
I had a hard time trying to write the last two paragraphs. I think the
placement here really is not significantly different than just ignoring
SIGPIPE for the entirety of cmd_fetch(). I kind of like your suggestion
elsewhere in the thread to just teach the git wrapper an IGNORE_SIGPIPE
flag.

 builtin/fetch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b620fd54b4..4ba63d5ac6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1556,7 +1556,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
+	sigchain_push(SIGPIPE, SIG_IGN);
 	exit_code = do_fetch(gtransport, &rs);
+	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;
-- 
2.21.0.675.g01c085a870
