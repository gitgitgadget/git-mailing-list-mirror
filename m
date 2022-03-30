Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5463EC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349495AbiC3Ryg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349456AbiC3Ryf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:54:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F9E1D6
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:52:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14B38117ED3;
        Wed, 30 Mar 2022 13:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vsuWI2G6JNW22aeIyTMKI3YVrqrPCHR09Nwhgy
        ty/w4=; b=qFPuGn8FCJCLhElkrqsYFE7U9YbmHSW4HyNtc85bH7U5LGHTLICnfC
        qKstilYIEyfQ3uuNL+YuT9qA21fnNHzrsMY6rgAdAvPmm78yMxtOrYP/1wSNi4i+
        93q6kl+qyestvkFX04WXr2s83mWG/a8eruPcJijLiX8h11OftH8Ek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C590117ED2;
        Wed, 30 Mar 2022 13:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E8E9117ED1;
        Wed, 30 Mar 2022 13:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 07/14] update-index: use the bulk-checkin infrastructure
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <8cac94598a58704d9b625a9d8a593779f7adc30f.1648616734.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 10:52:46 -0700
In-Reply-To: <8cac94598a58704d9b625a9d8a593779f7adc30f.1648616734.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 30 Mar 2022 05:05:25
        +0000")
Message-ID: <xmqqpmm38h01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35905922-B052-11EC-A076-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * Allow the object layer to optimize adding multiple objects in
> +	 * a batch.
> +	 */
> +	begin_odb_transaction();
>  	while (ctx.argc) {
>  		if (parseopt_state != PARSE_OPT_DONE)
>  			parseopt_state = parse_options_step(&ctx, options,
> @@ -1167,6 +1174,17 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		the_index.version = preferred_index_format;
>  	}
>  
> +	/*
> +	 * It is possible, though unlikely, that a caller could use the verbose
> +	 * output to synchronize with addition of objects to the object
> +	 * database. The current implementation of ODB transactions leaves
> +	 * objects invisible while a transaction is active, so end the
> +	 * transaction here if verbose output is enabled.
> +	 */
> +
> +	if (verbose)
> +		end_odb_transaction();
> +
>  	if (read_from_stdin) {
>  		struct strbuf buf = STRBUF_INIT;
>  		struct strbuf unquoted = STRBUF_INIT;
> @@ -1190,6 +1208,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		strbuf_release(&buf);
>  	}
>  
> +	/*
> +	 * By now we have added all of the new objects
> +	 */
> +	if (!verbose)
> +		end_odb_transaction();

If we had "flush" in addition to "begin" and "end", then we could,
instead of the above

    begin_transaction
	do things
    if condition:
	end_transaction
    loop:
	do thing
    if !condition:
	end_transaction


which is somewhat hard to follow and maintain, consider using a
different flow, which is

    begin_transaction
	do things
    loop:
	do thing
	if condition:
	    flush
    end_transaction

and that might make it easier to follow and maintain.  I am not 100%
sure if it is worth it, but I am leaning to say it would be.

Thanks.
