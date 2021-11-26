Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC9C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 06:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359107AbhKZG5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:57:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61047 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346291AbhKZGzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 01:55:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 294B6105105;
        Fri, 26 Nov 2021 01:52:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9w8nVODrlLIU3tokPAJkJjNQIevFvIvZBABzdj
        Mwhqw=; b=xzviVcXPABdAcc5WpH9m5QQWWJg5i+9N3Crre03R06iIKA6E5ECzxy
        cXpgoigl6ajQCFrG77a3iYbebMZNkDI//70cwZnnmebL9HZWEkQEbs0NrGuEG15F
        U9vyRSVjd/6xNOjGqtCGxCBRtxA9HMT/mzysQ6UAObzZQsj4svBCs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21EA8105104;
        Fri, 26 Nov 2021 01:52:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F80B105101;
        Fri, 26 Nov 2021 01:52:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/9] setup: introduce startup_info->original_cwd
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 22:52:18 -0800
In-Reply-To: <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 25 Nov 2021
        08:39:09 +0000")
Message-ID: <xmqqo8678l3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66541DF2-4E85-11EC-914C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/git.c b/git.c
> index 5ff21be21f3..2c98ab48936 100644
> --- a/git.c
> +++ b/git.c
> @@ -866,6 +866,8 @@ int cmd_main(int argc, const char **argv)
>  
>  	trace_command_performance(argv);
>  
> +	startup_info->original_cwd = xgetcwd();

We assume that, unless we are an auxiliary tool like git-remote-http,
we should always have cwd?

> diff --git a/setup.c b/setup.c
> index 347d7181ae9..f30657723ea 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -432,6 +432,54 @@ void setup_work_tree(void)
>  	initialized = 1;
>  }
>  
> +static void setup_original_cwd(void)
> +{
> +	struct strbuf tmp = STRBUF_INIT;
> +	const char *worktree = NULL;
> +	int offset = -1;
> +
> +	/*
> +	 * startup_info->original_cwd wass set early on in cmd_main(), unless

s/wass/was/;

> +	 * we're an auxiliary tool like git-remote-http or test-tool.
> +	 */
> +	if (!startup_info->original_cwd)
> +		return;
> +
> +	/*
> +	 * startup_info->original_cwd points to the current working
> +	 * directory we inherited from our parent process, which is a
> +	 * directory we want to avoid incidentally removing.
> +	 *
> +	 * For convience, we would like to have the path relative to the
> +	 * worktree instead of an absolute path.
> +	 *
> +	 * Yes, startup_info->original_cwd is usually the same as 'prefix',
> +	 * but differs in two ways:
> +	 *   - prefix has a trailing '/'
> +	 *   - if the user passes '-C' to git, that modifies the prefix but
> +	 *     not startup_info->original_cwd.
> +	 */
> +
> +	/* Normalize the directory */
> +	strbuf_realpath(&tmp, startup_info->original_cwd, 1);
> +	free((char*)startup_info->original_cwd);
> +	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +
> +	/* Find out if this is in the worktree */
> +	worktree = get_git_work_tree();
> +	if (worktree)
> +		offset = dir_inside_of(startup_info->original_cwd, worktree);
> +	if (offset >= 0) {
> +		/*
> +		 * original_cwd was inside worktree; precompose it just as
> +		 * we do prefix so that built up paths will match
> +		 */
> +		startup_info->original_cwd = \
> +			precompose_string_if_needed(startup_info->original_cwd
> +						    + offset);
> +	}

I wonder if we want to clear the .original_cwd member, so that the
"cwd protection" do not have to worry about anything at all when we
are in a bare repository.

> +}
> +
>  static int read_worktree_config(const char *var, const char *value, void *vdata)
>  {
>  	struct repository_format *data = vdata;
> @@ -1330,6 +1378,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
>  	}
>  
> +	setup_original_cwd();
>  
>  	strbuf_release(&dir);
>  	strbuf_release(&gitdir);
