Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2498E203C1
	for <e@80x24.org>; Mon, 14 Nov 2016 21:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964798AbcKNVdm (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 16:33:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:43050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938882AbcKNVdk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 16:33:40 -0500
Received: (qmail 23770 invoked by uid 109); 14 Nov 2016 21:33:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 21:33:39 +0000
Received: (qmail 4867 invoked by uid 111); 14 Nov 2016 21:34:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 16:34:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 16:33:37 -0500
Date:   Mon, 14 Nov 2016 16:33:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any
 output
Message-ID: <20161114213337.wipubwz5k22foyva@sigill.intra.peff.net>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
 <xmqqpolxwyh6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpolxwyh6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 01:19:49PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So something like this. It turned out to be a lot uglier than I had
> > hoped because we get fed the data from curl in odd-sized chunks, so we
> > need a state machine.
> 
> It is unfortunate that we have to snoop the protocol like this to
> infer an error, but I do not think we can do better than that
> approach.  FWIW, I did not find the logic in update_pktline_state()
> you wrote ugly at all.
> 
> Having to assume that the end of each round from the other end must
> be a FLUSH does feel somewhat ugly and brittle, though.

Yeah, I agree. The other option is to signal to fetch-pack that we saw
EOF on the server request, and then we do not have to snoop; it knows
where in the protocol state it is at.

But doing that is a little tricky. We could send our own flush packet,
but that doesn't quite work. When fetch-pack sees a flush it does not
know if it is the server's flush and it should wait for our flush, or if
the server hung up prematurely and the flush is from us. :)

The "elegant" solution is to just wrap the server's data in another set
of pktlines. So the server flush becomes "00080000" (8 bytes including
our pktline, and then 4 bytes for the flush packet). But wrapping each
pktline gets a little hairy. What happens when the server sends us a
pktline of LARGE_PACKET_MAX? We can't wrap that without sending our own
pktline that's LARGE_PACKET_MAX+4.

One solution is that pktlines 0001-0003 are unused and impossible for
data. So we could send the server pktlines as-is, and use pktline 0001
as our special signal for "end of http request". A server shouldn't ever
send that, and if they did (perhaps to try something malicious), it
would just cause fetch-pack to think they prematurely ended the
conversation.

Hmm. I suppose that doesn't quite work, though. One of the problems is
that the server sends a partial pktline, in which case our special flush
packet would get gobbled up as data for that broken pktline.

So you really do need framing or some other out-of-band communication,
or resolve yourself to snooping in remote-curl.

-Peff
