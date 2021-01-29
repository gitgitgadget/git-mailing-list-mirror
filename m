Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014D6C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923D764DED
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhA2W5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:57:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:41028 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhA2W5m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:57:42 -0500
Received: (qmail 4506 invoked by uid 109); 29 Jan 2021 22:56:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 22:56:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10534 invoked by uid 111); 29 Jan 2021 22:57:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 17:57:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 17:57:01 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBSSvXHIwUe/8rVj@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
 <YBRprCmIX4IrHAi0@nand.local>
 <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
 <YBSHzG9T72nYYVt4@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBSHzG9T72nYYVt4@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 05:10:20PM -0500, Taylor Blau wrote:

> On Fri, Jan 29, 2021 at 03:25:37PM -0500, Jeff King wrote:
> > So it may be reasonable to go that direction, which is really defining a
> > totally separate strategy from git-gc's "repack, and occasionally
> > objects age out". Especially if we find that the
> > assume-kept-packs-closed route is too risky (i.e., has too many cases
> > where it's possible to cause corruption if our assumptions isn't met).
> 
> Yeah, this whole conversation has made me very nervous about using
> reachability. Fundamentally, this isn't about reachability at all. The
> operation is as simple as telling pack-objects a list of packs that you
> do and don't want objects from, making a new pack out of that, and then
> optionally dropping the packs that you rolled up.
> 
> So, I think that teaching pack-objects a way to understand a caller that
> says "include objects from packs X, Y, and Z, but not if they appear in
> packs A, B, or C, and also pull in any loose objects" is the best way
> forward here.
> 
> Of course, you're going to be dragging along unreachable objects until
> you decide to do a full repack, but I'm OK with that since we wouldn't
> expect anybody to be solely relying on geometric repacks without
> occasionally running 'git repack -ad'.

While writing my other response, I had some thoughts that this "dragging
along" might not be so bad.

Just to lay out the problem as I see it, if you do:

  - frequently roll up all small packs and loose objects into a new
    pack, without regard to reachability

  - occasionally run "git repack -ad" to do a real traversal

then the problem is that unreachable objects never age out:

  - a loose unreachable object starts with a recent-ish mtime

  - the frequent roll-up rolls it into a pack, freshening its mtime

  - the full "repack -ad" doesn't delete it, because its pack mtime is
    too recent. It explodes it loose again.

  - repeat forever

We know that "repack -d" is not 100% accurate because of similar "closed
under reachability" assumptions (see my other email). But it's OK,
because the worst case is an object that doesn't quite get packed yet,
not that it gets deleted.

So you could do something like:

  - roll up loose objects into a pack with "repack -d"; mostly accurate,
    but doesn't suck up unreachable objects

  - roll up small packs into a bigger pack without regard for
    reachability. This includes the pack created in the first step, but
    we know everything in it is actually reachable.

  - eventually run "repack -ad" to do a real traversal

That would extend the lifetime of unreachable objects which were found
in a pack (they get dragged forward during the rollups). But they'd
eventually get exploded loose during a "repack -ad", and then _not_
sucked back into a roll-up pack. And then eventually "repack -ad"
removes them.

The downsides are:

  - doing a separate "repack -d" plus a roll-up repack is wasted work.
    But I think they could be combined into a single step (at the cost
    of some extra complexity in the implementation).

  - using "--unpacked" still means traversing every commit. That's much
    faster than traversing the whole object graph, but still scales with
    the size of the repo, not the size of the new objects. That might be
    acceptable, though.

I do think the original problem goes away entirely if we can keep better
track of the mtimes. I.e., if we had packs marked with ".cruft" instead
of exploding loose, then the logic is:

  - roll up all loose objects and any objects in a pack that isn't
    marked as cruft (or keep); never delete a cruft pack at this stage

  - occasionally "repack -ad"; this does delete old cruft packs (because
    we'd have rescued any reachable objects they might have contained)

I'm not sure I want to block this topic on having cruft packs, though.
Of course there are tons of _other_ reasons to want them (like not
causing operational headaches when a repo's disk and inode usage grows
by 10x due to exploding loose objects). So maybe it's not a bad idea to
work on them together. I dunno.

-Peff
