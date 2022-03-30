Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D87C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349636AbiC3Rtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349648AbiC3Rtj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:49:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD1BF9F85
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:47:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98FD01785CE;
        Wed, 30 Mar 2022 13:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mTVMHYRiaLuWNhD7D29avUs9HEHkYxqyH6Cacg
        8HtAA=; b=LWsa+aOgfVbzv5AuX/T9zbh6fQgguIp9Ado26Kl/JBlxluCjkVtQZj
        yD5DDYXeM8B6WapcX7f+dhlOC/Or7HvSbxPMBT3pPjvLpmNuzyec9u+gCG3hBZSU
        mISDV3Ww9cQUPwMfWJqJTYmBnGKAaRL074HMTBVyLkjQc0BGIzXGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 915C41785CD;
        Wed, 30 Mar 2022 13:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A48C41785CC;
        Wed, 30 Mar 2022 13:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 06/14] builtin/add: add ODB transaction around
 add_files_to_cache
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <d514842ad493a819e3640ecb658f702e530d6e85.1648616734.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 10:47:43 -0700
In-Reply-To: <d514842ad493a819e3640ecb658f702e530d6e85.1648616734.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 30 Mar 2022 05:05:24
        +0000")
Message-ID: <xmqqtubf8h8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81202A80-B051-11EC-B1EF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> The add_files_to_cache function is invoked internally by
> builtin/commit.c and builtin/checkout.c for their flags that stage
> modified files before doing the larger operation. These commands
> can benefit from batched fsyncing.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  builtin/add.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 9bf37ceae8e..e39770e4746 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -141,7 +141,16 @@ int add_files_to_cache(const char *prefix,
>  	rev.diffopt.format_callback_data = &data;
>  	rev.diffopt.flags.override_submodule_config = 1;
>  	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
> +
> +	/*
> +	 * Use an ODB transaction to optimize adding multiple objects.
> +	 * This function is invoked from commands other than 'add', which
> +	 * may not have their own transaction active.
> +	 */
> +	begin_odb_transaction();
>  	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
> +	end_odb_transaction();
> +

This one clearly is "bulk".  Makes sense.
