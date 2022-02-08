Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20B5C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386781AbiBHWZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387266AbiBHWS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 17:18:57 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78BC0612B8
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 14:18:56 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB04B186BC9;
        Tue,  8 Feb 2022 17:18:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KjXTUteIaLZCS8AuLCaaojmhZYU8c5ktNT8rhO
        8+Tdc=; b=luRX69/19JE59TVieZYscJGT+7LRpLuuJcCKAAaqhrDi0Fzeb3ekVl
        4hUh+S7lMeTM9Kd7rL1HDj4r7bfxLeoAzq6OtlYF94gLms/wVhrvZqV+GSRJEuGP
        NYGPx3TinkG1HxZb1JL4KN3kNgh5kF3H+z5tCyv8dbOgJUCymb2fw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1E7C186BC8;
        Tue,  8 Feb 2022 17:18:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2D9C6186BC7;
        Tue,  8 Feb 2022 17:18:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 3/6] config: add repo_config_set_worktree_gently()
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <cf9e86fe3a403d0ceaff9fdf484a9bf6b07799ac.1644269583.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 14:18:52 -0800
In-Reply-To: <cf9e86fe3a403d0ceaff9fdf484a9bf6b07799ac.1644269583.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 07 Feb 2022
        21:33:00 +0000")
Message-ID: <xmqqv8xpato3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19439BE0-892D-11EC-8D94-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Some config settings, such as those for sparse-checkout, are likely
> intended to only apply to one worktree at a time. To make this write
> easier, add a new config API method, repo_config_set_worktree_gently().
>
> This method will attempt to write to the worktree-specific config, but
> will instead write to the common config file if worktree config is not
> enabled.  The next change will introduce a consumer of this method.

Makes sense.

> +int repo_config_set_worktree_gently(struct repository *r,
> +				    const char *key, const char *value)
> +{
> +	/* Only use worktree-specific config if it is is already enabled. */
> +	if (repository_format_worktree_config) {
> +		char *file = repo_git_path(r, "config.worktree");
> +		int ret = git_config_set_multivar_in_file_gently(
> +					file, key, value, NULL, 0);
> +		free(file);
> +		return ret;
> +	}
> +	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
> +}

OK.

> @@ -3181,14 +3196,28 @@ void git_config_set_multivar_in_file(const char *config_filename,
>  int git_config_set_multivar_gently(const char *key, const char *value,
>  				   const char *value_pattern, unsigned flags)
>  {
> -	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
> -						      flags);
> +	return repo_config_set_multivar_gently(the_repository, key, value,
> +					       value_pattern, flags);
> +}

Is this an unrelated "morally no-op" change?

> +int repo_config_set_multivar_gently(struct repository *r, const char *key,
> +				    const char *value,
> +				    const char *value_pattern, unsigned flags)
> +{
> +	char *file = repo_git_path(r, "config");
> +	int res = git_config_set_multivar_in_file_gently(file,
> +							 key, value,
> +							 value_pattern,
> +							 flags);
> +	free(file);
> +	return res;
>  }

OK.

>  void git_config_set_multivar(const char *key, const char *value,
>  			     const char *value_pattern, unsigned flags)
>  {
> -	git_config_set_multivar_in_file(NULL, key, value, value_pattern,
> +	git_config_set_multivar_in_file(git_path("config"),
> +					key, value, value_pattern,
>  					flags);
>  }

Is this an unrelated "morally no-op" change?

It might have value to make caller more explicit by reducing the use
of "I give NULL, you use 'config' for me", but that doesn't sound
related to the addition of set_per_worktree_config_gently() helper.

> diff --git a/config.h b/config.h
> index f119de01309..1d98ad269bd 100644
> --- a/config.h
> +++ b/config.h
> @@ -253,6 +253,13 @@ void git_config_set_in_file(const char *, const char *, const char *);
>  
>  int git_config_set_gently(const char *, const char *);
>  
> +/**
> + * Write a config value that should apply to the current worktree. If
> + * extensions.worktreeConfig is enabled, then the write will happen in the
> + * current worktree's config. Otherwise, write to the common config file.
> + */
> +int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
> +
>  /**
>   * write config values to `.git/config`, takes a key/value pair as parameter.
>   */
> @@ -281,6 +288,7 @@ int git_config_parse_key(const char *, char **, size_t *);
>  
>  int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
>  void git_config_set_multivar(const char *, const char *, const char *, unsigned);
> +int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
>  int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
>  
>  /**
