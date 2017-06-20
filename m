Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64C520282
	for <e@80x24.org>; Tue, 20 Jun 2017 14:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdFTOIm (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 10:08:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:46268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752310AbdFTOIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 10:08:39 -0400
Received: (qmail 22918 invoked by uid 109); 20 Jun 2017 14:08:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Jun 2017 14:08:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13249 invoked by uid 111); 20 Jun 2017 14:08:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jun 2017 10:08:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jun 2017 10:08:38 -0400
Date:   Tue, 20 Jun 2017 10:08:38 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "There are too many unreachable loose objects" - why don't we
 run 'git prune' automatically?
Message-ID: <20170620140837.fq3wxb63lnqay6xz@sigill.intra.peff.net>
References: <9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com>
 <20170609052755.dsuqd4gizi2opoya@sigill.intra.peff.net>
 <7497DFA7-3F4E-4DB2-B31B-FDDEB2F30BB8@gmail.com>
 <20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net>
 <EDF2B923-8A5F-436E-BDB8-82249C6052ED@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EDF2B923-8A5F-436E-BDB8-82249C6052ED@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 03:22:29PM +0200, Lars Schneider wrote:

> > To be honest, the fact that we have to write this warning at all is a
> > sign that Git is not doing a very good job. The best place to spend
> > effort would be to teach git-gc to pack all of the unreachable objects
> > into a single "cruft" pack, so this problem doesn't happen at all (and
> > it's way more efficient, as well).
> > 
> > The big problem with that approach is that we lose individual-object
> > timestamps. Each object just gets the timestamp of its surrounding pack,
> > so as we continually ran auto-gc, the cruft-pack timestamp would get
> > updated and we'd never drop objects. So we'd need some auxiliary file
> > (e.g., pack-1234abcd.times) that stores the per-object timestamps. This
> > can be as small as a 32- or 64-bit int per object, since we can just
> > index it by the existing object list in the pack .idx.
> 
> Why can't we generate a new cruft-pack on every gc run that detects too
> many unreachable objects? That would not be as efficient as a single
> cruft-pack but it should be way more efficient than the individual
> objects, no?
> 
> Plus, chances are that the existing cruft-packs are purged with the next
> gc run anyways.

Interesting idea. Here are some thoughts in random order.

That loses some delta opportunities between the cruft packs, but that's
certainly no worse than the all-loose storage we have today.

One nice aspect is that it means cruft objects don't incur any I/O cost
during a repack.

It doesn't really solve the "too many loose objects after gc" problem.
It just punts it to "too many packs after gc". This is likely to be
better because the number of packs would scale with the number of gc
runs, rather than the number of crufty objects. But there would still be
corner cases if you run gc frequently. Maybe that would be acceptable.

I'm not sure how the pruning process would work, especially with respect
to objects reachable from other unreachable-but-recent objects. Right
now the repack-and-delete procedure is done by git-repack, and is
basically:

  1. Get a list of all of the current packs.

  2. Ask pack-objects to pack everything into a new pack. Normally this
     is reachable objects, but we also include recent objects and
     objects reachable from recent objects. And of course with "-k" all
     objects are kept.

  3. Delete everything in the list from (1), under the assumption that
     anything worth keeping was repacked in step (2), and anything else
     is OK to drop.

So if there are regular packs and cruft packs, we'd have to know in step
3 which are which. We'd delete the regular ones, whose objects have all
been migrated to the new pack (either a "real" one or a cruft one), but
keep the crufty ones whose timestamps are still fresh.

That's a small change, and works except for one thing: the reachable
from recent objects. You can't just delete a whole cruft pack. Some of
its objects may be reachable from objects in other cruft packs that
we're keeping. In other words, you have cruft packs where you want to
keep half of the objects they contain. How do you do that?

I think you'd have to make pack-objects aware of the concept of cruft
packs, and that it should include reachable-from-recent objects in the
new pack only if they're in a cruft pack that is going to be deleted. So
those objects would be "rescued" from the cruft pack before it goes away
and migrated to the new cruft pack. That would effectively refresh their
timestamp, but that's fine. They're reachable from objects with that
fresh timestamp already, so effectively they couldn't be deleted until
that timestamp is hit.

So I think it's do-able, but it is a little complicated.

-Peff
