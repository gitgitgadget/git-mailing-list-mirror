Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2444C4320A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8809D60EBD
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhGWHtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:49:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:55456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhGWHtE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 03:49:04 -0400
Received: (qmail 10731 invoked by uid 109); 23 Jul 2021 08:29:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 08:29:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23149 invoked by uid 111); 23 Jul 2021 08:29:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 04:29:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 04:29:37 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPhz+iOMu4Q7zjY4@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 03:22:34PM -0400, Taylor Blau wrote:

> > > This avoids a problem that would arise in subsequent patches due to the
> > > combination of 'git repack' reopening the object store in-process and
> > > the multi-pack index code not checking whether a pack already exists in
> > > the object store when calling add_pack_to_midx().
> > >
> > > This would ultimately lead to a cycle being created along the
> > > 'packed_git' struct's '->next' pointer. That is obviously bad, but it
> > > has hard-to-debug downstream effects like saying a bitmap can't be
> > > loaded for a pack because one already exists (for the same pack).
> >
> > I'm not sure I completely understand the bug that this causes.
> 
> Off-hand, I can't quite remember either. But it is important; I do have
> a distinct memory of dropping this patch and then watching a 'git repack
> --write-midx' (that option will be introduced in a later series) fail
> horribly.
> 
> If I remember correctly, the bug has to do with loading a MIDX twice in
> the same process. When we call add_packed_git() from within
> prepare_midx_pack(), we load the pack without caring whether or not it's
> already loaded. So loading a MIDX twice in the same process will fail.
> 
> So really I think that this is papering over that bug: we're just
> removing one of the times that we happened to load a MIDX from during
> the writing phase.

Hmm, after staring at this for a bit, I've unconfused and re-confused
myself several times.

Here are some interesting bits:

  - calling load_multi_pack_index() directly creates a new midx object.
    None of its m->packs[] array will be filled in. Nor is it reachable
    as r->objects->multi_pack_index.

  - in using that midx, we end up calling prepare_midx_pack() for
    various packs, which creates a new packed_git struct and adds it to
    r->objects->packed_git (via install_packed_git()).

So that's a bit weird already, because we have packed_git structs in
r->objects that came from a midx that isn't r->objects->multi_pack_index.
And then if we later call prepare_multi_pack_index(), for example as
part of a pack reprepare, then we'd end up with duplicates.

Whereas normally, when a direct load_multi_pack_index() was not called,
our only midx would be r->objects->multi_pack_index, and so we'd avoid
re-loading it.

That seems wrong and wasteful, but I don't see how it results in a
circular linked list. And it seems like it would already be the case for
this write path, independent of your series. Either way, the solution is
probably for prepare_midx_pack() to check for duplicates (which we can
do pretty cheaply these days due to the hashmap; see prepare_pack).

But I'm worried there is something else going on. Your commit message
mentions add_pack_to_midx(). That's something we call as part of
write_midx_internal(), and it does create other packed_git structs. But
it never calls install_packed_git() on them; they just live in the
write_midx_context. So I'm not sure how they'd interfere with things.

And then there's one final oddity. Your patch assigns to ctx.m from
r->objects->multi_pack_index. But later in write_midx_internal(), we
call close_midx(). In the original, it's in the middle of the function,
but one of your patches puts it at the end of the function. But that
means we are closing r->objects->multi_pack_index.

Looking at close_midx(), it does not actually zero the struct. So we'd
still have r->objects->multi_pack_index->data pointed to memory which
has been unmapped. That seems like an accident waiting to happen. I
guess it doesn't usually cause problems because we'd typically write a
midx near the end of the process, and then not look up other objects?

So I'm concerned this is introducing a subtle bug that will bite us
later. And we should figure out what the actual thing it's fixing is, so
we can understand if there is a better way to fix it (e.g., by removing
duplicates in prepare_midx_pack(), or if it is some interaction with the
writing code).

I guess a good thing to try would be dropping this patch and seeing if
the tests break. ;)

-Peff
