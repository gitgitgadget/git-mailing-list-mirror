Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F553C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B3860EB2
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhGWT4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:56:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57348 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWT4L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 15:56:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E137C1D07;
        Fri, 23 Jul 2021 16:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/XZ3wc/iQ56f5JoG/uEj9wGN+Rz9WmAb1BvA9J
        JFI3k=; b=dHIJEIf9VhTmwu4wEFHQuPc2XJh0dYnJvfCQnd7KH9PccH+QjXCOG1
        uAdtvywbagU7r629/8CiP0OIXMvHpkiQh5GhRj/YRcZBOUrxLq54VxmtSvJwDC01
        +yO7JAfsFKi85DQ6CjqioB3HFGY5xnOI857LHvnqaTjDAgAhQj0U4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95B1FC1D06;
        Fri, 23 Jul 2021 16:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E6BAC1D05;
        Fri, 23 Jul 2021 16:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>
Subject: Re: [GSoC] [PATCH] submodule--helper: introduce add-config subcommand
References: <20210722112143.97944-1-raykar.ath@gmail.com>
Date:   Fri, 23 Jul 2021 13:36:42 -0700
In-Reply-To: <20210722112143.97944-1-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 22 Jul 2021 16:51:43 +0530")
Message-ID: <xmqq4kckn4x1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0D8F106-EBF5-11EB-8DA5-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> This is meant to be a faithful conversion from shell to C, with only one
> minor change: A warning is emitted if no value is specified in
> 'submodule.active', ie, the config looks like: "[submodule] active\n",

... meaning that submodule.active is *not* a boolean.

In scripted porcelain, I think we let "submodule--helper is-active"
to inspect its value(s), which may end up feeding a NULL as one of
the pathspec elements when calling parse_pathspec(), so this may
even be a bugfix.  In any case, I think "submodule--helper
is-active" is where such a fix should happen and in the longer term,
the code that says "if submodule.active exists, ask is-active and
set submodule.*.active accordingly, otherwise activate everything"
we see in this patch should be simplified to always ask is-active
and let is-active worry about cases like missing submodule.active
and submodule.active being valueless true, so let's not worry too
much about what happens in this patch, because it needs to be
cleaned up anyway after the dust settles.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 862053c9f2..9658804d24 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2936,6 +2936,130 @@ static int add_clone(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static void config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
> +{
> +	char *key;
> +
> +	if (!is_writing_gitmodules_ok())
> +		die(_("please make sure that the .gitmodules file is in the working tree"));
> +
> +	key = xstrfmt("submodule.%s.%s", name, var);
> +	config_set_in_gitmodules_file_gently(key, value);

This uses _gently() to avoid dying, but does it discard error return
and hide it from our callers?

> +	free(key);
> +}
> +
> +static void configure_added_submodule(struct add_data *add_data)
> +{
> +	char *key, *submod_pathspec = NULL;
> +	struct child_process add_submod = CHILD_PROCESS_INIT;
> +	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
> +	int pathspec_key_exists, activate = 0;
> +
> +	key = xstrfmt("submodule.%s.url", add_data->sm_name);
> +	git_config_set_gently(key, add_data->realrepo);
> +	free(key);
> +
> +	add_submod.git_cmd = 1;
> +	strvec_pushl(&add_submod.args, "add",
> +		     "--no-warn-embedded-repo", NULL);
> +	if (add_data->force)
> +		strvec_push(&add_submod.args, "--force");
> +	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
> +
> +	if (run_command(&add_submod))
> +		die(_("Failed to add submodule '%s'"), add_data->sm_path);
> +
> +	config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path);
> +	config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo);
> +	if (add_data->branch)
> +		config_submodule_in_gitmodules(add_data->sm_name,
> +					       "branch", add_data->branch);

A failure in any of the above in the scripted version used to result
in "failed to register submodule" error, but they are now ignored.
Intended?

> +	add_gitmodules.git_cmd = 1;
> +	strvec_pushl(&add_gitmodules.args,
> +		     "add", "--force", "--", ".gitmodules", NULL);
> +
> +	if (run_command(&add_gitmodules))
> +		die(_("Failed to register submodule '%s'"), add_data->sm_path);
> +
> +	/*
> +	 * NEEDSWORK: In a multi-working-tree world this needs to be
> +	 * set in the per-worktree config.
> +	 */
> +	pathspec_key_exists = !git_config_get_string("submodule.active",
> +						     &submod_pathspec);
> +	if (pathspec_key_exists && !submod_pathspec) {
> +		warning(_("The submodule.active configuration exists, but the "
> +			  "pathspec was unset. If the submodule is not already "
> +			  "active, the value of submodule.%s.active will be "
> +			  "be set to 'true'."), add_data->sm_name);
> +		activate = 1;
> +	}
> +
> +	/*
> +	 * If submodule.active does not exist, or if the pathspec was unset,
> +	 * we will activate this module unconditionally.
> +	 *
> +	 * Otherwise, we ask is_submodule_active(), which iterates
> +	 * through all the values of 'submodule.active' to determine
> +	 * if this module is already active.
> +	 */
> +	if (!pathspec_key_exists || activate ||
> +	    !is_submodule_active(the_repository, add_data->sm_path)) {
> +		key = xstrfmt("submodule.%s.active", add_data->sm_name);
> +		git_config_set_gently(key, "true");
> +		free(key);
> +	}

This is the part I discussed earlier.  I think this "optimize so
that we can avoid calling is_submodule_active()" should go away in
the long run.  In the current code, is_submodule_active() needs to
find out the value of submodule.active itself anyway, so the
short-circuit is not working as an optimization.

Other than the "what happens when we see errors?" issue, the patch
looks quite straight-forward rewrite from the scripted version.

Thanks.
