Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF4DC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F7B60ED4
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhG1RqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:46:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:59968 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhG1RqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 13:46:24 -0400
Received: (qmail 4237 invoked by uid 109); 28 Jul 2021 17:46:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Jul 2021 17:46:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12346 invoked by uid 111); 28 Jul 2021 17:46:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Jul 2021 13:46:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Jul 2021 13:46:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQGX7SMu4UoTJ2VK@coredump.intra.peff.net>
References: <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
 <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
 <YQBEIrRfcq5dhpZn@nand.local>
 <YQBFi70c1wfXdKQf@coredump.intra.peff.net>
 <YQBGvEQoZpw49Z7L@nand.local>
 <YQBIqO5j0VHXL6V7@coredump.intra.peff.net>
 <YQBnE+ft/MR3zs1t@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQBnE+ft/MR3zs1t@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 04:05:39PM -0400, Taylor Blau wrote:

> > I actually think having write_midx_internal() open up a new midx is
> > reasonable-ish. It's just that:
> >
> >   - it's weird when it stuffs duplicate packs into the
> >     r->objects->packed_git list. But AFAICT that's not actually hurting
> >     anything?
> 
> It is hurting us when we try to write a MIDX bitmap, because we try to
> see if one already exists. And to do that, we call prepare_bitmap_git(),
> which tries to call open_pack_bitmap_1 on *each* pack in the packed_git
> list. Critically, prepare_bitmap_git() errors out if it is called with a
> bitmap_git that has a non-NULL `->pack` pointer.

It doesn't error out. It does produce a warning(), though, if it ignores
a bitmap (and that warning is doubly confusing because it is ignoring
bitmap X because it has already loaded and will use that exact same X!).

This causes t7700.13 to fail because it is being picky about stderr
being empty.

So the overall behavior is correct, but I agree it's sufficiently ugly
that we should make sure it doesn't happen.

  Side note: IMHO the "check all packs to see if there are any other
  bitmaps to warn about" behavior is kind of pointless, and we should
  consider just returning as soon as we have one. This is already
  somewhat the case after your midx-bitmap patches, as we will not even
  bother to look for a pack bitmap after finding a midx bitmap. That is
  a good thing, because it means you can keep pack bitmaps around for
  flexibility. But let's leave any changes to the pack-only behavior out
  of this series for simplicity.

> I stepped away from my computer for an hour or so and thought about
> this, and I think that the solution is two-fold:
> 
>   - We should be more careful about freeing up the ->next pointers of a
>     MIDX, and releasing the memory we allocated to hold each MIDX struct
>     in the first place.

Yeah. This is a bug already before your series. I suspect nobody noticed
because it's very rare for us to call close_midx() at all, and it only
matters if there's an alternate odb with a midx. (The common call to
close_midx() is in these write paths, but it is always using a single
midx file).

>   - We should always be operating on the repository's
>     r->objects->multi_pack_index, or any other MIDX that can be reached
>     via walking the `->next` pointers. If we do that consistently, then
>     we'll only have at most one instance of a MIDX struct corresponding
>     to each MIDX file on disk.

Certainly that makes sense to me in terms of the Windows "must close the
current midx before writing" behavior. We have to realize that we're
operating in the current repo.

But we do allow an "--object-dir" option to "multi-pack-index write",
and I don't see any other code explicitly requiring that it be part of
the current repository. What I'm wondering is whether this would be
breaking:

  cd $REPO/..
  git multi-pack-index --object-dir $REPO/.git/objects write

or:

  cd /some/other/repo
  git multi-pack-index --object-dir $REPO/.git/objects write

The latter does seem to work, but the former segfaults (usually -- if
there's already a midx it is OK).

If it is broken now, this may be a good time to explicitly forbid it.
It does seem to make the --object-dir mostly pointless, though it would
still work for operating on a midx in one of your alternates. I'm not
sure I understand the original point of that option, and if the current
behavior is sufficient.

If it turns out that we can't forbid writing midx's besides the ones in
r->objects, it may be sufficient to just make any assumptions
conditional. I.e., _if_ it's one of the ones mentioned by r->objects,
then close it, but otherwise leave it open. But if we can get away with
restricting ourselves as you described, I think the result will be much
simpler, and we should prefer that.

-Peff
