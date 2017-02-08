Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199A01FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 23:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdBHXBo (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 18:01:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:51883 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751149AbdBHXBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 18:01:42 -0500
Received: (qmail 4504 invoked by uid 109); 8 Feb 2017 23:00:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 23:00:59 +0000
Received: (qmail 7912 invoked by uid 111); 8 Feb 2017 23:01:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 18:01:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 18:00:57 -0500
Date:   Wed, 8 Feb 2017 18:00:57 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
Message-ID: <20170208230057.hking37uuynf4cgd@sigill.intra.peff.net>
References: <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
 <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
 <1486515795.1938.45.camel@novalis.org>
 <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
 <1486542299.1938.47.camel@novalis.org>
 <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
 <xmqqtw84wpag.fsf@gitster.mtv.corp.google.com>
 <1486580742.1938.52.camel@novalis.org>
 <20170208190858.rjoqehbhyizlwg5q@sigill.intra.peff.net>
 <1486592043.1938.82.camel@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1486592043.1938.82.camel@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2017 at 05:14:03PM -0500, David Turner wrote:

> > I wonder if you'd want to either bump the auto-gc object limit, or
> > possibly reduce the gc.pruneExpire limit to keep this situation from
> > coming up in the first place (or at least mitigating the amount of time
> > it's the case).
> 
> Auto-gc might not succeed in pruning objects, but it will at least
> reduce the number of packs, which is super-important for performance.

Right, I mean to bump the loose-object limit but keep the
gc.autoPackLimit at 50. If you couple that with setting
transfer.unpackLimit, then each push creates a single pack, and you
repack after 50 pushes.

You don't have to care about loose objects, because you know you only
get them when a "gc" ejects loose objects (so they're not as efficient,
but nothing actually accesses them; they just hang around until their
mtime grace period is up).

> I think the intent of automatic gc is to have a git repository be
> relatively low-maintenance from a server-operator perspective.  (Side
> note: it's fairly trivial for a user with push access to mess with the
> check simply by pushing a bunch of objects whose shas start with 17).
> It seems odd that git gets itself into a state where it refuses to do
> any maintenance just because at some point some piece of the maintenance
> didn't make progress.

In my experience, auto-gc has never been a low-maintenance operation on
the server side (and I do think it was primarily designed with clients
in mind).

At GitHub we disable it entirely, and do our own gc based on a throttled
job queue (one reason to throttle is that repacking is memory and I/O
intensive, so you really don't want to a bunch of repacks kicking off
all at once). So basically any repo that gets pushed to goes on the
queue, and then we pick the worst cases from the queue based on how
badly they need packing[1].

I wish regular Git were more turn-key in that respect. Maybe it is for
smaller sites, but we certainly didn't find it so. And I don't know that
it's feasible to really share the solution. It's entangled with our
database (to store last-pushed and last-maintenance values for repos)
and our job scheduler.

[1] The "how bad" thing is a heuristic, and we found it's generally
    proportional to the number of bytes stored in objects _outside_ of
    the big "main" pack. So 2 big pushes may need maintenance more
    than 10 tiny pushes, because they have more objects (and our goal
    with maintenance isn't just saving disk space or avoiding the linear
    pack search, but having up-to-date bitmaps and good on-disk deltas
    to make serving fetches as cheap as possible).

> Sure, I could change my configuration, but that doesn't help the other
> folks (e.g. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=813084 )
> who run into this.

Yeah, I'm certainly open to improving Git's defaults. If it's not clear
from the above, I mostly just gave up for a site the size of GitHub. :)

> Idea 1: when gc --auto would issue this message, instead it could create
> a file named gc.too-much-garbage (instead of gc.log), with this message.
> If that file exists, and it is less than one day (?) old, then we don't
> attempt to do a full gc; instead we just run git repack -A -d.  (If it's
> more than one day old, we just delete it and continue anyway).

I kind of wonder if this should apply to _any_ error. I.e., just check
the mtime of gc.log and forcibly remove it when it's older than a day.
You never want to get into a state that will fail to resolve itself
eventually. That might still happen (e.g., corrupt repo), but at the
very least it won't be because Git is too dumb to try again.

> Idea 2 : Like idea 1, but instead of repacking, just smash the existing
> packs together into one big pack.  In other words, don't consider
> dangling objects, or recompute deltas.  Twitter has a tool called "git
> combine-pack" that does this:
> https://github.com/dturner-tw/git/blob/dturner/journal/builtin/combine-pack.c

We wrote something similar at GitHub, too, but we never ended up using
it in production. We found that with a sane scheduler, it's not too big
a deal to just do maintenance once in a while.

  Also, our original problem was that repos which have gotten out of
  hand (say, 5000 packs) repacked _very_ slowly with a normal repack. So
  a "fast pack" followed by a real pack was a viable way out of that. In
  the end, I just made pack-objects handle this case better, and we
  don't need the fast-pack.

> That's less space-efficient than a true repack, but it's no worse than
> having the packs separate, and it's a win for read performance because
> there's no need to do a linear search over N packs to find an object.

Over the long term you may end up with worse packs, because the true
repack will drop some delta opportunities between objects in the same
pack (reasoning that they weren't made into deltas last time, so it's
not worth trying again). You'd probably need to use "-f" periodically.

This is all speculation, though. We never did it in production, so I was
never able to measure the real impact over time.

> Idea 3: As I suggested last time, separate fatal and non-fatal errors.
> If gc fails because of EIO or something, we probably don't want to touch
> the disk anymore. But here, the worst consequence is that we waste some
> processing power. And it's better to occasionally waste processing power
> in a non-interactive setting than it is to do so when a user will be
> blocked on it.  So non-fatal warnings should go to gc.log, and fatal
> errors should go to gc.fatal.  gc.log won't block gc from running. I
> think this is my preferred option.

This seems like your (1), except that it handles more than one type of
non-fatal error. So I like it much better.

I'm still not sure if it's worth making the fatal/non-fatal distinction.
Doing so is perhaps safer, but it does mean that somebody has to decide
which errors are important enough to block a retry totally, and which
are not. In theory, it would be safe to always _try_ and then the gc
process can decide when something is broken and abort. And all you've
wasted is some processing power each day.

-Peff
