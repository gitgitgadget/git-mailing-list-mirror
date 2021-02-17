Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95CDC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6EC64DFF
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhBQQGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 11:06:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:35772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233568AbhBQQGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 11:06:04 -0500
Received: (qmail 18835 invoked by uid 109); 17 Feb 2021 16:05:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 16:05:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5426 invoked by uid 111); 17 Feb 2021 16:05:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 11:05:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 11:05:22 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 6/8] builtin/pack-objects.c: rewrite honor-pack-keep
 logic
Message-ID: <YC0+wlRksoqm0xLO@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <c3868c7df92484f0527ce500ad1156275be334e8.1612411124.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3868c7df92484f0527ce500ad1156275be334e8.1612411124.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:59:17PM -0500, Taylor Blau wrote:

> @@ -1209,22 +1210,73 @@ static int want_found_object(int exclude, struct packed_git *p)
>  	 * Otherwise, we signal "-1" at the end to tell the caller that we do
>  	 * not know either way, and it needs to check more packs.
>  	 */
> -	if (!ignore_packed_keep_on_disk &&
> -	    !ignore_packed_keep_in_core &&
> -	    (!local || !have_non_local_packs))
> +
> +	/*
> +	 * Handle .keep first, as we have a fast(er) path there.
> +	 */
> +	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core) {
> +		/*
> +		 * Set the flags for the kept-pack cache to be the ones we want
> +		 * to ignore.
> +		 *
> +		 * That is, if we are ignoring objects in on-disk keep packs,
> +		 * then we want to search through the on-disk keep and ignore
> +		 * the in-core ones.
> +		 */
> +		unsigned flags = 0;
> +		if (ignore_packed_keep_on_disk)
> +			flags |= ON_DISK_KEEP_PACKS;
> +		if (ignore_packed_keep_in_core)
> +			flags |= IN_CORE_KEEP_PACKS;
> +
> +		if (ignore_packed_keep_on_disk && p->pack_keep)
> +			return 0;
> +		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
> +			return 0;
> +		if (has_object_kept_pack(oid, flags))
> +			return 0;
> +	}
> +
> +	/*
> +	 * At this point we know definitively that either we don't care about
> +	 * keep-packs, or the object is not in one. Keep checking other
> +	 * conditions...
> +	 */
> +
> +	if (!local || !have_non_local_packs)
>  		return 1;
> -
>  	if (local && !p->pack_local)
>  		return 0;
> -	if (p->pack_local &&
> -	    ((ignore_packed_keep_on_disk && p->pack_keep) ||
> -	     (ignore_packed_keep_in_core && p->pack_keep_in_core)))
> -		return 0;
>  
>  	/* we don't know yet; keep looking for more packs */
>  	return -1;

I know I wrote this patch, but just looking it over again with a
critical eye: it looks like more re-ordering could avoid work in some
cases.

In particular, has_object_kept_pack() is a potentially expensive call.
But if "(local && !p->pack_local)" is true, then we could cheaply exit
the function with "0", regardless of what the keep requirement says.

That's not a case that I think anybody cares that deeply about (and it
certainly is not covered by t/perf). But I think it does regress in this
patch. Prior to the patch, we'd check that condition before returning
-1, and it was the caller who would then continue to search through all
the kept packs. Now we do it preemptively.

I think just bumping that:

  if (local && !p->pack_local)
	return 0;

above the new code would fix it. Or to lay out the logic more fully, the
order of checks should be:

  - does _this_ pack we found the object in disqualify it. If so, we can
    cheaply return 0. And that applies to both keep and local rules.

  - otherwise, check all packs via has_object_kept_pack(), which is
    cheaper than continuing to iterate through all packs by returning
    -1.

  - once we know definitively about keep-packs, then check any shortcuts
    related to local packs (like !have_non_local_packs)

  - and then if no shortcuts, we return -1

I think that might be easier to express by rewriting the patch. :)

-Peff
