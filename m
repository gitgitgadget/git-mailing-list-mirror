Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93AEC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJUSTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJUST2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 14:19:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7411168
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 11:19:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B7001BEA9D;
        Fri, 21 Oct 2022 14:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HuMKtaW/Fiw8avYG+mjU7SJ1De/0BGJwFc0cBo
        3OlqU=; b=ZkKnG041zPC/mRHm/M4ipZ9eJghQQrvmb77kV43EyPXLeE5DCEdzLe
        CuEVpheb9czdDO5k38qBIPn254adCgm/7BovRdMaR4EKqcExw2TgOrDyYeII6C45
        CdJzc32E6QYGc0z0F+qazjqyrkxojneXhxw1eZOZyCHWHKGP3BFx0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6237E1BEA9C;
        Fri, 21 Oct 2022 14:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 808A61BEA9A;
        Fri, 21 Oct 2022 14:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] config: require at least one digit when parsing
 numbers
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 11:19:20 -0700
In-Reply-To: <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Oct 2022 13:45:13
        +0000")
Message-ID: <xmqqwn8tjazb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E26C7570-516C-11ED-AD03-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the input to strtoimax() or strtoumax() does not contain any digits
> then they return zero and set `end` to point to the start of the input
> string.  git_parse_[un]signed() do not check `end` and so fail to return
> an error and instead return a value of zero if the input string is a
> valid units factor without any digits (e.g "k").
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  config.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/config.c b/config.c
> index d5069d4f01d..b7fb68026d8 100644
> --- a/config.c
> +++ b/config.c
> @@ -1167,6 +1167,10 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>  		val = strtoimax(value, &end, 0);
>  		if (errno == ERANGE)
>  			return 0;
> +		if (end == value) {
> +			errno = EINVAL;
> +			return 0;
> +		}

This means well, but doesn't strto*() family of functions silently
ignore leading blanks, e.g.

    l = strtol("  432k", &end, 0);
	... l == 432, *end = k ...

If you really want to reject a string with no number before the
optional unit, end at this point may not match value.  With " k" as
input, value would point at the space at the beginning, and end
would point at 'k'.

It does not look _too_ bad if we just let such an empty string
through and interpreted it as zero.  Is that a problem?  Who are we
trying to help?

>  		factor = get_unit_factor(end);
>  		if (!factor) {
>  			errno = EINVAL;
> @@ -1202,6 +1206,10 @@ static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
>  		val = strtoumax(value, &end, 0);
>  		if (errno == ERANGE)
>  			return 0;
> +		if (end == value) {
> +			errno = EINVAL;
> +			return 0;
> +		}
>  		factor = get_unit_factor(end);
>  		if (!factor) {
>  			errno = EINVAL;
