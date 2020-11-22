Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106BEC5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A741320776
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 19:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qDZYmgow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgKVTgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 14:36:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53473 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgKVTgW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 14:36:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC00711634D;
        Sun, 22 Nov 2020 14:36:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M8ZaFq0bVIUjVoIQwy96wOe3NDg=; b=qDZYmg
        ow89ywDFTqATCteipqg1WraldOd1M2vQ56p8at42eTE3/1Rt7PtxiF6gMp3K8OAW
        EdykvimypqDIbEs4IrDXhqO/8z5/xaptQ5sGIQlP5N3m/LiA79adELg/25+BqdXe
        IaFel5oUJMIQ6nFwIcDq8B9ul12N8ASdFa3rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iLC4V3pqfG51LGVjlgiA15icZ4GvrMiI
        Uo1AUU52SBNVeJSOlHj5Fn+hPBow958hNsVk5wGFFZJYIk65fOxrF0qzpZQWoikE
        meOsGxckqtYTBSSIC+HvbYHRvQwAQkq4s8XM99EpGiZFWgkILg7zkbA5/LJAlQDs
        K0WgGumE7lM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4F4511634C;
        Sun, 22 Nov 2020 14:36:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 005CA11634B;
        Sun, 22 Nov 2020 14:36:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 01/23] ewah/ewah_bitmap.c: grow buffer past 1
References: <cover.1605123652.git.me@ttaylorr.com>
        <36deaad366d66d10b96755dd6969bfe51123a2d4.1605123652.git.me@ttaylorr.com>
Date:   Sun, 22 Nov 2020 11:36:17 -0800
In-Reply-To: <36deaad366d66d10b96755dd6969bfe51123a2d4.1605123652.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 11 Nov 2020 14:41:44 -0500")
Message-ID: <xmqqblfpqj4e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE519A3E-2CF9-11EB-9DFF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When the buffer size is exactly 1, we fail to grow it properly, since
> the integer truncation means that 1 * 3 / 2 = 1. This can cause a bad
> write on the line below.

When the buffer_size is exactly (alloc_size - 1), we can fit the new
element at the last word in the buffer array, but we still grow.  Is
this because we anticipate that we would need to add more soon?

> Bandaid this by first padding the buffer by 16, and then growing it.
> This still allows old blocks to fit into new ones, but fixes the case
> where the block size equals 1.

Adding 16 unconditionally is not "to pad".  If somebody really wants
"to pad", a likely implementation would be that the size resulting
from some computation (e.g. multiplying by 1.5) is round up to a
multiple of some number, than rounding up the original number before
multiplying it by 1.5, so the use of that verb in the explanation
did not help me understand what is going on.

Having said that, I see you used the word "bandaid" to signal that
we shouldn't worry about this being optimal or even correct and we
should be happy as long as it is not wrong ;-), but is there any
reason behind this 16 (as opposed to picking, say, 8 or 31), or is
that pulled out of thin air?

I think this probably mimics what alloc_nr() computes for ALLOC_GROW().
I wonder why buffer_grow() cannot be built around ALLOC_GROW() instead?

Nothing in the code is wrong per-se, but just what I noticed while
re-reading the patch.

Thanks.

> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ewah/ewah_bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index d59b1afe3d..3fae04ad00 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -45,7 +45,7 @@ static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
>  static inline void buffer_push(struct ewah_bitmap *self, eword_t value)
>  {
>  	if (self->buffer_size + 1 >= self->alloc_size)
> -		buffer_grow(self, self->buffer_size * 3 / 2);
> +		buffer_grow(self, (self->buffer_size + 16) * 3 / 2);
>  
>  	self->buffer[self->buffer_size++] = value;
>  }
