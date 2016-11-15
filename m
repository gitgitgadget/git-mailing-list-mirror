Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F439203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 00:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965115AbcKOAoa (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 19:44:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:43149 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965004AbcKOAo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 19:44:29 -0500
Received: (qmail 1965 invoked by uid 109); 15 Nov 2016 00:44:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Nov 2016 00:44:29 +0000
Received: (qmail 6991 invoked by uid 111); 15 Nov 2016 00:44:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 19:44:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 19:44:26 -0500
Date:   Mon, 14 Nov 2016 19:44:26 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any
 output
Message-ID: <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 02:40:49PM -0500, Jeff King wrote:

> On Mon, Nov 14, 2016 at 01:24:31PM -0500, Jeff King wrote:
> 
> >   2. Have remote-curl understand enough of the protocol that it can
> >      abort rather than hang.
> > 
> >      I think that's effectively the approach of your patch, but for one
> >      specific case. But could we, for example, make sure that everything
> >      we proxy is a complete set of pktlines and ends with a flush? And
> >      if not, then we hang up on fetch-pack.
> > 
> >      I _think_ that would work, because even the pack is always encased
> >      in pktlines for smart-http.
> 
> So something like this. It turned out to be a lot uglier than I had
> hoped because we get fed the data from curl in odd-sized chunks, so we
> need a state machine.
> 
> But it does seem to work. At least it doesn't seem to break anything in
> the test suite, and it fixes the new tests you added. I'd worry that
> there's some obscure case where the response isn't packetized in the
> same way.

Actually, I take it back. I think it works for a single round of ref
negotiation, but not for multiple. Enabling GIT_TEST_LONG=1 causes it to
fail t5551.

I think I've probably made a mis-assumption on exactly when in the HTTP
protocol we will see a flush packet (and perhaps that is a sign that
this protocol-snooping approach is not a good one).

I don't have time to dig more on this tonight, and I'll be traveling for
the rest of the week. So if anybody is interested, please feel free to
dig into it.

-Peff
