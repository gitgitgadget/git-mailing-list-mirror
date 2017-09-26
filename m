Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E642020A26
	for <e@80x24.org>; Tue, 26 Sep 2017 00:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936618AbdIZAZN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:25:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:50094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935582AbdIZAZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:25:12 -0400
Received: (qmail 14295 invoked by uid 109); 26 Sep 2017 00:25:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Sep 2017 00:25:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31446 invoked by uid 111); 26 Sep 2017 00:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:25:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 20:25:10 -0400
Date:   Mon, 25 Sep 2017 20:25:10 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926002510.xmusj6fkvb25fm5w@sigill.intra.peff.net>
References: <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <20170926001354.GN27425@aiede.mtv.corp.google.com>
 <20170926001724.cxuwsdadjbqqmnig@sigill.intra.peff.net>
 <20170926002020.GQ27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170926002020.GQ27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 05:20:20PM -0700, Jonathan Nieder wrote:

> > What do you think of ENODATA? The glibc text for it is pretty
> > appropriate. If it's not available everywhere, we'd have to fallback to
> > something else (EIO? 0?). I don't know how esoteric it is. The likely
> > candidate to be lacking it is Windows.
> 
> ENODATA with a fallback to ESPIPE sounds fine to me.
> 
> read() would never produce ESPIPE because it doesn't seek.
> 
> So that would be:
> 
> /* errno value to use for early EOF */
> #ifndef ENODATA
> #define ENODATA ESPIPE
> #endif

Thanks, I'll re-roll with that (and thank you Stefan for mentioning
ENODATA again; I came across it early in my search but discounted it as
not quite right semantically. I should have been looking at the
strerror() text, which is what really matters).

What do you think of patch 7 in light of this? If the short-read case
gives us a sane errno, should we even bother trying to consistently
handle its error separately?

-Peff
