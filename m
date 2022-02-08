Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B378C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 06:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347832AbiBHGuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 01:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347830AbiBHGuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 01:50:09 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C91C0401F6
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 22:50:07 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D070165A06;
        Tue,  8 Feb 2022 01:50:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0+oPR3Vsx6gwFWzwhalNJgbOun3KSmRfNzt3kt
        7FHGw=; b=Ln0WPwYPgYoaRwtj35ilnmi8mGLS1jdi33UqimKGWGBAtkPLE9xiun
        kZmNCTHvlp5v1jKMGnLu+g0GoyO7wQjh1xa3j6Sz5AdQ8vqFrWYdMdMoASGP10B8
        Ydx8sNAmre885xu0lLostcXkfJi48UyA8HZr4nK5GxsGkgtcvO2QA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15A9B165A04;
        Tue,  8 Feb 2022 01:50:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5297E165A03;
        Tue,  8 Feb 2022 01:50:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] checkout/fetch/pull/pack-objects: allow `-h`
 outside a repository
References: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
        <25d1a2963f2934753de4fb6899429301637377c9.1644277797.git.gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 22:50:02 -0800
In-Reply-To: <25d1a2963f2934753de4fb6899429301637377c9.1644277797.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 07 Feb 2022
        23:49:56 +0000")
Message-ID: <xmqqsfstett1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 584814F6-88AB-11EC-8C7E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When we taught these commands about the sparse index, we did not account
> for the fact that the `cmd_*()` functions _can_ be called without a
> gitdir, namely when `-h` is passed to show the usage.
>
> A plausible approach to address this is to move the
> `prepare_repo_settings()` calls right after the `parse_options()` calls:
> The latter will never return when it handles `-h`, and therefore it is
> safe to assume that we have a `gitdir` at that point, as long as the
> built-in is marked with the `RUN_SETUP` flag.
>
> However, it is unfortunately not that simple. In `cmd_pack_objects()`,
> for example, the repo settings need to be fully populated so that the
> command-line options `--sparse`/`--no-sparse` can override them, not the
> other way round.
>
> Therefore, we choose to imitate the strategy taken in `cmd_diff()`,
> where we simply do not bother to prepare and initialize the repo
> settings unless we have a `gitdir`.
>
> This fixes https://github.com/git-for-windows/git/issues/3688
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

These "prepare" calls are always tricky.  This somehow reminds me of
44c7e62e (repo-settings: prepare_repo_settings only in git repos,
2021-12-06) and e5b17bda (git: ensure correct git directory setup
with -h, 2021-12-06), which were part of the ld/sparse-diff-blame
topic that was merged at 8d2c3732 during the last cycle.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index cc804ba8e1e..1c13d7fedb3 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1602,9 +1602,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	opts->show_progress = -1;
>  
>  	git_config(git_checkout_config, opts);
> -
> -	prepare_repo_settings(the_repository);
> -	the_repository->settings.command_requires_full_index = 0;
> +	if (the_repository->gitdir) {
> +		prepare_repo_settings(the_repository);
> +		the_repository->settings.command_requires_full_index = 0;
> +	}

Looks quite straight-forward and sensible.  Of course, the checkout
command will go berserk and do nonsense if it is allowed to proceed
much further from here without .gitdir, but we know that 

 (1) the only case where .gitdir is NULL at this point is when
     running "-h" from outside a repository (we would have done a
     full RUN_SETUP without demoting it to RUN_SETUP_GENTLY if we
     weren't doing "-h"), and that

 (2) this is soon followed by parse_options() where it notices "-h"
     and stops.

so skipping "prepare" outside a repository is totally safe.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 5f06b21f8e9..e0a05de10ee 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2014,11 +2014,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	git_config(git_fetch_config, NULL);
> -	prepare_repo_settings(the_repository);
> -	the_repository->settings.command_requires_full_index = 0;
> +	if (the_repository->gitdir) {
> +		prepare_repo_settings(the_repository);
> +		the_repository->settings.command_requires_full_index = 0;
> +	}

Ditto.

>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
> +
>  	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {

Unrelated blank line?

>  		int *sfjc = submodule_fetch_jobs_config == -1
>  			    ? &submodule_fetch_jobs_config : NULL;
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ba2006f2212..87cb7b45c37 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3976,9 +3976,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	read_replace_refs = 0;
>  
>  	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
> -	prepare_repo_settings(the_repository);
> -	if (sparse < 0)
> -		sparse = the_repository->settings.pack_use_sparse;
> +	if (the_repository->gitdir) {
> +		prepare_repo_settings(the_repository);
> +		if (sparse < 0)
> +			sparse = the_repository->settings.pack_use_sparse;
> +	}
>  
>  	reset_pack_idx_option(&pack_idx_opts);
>  	git_config(git_pack_config, NULL);

This has a bit more sequence of calls until it reaches parse_options(),
but their side effect, when run outside a repository, are all benign
in-core effects, so this is safe, too.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 100cbf9fb85..d15007d93f3 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -994,8 +994,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		set_reflog_message(argc, argv);
>  
>  	git_config(git_pull_config, NULL);
> -	prepare_repo_settings(the_repository);
> -	the_repository->settings.command_requires_full_index = 0;
> +	if (the_repository->gitdir) {
> +		prepare_repo_settings(the_repository);
> +		the_repository->settings.command_requires_full_index = 0;
> +	}
>  
>  	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
