Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75773C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiBYToh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiBYTof (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:44:35 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F0D1A3621
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:44:02 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CA6A117148;
        Fri, 25 Feb 2022 14:44:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C+SaZeS7Cse9AbimAgOytppPx+a1LKXpYiTnd7
        uP4is=; b=aADVMo3fSlr31fkFUbh7bdy8cH63F5MpLeXScIKL6f/Z/L9YsfMPn3
        h0w/PXF7iNUE8QPLKV0Yt9ZdC2Hc2wInm1+erBrUfa30OtdvHOlAUDaoK1I/BKoV
        r7FHMtDw5rifPvGl9xIV06IRfFAvAAzO0A3gTCT+sqZJcFS6od3Do=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB988117147;
        Fri, 25 Feb 2022 14:44:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F6E7117146;
        Fri, 25 Feb 2022 14:44:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2] untracked-cache: support '--untracked-files=all' if
 configured
References: <pull.985.git.1624430668741.gitgitgadget@gmail.com>
        <pull.985.v2.git.1645811564461.gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 11:43:59 -0800
In-Reply-To: <pull.985.v2.git.1645811564461.gitgitgadget@gmail.com> (Tao
        Klerks via GitGitGadget's message of "Fri, 25 Feb 2022 17:52:44
        +0000")
Message-ID: <xmqqtucmag00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47326A38-9673-11EC-8801-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> If the previously stored flags no longer match the current
> configuration, but the currently-applicable flags do match the current
> configuration, then the previously stored untracked cache data is
> discarded.
>
> For most users there will be no change in behavior. Users who need
> '--untracked-files=all' to perform well will have the option of
> setting "status.showuntrackedfiles" to "all".
>
> Users who need '--untracked-files=all' to perform well for their
> tooling AND prefer to avoid the verbosity of "all" when running
> git status explicitly without options... are out of luck for now (no
> change).

So, in short, the root of the problem is that untracked cache can be
used to serve only one mode (between normal and all) of operation,
and the real solution to that problem must come in a different form,
i.e. allowing a single unified untracked cache to be usable in both
modes, perhaps by maintaining all the untracked ones in the cache,
but filter out upon output when the 'normal' mode is asked for?

> Users who set "status.showuntrackedfiles" to "all" and yet most
> frequently explicitly call 'git status --untracked-files=normal' (and
> use the untracked cache) are the only ones who would be disadvantaged
> by this change. It seems unlikely there are any such users.

Given how widely used we are these days, I am afraid that the days
we can safely say "users with such a strange use pattern would not
exist at all" is long gone.

> +static unsigned configured_default_dir_flags(struct index_state *istate)
> +{
> +	/* This logic is coordinated with the setting of these flags in
> +	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
> +	 * of the config setting in commit.c#git_status_config()
> +	 */

Good thing to note here.

Style.

  /*
   * Our multi-line comments reads more like this, with
   * slash-asterisk that opens, and asterisk-slash that closes,
   * sitting on their own lines.
   */

> +	char *status_untracked_files_config_value;
> +	int config_outcome = repo_config_get_string(istate->repo,
> +								"status.showuntrackedfiles",

The indentation looks a bit off.

In this project, tab width is 8.  The beginning of the second
parameter to the function call on the second line should align with
the beginning of the first parameter that immediately follows the
open parenthesis '('.

> +								&status_untracked_files_config_value);
> +	if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
> +		return 0;
> +	} else {
> +		/*
> +		 * The default, if "all" is not set, is "normal" - leading us here.
> +		 * If the value is "none" then it really doesn't matter.
> +		 */
> +		return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> +	}
> +}

I didn't see the need to pass istate to this function, though.
Shouldn't it take a repository instead?

> -static void new_untracked_cache(struct index_state *istate)
> +static void new_untracked_cache(struct index_state *istate, unsigned flags)
>  {
>  	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
>  	strbuf_init(&uc->ident, 100);
>  	uc->exclude_per_dir = ".gitignore";
> -	/* should be the same flags used by git-status */
> -	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> +	uc->dir_flags = flags;

So we used to hardcode these two flags to match what is done in
wt-status.c when show_untracked_files != SHOW_ALL_UNTRACKEDFILES;
we allow a different set of flags to be given by the caller.

> @@ -2761,11 +2781,13 @@ static void new_untracked_cache(struct index_state *istate)
>  void add_untracked_cache(struct index_state *istate)
>  {
>  	if (!istate->untracked) {
> -		new_untracked_cache(istate);
> +		new_untracked_cache(istate,
> +				configured_default_dir_flags(istate));
>  	} else {
>  		if (!ident_in_untracked(istate->untracked)) {
>  			free_untracked_cache(istate->untracked);
> -			new_untracked_cache(istate);
> +			new_untracked_cache(istate,
> +					configured_default_dir_flags(istate));
>  		}
>  	}
>  }

OK.  That's quite straight-forward to see how the tweak is made.

> @@ -2781,10 +2803,12 @@ void remove_untracked_cache(struct index_state *istate)
>  
>  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
>  						      int base_len,
> -						      const struct pathspec *pathspec)
> +						      const struct pathspec *pathspec,
> +							  struct index_state *istate)
>  {
>  	struct untracked_cache_dir *root;
>  	static int untracked_cache_disabled = -1;
> +	unsigned configured_dir_flags;
>  
>  	if (!dir->untracked)
>  		return NULL;
> @@ -2812,17 +2836,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>  	if (base_len || (pathspec && pathspec->nr))
>  		return NULL;
>  
> -	/* Different set of flags may produce different results */
> -	if (dir->flags != dir->untracked->dir_flags ||

This is removed because we are making sure that dir->flags and
dir->untracked->dir_flags match?

> -	    /*
> -	     * See treat_directory(), case index_nonexistent. Without
> -	     * this flag, we may need to also cache .git file content
> -	     * for the resolve_gitlink_ref() call, which we don't.
> -	     */
> -	    !(dir->flags & DIR_SHOW_OTHER_DIRECTORIES) ||

This is removed because...?

> -	    /* We don't support collecting ignore files */
> -	    (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> -			   DIR_COLLECT_IGNORED)))

> +	/* We don't support collecting ignore files */
> +	if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> +			DIR_COLLECT_IGNORED))
>  		return NULL;
>  
>  	/*
> @@ -2845,6 +2861,40 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>  		return NULL;
>  	}
>  
> +	/* We don't support using or preparing the untracked cache if
> +	 * the current effective flags don't match the configured
> +	 * flags.
> +	 */

Style (another one in large comment below).

> +	configured_dir_flags = configured_default_dir_flags(istate);
> +	if (dir->flags != configured_dir_flags)
> +		return NULL;

Hmph.  If this weren't necessary, this function does not need to
call configured_default_dir_flags(), and it can lose the
configured_dir_flags variable, too.  Which means that
new_untracked_cache() function does not need to take the flags word
as a caller-supplied parameter.  Instead, it can make a call to
configured_dir_flags() and assign the result to uc->dir_flags
itself, which would have been much nicer.

> +	/* If the untracked structure we received does not have the same flags
> +	 * as configured, but the configured flags do match the effective flags,
> +	 * then we need to reset / create a new "untracked" structure to match
> +	 * the new config.
> +	 * Keeping the saved and used untracked cache in-line with the
> +	 * configuration provides an opportunity for frequent users of
> +	 * "git status -uall" to leverage the untracked cache by aligning their
> +	 * configuration (setting "status.showuntrackedfiles" to "all" or
> +	 * "normal" as appropriate), where previously this option was
> +	 * incompatible with untracked cache and *consistently* caused
> +	 * surprisingly bad performance (with fscache and fsmonitor enabled) on
> +	 * Windows.
> +	 *
> +	 * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
> +	 * to not be as bound up with the desired output in a given run,
> +	 * and instead iterated through and stored enough information to
> +	 * correctly serve both "modes", then users could get peak performance
> +	 * with or without '-uall' regardless of their
> +	 * "status.showuntrackedfiles" config.
> +	 */
> +	if (dir->flags != dir->untracked->dir_flags) {
> +		free_untracked_cache(istate->untracked);
> +		new_untracked_cache(istate, configured_dir_flags);
> +		dir->untracked = istate->untracked;
> +	}


This compensates what we lost in the validate_untracked_cache()
above by making them match.  Looking reasonable.

>  	if (!dir->untracked->root)
>  		FLEX_ALLOC_STR(dir->untracked->root, name, "");
>  
> @@ -2916,7 +2966,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>  		return dir->nr;
>  	}
>  
> -	untracked = validate_untracked_cache(dir, len, pathspec);
> +	untracked = validate_untracked_cache(dir, len, pathspec, istate);
>  	if (!untracked)
>  		/*
>  		 * make sure untracked cache code path is disabled,
>
> base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
