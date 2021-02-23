Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F84C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3209164E20
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhBWSot (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:44:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:41982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhBWSor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:44:47 -0500
Received: (qmail 26776 invoked by uid 109); 23 Feb 2021 18:44:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 18:44:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2440 invoked by uid 111); 23 Feb 2021 18:44:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 13:44:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 13:44:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDVM9U7zLstNBVq2@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
 <xmqq7dmz5iw5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dmz5iw5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 11:43:22PM -0800, Junio C Hamano wrote:

> >     ++	/*
> >     ++	 * order packs by descending mtime so that objects are laid out
> >     ++	 * roughly as newest-to-oldest
> >     ++	 */
> >      +	if (a->mtime < b->mtime)
> >      +		return 1;
> >     ++	else if (b->mtime < a->mtime)
> >     ++		return -1;
> >      +	else
> >      +		return 0;
> 
> I think this strategy makes sense when this repack using this new
> feature is run for the first time in a repository that acquired many
> packs over time.  I am not sure what happens after the feature is
> used a few times---it won't always be the newest sets of packs that
> will be rewritten, but sometimes older ones are also coalesced, and
> when that happens the resulting pack that consists primarily of older
> objects would end up having a more recent timestamp, no?

Yeah, this is definitely a heuristic that can get out of sync with
reality. I think in general if you have base pack A and somebody pushes
up B, C, and D in sequence, we're likely to roll up a single DBC (in
that order) pack. Further pushes E, F, G would have newer mtimes. So we
might get GFEDBC directly. Or we might get GFE and DBC, but the former
would still have a newer mtime, so we'd create GFEDBC on the next run.

The issues come from:

  - we are deciding what to roll up based on size. A big push might not
    get rolled up immediately, putting it out-of-sync with the rest of
    the rollups.

  - we are happy to manipulate pack mtimes under the hood as part of the
    freshen_*() code.

I think you probably wouldn't want to use this roll-up strategy all the
time (even though in theory it would eventually roll up to a single good
pack), just because it is based on heuristics like this. You'd want to
occasionally run a "real" repack that does a full traversal, possibly
pruning objects, etc.

And that's how we plan to use it at GitHub. I don't remember how much of
the root problem we've discussed on-list, but the crux of it is:
per-object costs including traversal can get really high on big
repositories. Our shared-storage repo for all torvalds/linux forks is on
the order of 45M objects, and some companies with large and active
private repositories are close to that. Traversing the object graph
takes 15+ minutes (plus another 15 for delta island marking). For busy
repositories, by the time you finish repacking, it's time to start
again. :)

> Even then, I do agree that newer to older would be beneficial most
> of the time, so this is of course not an objection against this
> particular sort order.

So yeah. I consider this best-effort for sure, and I think this sort
order is the best we can do without traversing.

OTOH, we _do_ actually do a partial traversal in this latest version of
the series. We could use that to impact the final write order. It
doesn't necessarily hit every object, though, so we'd still want to fall
back on this pack ordering heuristic. I'm content to leave punt on that
work for now, and leave it for a future series after we see how this
heuristic performs in practice.

-Peff
