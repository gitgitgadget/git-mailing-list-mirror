Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BECDC433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 18:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382975AbiEMSTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 14:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381541AbiEMSTM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 14:19:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699DB239D9C
        for <git@vger.kernel.org>; Fri, 13 May 2022 11:19:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8956D1A366A;
        Fri, 13 May 2022 14:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K790DjxAjz8N7sejJhfgFJOfpwXd+kjvMpb+Un
        kdoJA=; b=o8I14WJWlX0FZkx2UjhNPAuGZsXn2XZ+RUsgHoKPocy6FVun0nxhYm
        i6ub0+NeETJbj65RrGESVZ/SJgImQatBrajjmhm3L74+fSeoOzqEl/ZQpTrsD5D0
        gNaSlBiPZczC4LZXxQxUehuJx0R+jPJtF0EeQBWxtcGePWLU7bINU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 819A21A3669;
        Fri, 13 May 2022 14:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29C1C1A3668;
        Fri, 13 May 2022 14:19:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com
Subject: Re: [PATCH 1/2] pack-bitmap: check preferred pack validity when
 opening MIDX bitmap
References: <cover.1652458395.git.me@ttaylorr.com>
        <06eca1fba9d2597906ec342c51ba2bb5c4fde0e4.1652458395.git.me@ttaylorr.com>
Date:   Fri, 13 May 2022 11:19:05 -0700
In-Reply-To: <06eca1fba9d2597906ec342c51ba2bb5c4fde0e4.1652458395.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 13 May 2022 12:23:17 -0400")
Message-ID: <xmqqpmkh9tye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D5C3384-D2E9-11EC-A4CB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The pack bitmap code does this, too, since prior to bab919bd44
> (pack-bitmap: check pack validity when opening bitmap, 2015-03-26) it
> was vulnerable to the same race.

That might be a GitHub internal reference to some other commit?
dc1daacd (pack-bitmap: check pack validity when opening bitmap,
2021-07-23) is what I found.

> The MIDX bitmap code does not do this, and is vulnerable to the same
> race. Apply the same treatment as bab919bd44 to the routine responsible
> for opening multi-pack bitmaps to close this race.

Same reference here and ...

> Similar to bab919bd44, we could technically just add this check in

... here.  But the solution in dc1daacd is quite different from what
we see here in the posted patch, so perhaps you are referring to
something different.  I dunno.

The call graph around the functions involved is

  prepare_midx_bitmap_git()
   -> open_midx_bitmap_1()
      * opens, mmaps and closes bitmap file
      -> load_midx_revindex()
   -> load_bitmap()
      -> load_reverse_index()
         -> prepare_midx_pack()
         -> load_pack_revindex()

And prepare_midx_pack() for these packs is moved from
load_reverse_index() to open_midx_bitmap_1() in this patch.

In addition, after doing so, we call is_pack_valid() on the single
preferred pack and return failure.

Because load_bitmap() or load_reverse_index() cannot be done before
you do open_midx_bitmap_1(), calling prepare_midx_pack() early will
end up calling add_packed_git() on underlying packs, allowing us to
access them even when somebody else removed them from the disk?  Is
that the idea?

> reuse_partial_packfile_from_bitmap(), since it's technically possible to
> use a MIDX .bitmap without needing to open any of its packs. But it's
> simpler to do the check as early as possible, covering all direct uses
> of the preferred pack. Note that doing this check early requires us to
> call prepare_midx_pack() early, too, so move the relevant part of that
> loop from load_reverse_index() into open_midx_bitmap_1().

OK.  That matches my observation above, I guess.  I do not quite get
why it is sufficient to check only the preferred one, though.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 97909d48da..6b1a43d99c 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -315,6 +315,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  	struct stat st;
>  	char *idx_name = midx_bitmap_filename(midx);
>  	int fd = git_open(idx_name);
> +	uint32_t i;
> +	struct packed_git *preferred;
>  
>  	free(idx_name);
>  
> @@ -353,6 +355,21 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  		warning(_("multi-pack bitmap is missing required reverse index"));
>  		goto cleanup;
>  	}
> +
> +	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> +		if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
> +			die(_("could not open pack %s"),
> +			    bitmap_git->midx->pack_names[i]);
> +	}
> +
> +	preferred = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
> +	if (!is_pack_valid(preferred)) {
> +		close(fd);

This close() does not look correct.  After calling xmmap() to map
the bitmap file to bitmap_git->map, we do not need the underlying
file descriptor in order to use the contents of the file.  We have
closed it already at this point.

> +		warning(_("preferred pack (%s) is invalid"),
> +			preferred->pack_name);
> +		goto cleanup;
> +	}
> +
>  	return 0;
>  
>  cleanup:
> @@ -429,8 +446,6 @@ static int load_reverse_index(struct bitmap_index *bitmap_git)
>  		 * since we will need to make use of them in pack-objects.
>  		 */
>  		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> -			if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
> -				die(_("load_reverse_index: could not open pack"));
>  			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
>  			if (ret)
>  				return ret;
