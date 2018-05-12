Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3591F406
	for <e@80x24.org>; Sat, 12 May 2018 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeELTMH (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 15:12:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:37410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751464AbeELTMH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 15:12:07 -0400
Received: (qmail 13108 invoked by uid 109); 12 May 2018 19:12:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 19:12:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16580 invoked by uid 111); 12 May 2018 19:12:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 15:12:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 15:12:05 -0400
Date:   Sat, 12 May 2018 15:12:05 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 03/12] shallow.c: use commit-slab for commit depth
 instead of commit->util
Message-ID: <20180512191205.GB8814@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180512080028.29611-4-pclouds@gmail.com>
 <20180512090748.GB28279@sigill.intra.peff.net>
 <20180512091809.GC28279@sigill.intra.peff.net>
 <CACsJy8ByKPSGR=Y+6y+bLBxq97M2EiZERMwZ9BGmJHYj7R0d3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8ByKPSGR=Y+6y+bLBxq97M2EiZERMwZ9BGmJHYj7R0d3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 02:09:18PM +0200, Duy Nguyen wrote:

> > That wastes an extra 4 bytes per slot over storing an int directly, but
> > it's the same as storing an 8-byte pointer, plus you avoid the storage
> > and runtime overhead of malloc.
> 
> Or we could have a way to let the user decide initial values. If the
> initial value here is -1 (which can't possibly be used in the current
> code), it could be the sentinel value.

That's actually a little tricky. Right now the sentinels are assigned by
xcalloc(), so they're all-bits zero. We _could_ walk any newly allocated
slab and assign a value to each element, but I'd worry that is wasteful
for cases where might only use a small part of the slab (and my
assumption is that the OS can give us zero'd pages pretty cheaply, and
maybe even avoid allocating a page until we touch them, but I don't know
how true that is).

> Did you notice the for loop in the end to free "int *"? I don't like
> peeking inside a slab that way and would prefer passing a "free"
> function pointer to clear_commit_depth(), or just assign a "free"
> function to some new field in struct commit_depth and
> clear_commit_depth() will call it. If we have a new field for "free"
> callback in the struct, it makes sense to have an "init" callback to
> do extra initialization on top of xcalloc.

You might find that a free() is tricky with the type system. This is all
implemented with macros, so you'd end up calling free() on an int (even
if it's a function that nobody ever calls). I suppose the value could be
cast to void to shut up the compiler, but then that function is like a
ticking time bomb. ;)

So I guess you'd need a variant of define_commit_slab() that defines the
clear function and one that doesn't.

> > I actually wonder if we could wrap commit_slab with a variant that
> > stores the sentinel data itself, to make this pattern easier. I.e.,
> > something like:
> >
> >   #define define_commit_slab_sentinel(name, type) \
> >         struct name##_value { \
> >                 unsigned valid:1; \
> >                 type value; \
> >         }; \
> >         define_commit_slab(name, struct name##_value)
> >
> > and some matching "peek" and "at" functions to manipulate value
> > directly.
> 
> If you keep this valid bit in a separate slab, you can pack these bits
> very tight and not worry about wasting memory. Lookup in commit-slab
> is cheap enough that doing double lookups (one for valid field, one
> for value) is not a problem, I think.

True, though your cache behavior gets worse if your have two separate
arrays. I'm not sure pinching bytes matters all that much. linux.git has
~600k commits, so even there a few bytes each is not so bad (although
again, we get into cache issues).

> Yeah I think I will stick with a faithful conversion for now. The
> conversion shows room for improvement which could be the next
> microproject (I thought of adding this removing 'util' task as a 2019
> microproject but it was too tricky for newcomers to do).

Makes sense to me.

-Peff
