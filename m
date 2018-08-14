Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308D41F404
	for <e@80x24.org>; Tue, 14 Aug 2018 22:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbeHOBWG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:22:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:55486 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728329AbeHOBWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:22:06 -0400
Received: (qmail 9432 invoked by uid 109); 14 Aug 2018 22:32:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 22:32:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26947 invoked by uid 111); 14 Aug 2018 22:32:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 18:32:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 18:32:47 -0400
Date:   Tue, 14 Aug 2018 18:32:47 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@aon.at>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
Message-ID: <20180814223246.GA2379@sigill.intra.peff.net>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 05:11:13PM +0200, SZEDER Gábor wrote:

>   - 'git upload-pack' receives the request, parses the want line,
>     notices the corrupt pack, responds with an 'ERR upload-pack: not
>     our ref' pkt-line, and die()s right away.
> 
>   - 'git fetch' finally approaches the end of the function, where it
>     attempts to send a done pkt-line via another send_request() call
>     through the now closing TCP socket.
> 
>   - What happens now seems to depend on the platform:
> 
>     - On Linux, both on my machine and on Travis CI, it shows textbook
>       example behaviour: write() returns with error and sets errno to
>       ECONNRESET.  Since it happens in write_or_die(), 'git fetch'
>       die()s with 'fatal: write error: Connection reset by peer', and
>       doesn't show the error send by 'git upload-pack'; how could it,
>       it doesn't even get as far to receive upload-pack's ERR
>       pkt-line.
> 
>       The test only checks that 'git fetch' fails, but it doesn't
>       check whether it failed with the right error message, so the
>       test still succeeds.  Had it checked the error message as well,
>       we most likely had noticed this issue already, it doesn't happen
>       all that rarely.

Hmm. Traditionally we did not send ERR as part of upload-pack at all. It
was the message you got from git-daemon if it couldn't start the
requested sub-process. It was only later in bdb31eada7 (upload-pack:
report "not our ref" to client, 2017-02-23) that we started sending
them. So I think that is why it does not check the error message: it is
not expecting that case at all (and it is not actually interesting here,
as the real problem is that the remote side is corrupt, but it sadly
does not say anything so useful).

I think that's somewhat tangential, though. The root of the issue is
this:

>     - On the new OSX images with XCode 9.4 on Travis CI the write()
>       triggers SIGPIPE right away, and 'test_must_fail' notices it and
>       fails the test.  I couldn't see any sign of an ECONNRESET or any
>       other error that we could act upon to avoid the SIGPIPE.

Right, as soon as we get SIGPIPE we can't offer any useful message,
because we're dead. I would argue that fetch should simply turn off
SIGPIPE entirely, and rely on getting EPIPE from write(). But since
we're in write_or_die(), it actually turns EPIPE back into a SIGPIPE
death!

So we'd probably also want to teach it to use a real write_in_full(),
and then output a more useful message in this case. write_or_die()
really does produce bad messages regardless, because it doesn't know
what it's writing to.

That would give us a baby step in the right direction, because at least
we'd always be doing a controlled die() then. And then the next step
would be to show the remote error message (even though it's not actually
useful in this case, in theory upload-pack could generate something
better). And that would mean turning the die() on write into an attempt
to drain any ERR messages before either dying or returning an error up
the stack.

I suspect the (largely untested) patch below would make your test
problems go away. Or instead, we could simply add sigpipe=ok to the
test_must_fail invocation, but I agree with you that the current
behavior on OS X is not ideal (the user sees no error message).

-Peff

diff --git a/fetch-pack.c b/fetch-pack.c
index 5714bcbddd..3e80604562 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -188,8 +188,10 @@ static void send_request(struct fetch_pack_args *args,
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
@@ -1167,7 +1169,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 
 	/* Send request */
 	packet_buf_flush(&req_buf);
-	write_or_die(fd_out, req_buf.buf, req_buf.len);
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno("unable to write request to remote");
 
 	strbuf_release(&req_buf);
 	return ret;
diff --git a/pkt-line.c b/pkt-line.c
index a593c08aad..450d0801b1 100644
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
+	if (write_in_full(fd, "0000", 4) < 0)
+		die_errno("unable to write delim packet");
 }
 
 int packet_flush_gently(int fd)
