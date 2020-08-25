Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11566C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 02:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD7A20738
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 02:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgHYC0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:26:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:39418 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgHYC0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 22:26:18 -0400
Received: (qmail 26374 invoked by uid 109); 25 Aug 2020 02:26:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 02:26:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20818 invoked by uid 111); 25 Aug 2020 02:26:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2020 22:26:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Aug 2020 22:26:14 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825022614.GA1391422@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 24, 2020 at 10:01:04PM -0400, Taylor Blau wrote:

> In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
> learned to remove a multi-pack-index file if it added or removed a pack
> from the object store.
> 
> This mechanism is a little over-eager, since it is only necessary to
> drop a MIDX if 'git repack' removes a pack that the MIDX references.
> Adding a pack outside of the MIDX does not require invalidating the
> MIDX, and likewise for removing a pack the MIDX does not know about.

Does "git repack" ever remove just one pack? Obviously "git repack -ad"
or "git repack -Ad" is going to pack everything and delete the old
packs. So I think we'd want to remove a midx there.

And "git repack -d" I think of as deleting only loose objects that we
just packed. But I guess it could also remove a pack that has now been
made redundant? That seems like a rare case in practice, but I suppose
is possible.

Not exactly related to your fix, but kind of the flip side of it: would
we ever need to retain a midx that mentions some packs that still exist?

E.g., imagine we have a midx that points to packs A and B, and
git-repack deletes B. By your logic above, we need to remove the midx
because now it points to objects in B which aren't accessible. But by
deleting it, could we be deleting the only thing that mentions the
objects in A?

I _think_ the answer is "no", because we never went all-in on midx and
allowed deleting the matching .idx files for contained packs. So we'd
still have that A.idx, and we could just use the pack as normal. But
it's an interesting corner case if we ever do go in that direction.

If you'll let me muse a bit more on midx-lifetime issues (which I've
never really thought about before just now):

I'm also a little curious how bad it is to have a midx whose pack has
gone away. I guess we'd answer queries for "yes, we have this object"
even if we don't, which is bad. Though in practice we'd only delete
those packs if we have their objects elsewhere. And the pack code is
pretty good about retrying other copies of objects that can't be
accessed. Alternatively, I wonder if the midx-loading code ought to
check that all of the constituent packs are available.

In that line of thinking, do we even need to delete midx files if one of
their packs goes away? The reading side probably ought to be able to
handle that gracefully.

And the more interesting case is when you repack everything with "-ad"
or similar, at which point you shouldn't even need to look up what's in
the midx to see if you deleted its packs. The point of your operation is
to put it all-into-one, so you know the old midx should be discarded.

> Teach 'git repack' to check for this by loading the MIDX, and checking
> whether the to-be-removed pack is known to the MIDX. This requires a
> slightly odd alternation to a test in t5319, which is explained with a
> comment.

My above musings aside, this seems like an obvious improvement.

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 04c5ceaf7e..98fac03946 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -133,7 +133,11 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
> +	struct multi_pack_index *m = get_multi_pack_index(the_repository);
> +	strbuf_addf(&buf, "%s.pack", base_name);
> +	if (m && midx_contains_pack(m, buf.buf))
> +		clear_midx_file(the_repository);
> +	strbuf_insertf(&buf, 0, "%s/", dir_name);

Makes sense. midx_contains_pack() is a binary search, so we'll spend
O(n log n) effort deleting the packs (I wondered if this might be
accidentally quadratic over the number of packs).

And after we clear, "m" will be NULL, so we'll do it at most once. Which
is why you can get rid of the manual "midx_cleared" flag from the
preimage.

So the patch looks good to me.

-Peff
