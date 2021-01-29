Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704B3C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEED764DDC
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhA2XcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:32:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:41128 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhA2XcM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:32:12 -0500
Received: (qmail 4784 invoked by uid 109); 29 Jan 2021 23:31:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 23:31:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11037 invoked by uid 111); 29 Jan 2021 23:31:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 18:31:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 18:31:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBSazIgZds5ZWGlW@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
 <YBRprCmIX4IrHAi0@nand.local>
 <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
 <YBSHzG9T72nYYVt4@nand.local>
 <xmqqh7mzs5w3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7mzs5w3.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 03:03:08PM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > So, I think that teaching pack-objects a way to understand a caller that
> > says "include objects from packs X, Y, and Z, but not if they appear in
> > packs A, B, or C, and also pull in any loose objects" is the best way
> > forward here.
> 
> Are our goals still include that the resulting packfile has good
> delta compression and object locality?  Reachability traversal
> discovers which commit comes close to which other commits to help
> pack-objects to arrange the resulting pack so that objects that
> appear close together in history appears close together.  It also
> gives each object a pathname hint to help group objects of the same
> type (either blobs or trees) with like-paths together for better
> deltification.
> 
> Without reachability traversal, I would imagine that it would become
> quite important to keep the order in which objects appear in the
> original pack, and existing delta chain, as much as possible, or
> we'd be seeing a horribly inefficient pack like fast-import would
> produce.

Thanks, that's another good point we discussed a while ago (off-list),
but hasn't come up in this discussion yet.

Another option here is not to roll up packs at all, but instead to use a
midx to cover them all[1]. That solves the issue where object lookup is
O(nr_packs), and you retain the same locality and delta characteristics.

But I think part of the goal is to actually improve the deltas, in two
ways:

  - we'd hopefully find new delta opportunities between objects in the
    various packs

  - we'll drop some objects that are duplicated in other packs.
    Definitely we have to to avoid duplicates in the roll-up pack, but I
    think we'd want to even for objects that are in the "big" kept pack.
    These are likely bases of deltas in our roll-up pack, since the
    common cause there is --fix-thin adding them to complete the pack.
    But we really prefer to serve fetches using the ones out of the main
    pack, since they may already themselves be deltas (which makes them
    way cheaper; we can send the delta straight off the disk, rather
    than looking for a new possible base).

So I would anticipate the delta-compression phase actually trying to do
some new work. I do worry that the lack of pathname hints may make the
deltas we find much more worse (or cause us to spend excessive CPU
searching for them). It's possible we could do a "best effort" traversal
where we walk new commits to find newly added pathnames, but don't
bother crossing into trees/commits that aren't in the set of objects to
be packed. It's OK to optimize for speed there, because it's just
feeding the delta heuristic, not the set of objects we'd plan to pack.

-Peff

[1] Our end-game plan is actually to _also_ use a midx to cover the
    roll-ups and the "big" pack, since we'd want to generate bitmaps for
    the new objects, too.'
