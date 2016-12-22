Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263B51FF40
	for <e@80x24.org>; Thu, 22 Dec 2016 03:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938580AbcLVDeX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 22:34:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:59548 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932915AbcLVDeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 22:34:23 -0500
Received: (qmail 18281 invoked by uid 109); 22 Dec 2016 03:34:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Dec 2016 03:34:22 +0000
Received: (qmail 16505 invoked by uid 111); 22 Dec 2016 03:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 22:35:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Dec 2016 22:34:19 -0500
Date:   Wed, 21 Dec 2016 22:34:19 -0500
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
Message-ID: <20161222033418.dmslmuhq7mqhmkwq@sigill.intra.peff.net>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
 <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
 <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
 <alpine.DEB.2.20.1612201511480.54750@virtualbox>
 <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net>
 <222ACFD4-ED9A-4B94-8BDD-3C70648A684B@gmail.com>
 <20161221155539.aykcmkuzqvq733ri@sigill.intra.peff.net>
 <F5001DF2-20C2-4757-997F-9D40BD48E1D9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F5001DF2-20C2-4757-997F-9D40BD48E1D9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2016 at 06:21:37PM -0800, Kyle J. McKay wrote:

> > Kind of. If it's a configuration that nobody[1] in the Git development
> > community intended to support or test, then isn't the person triggering
> > it the one making assumptions?
> 
> No, I don't think so.  NDEBUG is very clearly specified in POSIX [1].

I know what NDEBUG is, and I know it is widely used in other projects.
My claim is only that I do not think that the use of NDEBUG was
generally considered when people wrote assert() in git. That is
certainly true of me. I don't know about other developers.

> > I think here you are getting into superstition. Is there any single
> > assert() in Git that will actually have an impact on performance?
> 
> You have suggested there is and that Git is enabling NDEBUG for exactly that
> reason -- to increase performance:

Sorry if I wasn't clear, but I meant in Git itself, not in the nedmalloc
compat code. I think it's worth considering them separately because the
latter is not part of most Git builds in the first place, and certainly
it is written in a different style, and may have different assumptions
about how people might build it.

I do not know the nedmalloc code well at all. I gave a brief read of the
results of "git grep 'assert('" and it looked like some of its
assertions are more involved than simple comparisons. So I guessed that
perhaps the reason that NDEBUG was added there when the code was
imported is that there is a performance difference there. But that's
just a guess. It may or may not be borne out by measurements.

I'd be surprised if any of the assertions in the rest of git have a
noticeable impact (and I could not detect one by running t/perf).

> > What would be the advantage of that over `if(...) die("BUG: ...")`? It
> > does not require you to write a reason in the die(), but I am not sure
> > that is a good thing.
> 
> You have stated that you believe the current "assert" calls in Git
> (excluding nedmalloc) should not magically disappear when NDEBUG is defined.

Well, no, I mostly just said that I do not think there is any point in
defining NDEBUG in the first place, as there is little or no benefit to
removing those asserts from the built product.

> So precluding a more labor intensive approach where all currently existing
> "assert(...)" calls are replaced with an "if (!...) die(...)" combination,
> providing a "verify" macro is a quick way to make that happen.  Consider
> this, was the value that Jonathan provided for the "die" string immediately
> obvious to you?  It sure wasn't to me.  That means that whoever does the
> "assert(...)" -> "if(!...)die" swap out may need to be intimately familiar
> with that particular piece of code or the result will be no better than
> using a "verify" macro.

Sure, if you want to mass-convert them, doing so with a macro similar to
assert is the simplest way. I don't think we are in a huge hurry to do
that conversion though. I'm not complaining that NDEBUG works as
advertised by disabling asserts. I'm just claiming that it's largely
pointless in our code base, and I'd consider die("BUG") to be our
"usual" style. If any change is to be made, it would be to suggest
people prefer die("BUG") as a style guideline for future patches. But I
haven't seen anybody agree (or disagree) with the notion, so I'd
hesitate to impose my style suggestion without more discussion in that
area.

If we _did_ accept that as a style guideline, then we could move over
existing assert() calls over time (either as janitorial projects, or as
people touch the related code). But there's not a pressing need to do it
quickly.

-Peff
