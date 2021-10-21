Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5C1C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CB4610CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhJUVH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 17:07:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54198 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUVH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 17:07:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2164D163011;
        Thu, 21 Oct 2021 17:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sOAWus5jcZC1WhPSeDbpVrgvk0oB9tUE6o1jt7
        M2wOs=; b=h2pUD3UOy/trKKjgawfYVXByALzCG9kAtuLiZxbKqYkQVw9GIz0YhA
        fvXpukYEPjWiqGKVprRXkre1hxCtmtcZlvWl6kDbKYnfmPPIe4IU/9ZFqnHH1lDx
        03vfz3MwuhTaLaVQC3Py5kZ7UlZAKsvG25p9wGnnz//03jmzEIkHg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19E4D163010;
        Thu, 21 Oct 2021 17:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7BAED16300F;
        Thu, 21 Oct 2021 17:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 03/29] fsmonitor: config settings are
 repository-specific
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <882789b4dfebddb059f62b0b2edb95b92f3c69ee.1634826309.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:05:36 -0700
In-Reply-To: <882789b4dfebddb059f62b0b2edb95b92f3c69ee.1634826309.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Thu, 21 Oct 2021
        14:24:43 +0000")
Message-ID: <xmqqlf2mjdgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3CAF758-32B2-11EC-8D9C-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (fsmonitor > 0) {
> -		if (git_config_get_fsmonitor() == 0)
> +		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
> +
> +		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
> +			warning(_("core.useBuiltinFSMonitor is unset; "
> +				"set it if you really want to enable the "
> +				"builtin fsmonitor"));
>  			warning(_("core.fsmonitor is unset; "
> -				"set it if you really want to "
> -				"enable fsmonitor"));
> +				"set it if you really want to enable the "
> +				"hook-based fsmonitor"));
> +		}
>  		add_fsmonitor(&the_index);
>  		report(_("fsmonitor enabled"));
>  	} else if (!fsmonitor) {
> -		if (git_config_get_fsmonitor() == 1)
> +		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
> +		if (fsm_mode == FSMONITOR_MODE_IPC)
> +			warning(_("core.useBuiltinFSMonitor is set; "
> +				"remove it if you really want to "
> +				"disable fsmonitor"));
> +		if (fsm_mode == FSMONITOR_MODE_HOOK)
>  			warning(_("core.fsmonitor is set; "
>  				"remove it if you really want to "
>  				"disable fsmonitor"));

Hmph.  This does not change the behaviour per-se, but what are we
trying to achieve with these warning messages?  

The user uses --fsmonitor or --no-fsmonitor option from the command
line, presumably as a one-shot "this time I'd operate the command
differently from the configured way", so it seems unlikely that the
user is doing so because "... really want to enable/disable".  The
"report()" calls in these if/else cases seem sufficient reminder of
what is going on---perhaps these warnings should be made silenceable
by turning them into advice messages?

> -int git_config_get_fsmonitor(void)
> -{
> -	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
> -		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
> -
> -	if (core_fsmonitor && !*core_fsmonitor)
> -		core_fsmonitor = NULL;
> -
> -	if (core_fsmonitor)
> -		return 1;
> -
> -	return 0;
> -}

This used to be how we got the configuration.

> --- a/config.h
> +++ b/config.h
> @@ -610,7 +610,6 @@ int git_config_get_pathname(const char *key, const char **dest);
>  int git_config_get_index_threads(int *dest);
>  int git_config_get_split_index(void);
>  int git_config_get_max_percent_split_change(void);
> -int git_config_get_fsmonitor(void);

And that is removed so any in-flight topic that adds new caller will
be caught by the compiler.  OK.

> diff --git a/environment.c b/environment.c
> index 9da7f3c1a19..68f90632245 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -82,7 +82,6 @@ int protect_hfs = PROTECT_HFS_DEFAULT;
>  #define PROTECT_NTFS_DEFAULT 1
>  #endif
>  int protect_ntfs = PROTECT_NTFS_DEFAULT;
> -const char *core_fsmonitor;

So is this.

All nice.

> +static void lookup_fsmonitor_settings(struct repository *r)
> +{
> +	struct fsmonitor_settings *s;
> +
> +	CALLOC_ARRAY(s, 1);
> +
> +	r->settings.fsmonitor = s;
> +
> +	if (check_for_ipc(r))
> +		return;
> +
> +	if (check_for_hook(r))
> +		return;
> +
> +	fsm_settings__set_disabled(r);
> +}
> +
> +enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
> +{
> +	if (!r->settings.fsmonitor)
> +		lookup_fsmonitor_settings(r);

OK, and these "lookup" calls are what make this field "lazily
loaded".  A helper

static inline void lazily_load_fsmonitor_settings(struct repository *r)
{
	if (!r->settings.fsmonitor)
		lookup_fsmonitor_settings(r);
}

might be handy.  Also an assert to ensure nobody calls lookup() on a
repository that already has lazily loaded the settings would be
necessary.

	static void lookup_fsmonitor_settings(struct repository *r)
	{
		if (r->settings.fsmonitor)
			BUG("...");
		CALLOC_ARRAY(r->settings.fsmonitor, 1);

> +enum fsmonitor_mode {
> +	FSMONITOR_MODE_DISABLED = 0,
> +	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor */
> +	FSMONITOR_MODE_IPC = 2,  /* core.useBuiltinFSMonitor */
> +};

Please remind me why we need a new separate variable, instead of
turning the core.fsmonitor variable into an extended bool <false,
true, builtin>?  The compatibility issues during transition is the
same either way.  Old clients will ignore the request silently when
you set core.useBuiltinFSMonitor, or they will barf if you set
core.fsmonitor to 'builtin', so in a sense, extending the existing
variable may be a safer option.

> diff --git a/repository.h b/repository.h
> index a057653981c..89a1873ade7 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -4,6 +4,7 @@
>  #include "path.h"
>  
>  struct config_set;
> +struct fsmonitor_settings;
>  struct git_hash_algo;
>  struct index_state;
>  struct lock_file;
> @@ -34,6 +35,8 @@ struct repo_settings {
>  	int command_requires_full_index;
>  	int sparse_index;
>  
> +	struct fsmonitor_settings *fsmonitor; /* lazy loaded */

"lazily" loaded, I think.

>  GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
> -code path for utilizing a file system monitor to speed up detecting
> -new or changed files.
> +code path for utilizing a (hook based) file system monitor to speed up
> +detecting new or changed files.

Nice attention to the detail here.

Thanks.
