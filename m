Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A799C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5158761213
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhJUSpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:45:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52237 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUSpm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:45:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74332161FE3;
        Thu, 21 Oct 2021 14:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DKKjC8s1Rpn8U1Dl0azDGCiItMcoFgvdSOmYjI
        6JBy0=; b=CI97Uj/s/t/RXxVu8CP3kwB0W/KWoAVPeqjlr0UQOHcyLLyPDrhLCV
        K8hf19K/zictKnBj4HSbiq3vwUy+rrPghyyKvraXkl7tTzHW2D0byxw/e/aSHHex
        TSIc+n6bkHpPMeGvgQt0bTADiF1+77EGaJPxAmFcvRsGpkAIyQX+M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B7F7161FE2;
        Thu, 21 Oct 2021 14:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C0A67161FDB;
        Thu, 21 Oct 2021 14:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 09/11] pack-bitmap.c: more aggressively free in
 free_bitmap_index()
References: <cover.1634787555.git.me@ttaylorr.com>
        <e65ac7deb5973b8209e8d94ad9140e005e22c44e.1634787555.git.me@ttaylorr.com>
Date:   Thu, 21 Oct 2021 11:43:22 -0700
In-Reply-To: <e65ac7deb5973b8209e8d94ad9140e005e22c44e.1634787555.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 20 Oct 2021 23:40:07 -0400")
Message-ID: <xmqqlf2mkylx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C54D68E8-329E-11EC-A93C-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 0f6656db02..451ca3512c 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1854,9 +1854,17 @@ void free_bitmap_index(struct bitmap_index *b)
>  	ewah_pool_free(b->trees);
>  	ewah_pool_free(b->blobs);
>  	ewah_pool_free(b->tags);
> +	if (b->bitmaps) {
> +		struct stored_bitmap *sb;
> +		kh_foreach_value(b->bitmaps, sb, {
> +			ewah_pool_free(sb->root);
> +			free(sb);
> +		});
> +	}
>  	kh_destroy_oid_map(b->bitmaps);
>  	free(b->ext_index.objects);
>  	free(b->ext_index.hashes);
> +	kh_destroy_oid_pos(b->ext_index.positions);
>  	bitmap_free(b->result);
>  	bitmap_free(b->haves);
>  	if (bitmap_is_midx(b)) {

It is not a fault of this patch, but I was reading the corresponding
load_bitmap() to see if we are covering everything here.

On the error path of that function, where it does "got failed", it
does not clean after itself very well, it seems.  If we read commits
bitmap successfully but failed to read trees bitmap, for example,
the resource held by commits bitmap is never reclaimed.
