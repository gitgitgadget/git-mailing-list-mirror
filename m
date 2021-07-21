Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A7C63793
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D707D60FED
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhGUKqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:46:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:53054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239288AbhGUJyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:54:08 -0400
Received: (qmail 2059 invoked by uid 109); 21 Jul 2021 10:34:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:34:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3277 invoked by uid 111); 21 Jul 2021 10:34:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:34:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:34:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 09/24] midx: infer preferred pack when not given one
Message-ID: <YPf4MTDpbvinoIia@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <9495f6869d792264c4366c9914fcf93d544caa6a.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9495f6869d792264c4366c9914fcf93d544caa6a.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:21PM -0400, Taylor Blau wrote:

> In 9218c6a40c (midx: allow marking a pack as preferred, 2021-03-30), the
> multi-pack index code learned how to select a pack which all duplicate
> objects are selected from. That is, if an object appears in multiple
> packs, select the copy in the preferred pack before breaking ties
> according to the other rules like pack mtime and readdir() order.
> 
> Not specifying a preferred pack can cause serious problems with
> multi-pack reachability bitmaps, because these bitmaps rely on having at
> least one pack from which all duplicates are selected. Not having such a
> pack causes problems with the pack reuse code (e.g., like assuming that
> a base object was sent from that pack via reuse when in fact the base
> was selected from a different pack).

It might be helpful to use a more descriptive name for "pack reuse code"
here, since it's kind of vague for people who have not been actively
working on bitmaps.

I don't have a short name for that chunk of code, but maybe:

  ...causes problems with the code in pack-objects to reuse packs
  verbatim (e.g., that code assumes that a delta object in a chunk of
  pack sent verbatim will have its base object sent from the same pack).

> So why does not marking a pack preferred cause problems here? The reason
> is roughly as follows:
> 
>   - Ties are broken (when handling duplicate objects) by sorting
>     according to midx_oid_compare(), which sorts objects by OID,
>     preferred-ness, pack mtime, and finally pack ID (more on that
>     later).
> 
>   - The psuedo pack-order (described in
>     Documentation/technical/bitmap-format.txt) is computed by
>     midx_pack_order(), and sorts by pack ID and pack offset, with
>     preferred packs sorting first.

I think the .rev description in pack-format.txt may be a better
reference here.

>   - But! Pack IDs come from incrementing the pack count in
>     add_pack_to_midx(), which is a callback to
>     for_each_file_in_pack_dir(), meaning that pack IDs are assigned in
>     readdir() order.
> 
> When specifying a preferred pack, all of that works fine, because
> duplicate objects are correctly resolved in favor of the copy in the
> preferred pack, and the preferred pack sorts first in the object order.
> 
> "Sorting first" is critical, because the bitmap code relies on finding
> out which pack holds the first object in the MIDX's pseudo pack-order to
> determine which pack is preferred.
> 
> But if we didn't specify a preferred pack, and the pack which comes
> first in readdir() order does not also have the lowest timestamp, then
> it's possible that that pack (the one that sorts first in pseudo-pack
> order, which the bitmap code will treat as the preferred one) did *not*
> have all duplicate objects resolved in its favor, resulting in breakage.
> 
> The fix is simple: pick a (semi-arbitrary) preferred pack when none was
> specified. This forces that pack to have duplicates resolved in its
> favor, and (critically) to sort first in pseudo-pack order.
> Unfortunately, testing this behavior portably isn't possible, since it
> depends on readdir() order which isn't guaranteed by POSIX.

This explanation is rather confusing, but I'm not sure if we can do much
better. I followed all of it, because I was there when we found the bug
that this is fixing. And of course that happened _after_ we implemented
midx bitmaps and in particular adapted the verbatim reuse stuff in
pack-objects to make use of it.

I see why you'd want to float the fix up before then, so we don't ever
have the broken state. But it's hard to understand what bug this is
fixing, because the bug does not even exist yet at this point in
the series!

I dunno. Like I said, I was able to follow it, so maybe it is
sufficient. I'm just not sure others would be able to.

> +
> +		if (!found)
> +			warning(_("unknown preferred pack: '%s'"),
> +				preferred_pack_name);
> +	} else if (ctx.nr && (flags & MIDX_WRITE_REV_INDEX)) {
> +		time_t oldest = ctx.info[0].p->mtime;
> +		ctx.preferred_pack_idx = 0;
> +
> +		if (packs_to_drop && packs_to_drop->nr)
> +			BUG("cannot write a MIDX bitmap during expiration");

Likewise, this BUG() feels somewhat out-of-place. At this point in the
series, we don't have bitmaps yet. :)

I can live with that, though. And I don't want to make a lot of work by
trying to re-order this patch within the series. Mostly I want to make
sure that if somebody stumbles on this commit via git-log or in a
bisection, that they can make some sense of what it's trying to do.

-Peff
