Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D01D1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeAWArN (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:47:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:53974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751253AbeAWArM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:47:12 -0500
Received: (qmail 13508 invoked by uid 109); 23 Jan 2018 00:47:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 00:47:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12858 invoked by uid 111); 23 Jan 2018 00:47:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 19:47:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:47:10 -0500
Date:   Mon, 22 Jan 2018 19:47:10 -0500
From:   Jeff King <peff@peff.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180123004710.GF26357@sigill.intra.peff.net>
References: <87h8rki2iu.fsf@evledraar.gmail.com>
 <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
 <20180117235220.GD6948@thunk.org>
 <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
 <20180118162721.GA26078@lst.de>
 <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
 <20180120221445.GA4451@thunk.org>
 <xmqqefmknp3f.fsf@gitster.mtv.corp.google.com>
 <871siihqvw.fsf@evledraar.gmail.com>
 <20180122180903.GB3513@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180122180903.GB3513@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 01:09:03PM -0500, Theodore Ts'o wrote:

> > Wouldn't it also make gc pruning more expensive? Now you can repack
> > regularly and loose objects will be left out of the pack, and then just
> > rm'd, whereas now it would entail creating new packs (unless the whole
> > pack was objects meant for removal).
> 
> The idea is that the cruft pack would be all objects that were no
> longer referenced.  Hence the proposal that if they ever *are*
> accessed, they would be exploded to a loose object at that point.  So
> in the common case, the GC would go quickly since the entire pack
> could just be rm'ed once it hit the designated expiry time.

I think Ævar is talking about the case of:

  1. You make 100 objects that aren't referenced. They're loose.

  2. You run git-gc. They're still too recent to be deleted.

Right now those recent loose objects sit loose, and have zero cost at
the time of gc.  In a "cruft pack" world, you'd pay some I/O to copy
them into the cruft pack, and some CPU to zlib and delta-compress them.
I think that's probably fine, though.

That said, some of what you wrote left me confused, and whether we're
all talking about the same idea. ;) Let me describe the idea I had
mentioned in another thread.  Right now the behavior is basically this:

If an unreachable object becomes referenced, it doesn't immediately get
exploded. During the next gc, whatever new object referenced them would
be one of:

  1. Reachable from refs, in which case it carries along the
     formerly-cruft object into the new pack, since it is now also
     reachable.

  2. Unreachable but still recent by mtime; we keep such objects, and
     anything they reference (now as unreachable, in this proposal in
     the cruft pack). Now these get either left loose, or exploded loose
     if they were previously packed.

  3. Unreachable and old. Both objects can be dropped totally.

The current strategy is to use the mtimes for "recent", and we use the
pack's mtime for every object in the pack.

So if we pack all the loose objects into a cruft pack, the mtime of the
cruft pack becomes the new gauge for "recent". And if we migrate objects
from old cruft pack to new cruft pack at each gc, then they'll keep
getting their mtimes refreshed, and we'll never drop them.

So we need to either:

  - keep per-object mtimes, so that old ones can age out (i.e., they'd
    hit case 3 and just not get migrated to either the new "real" pack
    or the new cruft pack).

  - keep multiple cruft packs, and let whole packs age out. But then
    cruft objects which get referenced again by other cruft have to get
    copied (not moved!) to new packs. That _probably_ doesn't happen all
    that often, so it might be OK.

> Another way of doing things would be to use the mtime of the cruft
> pack for the expiry time, and if the curft pack is ever referenced,
> its mtime would get updated.  Yet a third way would be to simply clear
> the "cruft" bit if it ever *is* referenced.  In the common case, it
> would never be referenced, so it could just get deleted, but in the
> case where the user has manually "rescued" a set of commits (perhaps
> by explicitly setting a branch head to commit id found from a reflog),
> the objects would be saved.

I don't think we have to worry about "rescued" objects. Those are
reachable, so they'd get copied into the new "real" pack (and then their
cruft pack eventually deleted).

-Peff
