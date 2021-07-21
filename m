Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8495C636C9
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 10:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC30C6120C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhGUJWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 05:22:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52916 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238236AbhGUJKN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:10:13 -0400
Received: (qmail 1753 invoked by uid 109); 21 Jul 2021 09:50:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 09:50:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2716 invoked by uid 111); 21 Jul 2021 09:50:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 05:50:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 05:50:43 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <YPft87yCjR9e+93E@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:01PM -0400, Taylor Blau wrote:

> The set of objects covered by a bitmap must be closed under
> reachability, since it must be the case that there is a valid bit
> position assigned for every possible reachable object (otherwise the
> bitmaps would be incomplete).
> 
> Pack bitmaps are never written from 'git repack' unless repacking
> all-into-one, and so we never write non-closed bitmaps (except in the
> case of partial clones where we aren't guaranteed to have all objects).
> 
> But multi-pack bitmaps change this, since it isn't known whether the
> set of objects in the MIDX is closed under reachability until walking
> them. Plumb through a bit that is set when a reachable object isn't
> found.
> 
> As soon as a reachable object isn't found in the set of objects to
> include in the bitmap, bitmap_writer_build() knows that the set is not
> closed, and so it now fails gracefully.

Leaving aside your intended use here, I think it's nice to get rid of a
deep-buried die() like this in general.

The amount of error-plumbing you had to do is a little unpleasant, but I
think is unavoidable. The only non-obvious part was this hunk:

> @@ -463,8 +488,11 @@ void bitmap_writer_build(struct packing_data *to_pack)
>  		struct commit *child;
>  		int reused = 0;
>  
> -		fill_bitmap_commit(ent, commit, &queue, &tree_queue,
> -				   old_bitmap, mapping);
> +		if (fill_bitmap_commit(ent, commit, &queue, &tree_queue,
> +				       old_bitmap, mapping) < 0) {
> +			closed = 0;
> +			break;
> +		}
>  
>  		if (ent->selected) {
>  			store_selected(ent, commit);

This is the right thing to do because we still want to free memory, stop
progress, etc. I gave a look over what will run after breaking out of
the loop, and compute_xor_offsets(), which you already handled, is the
only thing we'd want to avoid running. Good.

-Peff
