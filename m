Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16700C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC23620E65
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 18:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgJMSzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 14:55:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgJMSzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 14:55:16 -0400
Received: (qmail 11650 invoked by uid 109); 13 Oct 2020 18:55:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Oct 2020 18:55:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7097 invoked by uid 111); 13 Oct 2020 18:55:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Oct 2020 14:55:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Oct 2020 14:55:15 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5500.43: make the check a bit more robust
Message-ID: <20201013185515.GA2994107@coredump.intra.peff.net>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 02:45:23PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Note: we have code in `demultiplex_sideband()` _specifically_ to stitch
> back together lines that were delivered in separate sideband packets.
> However, this stitching fails when a primary packet is delivered in
> between the two sideband packets: since a primary packet was received,
> `demultiplex_sideband()` has to return that (and cannot wait for other
> sideband packets, and therefore has to flush any incomplete line it
> received).

This sounds like a bug. We should accumulate multiple sideband 2
packets, even across data packets. And I think we _used_ to do that. The
original recv_sideband() looked roughly like this:

	while (!retval) {
		 packet_read();
		 band = buf[0] & 0xff;
		 switch (band) {
		 case 3:
		   ...stuff data into outbuf...
		   retval = SIDEBAND_ERROR_REMOTE;
		   break;
		 case 2:
		   ...print full lines, stuff remainder into outbuf...
		   break; /* note, does _not_ set retval */
		 case 1:
		   write_or_die(out, buf + 1, len);
		   break; /* likewise, does not set retval */
		 default:
		   ...complain about broken sideband...
		   retval = SIDEBAND_PROTOCOL_ERROR;
		}
	}
	if (outbuf.len)
		...print outbuf...

So we would keep looping until we see EOF, sideband 3, or a protocol
error. But notably we would not break out of the loop on bands 1 or 2,
and we do not flush band 2 until we break out of the loop.

But then in fbd76cd450 (sideband: reverse its dependency on pkt-line,
2019-01-16), the function became demultiplex_sideband(). The loop went
away, and we pump only a single packet on each call. When we see
sideband 2, we do an early return. But on sideband 1, we continue to the
cleanup: label, which flushes the scratch buffer.

I think we need to return from there without hitting that cleanup label,
like this:

diff --git a/sideband.c b/sideband.c
index 0a60662fa6..a5405b9aaa 100644
--- a/sideband.c
+++ b/sideband.c
@@ -190,7 +190,7 @@ int demultiplex_sideband(const char *me, char *buf, int len,
 		return 0;
 	case 1:
 		*sideband_type = SIDEBAND_PRIMARY;
-		break;
+		return 1;
 	default:
 		strbuf_addf(scratch, "%s%s: protocol error: bad band #%d",
 			    scratch->len ? "\n" : "", me, band);

Does that make the problem go away for you?

>     Work around flakiness in t5500.43
>     
>     It seems that this test became flaky only recently, although I have to
>     admit that I have no idea why: the involved code does not seem to have
>     changed recently at all. It should have been fixed by 
>     https://lore.kernel.org/git/20200506220741.71021-1-jonathantanmy@google.com/
>     , but apparently wasn't completely fixed, despite what I said in that
>     thread.

I think this is a real bug, and we shouldn't be changing the tests to
accommodate. Users may actually see the broken lines, and our tests are
telling us that.

I suspect it's uncommon in practice because it requires the server side
also splitting the line across two packets. And while the server-side
upload-pack might get a partial write from a child pack-objects or
whatever, that should only happen if:

  - the pipe buffer fills up. Which is hard to do since our messages
    tend to be very small. So perhaps it implies a very tiny pipe
    buffer, and/or slow scheduling of the receiving side to actually
    clean it out.

  - the writer is fully buffering its stderr writes instead of sending
    them a line at a time

The latter seems a more likely candidate for switching from gcc to
Visual C (which presumably has a different libc / CRT).  I think the
client should be handling this more robustly, but it may be worth
digging into the buffering issue if it means progress may not be
delivered in quite as timely a way as we expect it to be.

-Peff
