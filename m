Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B568C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 21:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiEJVsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiEJVsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 17:48:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE38381BD
        for <git@vger.kernel.org>; Tue, 10 May 2022 14:48:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D3DE18B2EE;
        Tue, 10 May 2022 17:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oWm8YCLE1h5wF+GCB/8Ya6y7CqZrx6LiOHrIVP
        3TtfQ=; b=VJsMroNaRpQunKI6ONFVibj8y9e7+83Oy72rD6RpmrNWS+gBi+Zsti
        HYRAtcx+REPWfjqnPSLZNJkrH0aG9ki/hgKSSma7FFxpcO01QfDQlSY77qQrfDab
        UvZcAx1vgY6T2fQLtIbjeOnf3DoMUgajqrvLcI05dX6j0D43nE8EA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1567918B2ED;
        Tue, 10 May 2022 17:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B45DD18B2EC;
        Tue, 10 May 2022 17:48:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/7] archive: optionally add "virtual" files
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 14:48:02 -0700
In-Reply-To: <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 10 May 2022
        19:26:58 +0000")
Message-ID: <xmqqtu9x6ovh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE7F0F4C-D0AA-11EC-8619-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -514,14 +522,38 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
>  	if (!arg)
>  		return -1;
>  
> -	path = prefix_filename(args->prefix, arg);
> -	item = string_list_append_nodup(&args->extra_files, path);
> -	item->util = info = xmalloc(sizeof(*info));
> +	info = xmalloc(sizeof(*info));
>  	info->base = xstrdup_or_null(base);
> -	if (stat(path, &info->stat))
> -		die(_("File not found: %s"), path);
> -	if (!S_ISREG(info->stat.st_mode))
> -		die(_("Not a regular file: %s"), path);
> +
> +	if (!strcmp(opt->long_name, "add-file")) {
> +		path = prefix_filename(args->prefix, arg);
> +		if (stat(path, &info->stat))
> +			die(_("File not found: %s"), path);
> +		if (!S_ISREG(info->stat.st_mode))
> +			die(_("Not a regular file: %s"), path);
> +		info->content = NULL; /* read the file later */
> +	} else {

This pretends that this new one will stay to be the only other
option that uses the same callback in the future.  To be more
defensive, it should do

	} else if (!strcmp(opt->long_name, "...")) {

and end the if/else if/else cascade with

	} else {
		BUG("add_file_cb called for unknown option");
	}

> +		const char *colon = strchr(arg, ':');
> +		char *p;
> +
> +		if (!colon)
> +			die(_("missing colon: '%s'"), arg);
> +
> +		p = xstrndup(arg, colon - arg);
> +		if (!args->prefix)
> +			path = p;
> +		else {
> +			path = prefix_filename(args->prefix, p);
> +			free(p);
> +		}
> +		memset(&info->stat, 0, sizeof(info->stat));
> +		info->stat.st_mode = S_IFREG | 0644;

I can sympathize with the desire to omit the mode bits because it
may not be useful for the immediate purpose of "scalar diagnose"
where the extracting end won't care what the file's permission bits
are, but by letting this "mode is hardcoded" thing squat here would
later make it more work when other people want to add an option that
truely lets the caller add a "vitual" file, in response to end-user
complaints that they cannot use the existing one to add an
exectuable file, for example.  I do not care too much about the
pathname limitation that does not allow a colon in it, simply
because it is unusual enough, but I am not sure about hardcoded
permission bits.

If we did "--add-virtual-file=<path>:0644:<contents>" instead from
day one, it certainly adds a few more lines of logic to this patch,
and the calling "scalar diagnose" may have to pass a few more bytes,
but I suspect that such a change would help the project in the
longer run.

Thanks.
