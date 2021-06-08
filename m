Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5503BC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 04:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9D060FE3
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 04:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhFHEQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:16:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53772 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhFHEQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 00:16:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAE8FDD2BB;
        Tue,  8 Jun 2021 00:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zB46J5KFvrgIuyMF16LJxwBZRhPIBFOaG83Ut9
        CYwLY=; b=PQxCwqh4rRigzbQV1A9pfrn+TCSePFf3S4rPQXJWif3+wcucdkocNa
        MdD/2PJia1VumNF5FTzom/9GeLJhfrqq4T+eFLBswToT1EIi4t2otegB3bVFjZOV
        LPzOtVqC5WQ10V4lsqx36JVVr5e8uBxpu0lq6kKYRUs3sNdAmEz90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2770DD2BA;
        Tue,  8 Jun 2021 00:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E751DD2B9;
        Tue,  8 Jun 2021 00:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 3/4] run-command: move envvar-resetting function
References: <cover.1622580781.git.jonathantanmy@google.com>
        <cover.1623111879.git.jonathantanmy@google.com>
        <9cbdf60981e66e938b6c57c041c15e85245c734d.1623111879.git.jonathantanmy@google.com>
Date:   Tue, 08 Jun 2021 13:14:31 +0900
In-Reply-To: <9cbdf60981e66e938b6c57c041c15e85245c734d.1623111879.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 7 Jun 2021 17:25:58 -0700")
Message-ID: <xmqqo8chq9g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06B8CF2E-C810-11EB-91E0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> There is a function that resets environment variables, used when
> invoking a sub-process in a submodule. The lazy-fetching code (used in
> partial clones) will need this function in a subsequent commit, so move
> it to a more central location.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  run-command.c | 10 ++++++++++
>  run-command.h |  9 +++++++++
>  submodule.c   | 14 ++------------
>  3 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index be6bc128cd..a6c458119c 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1892,3 +1892,13 @@ int run_auto_maintenance(int quiet)
>  
>  	return run_command(&maint);
>  }
> +
> +void prepare_other_repo_env(struct strvec *env_array)
> +{
> +	const char * const *var;
> +
> +	for (var = local_repo_env; *var; var++) {
> +		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
> +			strvec_push(env_array, *var);
> +	}
> +}

It does make sense to move this to run-command.c from submodule.c
and the function name is already suitable for being global.  I
however cannot help wondering if we should also pay attention to the
GIT_CONFIG_KEY_$n and GIT_CONFIG_VALUE_$n pairs (which is not a new
problem in this patch).

This helper may sit better next to prep_childenv(), instead of just
saying "the location does not matter, just append randomly at the
end", though.

Otherwise looking good.

Thanks.



> diff --git a/run-command.h b/run-command.h
> index d08414a92e..a1d9107f5b 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -483,4 +483,13 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
>  			       task_finished_fn, void *pp_cb,
>  			       const char *tr2_category, const char *tr2_label);
>  
> +/**
> + * Convenience function which adds all GIT_* environment variables to env_array
> + * with the exception of GIT_CONFIG_PARAMETERS. When used as the env_array of a
> + * subprocess, these entries cause the corresponding environment variables to
> + * be unset in the subprocess. See local_repo_env in cache.h for more
> + * information.
> + */
> +void prepare_other_repo_env(struct strvec *env_array);
> +
>  #endif
> diff --git a/submodule.c b/submodule.c
> index 0b1d9c1dde..a30216db52 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -484,26 +484,16 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
>  	strbuf_release(&sb);
>  }
>  
> -static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
> -{
> -	const char * const *var;
> -
> -	for (var = local_repo_env; *var; var++) {
> -		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
> -			strvec_push(out, *var);
> -	}
> -}
> -
>  void prepare_submodule_repo_env(struct strvec *out)
>  {
> -	prepare_submodule_repo_env_no_git_dir(out);
> +	prepare_other_repo_env(out);
>  	strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
>  		     DEFAULT_GIT_DIR_ENVIRONMENT);
>  }
>  
>  static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
>  {
> -	prepare_submodule_repo_env_no_git_dir(out);
> +	prepare_other_repo_env(out);
>  	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
>  }
