Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAEDC47256
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D6F206FA
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UzoGUvS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgEEFZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 01:25:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55903 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEFZw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 01:25:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71006DF900;
        Tue,  5 May 2020 01:25:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M06vpidaWcAQ5X7VTLCt9p5jJAU=; b=UzoGUv
        S1tBk9SEBNkuy/MO3ECfURWIP5BtLR73zg7Ma0nt8KxQXtCLc6tieTQA5r6k7cUQ
        YQfOMASR3GxRKLTmD7dhnwRIPqDlRapN7I2XCK/cbNt3eLT4CiJIki9kmo4qJC3K
        ZjPxwVaOFId6wItVZeSEiu6+fSEStosn6Lz3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Akeqe8HMyGISDTrA+2d5x0wgq8Vd7WmS
        dED8eVx2EPZWR3163vsNtAryvjJRNH23dnLMWyjNBMpyyjYI9DTskoxDKIuE9+X1
        Aryps+96HfYhzrzdyv3XG9cOeGeOXvKkdllD8fYFcaOtO2N++B///tUo1rDbnGkH
        AqgWu6/hBns=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 691C2DF8FF;
        Tue,  5 May 2020 01:25:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF13DDF8FE;
        Tue,  5 May 2020 01:25:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 3/4] pack-bitmap.c: support 'tree:0' filtering
References: <cover.1588633810.git.me@ttaylorr.com>
        <87b21d72bb588f7366d928544aeaf4de68b027a7.1588633810.git.me@ttaylorr.com>
Date:   Mon, 04 May 2020 22:25:46 -0700
In-Reply-To: <87b21d72bb588f7366d928544aeaf4de68b027a7.1588633810.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 4 May 2020 17:12:35 -0600")
Message-ID: <xmqq7dxrc5r9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E045FC54-8E90-11EA-A50B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 3693c9e62f..195ee8cad0 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -749,7 +749,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
>  	eword_t mask;
>  	uint32_t i;
>  
> -	if (type != OBJ_BLOB)
> +	if (type != OBJ_BLOB && type != OBJ_TREE)
>  		BUG("filter_bitmap_exclude_type: unsupported type '%d'", type);

OK.  This is the same as the previous step, but why would we even
need this guard?  find_tip_objects() is equipped to find tips of any
object type, iterating on the bitmap for "type", or flipping the
bits in the to_filter bitmap, does not have any limitation to the
blob type in the previous step, and there is no limitation to the
blob or tree types after this step, either, no?

> @@ -867,6 +867,20 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
>  	bitmap_free(tips);
>  }
>  
> +static void filter_bitmap_tree_depth(struct bitmap_index *bitmap_git,
> +				     struct object_list *tip_objects,
> +				     struct bitmap *to_filter,
> +				     unsigned long limit)
> +{
> +	if (limit)
> +		BUG("filter_bitmap_tree_depth given non-zero limit");

This one does make sense, because the code to exclude all trees and
all blobs we have below won't be able to cull only trees at a given
depth or deeper.

> +	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
> +				   OBJ_TREE);
> +	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
> +				   OBJ_BLOB);

And these two are quite straight-forward.

> +}
> +
>  static int filter_bitmap(struct bitmap_index *bitmap_git,
>  			 struct object_list *tip_objects,
>  			 struct bitmap *to_filter,
> @@ -890,6 +904,15 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
>  		return 0;
>  	}
>  
> +	if (filter->choice == LOFC_TREE_DEPTH &&
> +	    filter->tree_exclude_depth == 0) {
> +		if (bitmap_git)
> +			filter_bitmap_tree_depth(bitmap_git, tip_objects,
> +						 to_filter,
> +						 filter->tree_exclude_depth);

I briefly wondered if it is cleaner to read if we hardcode 0 as the
last argument.  But if the helper function ever learns how to filter
by tree with non-zero depth, we can only tweak the if() condition
without changing the call, so the way you wrote it is the right way.

Thanks.
