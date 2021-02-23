Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A6C433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEBB64DF3
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhBWBne (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 20:43:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:40980 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhBWBnd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 20:43:33 -0500
Received: (qmail 22645 invoked by uid 109); 23 Feb 2021 01:42:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 01:42:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21237 invoked by uid 111); 23 Feb 2021 01:42:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 20:42:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 20:42:50 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDRdmh8oS5/xq4rB@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
 <YDRM0E+GjLlXoSwC@coredump.intra.peff.net>
 <YDRVCIdwRTw4PoMR@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDRVCIdwRTw4PoMR@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 08:06:16PM -0500, Taylor Blau wrote:

> > >     ++static int pack_mtime_cmp(const void *_a, const void *_b)
> > >     ++{
> > >     ++        struct packed_git *a = ((const struct string_list_item*)_a)->util;
> > >     ++        struct packed_git *b = ((const struct string_list_item*)_b)->util;
> > >     ++
> > >     ++        if (a->mtime < b->mtime)
> > >     ++                return -1;
> > >     ++        else if (b->mtime < a->mtime)
> > >     ++                return 1;
> > >     ++        else
> > >     ++                return 0;
> > >     ++}
> > >     ++
> >
> > Does that give us the packs in increasing chronological order, but then
> > decreasing chronological order within the packs themselves?
> 
> I agree we should be sorting and not blindly accepting the order that
> the caller gave us, but...
> 
> "chronological order within the packs themselves" confuses me. I think
> that you mean ordering objects within a pack by their offsets. If so,
> then yes: this gives you the oldest pack first (and all of its objects
> in their original order), then the second oldest (and all of its
> objects) and so on.
> 
> Could you clarify a bit how you'd expect to sort the objects in two
> packs?

Yes, by "within the packs themselves" I meant the physical order of
objects within an individual pack (sorted by their offsets, as we'd get
from for_each_object_in_pack). We would generally expect that to be
"newest first" within a given pack (modulo some other heuristics, but we
generally follow traversal order from rev-list).

So if the packs themselves are in oldest-first order, won't that create
a weird discontinuity at the pack boundaries?

E.g., imagine we have a linear sequence of commits A..Z in chronological
order, stored in two packs of equal size. Something like:

  tick=1234567890
  commit() {
    tick=$((tick+10))
    export GIT_COMMITTER_DATE="@$tick +0000"
    git commit --allow-empty -m $1
  }

  for i in $(perl -le 'print for A..M'); do commit $i; done
  git repack -d
  sleep 5
  for i in $(perl -le 'print for N..Z'); do commit $i; done
  git repack -d

Since "repack -d" will use a traversal to decide which objects to pack,
the two packs will have their commits in reverse chronological order:
M..A and Z..N. You can verify that with:

  for idx in $(ls -rt .git/objects/pack/*.idx); do
    stat --format='==> %y %n' $idx
    git show-index <$idx |
    sort -n |
    awk '{print $2}' |
    git --no-pager log --no-walk=unsorted --stdin --format=%s
  done

And if we then ran "git repack -ad" to make a new pack, it would be in
newest-to-oldest Z..A order.

But if instead we concatenate the packs after sorting them in
oldest-first order, we'll end up with a pack that contains M..A, then
Z..N. We instead want newest packs first (and then newest objects within
that pack, which is the pack order), then oldest.

In other words, I think your comparison function should be reversed
(return "1" when a->mtime < b->mtime).

(Of course these orders aren't perfect; in a real pack you'd have
non-commit objects, and we'd tweak the write order to keep delta
families together, etc. But our "best guess" should keep packs and
objects-within-packs consistent in newest-first order).

-Peff
