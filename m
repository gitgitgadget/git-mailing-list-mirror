Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EC3C43219
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387124AbiBHWYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387238AbiBHWJT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 17:09:19 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF7CC0612B8
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 14:09:17 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37FB2105938;
        Tue,  8 Feb 2022 17:09:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mcsccxvlap8+iS5NM5VCiHF00kki/CWajqc+XR
        6HF2U=; b=D9woibfnLQnExRv/dzTR4p/68p9P4dDvmE4JTR7mVR6EAddoGvy7C/
        /TXMB4vhQRrlc0BiK3zQz8otEynpfa0kiLeC4ghasvDy2yC8EQ3xCRoiuhmQv/mr
        GG0x2+yRn/vJYsOXuj+KZDRPfFutfbzF0fUPIoRPjltd5YUcVekzw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F1C9105936;
        Tue,  8 Feb 2022 17:09:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B3EA105935;
        Tue,  8 Feb 2022 17:09:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 2/6] worktree: create init_worktree_config()
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <5d0cc242d92c68bf239f9e17eab9c80ec6b2d469.1644269583.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 14:09:13 -0800
In-Reply-To: <5d0cc242d92c68bf239f9e17eab9c80ec6b2d469.1644269583.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 07 Feb 2022
        21:32:59 +0000")
Message-ID: <xmqq1r0dc8om.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C062B48A-892B-11EC-B64A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int move_config_setting(const char *key, const char *value,
> +			       const char *from_file, const char *to_file)
> +{
> +	if (git_config_set_in_file_gently(to_file, key, value))
> +		return error(_("unable to set %s in '%s'"), key, to_file);
> +	if (git_config_set_in_file_gently(from_file, key, NULL))
> +		return error(_("unable to unset %s in '%s'"), key, from_file);
> +	return 0;
> +}

Interesting.

The verb "move" in its name made me expect a "get (and remove)
whatever value(s) defined out of the old file, and set them
identically in the new file" sequence, but that is not what is done
here.  "set to this new single value in the new file and unset from
the old one".

I can see the need to say "move it only when its value is X",
so having the caller to extract the value before deciding to call
the function (hence not "moving from old") does make sense, but then
the function is misnamed---it is not "moving", it is doing something
else.

> +int init_worktree_config(struct repository *r)
> +{
> +	int res = 0;
> +	int bare = 0;
> +	struct config_set cs = { { 0 } };
> +	const char *core_worktree;
> +	char *common_config_file;
> +	char *main_worktree_file;
> +
> +	/*
> +	 * If the extension is already enabled, then we can skip the
> +	 * upgrade process.
> +	 */
> +	if (repository_format_worktree_config)
> +		return 0;

OK.

> +	if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
> +		return error(_("failed to set extensions.worktreeConfig setting"));

OK.

> +	common_config_file = xstrfmt("%s/config", r->commondir);
> +	main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> +
> +	git_configset_init(&cs);
> +	git_configset_add_file(&cs, common_config_file);
> +
> +	/*
> +	 * If core.bare is true in the common config file, then we need to
> +	 * move it to the main worktree's config file or it will break all
> +	 * worktrees. If it is false, then leave it in place because it
> +	 * _could_ be negating a global core.bare=true.
> +	 */

Is the assumption that the secondary worktrees are never bare, but
the primary one could be (iow, adding worktrees to a bare repository
would leave the original bare repository as the primary "worktree"
that does not have "working tree")?  I am trying to see what downsides
it tries to avoid by not moving the core.bare==false setting.  Shouldn't
core.bare be set to false when "worktree add" creates a new one anyway,
if the secondaries are never bare?

> +	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
> +		if ((res = move_config_setting("core.bare", "true",
> +					       common_config_file,
> +					       main_worktree_file)))
> +			goto cleanup;
> +	}

> +	/*
> +	 * If core.worktree is set, then the main worktree is located
> +	 * somewhere different than the parent of the common Git dir.

OK.  We do not want to share the working tree for the primary worktree
among secondary worktrees.  For the primary, common and uncommon are
the same, so it may not matter, but mention of "common Git dir" here
may confuse readers?  Unless overridden by the config, the parent of
the git dir is the root of the working tree, no?

> +	 * Relocate that value to avoid breaking all worktrees with this
> +	 * upgrade to worktree config.
> +	 */

And if it is not set, then working tree of each worktree is the
parent of the per-worktree Git dir, so they will automatically
become separate, which makes sense.

> +	if (!git_configset_get_value(&cs, "core.worktree", &core_worktree)) {
> +		if ((res = move_config_setting("core.worktree", core_worktree,
> +					       common_config_file,
> +					       main_worktree_file)))
> +			goto cleanup;
> +	}
> +
> +	/*
> +	 * Ensure that we use worktree config for the remaining lifetime
> +	 * of the current process.
> +	 */
> +	repository_format_worktree_config = 1;
> +
> +cleanup:
> +	git_configset_clear(&cs);
> +	free(common_config_file);
> +	free(main_worktree_file);
> +	return res;
> +}
> diff --git a/worktree.h b/worktree.h
> index 9e06fcbdf3d..e9e839926b0 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -183,4 +183,25 @@ void strbuf_worktree_ref(const struct worktree *wt,
>  			 struct strbuf *sb,
>  			 const char *refname);
>  
> +/**
> + * Enable worktree config for the first time. This will make the following
> + * adjustments:
> + *
> + * 1. Add extensions.worktreeConfig=true in the common config file.
> + *
> + * 2. If the common config file has a core.worktree value, then that value
> + *    is moved to the main worktree's config.worktree file.
> + *
> + * 3. If the common config file has a core.bare enabled, then that value
> + *    is moved to the main worktree's config.worktree file.
> + *
> + * If extensions.worktreeConfig is already true, then this method
> + * terminates early without any of the above steps. The existing config
> + * arrangement is assumed to be intentional.
> + *
> + * Returns 0 on success. Reports an error message and returns non-zero
> + * if any of these steps fail.
> + */
> +int init_worktree_config(struct repository *r);
> +
>  #endif
