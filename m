Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8DCEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFTVBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjFTVBu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 17:01:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E5F1731
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:01:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60A1018E4F6;
        Tue, 20 Jun 2023 17:01:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2kznIs8FoAl2Pm+++sRpxy0C+Eh3HEvRXmAY3O
        ZtELY=; b=FsDQ46Ojl44dWO0Fc/gzhB0Ot+YHsZtk5RXcsuTCyovPf+mrRwPL1c
        Pkwp+tdXQ5yPGFc1IXNat70zFGLGGyTSgFxB6+Q6AXt7W3R9/JxLKNEdOAx/fxFU
        MAPsuqvpSeVocjFtGKKm/1JGn543sDb21t85ZMSH5O18vJLT7JlsY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5885618E4F5;
        Tue, 20 Jun 2023 17:01:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C85518E4F1;
        Tue, 20 Jun 2023 17:01:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 01/12] config: inline git_color_default_config
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <26109b65142d2a325201940262a6c0bf183ec4bd.1687290232.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 14:01:45 -0700
In-Reply-To: <26109b65142d2a325201940262a6c0bf183ec4bd.1687290232.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Tue, 20 Jun 2023 19:43:40
        +0000")
Message-ID: <xmqqjzvxlufa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAE4D2D2-0FAD-11EE-9452-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> git_color_default_config() is a shorthand for calling two other config
> callbacks. There are no other non-static functions that do this and it
> will complicate our refactoring of config_fn_t so inline it instead.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---

We would need to deal with git_default_config() that is called from
everywhere in exactly the same way, so I am not sure if the presence
of git_color_default_config() will complicate so much to require
this step while git_default_config() can be dealt with without
inlining into its callers, but this change does not hurt anybody
either.

OK.  

>  builtin/branch.c      | 5 ++++-
>  builtin/clean.c       | 6 ++++--
>  builtin/grep.c        | 5 ++++-
>  builtin/show-branch.c | 5 ++++-
>  builtin/tag.c         | 6 +++++-
>  color.c               | 8 --------
>  color.h               | 6 +-----
>  7 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index e6c2655af68..df99e38847b 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -117,7 +117,10 @@ static int git_branch_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> -	return git_color_default_config(var, value, cb);
> +	if (git_color_config(var, value, cb) < 0)
> +		return -1;
> +
> +	return git_default_config(var, value, cb);
>  }
>  
>  static const char *branch_get_color(enum color_branch ix)
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 78852d28cec..57e7f7cac64 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -130,8 +130,10 @@ static int git_clean_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> -	/* inspect the color.ui config variable and others */
> -	return git_color_default_config(var, value, cb);
> +	if (git_color_config(var, value, cb) < 0)
> +		return -1;
> +
> +	return git_default_config(var, value, cb);
>  }
>  
>  static const char *clean_get_color(enum color_clean ix)
> diff --git a/builtin/grep.c b/builtin/grep.c
> index b86c754defb..76cf999d310 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -293,7 +293,10 @@ static int wait_all(void)
>  static int grep_cmd_config(const char *var, const char *value, void *cb)
>  {
>  	int st = grep_config(var, value, cb);
> -	if (git_color_default_config(var, value, NULL) < 0)
> +
> +	if (git_color_config(var, value, cb) < 0)
> +		st = -1;
> +	else if (git_default_config(var, value, cb) < 0)
>  		st = -1;
>  
>  	if (!strcmp(var, "grep.threads")) {
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 7ef4a642c17..a2461270d4b 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -579,7 +579,10 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> -	return git_color_default_config(var, value, cb);
> +	if (git_color_config(var, value, cb) < 0)
> +		return -1;
> +
> +	return git_default_config(var, value, cb);
>  }
>  
>  static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 49b64c7a288..1acf5f7a59f 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -209,7 +209,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
>  
>  	if (starts_with(var, "column."))
>  		return git_column_config(var, value, "tag", &colopts);
> -	return git_color_default_config(var, value, cb);
> +
> +	if (git_color_config(var, value, cb) < 0)
> +		return -1;
> +
> +	return git_default_config(var, value, cb);
>  }
>  
>  static void write_tag_body(int fd, const struct object_id *oid)
> diff --git a/color.c b/color.c
> index 83abb11eda0..b24b19566b9 100644
> --- a/color.c
> +++ b/color.c
> @@ -430,14 +430,6 @@ int git_color_config(const char *var, const char *value, void *cb UNUSED)
>  	return 0;
>  }
>  
> -int git_color_default_config(const char *var, const char *value, void *cb)
> -{
> -	if (git_color_config(var, value, cb) < 0)
> -		return -1;
> -
> -	return git_default_config(var, value, cb);
> -}
> -
>  void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb)
>  {
>  	if (*color)
> diff --git a/color.h b/color.h
> index cfc8f841b23..bb28343be21 100644
> --- a/color.h
> +++ b/color.h
> @@ -88,12 +88,8 @@ extern const int column_colors_ansi_max;
>   */
>  extern int color_stdout_is_tty;
>  
> -/*
> - * Use the first one if you need only color config; the second is a convenience
> - * if you are just going to change to git_default_config, too.
> - */
> +/* Parse color config. */
>  int git_color_config(const char *var, const char *value, void *cb);
> -int git_color_default_config(const char *var, const char *value, void *cb);
>  
>  /*
>   * Parse a config option, which can be a boolean or one of
