Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625301F463
	for <e@80x24.org>; Fri, 13 Sep 2019 22:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404053AbfIMW3I (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 18:29:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55198 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404009AbfIMW3I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 18:29:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AAFB770AB;
        Fri, 13 Sep 2019 18:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XoejsZ7p8wGY7UX8m04emyRzvSA=; b=cymPaO
        R0ZN5opKVEmEG9Dh/DDxFt7ySHOIeJ1ZQpB6F32R2H0who5CYuUpoPAtbfIdQk1T
        akv2aSwR3nV4lLLjP/Qcc6bAqCBMgvPjLJPNhz2bPqgwWRZNPLikyXU4hXVlpzA3
        xdMZQ/CHbKGRPsqQrPp8MC9BG1tT2RdQoVpq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jyH9Hrphnr3MFW0IiUXIKbBAW7y0UXvu
        gNCQ7mLR/wXkJF9zMble2JsamhojWm/DzzubV/5WBqqb8KRvIxIFkytWGe3gdPMv
        OLhZBRdV2Tdfju4qKwnOI9s7tJLGcO8BN3sCOryVY/xA0ibxKqYqrmXMSehg7oc6
        yiQI+6bcIVA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27300770A9;
        Fri, 13 Sep 2019 18:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA168770A7;
        Fri, 13 Sep 2019 18:29:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
        <20190913130226.7449-11-chriscool@tuxfamily.org>
Date:   Fri, 13 Sep 2019 15:29:00 -0700
In-Reply-To: <20190913130226.7449-11-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 13 Sep 2019 15:02:26 +0200")
Message-ID: <xmqq7e6bde4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E37F2946-D675-11E9-BF98-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +/*
> + * Record the offsets needed in our reused packfile chunks due to
> + * "gaps" where we omitted some objects.
> + */

The meaning of 'start' and 'offset' is unclear from the first
reading.  Is it "starting offset" and "for how many bytes the region
lasts"?  If so, 'offset', which is usually a location (unless you
always measure from the beginning, in which case you could say it
names the byte-size of a region), may be a misnomer (side note: I'll
pretend that I haven't realized the 'offset' may be the end offset
of a region for now---this is a good illustration why a better
comment should be here anyway ;-).

> +static struct reused_chunk {
> +	off_t start;
> +	off_t offset;
> +} *reused_chunks;
> +static int reused_chunks_nr;
> +static int reused_chunks_alloc;
> +
> +static void record_reused_object(off_t where, off_t offset)

And here, 'start' is called 'where'; either is a good word for a
location; we'd want to pick either one to be consistent, perhaps?

>  {
> -	unsigned char buffer[8192];
> -	off_t to_write, total;
> -	int fd;
> +	if (reused_chunks_nr && reused_chunks[reused_chunks_nr-1].offset == offset)
> +		return;

The reason why the above code works is because this function will
always be called in the ascending order of the 'offset'?

Hmmm, perhaps 'offset' is not a region-size after all.  Is it the
end offset, as opposed to 'start' which is the starting offset, and
the two offsets sandwitch a region?

> -	if (!is_pack_valid(reuse_packfile))
> -		die(_("packfile is invalid: %s"), reuse_packfile->pack_name);
> +	ALLOC_GROW(reused_chunks, reused_chunks_nr + 1,
> +		   reused_chunks_alloc);
> +	reused_chunks[reused_chunks_nr].start = where;
> +	reused_chunks[reused_chunks_nr].offset = offset;
> +	reused_chunks_nr++;
> +}
>  
> -	fd = git_open(reuse_packfile->pack_name);
> -	if (fd < 0)
> -		die_errno(_("unable to open packfile for reuse: %s"),
> -			  reuse_packfile->pack_name);
> +/*
> + * Binary search to find the chunk that "where" is in. Note
> + * that we're not looking for an exact match, just the first
> + * chunk that contains it (which implicitly ends at the start
> + * of the next chunk.
> + */
> +static off_t find_reused_offset(off_t where)
> +{
> +	int lo = 0, hi = reused_chunks_nr;
> +	while (lo < hi) {
> +		int mi = lo + ((hi - lo) / 2);
> +		if (where == reused_chunks[mi].start)
> +			return reused_chunks[mi].offset;
> +		if (where < reused_chunks[mi].start)
> +			hi = mi;
> +		else
> +			lo = mi + 1;
> +	}
>  
> -	if (lseek(fd, sizeof(struct pack_header), SEEK_SET) == -1)
> -		die_errno(_("unable to seek in reused packfile"));
> +	/*
> +	 * The first chunk starts at zero, so we can't have gone below
> +	 * there.
> +	 */
> +	assert(lo);
> +	return reused_chunks[lo-1].offset;
> +}

This comment has nothing to do with the change, but the way the
patch is presented is quite hard to follow, in that the preimage or
the common context lines do not help understand what the new code is
doing at all ;-)

I'll come back to the remainder of the patch later.  Thanks.
