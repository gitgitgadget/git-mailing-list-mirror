Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C569AC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C805611CE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbhI0X4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:56:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:55922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhI0X4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:56:00 -0400
Received: (qmail 7906 invoked by uid 109); 27 Sep 2021 23:54:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Sep 2021 23:54:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22281 invoked by uid 111); 27 Sep 2021 23:54:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 19:54:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 19:54:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
Message-ID: <YVJZrOYucywgoi+v@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
 <694f477d-b387-c8ea-4138-0e9334540c69@kdbg.org>
 <87czou1dmp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czou1dmp.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 01:02:35PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >>  static inline void cb_init(struct cb_tree *t)
> >>  {
> >> -	t->root = NULL;
> >> +	struct cb_tree blank = CBTREE_INIT;
> >
> > This could be
> >
> > 	static const struct cb_tree blank = CBTREE_INIT;
> 
> *nod*...
> [...]
> ...but to both this & the above my reply in the side-thread at
> https://lore.kernel.org/git/87h7e61duk.fsf@evledraar.gmail.com/
> applies. I.e. this is just following a pattern I got from Jeff King &
> used in bd4232fac33 (Merge branch 'ab/struct-init', 2021-07-16).

I'm not sure how a compiler would react to the "static const" thing. I
tested the compiler output for the "auto" struct case you've written
here, and at least gcc and clang are smart enough to just initialize the
pointed-to struct directly, with no extra copy.

For a "static const" I'm not sure if they'd end up with the same code,
or if they'd allocate a struct in the data segment and just memcpy()
into place. A non-const static would perhaps push it in the direction of the
data/memcpy thing, though the compiler should be well aware that the
struct is never changed nor aliased, and thus we're always writing the
INIT values.

I suspect the performance is not that different either way (the big
thing to avoid is initializing an auto struct on the fly and then
copying from it, but this is a pretty easy optimization for compilers to
get right).

> >> +	memcpy(t, &blank, sizeof(*t));
> >
> > Is
> > 	*t = blank;
> >
> > not a thing in C?

It would be fine to use struct assignment here, and should be equivalent
in most compilers. They know about memcpy() and will inline it as
appropriate.

I think some C programmers tend to prefer memcpy() just because that's
how they think. It also wasn't legal in old K&R compilers, but as far as
I know was in C89.

You have to take care with assignment of flex-structs, of course, but
you also have to do so with memcpy(), too. :)

> FWIW with "const" in general I don't use it as much as I'd personally
> prefer, see e.g. [1] for one recent discussion, but maybe there wouldn't
> be any push-back in this case...

This isn't a parameter, so I don't think that discussion applies. _If_
you are going to make it a static, I think a const makes sense here (but
probably does nothing beyond signaling your intention, because the
compiler can see that it is never modified), but I wouldn't bother with
either.

-Peff
