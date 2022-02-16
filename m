Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B7C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 01:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiBPB2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:28:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbiBPB2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 20:28:18 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B6566AC9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 17:28:07 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D04211D555;
        Tue, 15 Feb 2022 20:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=17vJsfriPOoeYmZ+hark/3Eftdim992rMQScky
        7whZM=; b=wk0dw/Uo1FZXpEDDJp8m3MhSXt7J1gFiZ8H1zedpDd5IwFaJoSlaZ+
        bg+IwnJc4pSDl7FdjvMLPUo/M1+MhV0rt0fc+EIRBiAblIAus0d4UIC3kcwYgLqf
        9jrmrn+YfxxKtF0JEfb0G3ikGciTcYRo7ZipM+Hnc641madnwrEg0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 629D411D554;
        Tue, 15 Feb 2022 20:28:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7BD011D553;
        Tue, 15 Feb 2022 20:28:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v7 4/4] cat-file: add --batch-command mode
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
        <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
        <aebaf7e3fe1d4448037d2caf03f3de393908ff9a.1644972810.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 17:28:04 -0800
In-Reply-To: <aebaf7e3fe1d4448037d2caf03f3de393908ff9a.1644972810.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Wed, 16 Feb 2022 00:53:30
        +0000")
Message-ID: <xmqqfsojy50b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0D270EA-8EC7-11EC-AEA4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void dispatch_calls(struct batch_options *opt,
> +		struct strbuf *output,
> +		struct expand_data *data,
> +		struct queued_cmd *cmd,
> +		size_t *nr)
> +{
> +	int i;
> +
> +	if (!opt->buffer_output)
> +		die(_("flush is only for --buffer mode"));
> +
> +	for (i = 0; i < *nr; i++) {

If you updated the max number of items *nr to size_t, don't you need
to use 'i' with the same type to count up to it?

> +		cmd[i].fn(opt, cmd[i].line, output, data);
> +		free(cmd[i].line);
> +	}
> +
> +	*nr = 0;
> +	fflush(stdout);
> +}

Wouldn't it be easier to reason about what the caller/callee are
responsible for, if the function signature looked more like:

	static size_t dispatch_calls(struct batch_options *opt,
				     ...
				     struct queued_cmd cmd[], size_t nr)
	{
		size_t i;

		for (i = 0; i < nr; i++)
			... do stuff ...;

		return updated_nr;
	}

and make the caller do

	nr = dispatch_calls(opt, ..., nr);

or if the function *never* leaves anything in the queue when it
returns, then

	static void dispatch_calls(struct batch_options *opt,
				     ...
				     struct queued_cmd cmd[], size_t nr)
	{
		size_t i;

		for (i = 0; i < nr; i++)
			... do stuff ...;
	}

and make the caller do

	dispatch_calls(opt, ..., nr);
	nr = 0;

instead of passing a pointer to nr like the posted patch?
