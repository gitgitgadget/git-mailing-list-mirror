Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EFAC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCUSNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCUSNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:13:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9426AE1A7
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:13:17 -0700 (PDT)
Received: (qmail 28410 invoked by uid 109); 21 Mar 2023 18:13:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 18:13:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2643 invoked by uid 111); 21 Mar 2023 18:13:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 14:13:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 14:13:15 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 6/6] pack-bitmap.c: factor out
 `bitmap_index_seek_commit()`
Message-ID: <20230321181315.GH3119834@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <82049ed09e1695db644d1d4cf17557214e54dcea.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82049ed09e1695db644d1d4cf17557214e54dcea.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 04:02:55PM -0400, Taylor Blau wrote:

> Factor out a common pattern within `lazy_bitmap_for_commit()` where we
> seek to a given position (expecting to read the start of an individual
> bitmap entry).
> 
> Both spots within `lazy_bitmap_for_commit()` emit a common error, so
> factor out the whole routine into its own function to DRY things up a
> little.

OK, so this case makes more sense to me as a bounds-check, because we
are seeking to an arbitrary offset.

But...

> +static int bitmap_index_seek_commit(struct bitmap_index *bitmap_git,
> +				     struct object_id *oid,
> +				     size_t pos)
> +{
> +	const int bitmap_header_size = 6;
> +
> +	bitmap_index_seek(bitmap_git, pos, SEEK_SET);
> +
> +	if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size)
> +		return error(_("corrupt ewah bitmap: truncated header for "
> +			       "bitmap of commit \"%s\""),
> +			oid_to_hex(oid));
> +	return 0;
> +}

So here we seek to the position, and then make sure we have 6 bytes to
read, which makes sense. But in the seek step, are we worried that we
will seek to somewhere bogus? If so, we'll get a BUG(). But is that the
right thing if somebody feeds a bogus "pos" that moves past truncation?

I'm not 100% sure on where these offsets come from. But it looks like
they're coming from the bitmap lookup table. In which case a bogus value
there should be an error(), and not a BUG(), I would think.

-Peff
