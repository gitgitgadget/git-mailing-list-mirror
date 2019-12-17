Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D2C2D0CD
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F52176D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xewvMTLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfLQUTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:19:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51234 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfLQUTV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 15:19:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 778CE9B870;
        Tue, 17 Dec 2019 15:19:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jeAdSaiE6onMzQG4pk1JdNB4DLI=; b=xewvMT
        LWRoqcfYM7qitovxt2Rh46JlkRd3vd10t86IzN5gvyPpgOREFkqWsZdj93ebhadi
        iI5yvb/zjX0gr7hu+Nhm2dzdh77L+QolNMasKrUBs20miodGi1r6wtfxxw/VwtI1
        MMJ8wGSnvDfdtyuw58gfgmhdhzIC/vl9MgeG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o/Rb+pZRH82OVvZFkaNjh4SxbTWO+QRU
        U/42AJ3tMkYTTE6YZFfYtDOfy8jJ+2PK4FIiKhMlYVMWFwPmW7Kv2DtsbXIqLiRt
        8nNFRZy5m8OnhlTwAknRw1UdUOdjMN4aQpQF/701lvVdC6QdMLSOL+cPJaFFdfvv
        jOjqmYwud4Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7065B9B86F;
        Tue, 17 Dec 2019 15:19:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98C429B86D;
        Tue, 17 Dec 2019 15:19:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/7] built-in stash: use the built-in `git add -p` if so configured
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <40c00302f67ed927317fb5955e13690328e2f4e8.1576579264.git.gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 12:19:14 -0800
In-Reply-To: <40c00302f67ed927317fb5955e13690328e2f4e8.1576579264.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 17 Dec 2019
        10:41:01 +0000")
Message-ID: <xmqqr212g0xp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FD6D97C-210A-11EA-8389-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 4e806176b0..2dafd97766 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -999,9 +999,9 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
>  {
>  	int ret = 0;
>  	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
> -	struct child_process cp_add_i = CHILD_PROCESS_INIT;
>  	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
>  	struct index_state istate = { NULL };
> +	char *old_index_env = NULL, *old_repo_index_file;
>  
>  	remove_path(stash_index_path.buf);
>  

Together with the previous step, it makes sense.  Earlier we always
spawned the scripted version.  Now we first give control to the C
code and allow it to punt to the scripted version unless it is told
to take control with USE_BUILTIN.

> @@ -1015,16 +1015,19 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
>  	}
>  
>  	/* Find out what the user wants. */
> -	cp_add_i.git_cmd = 1;
> -	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
> -			 "--", NULL);
> -	add_pathspecs(&cp_add_i.args, ps);
> -	argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
> -	if (run_command(&cp_add_i)) {
> -		ret = -1;
> -		goto done;
> -	}
> +	old_repo_index_file = the_repository->index_file;
> +	the_repository->index_file = stash_index_path.buf;
> +	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
> +	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
> +
> +	ret = run_add_interactive(NULL, "--patch=stash", ps);
> +
> +	the_repository->index_file = old_repo_index_file;
> +	if (old_index_env && *old_index_env)
> +		setenv(INDEX_ENVIRONMENT, old_index_env, 1);
> +	else
> +		unsetenv(INDEX_ENVIRONMENT);
> +	FREE_AND_NULL(old_index_env);

OK.  I suspect that, as we move more stuff that used to be an
external call with one-shot environment assignments like this to an
internall call, we'd see patterns of "save away the state of this
and that environment variables, then replace them with these values"
paired with "now restore the state of those environment variables".

We might eventually want to add a helper for doing so easily, which
may make the caller look like

	extern void save_environment(struct saved_env *, ...);

	struct saved_env env;
	save_environment(&env, 
			INDEX_ENVIRONMENT, the_repository->index_file,
			NULL /* end of "VAR, val" tuples */);

	ret = run_add_interactive(NULL, "--patch=stash", ps);

        restore_environment(&env);

It might (or might not) be premature to introduce such a helper at
this stage in the series, though.

Thanks.
