Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B36C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC322100A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qjYRTRRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKKU7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:59:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56068 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKU7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:59:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B686A3182;
        Wed, 11 Nov 2020 15:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Mt03EiIXlRg1CDbXE3HVXMAA10=; b=qjYRTR
        RllpqL6kAHkcs9J7fGMalzdgXnDg6lt+DZjq/n+sGzI1iyLoHG9IehuLpBSu4I+3
        OU64T/ZjvWGg9h3uVerpzkkyJ91vC+4xRMrRkXWPGGO4xVeILjH9FNc894e6sBfG
        h+dyFXHlO/csLsgp2IUeoMz4d4fTYoQXMewKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fxIklZN/82QWPbE3XoExlqbdFf7h0p2T
        g6lNBIIbmiKesHy7vsbnztCw27M8H+b61gq6h1vMAnD+gU9Vdw8JElLhHT2Yfbbb
        DlcwXXzWNaMrPjZYDoQ0PrBfNczs2kPgh/eqdDkF+MlDn1bL0CNYEEzGAcPPP6pB
        3i/KJZoJwDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3200BA3181;
        Wed, 11 Nov 2020 15:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9651FA317F;
        Wed, 11 Nov 2020 15:59:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pudinha <rogi@skylittlesystem.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] mergetool: avoid letting `list_tool_variants` break
 user-defined setups
References: <pull.787.git.1605126798.gitgitgadget@gmail.com>
        <c157c07d5d4917e6eef6717894f61c54cbc9af22.1605126798.git.gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:59:40 -0800
In-Reply-To: <c157c07d5d4917e6eef6717894f61c54cbc9af22.1605126798.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 11 Nov 2020
        20:33:18 +0000")
Message-ID: <xmqq1rgz4nk3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D190EA0A-2460-11EB-9291-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 83bbf9b92ea8 (mergetool--lib: improve support for vimdiff-style tool
> variants, 2020-07-29), we introduced a `list_tool_variants` function
> in the spirit of Postel's Law: be lenient in what you accept as input.
> In this particular instance, we wanted to allow not only `bc` but also
> `bc3` as name for the Beyond Compare tool.
>
> However, what this patch overlooked is that it is totally allowed for
> users to override the defaults in `mergetools/`. But now that we strip
> off trailing digits, the name that the user gave the tool might not
> actually be in the list produced by `list_tool_variants`.
>
> So let's do the same as for the `diff_cmd` and the `merge_cmd`: override
> it with the trivial version in case a user-defined setup was detected.

Makes sense.  Will queue.  Thanks.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-mergetool--lib.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 2defef28cd..7225abd811 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -138,6 +138,10 @@ setup_user_tool () {
>  	merge_cmd () {
>  		( eval $merge_tool_cmd )
>  	}
> +
> +	list_tool_variants () {
> +		echo "$tool"
> +	}
>  }
>  
>  setup_tool () {
