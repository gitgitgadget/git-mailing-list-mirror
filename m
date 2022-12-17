Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A14CC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 21:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiLQVxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 16:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLQVxw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 16:53:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4057DFDB
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 13:53:51 -0800 (PST)
Received: (qmail 5372 invoked by uid 109); 17 Dec 2022 21:53:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Dec 2022 21:53:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27939 invoked by uid 111); 17 Dec 2022 21:53:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Dec 2022 16:53:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Dec 2022 16:53:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
Message-ID: <Y546bgdvYIkfwTlv@coredump.intra.peff.net>
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
 <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
 <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
 <Y53DAoJ4eK01rEji@coredump.intra.peff.net>
 <91c5120d-bbd4-8aa5-a205-d1f5387a7f19@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91c5120d-bbd4-8aa5-a205-d1f5387a7f19@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2022 at 05:07:12PM +0100, René Scharfe wrote:

> > If we are just re-ordering argv, though, it feels like this could still
> > work with a strvec. Right now a strvec with "nr" items will free items 0
> > through nr-1, assuming that v[nr] is its NULL invariant. But it could
> > free v[nr], too, in case the NULL was swapped into an earlier position.
> >
> > It's a little weird already, because that swap has violated the
> > invariant, so trying to strvec_push() onto it would cause confusing
> > results. But if the general use case is to pass the strvec to
> > parse_options(), get reordered, and then clear() it, it should work. If
> > you wanted to get really fancy, push() et al could double-check the
> > invariant and BUG().
> 
> Yes, parse_options() and strvec are not fitting perfectly.  Changing the
> former to reorder the elements and keeping them all would require
> checking that all callers use the return value.  Feels like a lot of work.

I think we're already munging the strvec arrays in the option parser,
though. I'm just suggesting that parse_options() swap arguments to the
end instead of overwriting a NULL (actually, I'm not even sure it
doesn't do that already), and strvec_clear() checking the final element.
The end state is not necessarily safe, but it's no worse than what we
have today.

That said...

> A variant that takes a strvec and removes and frees parsed items from it
> would be clean, but would require refactoring indirect callers like
> apply_parse_options() users.  Busywork.
> 
> Making a shallow copy to give to parse_options() in callers that currently
> pass a strvec directly or indirectly seems like the simplest solution to
> me for now.

Yes, I thought your original patch actually got to the root of the
problem. strvec owns the array and its elements, and parse-options wants
to munge the array itself (but not the elements). Making a shallow copy
is eliminates the conflict over ownership.

-Peff
