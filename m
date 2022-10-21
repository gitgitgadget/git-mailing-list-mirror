Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F3DC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 18:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJUScD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 14:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUScB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 14:32:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF8822D5EB
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 11:32:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E6FC15ACB4;
        Fri, 21 Oct 2022 14:32:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DMq68CB3XR2gSVxsWL/A9Bw/OXePqeyGtW43Iq
        /+WL4=; b=jlWqxWw3J4JCrOeHiTGLsC9mYagLgb/pNcBi77m1Ln43cbb8pVOzMC
        GQFA6yHy+8po7BjbtXo93Tpl6UTqb67j1MTs11CwDqcVZ9OPWMKA2NeP2KE4KhUs
        LC/MsIv9YJ/1Wa+XT+AOXqLMoCkpv9SgQZgXrxzsL0C7R4y8+c4p4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2ABB815ACB3;
        Fri, 21 Oct 2022 14:32:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88AAA15ACB2;
        Fri, 21 Oct 2022 14:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] git_parse_signed(): avoid integer overflow
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <f058f391c3821b341a15fda9ae9fd20dda6a0494.1666359915.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 11:31:58 -0700
In-Reply-To: <f058f391c3821b341a15fda9ae9fd20dda6a0494.1666359915.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Oct 2022 13:45:14
        +0000")
Message-ID: <xmqqpmeljae9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A63F22D0-516E-11ED-9C8C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> git_parse_signed() checks that the absolute value of the parsed string
> is less than or equal to a caller supplied maximum value. When
> calculating the absolute value there is a integer overflow if `val ==
> INTMAX_MIN`.

It is a problem that is worth looking into.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  config.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/config.c b/config.c
> index b7fb68026d8..aad3e00341d 100644
> --- a/config.c
> +++ b/config.c
> @@ -1160,8 +1160,10 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>  	if (value && *value) {
>  		char *end;
>  		intmax_t val;
> -		uintmax_t uval;
> -		uintmax_t factor;
> +		intmax_t factor;
> +
> +		if (max < 0)
> +			BUG("max must be a positive integer");

In parse_signed(), would we expect to accept end-user input that is
a negative integer?  We must.  Otherwise we would not be calling a
"signed" parser.  Now, are there cases where the valid value range
is bounded by a negative integer at the top?  No current callers may
pass such a value, but is it reasonable to add such a new constraints
to an existing API function?

