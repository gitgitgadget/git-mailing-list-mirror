Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B3C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30648610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhJ1XIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 19:08:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64500 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhJ1XIF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 19:08:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02E88F5182;
        Thu, 28 Oct 2021 19:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B+vG0N9x0sP2/4wpxYR7pHPEfrdbMla/LgEzwf
        z0E2A=; b=XFU4ntVI5kcFyrtwhbZ9VUfyYy8zrw7jrgUHry0S5Sj3BSV/gRZeNH
        6JlRRSlSPTzZLjUWj3PxU0vK7hwlGItGl/u1Pu1ViAuljf9wMY7DnMOtC2gHP/mu
        23Hg7Xin9qgKYlAiaPsBGJZjVf83dM+b0uCoPDkYLB3IRScaz3dwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8BCBF5180;
        Thu, 28 Oct 2021 19:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 242CEF517F;
        Thu, 28 Oct 2021 19:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/7] git-compat-util: introduce more size_t helpers
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <32472ae3f98bbe0162b39a16109522ec18026404.1635454237.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:05:34 -0700
In-Reply-To: <32472ae3f98bbe0162b39a16109522ec18026404.1635454237.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 28 Oct 2021
        20:50:35 +0000")
Message-ID: <xmqqr1c4oim9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F6971EA-3843-11EC-A37E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We will use them in the next commit.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-compat-util.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a508dbe5a35..7977720655c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -113,6 +113,14 @@
>  #define unsigned_mult_overflows(a, b) \
>      ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
>  
> +/*
> + * Returns true if the left shift of "a" by "shift" bits will
> + * overflow. The types of "a" and "b" must be unsigned.

The type of "a" must be unsigned, and there is no "b".

"shift" can be of an integral type, and it probably is a good idea
to feed a positive value that is smaller than bitsizeof(type(a)),
but we probably do not have to say anything about it.

> + * Note that this macro evaluates "a" twice!

maximum_unsigned_value_of_type() does take bitsizeof() of the thing,
but it only needs the type of it, not the value, so I doubt that it
would evaluate 'a' even once.  This macro does need the value of 'a'
so it would evaluate it once.

> + */
> +#define unsigned_left_shift_overflows(a, shift) \
> +    ((a) > maximum_unsigned_value_of_type(a) >> shift)

try:

	unsigned a = 0;
	int ov = unsigned_left_shift_overflows(++a, 4);
	
	printf("a = %d, ov = %d\n", a, ov);
	return 0;

I think you'd get "a = 1".

