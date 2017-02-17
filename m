Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B834201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 05:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdBQFDn (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 00:03:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:56839 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbdBQFDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 00:03:42 -0500
Received: (qmail 24587 invoked by uid 109); 17 Feb 2017 05:03:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 05:03:42 +0000
Received: (qmail 30084 invoked by uid 111); 17 Feb 2017 05:03:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 00:03:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 00:03:39 -0500
Date:   Fri, 17 Feb 2017 00:03:39 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
Message-ID: <20170217050339.i4s2esabk3uvi5yb@sigill.intra.peff.net>
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
 <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
 <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
 <20170214195513.7zae6x22advkrms6@sigill.intra.peff.net>
 <CAP8UFD0EfUgfmTB4dj-A+rw79F7SWKxYvatNfR+Nj-8ukWYAQA@mail.gmail.com>
 <20170215214052.5py4pxkcz4g2bmtk@sigill.intra.peff.net>
 <CAP8UFD20=zVy=1Tr4D1Rxf+a4yR_X2zmexNCTNKV5RSF9ueYrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD20=zVy=1Tr4D1Rxf+a4yR_X2zmexNCTNKV5RSF9ueYrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 01:40:00PM +0100, Christian Couder wrote:

> > I started to add some tests, but I had second thoughts. It _is_ nice
> > to show off the fix, but as far as regressions go, this specific case is
> > unlikely to come up again. What would be more valuable, I think, is a
> > test script which set up a very long refname (not just 150 bytes or
> > whatever) and ran it through a series of git commands.
> 
> I agree that a test script running through a series of command with
> long refnames would be great.
> 
> But I think the refname should not necesarily be too long. As I wrote
> in the commit message of my patch, if the ref name had been much
> longer the crash would not have happened because the ref could not
> have been created in the first place.

Right, I think there's a tension there. Too short and it is not
interesting, and too long and things start to fail for uninteresting
reasons (e.g., your filesystem can't handle the name).

> So the best would be to run through a series of commands with a
> refname ranging from let's say 80 chars to 300 chars.
> 
> That would have a chance to catch crashes due to legacy code using for
> example things like `char stuff[128]` or `char stuff[256]`.

But that doesn't catch `char stuff[512]`. I think you'd really want a
range of sizes, and to test all of them. Worse, though, is it's not
clear how you decide when a test has failed. Obviously smashing the
stack is a bad outcome, but part of the goal would presumably be to
flush out unnecessary length limitations elsewhere.

I got about that far in my thinking before saying "wow, this is getting
to be complicated for not much gain".

> > So I dunno. It seems like being thorough is a
> > lot of hassle for not much gain. Being not-thorough is easy, but is
> > mostly a token that is unlikely to find any real bugs.
> 
> Yeah, if we really care, it might be better to start using a fuzzer or
> a property based testing tool instead of bothering with these kind of
> tests by ourselves, which is also a different topic.

Yes, I'd agree that a fuzzer is probably a better choice. I played with
AFL a bit back when it came out, but I never got it to turn up anything
useful.

I am disappointed that this obvious memory problem survived for so long.
I did quite a bit of auditing for such problems a year or two ago, but I
focused on problematic functions like strcpy, sprintf, etc.

It's easy to use memcpy() wrong, too, but it's hard to audit. There are
a lot of calls, and you have to match up the copied length with a value
computed elsewhere. I traded a lot of them out back then for safer
variants (like the FLEX_ALLOC stuff), but many calls just fundamentally
need something unsafe like memcpy to get their job done.

-Peff
