Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B1C7619A
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCUSFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjCUSFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:05:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E18E298E3
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:05:27 -0700 (PDT)
Received: (qmail 28314 invoked by uid 109); 21 Mar 2023 18:05:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 18:05:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2551 invoked by uid 111); 21 Mar 2023 18:05:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 14:05:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 14:05:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 5/6] pack-bitmap.c: use `bitmap_index_seek()` where
 possible
Message-ID: <20230321180525.GG3119834@coredump.intra.peff.net>
References: <cover.1679342296.git.me@ttaylorr.com>
 <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 04:02:52PM -0400, Taylor Blau wrote:

> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -174,7 +174,7 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
>  		return NULL;
>  	}
>  
> -	index->map_pos += bitmap_size;
> +	bitmap_index_seek(index, bitmap_size, SEEK_CUR);
>  	return b;

As an aside, I notice none of the callers here or in the next patch
check the return value of bitmap_index_seek(). I guess you included it
to match the return value of lseek(), but maybe it is better to return
void if nobody is looking at it.

But getting back to the bounds-checking: I think we are already
correctly bounds-checked here, because ewah_read_mmap() will make sure
that it doesn't read too far (and will return an error if there's
truncation). And if it didn't, this check-on-seek doesn't help us,
because we'll already have done out-of-bounds reads.

> @@ -230,7 +230,7 @@ static int load_bitmap_header(struct bitmap_index *index)
>  
>  	index->entry_count = ntohl(header->entry_count);
>  	index->checksum = header->checksum;
> -	index->map_pos += header_size;
> +	bitmap_index_seek(index, header_size, SEEK_CUR);
>  	return 0;
>  }

Likewise this function already has bounds checks at the top:

	if (index->map_size < header_size + the_hash_algo->rawsz)
		return error(_("corrupted bitmap index (too small)"));

I'd be perfectly happy if we swapped that our for checking the bounds on
individual reads, but the extra checking in the seek step here just
seems redundant (and again, too late).

> @@ -269,13 +269,15 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
>  static uint32_t read_be32(struct bitmap_index *bitmap_git)
>  {
>  	uint32_t result = get_be32(bitmap_git->map + bitmap_git->map_pos);
> -	bitmap_git->map_pos += sizeof(result);
> +	bitmap_index_seek(bitmap_git, sizeof(uint32_t), SEEK_CUR);
>  	return result;
>  }

The function doesn't do bounds-checks itself, but the callers do, like:

                if (index->map_size - index->map_pos < 6)
                        return error(_("corrupt ewah bitmap: truncated header for entry %d"), i);

                commit_idx_pos = read_be32(index->map, &index->map_pos);
                xor_offset = read_u8(index->map, &index->map_pos);
                flags = read_u8(index->map, &index->map_pos);

(and again, I'd be happy to see this magic "6" go away in favor of
checking as we read each item).

Maybe I'm misunderstanding the purpose of your series. I thought it was
to avoid reading out of bounds. But since bitmap_index_seek() triggers a
BUG(), it's not good for detecting truncated files, etc. So is it really
just meant to be a belt-and-suspenders check on the existing
bounds-checks? I guess that makes more sense with the way it is written,
but I'm just a little skeptical that it's really useful.

-Peff
