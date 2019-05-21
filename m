Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8571F462
	for <e@80x24.org>; Tue, 21 May 2019 21:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfEUVUZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 17:20:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:35374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727525AbfEUVUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 17:20:25 -0400
Received: (qmail 1257 invoked by uid 109); 21 May 2019 21:20:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 May 2019 21:20:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17257 invoked by uid 111); 21 May 2019 21:21:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 May 2019 17:21:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 May 2019 17:20:23 -0400
Date:   Tue, 21 May 2019 17:20:23 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190521212023.GB14807@sigill.intra.peff.net>
References: <20190516214257.GD10787@sigill.intra.peff.net>
 <20190516231509.253998-1-jonathantanmy@google.com>
 <20190517010950.GA30146@sigill.intra.peff.net>
 <20190517012234.GA31027@sigill.intra.peff.net>
 <20190517043939.GA12063@sigill.intra.peff.net>
 <CACsJy8CNyug3wvZ+6ts1nzgWyPF1JqC0LceP-HzMHjqvCr2Ugw@mail.gmail.com>
 <20190517085509.GA20039@sigill.intra.peff.net>
 <CACsJy8AkhKX57RYL1Z+HZHqKbAKKOcLoRkgwg8bSnk+DW2+Nmg@mail.gmail.com>
 <nycvar.YSQ.7.76.1905201803520.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1905201803520.1558@knanqh.ubzr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 07:04:14PM -0400, Nicolas Pitre wrote:

> > That still has some value even if your commit ends up with a question
> > mark. There's not much to dig out of 636171cb80 (make index-pack able
> > to complete thin packs., 2006-10-25). Adding Nico, maybe he still
> > remembers...
> 
> What about this comment in fix_unresolved_deltas():
> 
>         /*
>          * Since many unresolved deltas may well be themselves base objects
>          * for more unresolved deltas, we really want to include the
>          * smallest number of base objects that would cover as much delta
>          * as possible by picking the
>          * trunc deltas first, allowing for other deltas to resolve without
>          * additional base objects.  Since most base objects are to be found
>          * before deltas depending on them, a good heuristic is to start
>          * resolving deltas in the same order as their position in the pack.
>          */
> 
> Doesn't that cover it?

Hmm. It does help, but only because my earlier comments were actually
wrong. I was claiming that index-pack would not be able to resolve "A"
from the delta chain when A is a regular delta, B is a thin delta, and C
is not in the pack.

Because I did not see how we would ever find base "B" in that third pass
of fix_unresolved_deltas(), because we look only for objects we already
have on disk.

But I think the trick that I was missing is that if we see "B" first,
we'll resolve it against C that we already have, but then we'll _also_
look for children that this now enables us to resolve. So we'd resolve
"A" at that point, and then when we later hit "A" in the loop from
fix_unresolved_deltas(), we skip it because of this:

   if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
	continue;

So this situation _can_ happen, and we do handle it properly. I don't
know why the tests I showed in [1] didn't work. Obviously I botched
something.

I'm still not quite sure what would happen if we see "A" first (i.e.,
the delta is physically in the pack before its base, "B") and both are
REF_DELTA. Right now we'd skip over A, knowing that we don't have B. And
then when we get to B, we'd correctly resolve A on top of it (and if we
have no such B, we'd eventually complain "hey, there are still some
unresolved deltas").

But what happens if we _do_ have "B", but we just weren't able to tell
the sender for some reason (e.g., it's unreferenced). We'd add a new
copy of "B" to the pack while resolving "A", as part of --fix-thin. And
then when we resolve "B", we'd get _another_ copy of "B" in the pack,
and our result would have a duplicate.

I don't think this happens in practice because we'd generally use
OFS_DELTA in the first place these days. And even for REF_DELTA, I think
we prefer to put bases before their deltas (i.e., we'd always see "B"
before "A"). But I think if we ever _did_ see it (alternate
implementation? malicious packfile?) we'd generate duplicates. I _think_
that would then cause us to barf due to the duplicate check from
68be2fea50 (receive-pack, fetch-pack: reject bogus pack that records
objects twice, 2011-11-16).

And that's true today, even without Jonathan's on-demand fetching patch.
So I don't think that materially changes the requirements for
correctness. It does mean that we might fetch (but not use!) a thin base
we don't need, but only if the sender uses REF_DELTA for non-thin
deltas, which we wouldn't normally do.

-Peff

[1] https://public-inbox.org/git/20190517043939.GA12063@sigill.intra.peff.net/
