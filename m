Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4DEC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJLVIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJLVID (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:08:03 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705A3F028
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:07:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA9B215613C;
        Wed, 12 Oct 2022 17:07:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kOlUCmBCU7+t7OyKtmbBCwMsoMXD3K/J6nXzkh
        +SRRE=; b=GzlofisFgkDohF3VGb5UvOAN0Qf2G8A3A3bfdd+OngOlIVye0Sms0C
        zAA7Sr4RlxICrXMRPrwUdBCAYyBI+yUaBL1vekreqbKMcIsGwo91RPedkQDks5+z
        x00ZG7Hb+WU90eSrC+yIXYBQX74vAO8q7WmQ92AJ995dyPW8jwsNQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A182515613A;
        Wed, 12 Oct 2022 17:07:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F87415612E;
        Wed, 12 Oct 2022 17:07:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 2/2] config: respect includes in protected config
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
        <0ff5b5741a519c63e65ef57d7d0b3148c38c1a52.1665603814.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 14:07:52 -0700
In-Reply-To: <0ff5b5741a519c63e65ef57d7d0b3148c38c1a52.1665603814.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Wed, 12 Oct 2022 19:43:34
        +0000")
Message-ID: <xmqqilkokaxj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F03F3DF6-4A71-11ED-9AF3-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -int git_configset_add_parameters(struct config_set *cs)
> -{
> -	return git_config_from_parameters(config_set_callback, cs);
> -}
> -
>  int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
>  {
>  	const struct string_list *values = NULL;
> @@ -2641,24 +2636,15 @@ int repo_config_get_pathname(struct repository *repo,
>  /* Read values into protected_config. */
>  static void read_protected_config(void)
>  {
> -	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
> -
> +	struct config_options opts = {
> +		.respect_includes = 1,
> +		.ignore_repo = 1,
> +		.ignore_worktree = 1,
> +		.system_gently = 1,
> +	};
>  	git_configset_init(&protected_config);
> -
> -	system_config = git_system_config();
> -	git_global_config(&user_config, &xdg_config);
> -
> -	if (system_config)
> -		git_configset_add_file(&protected_config, system_config);
> -	if (xdg_config)
> -		git_configset_add_file(&protected_config, xdg_config);
> -	if (user_config)
> -		git_configset_add_file(&protected_config, user_config);
> -	git_configset_add_parameters(&protected_config);
> -	free(system_config);
> -	free(xdg_config);
> -	free(user_config);

Compared to the above hand-crafted sequence, we seem to be a lot
more careful in config.c::do_git_config_sequence() with respect to
error checking, which is good.  We can lose the custom helper to
read from command line parameters, which is also nice.

> +	config_with_options(config_set_callback, &protected_config,
> +			    NULL, &opts);
>  }

Very nice, code reduction with an additional feature.  I wish all
fixes were like this.

>  config.c                        | 30 ++++++++----------------------
>  t/t0033-safe-directory.sh       |  2 +-
>  t/t0035-safe-bare-repository.sh |  2 +-
>  3 files changed, 10 insertions(+), 24 deletions(-)
