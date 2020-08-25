Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542B0C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA8C20706
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHYRWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:22:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:40164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgHYRWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 13:22:16 -0400
Received: (qmail 1287 invoked by uid 109); 25 Aug 2020 17:22:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 17:22:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30251 invoked by uid 111); 25 Aug 2020 17:22:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 13:22:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 13:22:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825172214.GC1414394@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 08:58:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Does "git repack" ever remove just one pack? Obviously "git repack -ad"
> > or "git repack -Ad" is going to pack everything and delete the old
> > packs. So I think we'd want to remove a midx there.
> 
> AFAIK, the pack-redundant subcommand is used by nobody in-tree, so
> nobody is doing "there are three packfiles, but all the objects in
> one of them are contained in the other two, so let's remove that
> redundant one".

OK, that's the part I was missing. The discussion here and the statement
from git-repack(1):

  -d
      After packing, if the newly created packs make some existing packs
      redundant, remove the redundant packs. Also run git prune-packed
      to remove redundant loose object files.

made me think that it was running pack-redundant. But it doesn't seem
to. It looks like we stopped doing so in 6ed64058e1 (git-repack: do not
do complex redundancy check., 2005-11-19).

As an aside, we tried using pack-redundant at GitHub several years ago
for dropping packs that were replicated in alternates storage. It
performs very poorly (quadratically, perhaps?) to the point that we
found it unusable, and I implemented a "local-redundant" command to do
the same thing more quickly. We ended up dropping that as we now migrate
packs wholesale (rather than via fetch), so I never upstreamed it.

I mention that here to warn people away from pack-redundant (I wondered
at the time why nobody had noticed its terrible performance, but now I
think the answer is just that nobody ever runs it). I wonder if we
should even consider deprecating and removing it.

I'm also happy to share local-redundant if anybody is interested (though
as I've mentioned elsewhere, I think the larger scheme it was part of it
also performed poorly and isn't worth pursuing).

> > And "git repack -d" I think of as deleting only loose objects that we
> > just packed. But I guess it could also remove a pack that has now been
> > made redundant? That seems like a rare case in practice, but I suppose
> > is possible.
> 
> Meaning it can become reality?  Yes.  Or it already can happen?  I
> doubt it.

I thought the latter, but after this thread I agree that it can't.

> > I'm also a little curious how bad it is to have a midx whose pack has
> > gone away. I guess we'd answer queries for "yes, we have this object"
> > even if we don't, which is bad. Though in practice we'd only delete
> > those packs if we have their objects elsewhere.
> 
> Hmph, object O used to be in pack A and pack B, midx points at the
> copy in pack B but we deleted it because the pack is redundant.
> Now, midx says O exists, but midx cannot be used to retrieve O.  We
> need to ask A.idx about O to locate it.
> 
> That sounds brittle.  I am not sure our error fallback is all that
> patient.

It has to be that patient even without a midx, I think. We might open
A.idx and mmap its contents, without opening the matching A.pack (or we
might open it and later close it due to memory or descriptor
constraints). And we have two layers there:

  - when object_info_extended sees a bad return from
    packed_object_info(), it will mark the entry as bad and recurse,
    giving us an opportunity to find another one

  - when we can't find the object at all (e.g., because we marked that
    particular pack's version as inaccessible), we'll hit the
    reprepare_packed_git() path and look for a new idx

Those same things should be kicking in for midx lookups, too (I didn't
test them, but from a cursory look at the organization of the code, I
think they will).

> > In that line of thinking, do we even need to delete midx files if one of
> > their packs goes away? The reading side probably ought to be able to
> > handle that gracefully.
> 
> But at that point, is there even a point to have that midx file that
> knows about objects (so it can answer has_object()? correctly and
> quickly) but does not know the correct location of half of the objects?
> Instead of going directly to A.idx to locate O, we need to go to midx
> to learn the location of O in B (which no longer exists), and then
> fall back to it, that is a pure overhead.

It is overhead for sure. But my thinking was that you're trading one
efficiency for another:

  - the midx may incur an extra lookup for objects in the redundant
    pack, but that pack may be a small portion of what the midx indexes
    (and this is likely in the usual case that you have one big
    cumulative pack and many recently-created smaller ones; the big one
    will never be made redundant and dominates the object count of the
    midx)

  - by keeping the midx, you're improving lookup speed for all of the
    other objects, which don't have to hunt through separate pack idx
    files

So my guess is that it would usually be a win. Though really the correct
answer is: if you are mucking with packs you should just generate a new
midx (or you should pack all-into-one, which generates a single idx
accomplishing the same thing).

> > And the more interesting case is when you repack everything with "-ad"
> > or similar, at which point you shouldn't even need to look up what's in
> > the midx to see if you deleted its packs. The point of your operation is
> > to put it all-into-one, so you know the old midx should be discarded.
> 
> Old one, yes.  Do we need to have the new one in that case?

You shouldn't need one since you'd only have a single pack now.

-Peff
