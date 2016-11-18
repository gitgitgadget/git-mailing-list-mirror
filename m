Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F96B1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 17:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbcKRRBw (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 12:01:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:44816 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752526AbcKRRBv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 12:01:51 -0500
Received: (qmail 14397 invoked by uid 109); 18 Nov 2016 17:01:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Nov 2016 17:01:50 +0000
Received: (qmail 2578 invoked by uid 111); 18 Nov 2016 17:02:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Nov 2016 12:02:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Nov 2016 09:01:47 -0800
Date:   Fri, 18 Nov 2016 09:01:47 -0800
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any
 output
Message-ID: <20161118170147.g7nbkxpyihwkk6fw@sigill.intra.peff.net>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
 <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
 <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
 <20161115035844.e6ehuy7uigqinbnv@sigill.intra.peff.net>
 <xmqqzil0tza6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzil0tza6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 09:42:57AM -0800, Junio C Hamano wrote:

> >> Hmph.  I think I tried David's original under GIT_TEST_LONG and saw
> >> it got stuck; could be the same issue, I guess.
> >
> > It works OK here. I think it is just that the test is really slow (by
> > design).
> 
> Yeah, I think what I recalled was my old attempt to run the
> follow-up "any SHA-1" patch without this one.

Right, that makes sense.

So I don't feel like we have a good patch for the general case yet, and
I'm probably not going to get around to implementing it anytime soon. So
I'd suggest taking David's original patch (to punt when the response is
empty) in the meantime.

It doesn't fix all cases, but if fixes _a_ case, and probably one of the
most likely one in practice. I don't think it can cause any regressions.
It's a "snooping" solution like mine, but it makes many fewer
assumptions about the protocol. We know that an empty response cannot
possibly advance fetch-pack further because we won't have sent it any
bytes. :)

I do think the commit message could be improved based on the discussion
here, though (at the very least to describe the nature of the deadlock,
and that we are choosing only one of the possible solutions, and why).

-Peff
