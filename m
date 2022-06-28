Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D619C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiF1SER (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiF1SEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 14:04:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F191BE84
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 11:04:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12FD01970A8;
        Tue, 28 Jun 2022 14:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0UOIR/6JxTXZIIW7FwvBqlThd2PbDn3dLJxpbu
        nJOXY=; b=yC9D3IGbsH8D14FEvrw6gazHfXRvHtW2J/y2QgQxOCj1g9sONkoQM+
        b8m5Vl3aHwqS8bQn0xVu/iatE3Oh/AH3wZUQRdKm0vw5zCK5LyVGPcaGqhJ+mk0d
        ESRPAih+jk+GJmB6fOj0xfRFwY6WuZFJ6T6Vlef0RYaLMxUPsoqMU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09EE11970A7;
        Tue, 28 Jun 2022 14:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 889561970A6;
        Tue, 28 Jun 2022 14:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, git@jeffhostetler.com
Subject: Re: [PATCH v5 3/5] pack-bitmap.c: using error() instead of silently
 returning -1
References: <cover.1656403084.git.dyroneteng@gmail.com>
        <82d4493a6ee7d18063e0feb72d0bc1cc450f2682.1656403084.git.dyroneteng@gmail.com>
Date:   Tue, 28 Jun 2022 11:04:09 -0700
In-Reply-To: <82d4493a6ee7d18063e0feb72d0bc1cc450f2682.1656403084.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 28 Jun 2022 16:17:48 +0800")
Message-ID: <xmqqmtdwk6li.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5F0D0AA-F70C-11EC-8C46-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>  	if (fstat(fd, &st)) {
>  		close(fd);
> -		return -1;
> +		return error_errno(_("cannot stat bitmap file"));

"stat" -> "fstat" perhaps?

Not a new problem, but before this hunk, we have

	fd = git_open(...);
	if (fd < 0)
		return -1;

where it probably is legitimate to ignore ENOENT silently.  In
practice, it may be OK to treat a file that exists but cannot be
opened for whatever reason, but I do not think it would hurt to
report such a rare anomaly with a warning, e.g.

	if (fd < 0) {
		if (errno != ENOENT)
			warning("'%s' cannot open '%s'",
				strerror(errno), bitmap_name);
		free(bitmap_name);
		return -1;
	}

or something like that perhaps.

> @@ -361,7 +361,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  	bitmap_git->map_pos = 0;
>  	bitmap_git->map = NULL;
>  	bitmap_git->midx = NULL;
> -	return -1;
> +	return error(_("cannot open midx bitmap file"));

This is not exactly "cannot open".  We opened the file, and found
there was something we do not like in it.  If we failed to find midx
lacks revindex chunk, we already would have given a warning, and the
error is not just misleading but is redundant.  load_bitmap_header()
also gives an error() on its own.

I think this patch aims for a good end result, but needs more work.
At least, checksum mismatch that goes to cleanup also needs to issue
its own error() and then we can remove this "cannot open" at the end.

> @@ -382,7 +382,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  
>  	if (fstat(fd, &st)) {
>  		close(fd);
> -		return -1;
> +		return error_errno(_("cannot stat bitmap file"));

"stat" -> "fstat"

> @@ -394,7 +394,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  
>  	if (!is_pack_valid(packfile)) {
>  		close(fd);
> -		return -1;
> +		return error(_("packfile is invalid"));

Same "sometimes redundant" comment applies here, but not due to this
part of the code but due to the helpers called from is_pack_valid().

Namely, packfile.c::open_packed_git_1() is mostly chatty, but is
silent upon "unable to open" and "unable to fstat" (which I think is
safe to make chatty as well---we do not want to special case ENOENT
in open_packed_git(), so "cannot open because it is not there" is an
error).

And then, this "invalid" will become redundant and fuzzier message
than what is_pack_valid() would have already given, so you can leave
it to silently return -1 here.

> @@ -409,7 +409,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  		bitmap_git->map_size = 0;
>  		bitmap_git->map_pos = 0;
>  		bitmap_git->pack = NULL;
> -		return -1;
> +		return error(_("bitmap header is invalid"));

Having shown how to analize these kind of things twice in the above,
I would not bother checking myself, but you should look at the
existing error messages from load_bitmap_header() and see if this
extra message should really be here.  I suspect not.

>  	}
>  
>  	return 0;
