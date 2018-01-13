Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F911FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 09:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965469AbeAMJ66 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 04:58:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:43018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965443AbeAMJ64 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 04:58:56 -0500
Received: (qmail 28300 invoked by uid 109); 13 Jan 2018 09:58:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Jan 2018 09:58:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5605 invoked by uid 111); 13 Jan 2018 09:59:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Jan 2018 04:59:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Jan 2018 04:58:49 -0500
Date:   Sat, 13 Jan 2018 04:58:49 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: git gc --auto yelling at users where a repo legitimately has
 >6700 loose objects
Message-ID: <20180113095849.GA30511@sigill.intra.peff.net>
References: <87inc89j38.fsf@evledraar.gmail.com>
 <20180112134609.GB7880@sigill.intra.peff.net>
 <20180112142305.GA338@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180112142305.GA338@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 09:23:05PM +0700, Duy Nguyen wrote:

> > > Why can't we generate a new cruft-pack on every gc run that
> > > detects too many unreachable objects? That would not be as
> > > efficient as a single cruft-pack but it should be way more
> > > efficient than the individual objects, no?
> > > 
> > > Plus, chances are that the existing cruft-packs are purged with
> > > the next gc run anyways.
> > 
> > Interesting idea. Here are some thoughts in random order.
> > 
> > That loses some delta opportunities between the cruft packs, but
> > that's certainly no worse than the all-loose storage we have today.
> 
> Does it also affect deltas when we copy some objects to the new
> repacked pack (e.g. some objects in the cruft pack getting referenced
> again)? I remember we do reuse deltas sometimes but not in very
> detail. I guess we probably won't suffer any suboptimal deltas ...

We always reuse deltas that are coming from one pack into another pack,
unless the base isn't present in the new pack. So we'd retain existing
deltas. What you'd miss out on is just two versions of a file in two
separate cruft packs could not be delta'd together.

> > One nice aspect is that it means cruft objects don't incur any I/O
> > cost during a repack.
> 
> But cruft packs do incur object lookup cost since we still go through
> all packs linearly. The multi-pack index being discussed recently
> would help. But even without that, packs are sorted by mtime and old
> cruft packs won't affect as much I guess, as long as there aren't a
> zillion cruft packs around. Then even prepare_packed_git() is hit.

The cruft packs should behave pretty well with the mru list. We'd never
as for an object in such a pack during normal operations, so they'd end
up at the end of the list (the big exception is abbreviation, which has
to look in every single pack).

I'm not sure how many cruft packs you'd end up with in practice. If it's
one per auto-gc, then probably you're only generating one every few
days, and cleaning up old ones as you go.

I do still kind of favor having a single cruft pack, though, just
because it makes it simpler to reason about these sorts of things (but
then you need to mark individual object timestamps).

> > I'm not sure how the pruning process would work, especially with
> > respect to objects reachable from other unreachable-but-recent
> > objects. Right now the repack-and-delete procedure is done by
> > git-repack, and is basically:
> > 
> >   1. Get a list of all of the current packs.
> > 
> >   2. Ask pack-objects to pack everything into a new pack. Normally this
> >      is reachable objects, but we also include recent objects and
> >      objects reachable from recent objects. And of course with "-k" all
> >      objects are kept.
> > 
> >   3. Delete everything in the list from (1), under the assumption that
> >      anything worth keeping was repacked in step (2), and anything else
> >      is OK to drop.
> > 
> > So if there are regular packs and cruft packs, we'd have to know in
> > step 3 which are which. We'd delete the regular ones, whose objects
> > have all been migrated to the new pack (either a "real" one or a
> > cruft one), but keep the crufty ones whose timestamps are still
> > fresh.
> > 
> > That's a small change, and works except for one thing: the reachable
> > from recent objects. You can't just delete a whole cruft pack. Some
> > of its objects may be reachable from objects in other cruft packs
> > that we're keeping. In other words, you have cruft packs where you
> > want to keep half of the objects they contain. How do you do that?
> 
> Do we have to? Those reachable from recent objects must have ended up
> in the new pack created at step 2, correct? Which means we can safely
> remove the whole pack.

No, I think just I wrote (2) poorly. We repack the reachable objects,
but the recent ones (and things reachable only from them) are not
actually packed, but turned loose.

And of course in a cruft-packed world they'd end up in a cruft pack.

> Those reachable from other cruft packs. I'm not sure if it's different
> from when these objects are loose. If a loose object A depends on B,
> but B is much older than A, then B may get pruned anyway while A stays
> (does not sound right if A gets reused).

Hopefully not, after d3038d22f9 (prune: keep objects reachable from
recent objects, 2014-10-15). :)

-Peff
