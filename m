Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AFDC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352528AbiCXST6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350038AbiCXSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:19:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281C6AF1D4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:18:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89F9918FF83;
        Thu, 24 Mar 2022 14:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6i8BV23LNmpCQrDa2x504Cl8DjfcDU8kUSAQJd
        Qc53A=; b=dHnxiIujaGaaE3rq7pJUU8bhsrup37/eK7vFY6RDyzMl69CwcShY1z
        izuTWZniolT6npvVCOigMGzpUKclR18dMzzinYlz1BekxLbfUwFz7sal4jDU0FIF
        K+7y8XuY9T+B6shM2N5SgKJ+WxXKL70tztmxyNKi8iwNXvnR0pKQI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8344B18FF82;
        Thu, 24 Mar 2022 14:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1F9718FF80;
        Thu, 24 Mar 2022 14:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 05/11] update-index: use the bulk-checkin infrastructure
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <913ce1b3df9cf273f1572c256dffad1cacc192a6.1648097906.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 11:18:15 -0700
In-Reply-To: <913ce1b3df9cf273f1572c256dffad1cacc192a6.1648097906.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Thu, 24 Mar 2022 04:58:20
        +0000")
Message-ID: <xmqqfsn7i594.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6B8152E-AB9E-11EC-A706-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void end_odb_transaction_if_active(void)
> +{
> +	if (!odb_transaction_active)
> +		return;
> +
> +	end_odb_transaction();
> +	odb_transaction_active = 0;
> +}

>  __attribute__((format (printf, 1, 2)))
>  static void report(const char *fmt, ...)
>  {
> @@ -57,6 +68,16 @@ static void report(const char *fmt, ...)
>  	if (!verbose)
>  		return;
>  
> +	/*
> +	 * It is possible, though unlikely, that a caller
> +	 * could use the verbose output to synchronize with
> +	 * addition of objects to the object database, so
> +	 * unplug bulk checkin to make sure that future objects
> +	 * are immediately visible.
> +	 */
> +
> +	end_odb_transaction_if_active();
> +
>  	va_start(vp, fmt);
>  	vprintf(fmt, vp);
>  	putchar('\n');
> @@ -1116,6 +1137,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  	 */
>  	parse_options_start(&ctx, argc, argv, prefix,
>  			    options, PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	/*
> +	 * Allow the object layer to optimize adding multiple objects in
> +	 * a batch.
> +	 */
> +	begin_odb_transaction();
> +	odb_transaction_active = 1;

This looks strange.  Shouldn't begin/end pair be responsible for
knowing if there is a transaction active already?  For that matter,
didn't the original unplug in plug/unplug pair automatically turned
into no-op when it is already unplugged?

IOW, I am not sure end_if_active() should exist in the first place.
Shouldn't end_transaction() do that instead?

