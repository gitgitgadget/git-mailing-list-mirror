Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80D6202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 00:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936570AbdIZAR2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:17:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:50032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935704AbdIZAR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:17:27 -0400
Received: (qmail 13716 invoked by uid 109); 26 Sep 2017 00:17:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Sep 2017 00:17:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31185 invoked by uid 111); 26 Sep 2017 00:18:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:18:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 20:17:24 -0400
Date:   Mon, 25 Sep 2017 20:17:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926001724.cxuwsdadjbqqmnig@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <20170926001354.GN27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170926001354.GN27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 05:13:54PM -0700, Jonathan Nieder wrote:

> > I actually prefer "0" of the all of the options discussed. At least it
> > is immediately clear that it is not a syscall error.
> 
> I have a basic aversion to ": Success" in error messages.  Whenever I
> see such an error message, I stop trusting the program that produced it
> not to be seriously buggy.  Maybe I'm the only one?

That's a fair criticism, I think.

> If no actual errno works, we could make a custom strerror-like function
> with our own custom errors (making them negative to avoid clashing with
> standard errno values), but this feels like overkill.

Yes, I also thought about that. It feels pretty invasive (I guess we'd
wrap strerror() with our own custom function so that callers don't have
to remember which one to use).

> In the same spirit of misleadingly confusing too-long and too-short,
> there is also ERANGE ("Result too large"), which doesn't work here.
> There's also EPROTO "Protocol error", but that's about protocols, not
> file formats.  More vague and therefor maybe more applicable is EBADMSG
> "Bad message".  There's also ENOMSG "No message of the desired type".
> 
> If the goal is to support debugging, an error like EPIPE "Broken pipe"
> or ESPIPE "Invalid seek" would be likely to lead me in the right
> direction (wrong file size), even though it is misleading about how
> the error surfaced.
> 
> We could also avoid trying to be cute and use something generic like
> EIO "Input/output error".

I definitely would prefer to avoid EIO, or anything that an actual
read() might return.

What do you think of ENODATA? The glibc text for it is pretty
appropriate. If it's not available everywhere, we'd have to fallback to
something else (EIO? 0?). I don't know how esoteric it is. The likely
candidate to be lacking it is Windows.

-Peff
