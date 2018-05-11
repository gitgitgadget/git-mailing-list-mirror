Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB791F42D
	for <e@80x24.org>; Fri, 11 May 2018 08:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeEKI4h (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 04:56:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:35972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751406AbeEKI4g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 04:56:36 -0400
Received: (qmail 21687 invoked by uid 109); 11 May 2018 08:56:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 08:56:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31669 invoked by uid 111); 11 May 2018 08:56:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 04:56:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 04:56:34 -0400
Date:   Fri, 11 May 2018 04:56:34 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
Message-ID: <20180511085634.GC22086@sigill.intra.peff.net>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
 <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
 <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
 <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
 <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 08:19:59AM +0200, Duy Nguyen wrote:

> On Fri, May 11, 2018 at 6:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> René Scharfe <l.s.r@web.de> writes:
> >>
> >>>> But it somehow feels backwards in spirit to me, as the reason why we
> >>>> use "void *" there in the decoration field is because we expect that
> >>>> we'd have a pointer to some struture most of the time, and we have
> >>>> to occasionally store a small integer there.
> >>>
> >>> Yes, fast-export seems to be the only place that stores an integer as
> >>> a decoration.
> >>
> >> With the decoration subsystem that might be the case, but I think
> >> we have other codepaths where "void * .util" field in the structure
> >> is used to store (void *)1, expecting that a normal allocation will
> >> never yield a pointer that is indistinguishable from that value.
> >
> > I was looking at a different topic and noticed that bisect.c uses
> > commit->util (which is of type "void *") to always store an int (it
> > never stores a pointer and there is no mixing).  This one is equally
> > unportable as fast-export after your fix.
> >
> 
> In both cases we should be able to use commit-slab instead of
> commit->util. We could go even further and kill "util" pointer but
> that's more work.

I would love it if we could kill the util pointer in favor of
commit-slab. Unfortunately the fast-export case is decorating non-commit
objects, too.

I'm not sure how possible/easy it would be to have an "object slab".
Some complications are:

  1. It would increase the size of "struct tree" and "struct blob" by at
     least 4 bytes (possibly 8, due to alignment) to store the slab
     index. Commits would stay the same, but my experience is that most
     repositories have 5-10 times as many trees/blobs as commits.

     Some of that memory might be reclaimable. E.g., if we moved
     tree->buffer and tree->size into a slab, callers which don't use
     them would actually come out ahead (and more callers than you might
     expect could do this, since many only need to look at the tree
     contents inside a single function).

  2. If we allocate the indices for all types as a single sequence, then
     callers who only care about a specific type will have very sparse
     slabs (so they'll over-allocate, and it will have poor cache
     behavior).

     It might be possible to do something more clever. E.g., give each
     object type its own index counter, but then for a full object-slab,
     store per-type slabs and dereference obj->type to know which slab
     to look in.

     There'd be some complication with any_object. We'd probably need an
     OBJ_NONE slab, and then to allocate a type-specific index when the
     type is assigned. There's already a central point for this in
     object_as_type(). But we'd also have to migrate any
     previously-stored slab data (stored when it was OBJ_NONE), which
     implies having a global list of slabs.

So I dunno. It seems do-able but complicated.

-Peff
