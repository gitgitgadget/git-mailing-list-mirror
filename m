Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB50C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 08:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2750A22202
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 08:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895053AbgJ0IjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:39:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:38370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895050AbgJ0IjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 04:39:09 -0400
Received: (qmail 15151 invoked by uid 109); 27 Oct 2020 08:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 08:39:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15451 invoked by uid 111); 27 Oct 2020 08:39:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 04:39:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 04:39:06 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2020, #03; Mon, 19)
Message-ID: <20201027083906.GA61563@coredump.intra.peff.net>
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
 <20201023080202.GA4012156@coredump.intra.peff.net>
 <CABPp-BFV8ZAu5vLarG2mX8gT5bfV31oqbd-vjAQF_YDcyNSRiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFV8ZAu5vLarG2mX8gT5bfV31oqbd-vjAQF_YDcyNSRiw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 12:17:43PM -0700, Elijah Newren wrote:

> > I suspect my "check_and_add" function could be folded into Elijah's
> > implementation. The other big difference is that mine uses the
> > FLEX_ALLOC approach, and his doesn't. I haven't digested the code and
> > discussion around that from Elijah's series yet.
> 
> From a brief glance, it looks like the code in shortlog would probably
> be easy to convert over.  But more important is making sure we have a
> strmap/strset/strintmap API that we like.  You provided a lot of good
> feedback and pointers on the first round of the series, so if you
> could find some time to take a look at the second round, it'd be very
> appreciated.  I'm also very interested in your opinion on whether the
> changes I made were good enough, or if you'd like me to dig further
> into whether going the FLEX_ALLOC route will work.

I suspect the FLEX_ALLOC thing wouldn't really matter much either way
for the use I added in shortlog. It would rarely have more than a
handful of entries in it anyway: one per trailer in a given commit. I
suspect it might even perform better as an unsorted list, given the size
of N, but as soon as you code something like that somebody shows up with
a commit that has 10,000 "Reviewed-by" trailers in it or something. ;)

One possible solution is to use FLEXPTR_ALLOC, which embeds the string
in the struct but adds a pointer to it, as well. That gives most of the
benefits of FLEX_ALLOC (one malloc per entry instead of two, and better
cache locality), with only a small cost (8 bytes per entry). And it
would let the same data type be used to hold your use cases that do
pointer comparison (they'd use an empty FLEX_ARRAY and just set the
pointer as appropriate). And you only have to care when creating the
struct; all of the readers just look at the pointer, which is always
valid.

If you wanted to get _really_ crazy you could probably have a union of
the pointer and the FLEX_ARRAY, and then you could save those 8 bytes.
Not sure if that's worth the complexity (we need a separate bit flag to
tell the two cases apart, and every read would have to check it).

Hopefully that gives you some food for thought for now. I had hoped to
read through the series carefully tonight, but didn't get to it. But
it is on my todo list.

-Peff
