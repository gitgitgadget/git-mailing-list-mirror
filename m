Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6086BC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42ECA60EFF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJ2XND (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:13:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57023 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2XNC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 19:13:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD3D315F244;
        Fri, 29 Oct 2021 19:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MmGVU57Vr6nn575X+CTkobJFrrtM6BVw1hhLRI
        e24/U=; b=cGqSZ8ND7AwQovQnQocCW/Uf240VRMYp9L1TpFeG4vHZ4nhW0n5ghN
        5Uvj+t5serc4DasSMsTYSRM49lDf1BxLrl+k06BMocmNa5DuJQUIIom1v5cwakfR
        gSq8FzdfY6LkqgipafsrL4S3LAA7AxkD8ZZ5PDQj7fXibQOpfmsH4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A611615F243;
        Fri, 29 Oct 2021 19:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0097B15F242;
        Fri, 29 Oct 2021 19:10:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 6/8] git-compat-util: introduce more size_t helpers
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <18419070c29aef85c266f01174f436566bf792fd.1635515959.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 16:10:27 -0700
In-Reply-To: <18419070c29aef85c266f01174f436566bf792fd.1635515959.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 29 Oct 2021
        13:59:17 +0000")
Message-ID: <xmqqcznnh1gc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68611A60-390D-11EC-896C-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +/*
> + * Returns true if the left shift of "a" by "shift" bits will
> + * overflow. The type of "a" must be unsigned.
> + */
> +#define unsigned_left_shift_overflows(a, shift) \
> +    ((shift) < bitsizeof(a) && \
> +     (a) > maximum_unsigned_value_of_type(a) >> (shift))

Cute.  So somebody asks

    if (unsigned_left_shift_overflows(a, 100)

and they get "you are unsafe, regardless of the value of a, you get
an overflow".  Makes perfect sensen.

>  #ifdef __GNUC__
>  #define TYPEOF(x) (__typeof__(x))
>  #else
> @@ -859,6 +867,23 @@ static inline size_t st_sub(size_t a, size_t b)
>  	return a - b;
>  }
>  
> +static inline size_t st_left_shift(size_t a, unsigned shift)
> +{
> +	if (unsigned_left_shift_overflows(a, shift))
> +		die("size_t overflow: %"PRIuMAX" << %u",
> +		    (uintmax_t)a, shift);
> +	return a << shift;
> +}

Makes sense.

> +static inline unsigned long cast_size_t_to_ulong(size_t a)
> +{
> +	if (a != (unsigned long)a)
> +		die("object too large to read on this platform: %"
> +		    PRIuMAX" is cut off to %lu",
> +		    (uintmax_t)a, (unsigned long)a);
> +	return (unsigned long)a;
> +}
> +
>  #ifdef HAVE_ALLOCA_H
>  # include <alloca.h>
>  # define xalloca(size)      (alloca(size))
