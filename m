Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3FAC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A7B20773
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgKCQUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:20:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:46254 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgKCQUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:20:14 -0500
Received: (qmail 6513 invoked by uid 109); 3 Nov 2020 16:20:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 16:20:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2115 invoked by uid 111); 3 Nov 2020 16:20:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 11:20:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 11:20:13 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] strmap: add functions facilitating use as a
 string->int map
Message-ID: <20201103162013.GE444466@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <cc8d702f98f94fd9202d227d19be43a912467e84.1602549650.git.gitgitgadget@gmail.com>
 <20201030143906.GH3277724@coredump.intra.peff.net>
 <CABPp-BFyqTthyBmp5yt+iUniwTi+=y2QcBcmNnnCy=zvyi3Rbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFyqTthyBmp5yt+iUniwTi+=y2QcBcmNnnCy=zvyi3Rbw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 10:28:51AM -0700, Elijah Newren wrote:

> > You might want to mention that this _could_ be done as just accessors to
> > strmap, but using a separate struct provides type safety against
> > misusing pointers as integers or vice versa.
> 
> If I just did it as accessors, it makes it harder for myself and
> others to remember what my huge piles of strmaps in merge-ort do; I
> found that it became easier to follow the code and remember what
> things were doing when some were marked as strmap, some as strintmap,
> and some as strset.

Oh, I'm definitely on board with that argument. I was just suggesting
you might want to put it in the commit message for posterity.

> > > +/*
> > > + * strintmap:
> > > + *    A map of string -> int, typecasting the void* of strmap to an int.
> >
> > Are the size and signedness of an int flexible enough for all uses?
> 
> If some users want signed values and others want unsigned, I'm not
> sure how we can satisfy both.  Maybe make a struintmap?

Right, that was sort of my question: do your users actually want it
signed or not. Sounds like they do want it signed, and don't mind the
loss of range.

> Perhaps that could be added later if uses come up for it?  Some of my
> uses need int, the rest of them wouldn't care about int vs unsigned.

Yeah, if you don't have any callers which care, I'd definitely punt on
it for now.

> If someone does care about the full range of bits up to 64 on relevant
> platforms, I guess I should make it strintptr_t_map.

Yeah, that's what I was wondering. I suspect the use case for that is
pretty narrow, though. If you really care about having a 64-bit value
for some data, then you probably want it _everywhere_, not just on
64-bit platforms. I guess the exception would be if you're mapping into
size_t's or something.

I think my question was as much "did you think about range issues for
your intended users" as "should we provide more range in this map type".
And it sounds like you have thought about that, so I'm happy proceeding.

> But besides the
> egregiously ugly name, one advantage of int over intptr_t (or unsigned
> over uintptr_t) is that you can use it in a printf easily:
>    printf("Size: %d\n", strintmap_get(&foo, 0));
> whereas if it strintmap_get() returns an intptr_t, then it's a royal
> mess to attempt to portably use it without adding additional manual
> casts.  Maybe I was just missing something obvious, but I couldn't
> figure out the %d, %ld, %lld, PRIdMAX, etc. choices and get the
> statement to compile on all platforms, so I'd always just cast to int
> or unsigned at the time of calling printf.

The right way is:

  printf("Size: %"PRIdMAX", (intmax_t) your_intptr_t);

which will always do the right thing no matter the size (at the minor
cost of passing a larger-than-necessary parameter, but if you're
micro-optimizing then calling printf at all is probably already a
problem).

But yeah, in general using a real "int" is much more convenient and if
there's no reason to avoid it for range problems, I think it's
preferable.

-Peff
