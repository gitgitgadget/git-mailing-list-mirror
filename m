Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467EDC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF66206DA
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLTVOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:14:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:51458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727402AbfLTVOB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 16:14:01 -0500
Received: (qmail 3330 invoked by uid 109); 20 Dec 2019 21:14:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Dec 2019 21:14:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15350 invoked by uid 111); 20 Dec 2019 21:18:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2019 16:18:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Dec 2019 16:14:00 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v4 6/8] dir: fix checks on common prefix directory
Message-ID: <20191220211400.GB2752079@coredump.intra.peff.net>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
 <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
 <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
 <xmqq1rt1e30q.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHhAPjL9daPdp7UmVT+vLrcpo6SX0rKt5s1bH4Vz31wxw@mail.gmail.com>
 <20191219222403.GA705525@coredump.intra.peff.net>
 <CABPp-BEe7=LfR5KJriu1Lq-v5SVET-zm3GK3ZPjOYuLHrxqimg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEe7=LfR5KJriu1Lq-v5SVET-zm3GK3ZPjOYuLHrxqimg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 09:00:40AM -0800, Elijah Newren wrote:

> > > > > +     de = xcalloc(1, sizeof(struct dirent)+len+1);
> > > >
> > > > That "+len+1" may deserve a comment?
> > >
> > > Good point, I'll add one and send a re-roll.
> >
> > Please use st_add3() while you are at it.
> 
> I would, but Junio already took the patches and applied them to next
> already.  (I am curious, though, why we're worried about overflow in a
> context like this?)

If len is large enough to cause integer overflow when computing the
total size, then we'd allocate a too-small buffer (and then later
overflow the buffer when writing into it).

I'm not sure how possible that is here. On 32-bit systems, overflowing
size_t only needs 4GB. you're not likely to have a 4GB path on a
filesystem, but malicious folks could shove them into a tree. I'm not
sure if this code could be triggered for anything that doesn't actually
exist on the filesystem, though.

You're also not likely to actually manage to store a 4GB string in
"path" on a 32-bit system in the first place. But "len" is actually an
"int". On a 64-bit system it would be easy to do, though, and int is
still 32 bits there. But because the result of sizeof() is a size_t, I
think the int will be promoted as well during the addition (and assuming
it's not negative, will be too small to overflow). (Also, the "len"
parameter probably should to be a size_t in the first place, but that's
not new).

So I don't think it's exploitable, but as you can see there's a bit of
pondering to see that it's so. When I audit I usually look for something
like /x[mc]alloc.*[+*] / to find potential problem spots. Even if we're
pretty sure a particular site isn't vulnerable, marking it with st_add()
errs on the safe side, and makes those audits easier.

> It's possible I vastly overestimated how much work ripping out the
> dirent would be; I mean I've mis-estimated absolutely everything in
> dir.c and assumed each "little" thing would all be a small amount of
> work, so maybe I'm just swinging the pendulum too far the other way.
> But, although I think this alternative would be the cleanest, I saw a
> couple things that looked like this was going to turn into a huge can
> of worms when I started to peek at what it all touched.  I'd be happy
> for someone to take this route, but it won't be me (see also
> https://lore.kernel.org/git/CABPp-BEkX9cH1=r3dJ4WLzcJKVcF-KpGUkshL34MMp3Xhhhpuw@mail.gmail.com/).

OK. I certainly don't insist on this direction. I just saw the
portability issues and wondered how bad it would be to do so. Hence the
patch I sent, which I _think_ is correct, but I really don't know the
dir.c code very well. And I'm sure it will not surprise you that I have
generally been confused and/or frightened by it when I do look at it. :)

-Peff
