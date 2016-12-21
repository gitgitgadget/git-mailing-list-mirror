Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8691FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 15:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936516AbcLUPzp (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 10:55:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:59331 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936446AbcLUPzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 10:55:43 -0500
Received: (qmail 6676 invoked by uid 109); 21 Dec 2016 15:55:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 15:55:42 +0000
Received: (qmail 12594 invoked by uid 111); 21 Dec 2016 15:56:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 10:56:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Dec 2016 10:55:39 -0500
Date:   Wed, 21 Dec 2016 10:55:39 -0500
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
Message-ID: <20161221155539.aykcmkuzqvq733ri@sigill.intra.peff.net>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
 <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
 <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
 <alpine.DEB.2.20.1612201511480.54750@virtualbox>
 <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net>
 <222ACFD4-ED9A-4B94-8BDD-3C70648A684B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <222ACFD4-ED9A-4B94-8BDD-3C70648A684B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 09:54:15PM -0800, Kyle J. McKay wrote:

> > I wasn't aware anybody actually built with NDEBUG at all. You'd have to
> > explicitly ask for it via CFLAGS, so I assume most people don't.
> 
> Not a good assumption.  You know what happens when you assume[1], right? ;)

Kind of. If it's a configuration that nobody[1] in the Git development
community intended to support or test, then isn't the person triggering
it the one making assumptions?

At any rate, I agree that setting NDEBUG should not create a broken
program, and some solution like your patch is a good idea here. I was
mainly speaking to the "do not bother" comment. It is not that I do not
bother to build with NDEBUG, it is that I think it is actively a bad
idea.

[1] Maybe I am alone in my surprise, and everybody working on Git is
    using assert() with the intention that it can be disabled. But if
    that were the case, I'd expect more push-back against "die(BUG)"
    which does not have this feature. I don't recall a single discussion
    to that effect, and searching for NDEBUG in the list archives turns
    up hardly any mentions.

> I've been defining NDEBUG whenever I make a release build for quite some
> time (not just for Git) in order to squeeze every last possible drop of
> performance out of it.

I think here you are getting into superstition. Is there any single
assert() in Git that will actually have an impact on performance?

I'd be more impressed if you could show some operation that is faster
when built with NDEBUG than without. Running all of t/perf does not seem
to show any difference, and looking at the asserts themselves, they're
almost all single-instruction compares in code that isn't performance
critical anyway.

> > So from my perspective it is not so much "do not bother with release
> > builds" as "are release builds even a thing for git?"
> 
> They should be if you're deploying Git in a performance critical
> environment.

I hope my history of patches shows that I do care about deploying Git in
a performance critical environment. But I only care about performance
tradeoffs that have a _measurable_ gain.

> Perhaps Git should provide a "verify" macro.  Works like "assert" except
> that it doesn't go away when NDEBUG is defined.  Being Git-provided it could
> also use Git's die function.  Then Git could do a global replace of assert
> with verify and institute a no-assert policy.

What would be the advantage of that over `if(...) die("BUG: ...")`? It
does not require you to write a reason in the die(), but I am not sure
that is a good thing.

> > I do notice that we set NDEBUG for nedmalloc, though if I am reading the
> > Makefile right, it is just for compiling those files. It looks like
> > there are a ton of asserts there that _are_ potentially expensive, so
> > that makes sense.
> 
> So there's no way to get a non-release build of nedmalloc inside Git then
> without hacking the Makefile?  What if you need those assertions enabled?
> Maybe NDEBUG shouldn't be defined by default for any files.

AFAICT, yes. I'd leave it to people who actually build with nedmalloc to
decide whether it is worth caring about, and whether the asserts there
have a noticeable performance impact.

-Peff
