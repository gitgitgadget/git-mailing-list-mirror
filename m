Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB5C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 05:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhLVFiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 00:38:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64604 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhLVFiM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 00:38:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF732184370;
        Wed, 22 Dec 2021 00:38:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4jM4UyLCPyJYawju65+b6YgCCaE8asHpfDnFmA
        fn5ME=; b=mX0EOvS9qOIFLhcQhXuRixV8KwvbB7kdLkgdiDvCzZgl2sfvuKOs7Q
        FaLSBDrfbBLMHxDpnoIWZ9gVsb6YSOpjVoZ9ksK1ffraxSzZIFYJRSkd0O4Lqk+5
        vgN2nMqu+iwS59aCOZct9QFcD+wXFcp32VpQZXWaJcIhXrUs3SYjw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C711418436F;
        Wed, 22 Dec 2021 00:38:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F8E418436C;
        Wed, 22 Dec 2021 00:38:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, sunshine@sunshineco.com,
        allred.sean@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/5] worktree: add upgrade_to_worktree_config()
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
        <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
        <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 21:38:06 -0800
In-Reply-To: <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 21 Dec 2021
        19:14:06 +0000")
Message-ID: <xmqq4k71mc75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57D4DD98-62E9-11EC-8F1A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +int upgrade_to_worktree_config(struct repository *r)

Not a suggestion to rename the function, but does it mean "we have
been using a single configuration for all worktrees attached to the
repository, but we are switching to use per-worktree configuration
file"?  I am wondering if the phrase "worktree_config" is clear
enough for our future developers.

> +{
> +	int res;
> +	int bare = 0;
> +	struct config_set cs = { 0 };
> +	char *base_config_file = xstrfmt("%s/config", r->commondir);
> +	char *base_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> +
> +	git_configset_init(&cs);
> +	git_configset_add_file(&cs, base_config_file);
> +
> +	/*
> +	 * If the base repository is bare, then we need to move core.bare=true
> +	 * out of the base config file and into the base repository's
> +	 * config.worktree file.
> +	 */
> +	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
> +		if ((res = git_config_set_in_file_gently(base_worktree_file,
> +							"core.bare", "true"))) {
> +			error(_("unable to set core.bare=true in '%s'"), base_worktree_file);
> +			goto cleanup;
> +		}

Hmph, I would have expected to see

		if (git_config_set_in_file_gently(...)) {
			res = error(_("..."));
                        goto cleanup;
		}

instead (obviously with "res" initialized to "0" to assume all will
be well at the beginning).

More importantly, are we prepared to see the repository 'r' that
already uses per-worktree config layout and refrain from causing any
damage to it, or are we all perfect developers that any caller that
calls this on repository 'r' that does not need to be upgraded is a
BUG()?

Is "core.bare" the only thing that needs special treatment?  Will it
stay to be, or will we see more configuration variables that need
special casing like this?

> +	if (upgrade_repository_format(r, 1) < 0) {
> +		res = error(_("unable to upgrade repository format to enable worktreeConfig"));
> +		goto cleanup;
> +	}
> +	if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
> +		error(_("failed to set extensions.worktreeConfig setting"));
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	git_configset_clear(&cs);
> +	free(base_config_file);
> +	free(base_worktree_file);
> +	trace2_printf("returning %d", res);
> +	return res;
> +}
> diff --git a/worktree.h b/worktree.h
> index 8b7c408132d..170b6b1e1f5 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -182,4 +182,16 @@ void strbuf_worktree_ref(const struct worktree *wt,
>  			 struct strbuf *sb,
>  			 const char *refname);
>  
> +/**
> + * Upgrade the config of the current repository and its base (if different
> + * from this repository) to use worktree-config. This might adjust config
> + * in both repositories, including:
> + *
> + * 1. Upgrading the repository format version to 1.
> + * 2. Adding extensions.worktreeConfig to the base config file.
> + * 3. Moving core.bare=true from the base config file to the base
> + *    repository's config.worktree file.
> + */
> +int upgrade_to_worktree_config(struct repository *r);
> +
>  #endif
