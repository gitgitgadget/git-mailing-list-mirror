Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2589FC433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 19:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379157AbhLDUBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:01:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63560 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378395AbhLDUBs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 15:01:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B82D9F2F29;
        Sat,  4 Dec 2021 14:58:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O6jJo5Bog9dUr/WMwJlnGdZdur5/sT+EwNGBWF
        hI/sc=; b=oTc1EGK/50NgYr1T9tBG/Psojmybptlq5aDXE7VZvVktdSxUH8JUU5
        TpYHqkBpAAqHl18H2WOhB2mAm4ki8CMm1mGSC/evBUBcGodTG8t6JzrG4QzOnJDf
        AVqsJRpFg4Py2r6u3DaSIgixchxwxrsPU4GF/hM7FITs7qfke6AXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF144F2F28;
        Sat,  4 Dec 2021 14:58:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F46FF2F27;
        Sat,  4 Dec 2021 14:58:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v5 1/7] git: esnure correct git directory setup with -h
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
        <09c2ff9f89833b3ac918a399e10d1b6abe71b339.1638566165.git.gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 11:58:19 -0800
In-Reply-To: <09c2ff9f89833b3ac918a399e10d1b6abe71b339.1638566165.git.gitgitgadget@gmail.com>
        (Lessley Dennington via GitGitGadget's message of "Fri, 03 Dec 2021
        21:15:59 +0000")
Message-ID: <xmqq1r2sp2g4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 881A26DA-553C-11EC-B69D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -421,27 +421,28 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	int status, help;
>  	struct stat st;
>  	const char *prefix;
> -
> +	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
>  	prefix = NULL;

Don't lose the blank line that separates the variable declarations
and the first statement.  Also, it probably makes sense to remove
the assignment of NULL to prefix from here (see below).

>  	help = argc == 2 && !strcmp(argv[1], "-h");
> -...
> +	if (help && (run_setup & RUN_SETUP))
> +		/* demote to GENTLY to allow 'git cmd -h' outside repo */
> +		run_setup = RUN_SETUP_GENTLY;

OK.

> +	if (run_setup & RUN_SETUP)
> +		prefix = setup_git_directory();
> +	else if (run_setup & RUN_SETUP_GENTLY) {
> +		int nongit_ok;
> +		prefix = setup_git_directory_gently(&nongit_ok);
>  	}

Here, we say "depending on how run_setup is specified, we compute
the prefix in different ways".  So the "we do not run setup, so set
prefix to NULL" naturally belongs here.  Perhaps something like...

	if (run_setup & RUN_SETUP) {
		prefix = setup_git_directory();
	} else if (run_setup & RUN_SETUP_GENTLY) {
		int nongit_ok;
		prefix = setup_git_directory_gently(&nongit_ok);
	} else {
		prefix = NULL;
	}

> +	precompose_argv_prefix(argc, argv, NULL);
> +	if (use_pager == -1 && run_setup &&
> +		!(p->option & DELAY_PAGER_CONFIG))
> +		use_pager = check_pager_config(p->cmd);
> +	if (use_pager == -1 && p->option & USE_PAGER)
> +		use_pager = 1;
> +	if (run_setup && startup_info->have_repository)
> +		/* get_git_dir() may set up repo, avoid that */
> +		trace_repo_setup(prefix);
>  	commit_pager_choice();
>  
>  	if (!help && get_super_prefix()) {
