Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED15C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 23:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiAUXj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 18:39:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50862 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiAUXj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 18:39:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46CB3101F71;
        Fri, 21 Jan 2022 18:39:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=flaXY87otlqO9Tz06g2W4Qbqj1deM52JYCpDks
        tnkM4=; b=qiYJDMd8bWyHw1q3C4J5p89uDN4Xg9iVEHZ2JlVP5NtFIoOZyI90XO
        /j+6+FpBKSuUK3u03ddpgI6aBJ+vGpn7SqIMIuBKZN7XDqVikwK1uZ5A76A/6Wpt
        9uceUPr7xqEr7hJoEYyNJ1p4nRofbCX+++k5ig9qzRNHevrNv14ms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E8A6101F70;
        Fri, 21 Jan 2022 18:39:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3404101F6F;
        Fri, 21 Jan 2022 18:39:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] split-index: it really is incompatible with the
 sparse index
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
        <1bb57ccd61452124119bb663f5e35e9676748c82.1642613380.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 15:39:55 -0800
In-Reply-To: <1bb57ccd61452124119bb663f5e35e9676748c82.1642613380.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 19 Jan 2022
        17:29:39 +0000")
Message-ID: <xmqqh79wejzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70B07844-7B13-11EC-BE53-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> ... at least for now. So let's error out if we are even trying to
> initialize the split index when the index is sparse, or when trying to
> write the split index extension for a sparse index.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  read-cache.c  | 3 +++
>  split-index.c | 3 +++
>  2 files changed, 6 insertions(+)

Good.  Will queue.


> diff --git a/read-cache.c b/read-cache.c
> index cbe73f14e5e..a932e01fc7a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3009,6 +3009,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  	    !is_null_oid(&istate->split_index->base_oid)) {
>  		struct strbuf sb = STRBUF_INIT;
>  
> +		if (istate->sparse_index)
> +			die(_("cannot write split index for a sparse index"));
> +
>  		err = write_link_extension(&sb, istate) < 0 ||
>  			write_index_ext_header(f, eoie_c, CACHE_EXT_LINK,
>  					       sb.len) < 0;
> diff --git a/split-index.c b/split-index.c
> index 8e52e891c3b..9d0ccc30d00 100644
> --- a/split-index.c
> +++ b/split-index.c
> @@ -5,6 +5,9 @@
>  struct split_index *init_split_index(struct index_state *istate)
>  {
>  	if (!istate->split_index) {
> +		if (istate->sparse_index)
> +			die(_("cannot use split index with a sparse index"));
> +
>  		CALLOC_ARRAY(istate->split_index, 1);
>  		istate->split_index->refcount = 1;
>  	}
