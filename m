Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA3AC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 18:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJUSJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJUSJS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 14:09:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F026DB36
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 11:09:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBD0015AB74;
        Fri, 21 Oct 2022 14:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cIKkp/H9ZepNQuthAWlrB4DXeEfYWWSqkquMIH
        bcPAc=; b=fp9O7oRJl1E/8MLYXkBgiWYSGKmwUNQIU7HvN0QoW4/BZF+9YAYFaq
        vGnmDn1qN4H84CPv1MFU/GwGDxF/vN4hiuQAaTWdUkHmyGDYkCunDuewC7HiAQh8
        KTjN4SHBQ+ds6u1Pzxad+aSLrludkmweGAImkEZhuZcx3v7eVNa2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1F3C15AB73;
        Fri, 21 Oct 2022 14:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C2D015AB72;
        Fri, 21 Oct 2022 14:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] git_parse_unsigned: reject negative values
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <9c8440e5e82777311c6217cb4a9ddcd5cb8ce689.1666359915.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 11:09:13 -0700
In-Reply-To: <9c8440e5e82777311c6217cb4a9ddcd5cb8ce689.1666359915.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Oct 2022 13:45:12
        +0000")
Message-ID: <xmqqbkq5kq0m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7903343A-516B-11ED-981E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> git_parse_unsigned() relies on strtoumax() which unfortunately parses
> negative values as large positive integers. Fix this by rejecting any
> string that contains '-' as we do in strtoul_ui(). I've chosen to treat
> negative numbers as invalid input and set errno to EINVAL rather than
> ERANGE one the basis that they are never acceptable if we're looking for
> a unsigned integer.

And the code now would reject something like "43-21" because it does
not insist that "-" must be used for a sign, so it makes EINVAL
doubly appropriate, I would think.  In the original code, "43-21"
would have been parsed as "43" (by strtoumax) followed by "-" (which
is rejected by get_unit_factor() and yielded EINVAL, so this change
would not change the behaviour for such an input, if we receive
EINVAL when we see a "-".

A devil's advocate would consider if we ever want to have a unit
factor that has "-" in it (e.g. "10000e-3" == 10).  I can buy it if
we want to declare that it is not worth supporting.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  config.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/config.c b/config.c
> index cbb5a3bab74..d5069d4f01d 100644
> --- a/config.c
> +++ b/config.c
> @@ -1193,6 +1193,11 @@ static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
>  		uintmax_t val;
>  		uintmax_t factor;
>  
> +		/* negative values would be accepted by strtoumax */
> +		if (strchr(value, '-')) {
> +			errno = EINVAL;
> +			return 0;
> +		}
>  		errno = 0;
>  		val = strtoumax(value, &end, 0);
>  		if (errno == ERANGE)
