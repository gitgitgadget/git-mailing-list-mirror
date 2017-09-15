Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73C020A21
	for <e@80x24.org>; Fri, 15 Sep 2017 00:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbdIOAmk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 20:42:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:39396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751641AbdIOAmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 20:42:39 -0400
Received: (qmail 16938 invoked by uid 109); 15 Sep 2017 00:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 00:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1480 invoked by uid 111); 15 Sep 2017 00:43:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 20:43:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 20:42:37 -0400
Date:   Thu, 14 Sep 2017 20:42:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/7] avoid "write_in_full(fd, buf, len) != len" pattern
Message-ID: <20170915004237.wjys6tgyxk6j43op@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171603.3whuql7l5da3ynrn@sigill.intra.peff.net>
 <20170913211430.GK27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913211430.GK27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 02:14:30PM -0700, Jonathan Nieder wrote:

> >        I really wish every "write_in_full()" user would just
> >        check against "<0" now, but this fixes the nasty and
> >        stupid ones.
> 
> Ok, you convinced me.
> 
> Should we add a comment to cache.h as well encouraging this?

I'd be OK with a comment, though I don't know that it's strictly
necessary. It looks like most of it was just cargo-culted, so removing
the offending examples is sufficient.

> > [1] A careful reader may notice there is one way that
> >     write_in_full() can return a different value. If we ask
> >     write() to write N bytes and get a return value that is
> >     _larger_ than N, we could return a larger total. But
> >     besides the fact that this would imply a totally broken
> >     version of write(), it would already invoke undefined
> >     behavior. Our internal remaining counter is an unsigned
> >     size_t, which means that subtracting too many byte will
> >     wrap it around to a very large number. So we'll instantly
> >     begin reading off the end of the buffer, trying to write
> >     gigabytes (or petabytes) of data.
> 
> This footnote just leaves me more confused, since as you mention,
> write() never would return a value greater than N.  Are you saying we
> need to defend against a broken platform where that isn't true?

No, I'm saying that my claim that write_in_full() can only return two
values (-1 and the original length) is not strictly true. But that it
doesn't matter in practice.

I don't think we need to defend against such a broken platform, but I
didn't want anybody reading the claim to say "aha, you forgot this
case". It is a case that does not matter.

-Peff
