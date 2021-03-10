Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DC2C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812A864FAF
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhCJVBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:01:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:59184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232413AbhCJVAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 16:00:51 -0500
Received: (qmail 7014 invoked by uid 109); 10 Mar 2021 21:00:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 21:00:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25841 invoked by uid 111); 10 Mar 2021 21:00:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 16:00:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 16:00:49 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 4/5] builtin/repack.c: be more conservative with unsigned
 overflows
Message-ID: <YEkzgeuqkgF4RvaF@coredump.intra.peff.net>
References: <cover.1614957681.git.me@ttaylorr.com>
 <d55324f7a256fce491a29a1debf142f817eb01d3.1614957681.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d55324f7a256fce491a29a1debf142f817eb01d3.1614957681.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 10:21:56AM -0500, Taylor Blau wrote:

> There are a number of places in the geometric repack code where we
> multiply the number of objects in a pack by another unsigned value. We
> trust that the number of objects in a pack is always representable by a
> uint32_t, but we don't necessarily trust that that number can be
> multiplied without overflow.
> 
> Sprinkle some unsigned_add_overflows() and unsigned_mult_overflows() in
> split_pack_geometry() to check that we never overflow any unsigned types
> when adding or multiplying them.
> 
> Arguably these checks are a little too conservative, and certainly they
> do not help the readability of this function. But they are serving a
> useful purpose, so I think they are worthwhile overall.

Hmm. My initial reaction was: how close might we reasonably come to the
limit? Packfiles are limited to uint32_t, and:

  - you'd have a pretty hard time approaching that; pack-objects needs
    at least 100 bytes of heap per object for its internal book-keeping.
    So you're looking at 200GB-400GB of RAM to generate such a packfile.

  - I'm pretty sure the rest of the repack code would die horribly and
    unpredictably if it were allowed to have that much RAM.

Which isn't an argument against such protections, but I wonder if it
might give people a false sense that we are in any way prepared for
repositories of this scale.

However, at least one of these looks to be multiplying the user-provided
scale factor. I can't imagine a scale factor beyond "2" is all that
useful, but conceptually somebody could provide a big number there.

Looking at the code, though...

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 21a5778e73..677c6b75c1 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -363,6 +363,12 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
>  	for (i = geometry->pack_nr - 1; i > 0; i--) {
>  		struct packed_git *ours = geometry->pack[i];
>  		struct packed_git *prev = geometry->pack[i - 1];
> +
> +		if (unsigned_mult_overflows(factor, geometry_pack_weight(prev)))
> +			die(_("pack %s too large to consider in geometric "
> +			      "progression"),
> +			    prev->pack_name);

This says "unsigned_mult_overflows", but "factor" is a signed int. This
will generally be cast to unsigned in the actual multiplication, but it
depends on the size of the operands.

If int is larger than uint32_t, we'd do the multiplication as a signed
int. But the overflow check would be against an unsigned int (since our
macro only looks at the type of the first argument). So it would be
overly permissive with the final bit. I suspect it would also be wrong
if "factor" is negative.

If int is smaller than 32 bits, then we'd be too conservative (it would
get promoted to uint32_t for the actual multiplication). Also, you
should get a better computer in that case.

It's probably OK in practice, as int tends to just be 32 bits. But if
the point is to be careful, we should probably just take "factor" as a
uint32_t in the first place.

> @@ -388,11 +394,25 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
>  	 * packs in the heavy half need to be joined into it (if any) to restore
>  	 * the geometric progression.
>  	 */
> -	for (i = 0; i < split; i++)
> -		total_size += geometry_pack_weight(geometry->pack[i]);
> +	for (i = 0; i < split; i++) {
> +		struct packed_git *p = geometry->pack[i];
> +
> +		if (unsigned_add_overflows(total_size, geometry_pack_weight(p)))
> +			die(_("pack %s too large to roll up"), p->pack_name);
> +		total_size += geometry_pack_weight(p);
> +	}

This one seems even less likely to overflow. total_size is an off_t, so
unless you're on a really lame system, we should be able to fit a lot of
uint32_t's in there.

(It actually feels a little weird for it to be an off_t in the first
place; we're still dealing in units of "number of objects", which the
rest of Git generally considers to be in the realm of a uint32_t).

>  	for (i = split; i < geometry->pack_nr; i++) {
>  		struct packed_git *ours = geometry->pack[i];
> +
> +		if (unsigned_mult_overflows(factor, total_size))
> +			die(_("pack %s too large to roll up"), ours->pack_name);

This one is wrong in the same way as the earlier multiplication, except
this time we're pretty sure that total_size actually is much bigger. So
we'll complain about overflowing an int, but the multiplication will
actually be done as an off_t. And of course it has the same problems
with negative values.

Should total_size just be a uint32_t? Or perhaps any of these factor
multiplication results should just be uint64_t, which would be the
obviously-large-enough type. Then you wouldn't have these ugly overflow
checks. :)

-Peff
