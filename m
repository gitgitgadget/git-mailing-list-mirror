Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DDC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbiC2RpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbiC2RpV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:45:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20FEDEB8
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:43:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8A2C109F55;
        Tue, 29 Mar 2022 13:43:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vI/cJfUHrlFed1eE96TzYCunqduor9TKk4ymHE
        RuXnw=; b=KzbPBtxz23QVeGMn/wemNf6Kkf0FjJ5vWDr+FKwG8OWVNaem2kLPQC
        vlBo5GznFyDLkyd1HlaFjdNkWFTuz2HodWAlea2sTkhGk0HXGAZLUQ1QzecuaI9V
        h1j5WemVC+flheNe19KYG71Ma+YWIJfXLkzYGfbYbY0m5gJdHmlMM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C03B7109F54;
        Tue, 29 Mar 2022 13:43:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20212109F53;
        Tue, 29 Mar 2022 13:43:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 2/2] untracked-cache: support '--untracked-files=all'
 if configured
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
        <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
        <f60d2c6e36c3218f9b19d7ce62a090d7d6e0e7f6.1648553134.git.gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 10:43:35 -0700
In-Reply-To: <f60d2c6e36c3218f9b19d7ce62a090d7d6e0e7f6.1648553134.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Tue, 29 Mar 2022 11:25:34
        +0000")
Message-ID: <xmqqsfr0u01k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C29305CA-AF87-11EC-B0C4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> Untracked cache was originally designed to only work with
> '--untracked-files=normal', but this causes performance issues for UI
> tooling that wants to see "all" on a frequent basis. On the other hand,
> the conditions that prevented applicability to the "all" mode no
> longer seem to apply.

There is a slight leap in logic flow before ", but this causes" that
forces readers read the above twice and guess what is missing.  I am
guessing that

    ... was designed to only work with "--untracked-files=normal",
    and is bypassed when "--untracked-files=all" request, but this
    causes ...

is what you meant to say.

The claim in the last sentence "... no longer seem to apply" is
thrown at the readers without much rationale.  Either justify it
more solidly or discard the claim?

> The disqualification of untracked cache has a particularly significant
> impact on Windows with the defaulted fscache, where the introduction
> of fsmonitor can make the first and costly directory-iteration happen
> in untracked file detection, single-threaded, rather than in
> preload-index on multiple threads. Improving the performance of a
> "normal" 'git status' run with fsmonitor can make
> 'git status --untracked-files=all' perform much worse.

The last sentence is a bit hard to parse and very hard to reason
about.  Do you mean to say "--untracked-files=all is slower when the
untracked cache is in use, so the performance of 'git status' may be
improved for '--untracked-files=normal' when the untracked cache is
used, it hurts when 'git status --untracked-files=all' is run"?

> To partially address this, align the supported directory flags for the
> stored untracked cache data with the git config. If a user specifies
> an '--untracked-files=' commandline parameter that does not align with
> their 'status.showuntrackedfiles' config value, then the untracked
> cache will be ignored - as it is for other unsupported situations like
> when a pathspec is specified.
>
> If the previously stored flags no longer match the current
> configuration, but the currently-applicable flags do match the current
> configuration, then discard the previously stored untracked cache
> data.

Let me follow what actually happens in the patch aloud.

> -static void new_untracked_cache(struct index_state *istate)
> +static unsigned new_untracked_cache_flags(struct index_state *istate)
> +{
> +	struct repository *repo = istate->repo;
> +	char *val;
> +
> +	/*
> +	 * This logic is coordinated with the setting of these flags in
> +	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
> +	 * of the config setting in commit.c#git_status_config()
> +	 */
> +	if (!repo_config_get_string(repo, "status.showuntrackedfiles", &val) &&
> +	    !strcmp(val, "all"))
> +		return 0;
> +
> +	/*
> +	 * The default, if "all" is not set, is "normal" - leading us here.
> +	 * If the value is "none" then it really doesn't matter.
> +	 */
> +	return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> +}

This _guesses_ the user preference from the configuration.

> +static void new_untracked_cache(struct index_state *istate, int flags)
>  {
>  	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
>  	strbuf_init(&uc->ident, 100);
>  	uc->exclude_per_dir = ".gitignore";
> -	/* should be the same flags used by git-status */
> -	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> +	uc->dir_flags = flags >= 0 ? flags : new_untracked_cache_flags(istate);

We use unsigned for the flag word unless there is a reason not to,
but this function wants to use top-bit as a signal to "guess from
config".  The caller either dictates what bits to set, or we guess.

And the created uc records the flags.

> @@ -2762,11 +2782,11 @@ static void new_untracked_cache(struct index_state *istate)
>  void add_untracked_cache(struct index_state *istate)
>  {
>  	if (!istate->untracked) {
> -		new_untracked_cache(istate);
> +		new_untracked_cache(istate, -1);

We are newly creating, so "-1" (guess from config) may be the most
appropriate (unless the caller of add_untracked_cache() already
knows what operation it is using for, that is).

>  	} else {
>  		if (!ident_in_untracked(istate->untracked)) {

Found an existing one but need to recreate.

>  			free_untracked_cache(istate->untracked);
> -			new_untracked_cache(istate);
> +			new_untracked_cache(istate, -1);

In this case, is it likely to give us a better guess to read the
configuration, or copy from the existing untracked file?  My gut
feeling says it would be the latter, and if that is correct, then
we might want

+	      		int old_flags = istate->untracked->dir_flags;
 			free_untracked_cache(istate->untracked);
-			new_untracked_cache(istate);
+			new_untracked_cache(istate, old_flags);

instead?  I dunno.

> @@ -2781,9 +2801,9 @@ void remove_untracked_cache(struct index_state *istate)
>  }
>  
>  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
> -						      int base_len,
> -						      const struct pathspec *pathspec,
> -						      struct index_state *istate)
> +							    int base_len,
> +							    const struct pathspec *pathspec,
> +							    struct index_state *istate)
>  {
>  	struct untracked_cache_dir *root;
>  	static int untracked_cache_disabled = -1;

Is this just re-indenting?  Not very welcome, but OK.

> @@ -2814,17 +2834,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>  	if (base_len || (pathspec && pathspec->nr))
>  		return NULL;
>  
> -	/* Different set of flags may produce different results */
> -	if (dir->flags != dir->untracked->dir_flags ||
> -	    /*
> -	     * See treat_directory(), case index_nonexistent. Without
> -	     * this flag, we may need to also cache .git file content
> -	     * for the resolve_gitlink_ref() call, which we don't.
> -	     */
> -	    !(dir->flags & DIR_SHOW_OTHER_DIRECTORIES) ||
> -	    /* We don't support collecting ignore files */
> -	    (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> -			   DIR_COLLECT_IGNORED)))
> +	/* We don't support collecting ignore files */
> +	if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> +			DIR_COLLECT_IGNORED))
>  		return NULL;
>  
>  	/*
> @@ -2847,6 +2859,41 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>  		return NULL;
>  	}
>  
> +	/*
> +	 * We don't support using or preparing the untracked cache if
> +	 * the current effective flags don't match the configured
> +	 * flags.
> +	 */

Is that what we want?  What happens when your user does this:

    - set showuntrackedfiles to "normal"
    - generate the untracked cache
    - set showuntrackedfiles to "all"

And now the user wants to make a request that wants to see flags
that are suitable for "normal".

The best case would be for the untracked cache to know what flags
were in use when it was generated, so that in the above sequence,
even though the current value of configuration variable and the
current request from the command line contradict each other, we
can notice that the untracked cache data is suitable for the current
request and the right thing happens.

> +	if (dir->flags != new_untracked_cache_flags(istate))
> +		return NULL;

But this only pays attention to what is in the configuration?  It
seems to me that it is being too pessimistic, but perhaps it is
necessary for correctness somehow?

Thanks.

