Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A347AC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B8764E09
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 19:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhA2TWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 14:22:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:40696 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbhA2TUO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 14:20:14 -0500
Received: (qmail 3421 invoked by uid 109); 29 Jan 2021 19:19:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 19:19:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8193 invoked by uid 111); 29 Jan 2021 19:19:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 14:19:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 14:19:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 07:21:09PM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > Teach pack-objects an option to imply the revision machinery's new
> > '--no-kept-objects' option when doing a reachability traversal.
> >
> > When '--assume-kept-packs-closed' is given as an argument to
> > pack-objects, it behaves differently (i.e., passes different options to
> > the ensuing revision walk) depending on whether or not other arguments
> > are passed:
> >
> >   - If the caller also specifies a '--keep-pack' argument (to mark a
> >     pack as kept in-core), then assume that this combination means to
> >     stop traversal only at in-core packs.
> >
> >   - If instead the caller passes '--honor-pack-keep', then assume that
> >     the caller wants to stop traversal only at packs with a
> >     corresponding .keep file (consistent with the original meaning which
> >     only refers to packs with a .keep file).
> >
> >   - If both '--keep-pack' and '--honor-pack-keep' are passed, then
> >     assume the caller wants to stop traversal at either kind of kept
> >     pack.
> 
> If there is an out-of-band guarantee that .kept packs won't refer to
> outside world, then we can obtain identical results to what existing
> --honor-pack-keep (which traverses everything and then filteres out
> what is in .keep pack) does by just stopping traversal when we see
> an object that is found in a .keep pack.  OK, I guess that it
> answers the correctness question I asked about [02/10].
> 
> It still is curious how we can safely "assume", but presumably we
> will see how in a patch that appears later in the series.

I think this would generally happen if the .keep packs are generated
using something like "git repack -a", which packs everything reachable
together. So if you do:

  git repack -ad
  touch .git/objects/pack/pack-whatever.keep
  ... some more packs come in, perhaps via pushes ...
  # imagine repack knew how to pass this along...
  git repack -a --assume-kept-packs-closed

then you'd repack just the objects that aren't in the big pack.

(And other kept packs; this probably would not want to be used with
.keep packs, since those can be racily created by receive-pack. Rather
you'd want to say "consider this specific list of packs to be closed and
kept").

It is dangerous, though. If your assumption is somehow wrong, then you'd
potentially corrupt the repository (because you'd stop traversing, but
perhaps delete a pack that contained a useful object you would have
reached that you don't have elsewhere).

The overall goal here is being able to roll up loose objects and smaller
packs without having to pay the cost of a full reachability traversal
(which can take several minutes on large repositories). Another
very-different direction there is to just enumerate those objects
without respect to reachability, stick them in a pack, and then delete
the originals. That does imply something like "repack -k", though, and
interacts weirdly with letting unreachable objects age out via their
mtimes (we'd constantly suck them back into fresh packs).

That would work better if we our unreachable "aging out" storage was
marked as such (say, in a pack marked with a ".cruft" file, rather than
just a regular loose object that might be new or might be cruft). Then a
roll-up repack would leave cruft packs alone (neither rolling them up,
nor deleting them). A "real" repack would eventually delete them, but
only after having done an actual reachability traversal, which make sure
there are no objects within them that need rescued.

> How "closed" are these kept packs supposed to be?  When there are
> two .keep packs, should objects in each of the packs never refer to
> outside their own pack, or is it OK for objects in one kept pack to
> refer to another object in the other kept pack?  Readers and those
> who want to understand and extend this code in the future would need
> to know what definition of "closed" you are using here.

I think it would want to be "the set of all .keep packs is closed". In a
"roll all into one" scenario like above, there is only one .keep pack.
But in a geometric progression, that single pack which constitutes your
base set could be multiple packs (the last whole "git repack -ad", but
then a sequence of roll-ups that came on top of it).

-Peff
