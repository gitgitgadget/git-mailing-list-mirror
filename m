Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04FC1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 20:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeJBDFj (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 23:05:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:37738 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726027AbeJBDFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 23:05:39 -0400
Received: (qmail 21847 invoked by uid 109); 1 Oct 2018 20:26:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Oct 2018 20:26:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21647 invoked by uid 111); 1 Oct 2018 20:25:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Oct 2018 16:25:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Oct 2018 16:26:06 -0400
Date:   Mon, 1 Oct 2018 16:26:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
Message-ID: <20181001202605.GB10234@sigill.intra.peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
 <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
 <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
 <20180814015842.GA27055@sigill.intra.peff.net>
 <030bac66-eeb4-7bc9-8f27-1e6b4124fd76@web.de>
 <20180827230314.GB10402@sigill.intra.peff.net>
 <9e2440cc-39a6-f51b-9aee-8536020ed033@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e2440cc-39a6-f51b-9aee-8536020ed033@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 09:15:53PM +0200, René Scharfe wrote:

> Am 28.08.2018 um 01:03 schrieb Jeff King:
> > On Sun, Aug 26, 2018 at 01:37:41PM +0200, René Scharfe wrote:
> >> So it seems worth it.
> > 
> > Hmm, that really does. Which is a shame, because I hoped that one day we
> > could get rid of the nasty macro-infestation that is khash.h. But it
> > really is a lot faster than the alternatives.
> 
> Well, we only compare it to hashmap.c here.  There might be better
> implementations out there.  Hash tables in plain old C seem to be much
> harder to find than e.g. in C++, though.

I think it may be either-or here. The speed benefit to using khash here
is that we stick the data into the hash table itself, rather than
incurring a separate malloc for each entry. Which is pretty hard to do
in C without macros (the alternative is lots of void pointers, and
telling the hash table "your size is X bytes").

> And then there are several possible variations that affect
> performance -- perhaps hashmap.c could be improved by using open
> addressing, maybe with Robin Hood hashing, and/or by offering better
> support for sets, and/or by having a few macros to allow type
> specialization.

The reason hashmap.c was added was to avoid open addressing. ;)

So yeah, I think it could perhaps be improved, but in my mind talking
about "hashmap.c" is fundamentally talking about chained buckets.

But whatever you want to call it, I would be happy with a more type-safe
and performance hashmap.

> But I like how khash.h is both already in the tree and also really easy
> to deploy, as it's just a single header file.  It's a tasty low-hanging
> fruit.

Yeah. And if it really does perform better, I think we should stick with
it in the code base. I wonder if we could stand to clean up the
interfaces a little.  E.g., I had a hard time declaring a hash in one
place, and then defining it somewhere else. And I think as you found
that it insists on heap-allocating the hash-table struct itself, which
does not match our usual style.

> > Do you want to pick up this topic and carry it forward?
> 
> Well, I tried to simplify the implementation as much as possible and
> ended up doing the opposite of what I wrote earlier.  Hmm.
> 
> The patch below postpones struct allocation until cleanup time, which is
> a bit weird.  We can't avoid it fully without reimplementing kh_destroy,
> but we can use structs supplied by callers for basically all other
> operations.  That avoids NULL checks, and the main benefits of that are
> simplicity and safety; performance is not much better without them.

Your patch looks OK from a cursory view. I actually think that retaining
the extra NULL encapsulation is not the worst thing in the world. Most
callers should be going through the oid_* functions anyway.

But if we want to take the time to refactor khash (or even write our own
version, taking inspiration from what's there), the result would be
better still. If you're not planning to work on that in the near future,
though, I'd be OK with either of the alternates (the extra level of
pointer indirection from earlier, or this slight kh_destroy hackery
here).

> -- >8 --
> Subject: [PATCH] oidset: use khash
> 
> Reimplement struct oidset using khash.h in order to reduce its memory
> footprint and make it faster.
> 
> This is straight-forward, except for oidset_clear(), which needs to
> allocate a kh_oid_t on the heap in order to be able to feed it to
> kh_destroy_oid() for release it.  Alternatively we could open-code the
> relevant parts of the latter, but that would be a layering violation.

This is kind of a layering violation, too. You're assuming that struct
assignment is sufficient to make one kh struct freeable from another
pointer. That's probably reasonable, since you're just destroying them
both (e.g., some of our FLEX structs point into their own struct memory,
making a hidden dependency; but they obviously would not need to free
such a field).

-Peff
