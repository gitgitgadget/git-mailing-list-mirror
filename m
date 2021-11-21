Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9D9C433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 08:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhKUIDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 03:03:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64768 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKUIDb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 03:03:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DBA4165754;
        Sun, 21 Nov 2021 03:00:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nZHhYigUpJNBc2Pn2pOV3Hm/HNp7X4FzwWBKPs
        qJqG0=; b=AQS73e5oL2Ptf8tTNRz6e+lIyTO4c3B4ouDEZ9Dcpsh/oAlvkBUUZJ
        6NYo2H4d+vTal+8WvC5OcytiMc3caeT0Wu24dNLbaycwfJtBWyfZYbVZc498D5CM
        ZW6W6xQHC4wpPP5t7NcuI2Pxf+gwGzutKHuExO5dlSDAoq03RclTg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06C81165753;
        Sun, 21 Nov 2021 03:00:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68BE7165752;
        Sun, 21 Nov 2021 03:00:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/8] repository, setup: introduce the_cwd
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <7b0c665fb75d3d73d9d8d03b629a09a0ec4244e6.1637455620.git.gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:00:22 -0800
In-Reply-To: <7b0c665fb75d3d73d9d8d03b629a09a0ec4244e6.1637455620.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 21 Nov 2021
        00:46:54 +0000")
Message-ID: <xmqqv90mlyzt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 146BE46C-4AA1-11EC-B022-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Removing the current working directory causes all subsequent git
> commands (and likely a number of non-git commands) run from that
> directory to get confused and fail with a message about being unable to
> read the current working directory.  That confuses end users,
> particularly since the command they get the error from is not the one
> that caused the problem; the problem came from the side-effect of some
> previous command.
>
> We would like to avoid removing the current working directory; towards
> this end, introduce a new the_cwd variable that tracks the current
> working directory.  Subsequent commits will make use of this new
> variable.

Maybe a stupid question, but how is this different from doing getcwd()
and storing it away to the_cwd, or adding a check to see if the
directory we are about to rmdir() is the cwd, next to the existing
check that we do to see if that directory has some untracked files?

I am wondering how we are going to make sure that the_cwd is always
set to, and maintained to be, the correct value, even in the future
when these code paths change.  I also wonder if it might be safer to
learn what the value of cwd is very near the place where it will
become needed (i.e. the callsites of such rmdir() of a directory
inside working tree), instead of caching.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  repository.c | 1 +
>  repository.h | 1 +
>  setup.c      | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/repository.c b/repository.c
> index c5b90ba93ea..69a106c553c 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -17,6 +17,7 @@
>  static struct repository the_repo;
>  struct repository *the_repository;
>  struct index_state the_index;
> +char *the_cwd;
>  
>  void initialize_the_repository(void)
>  {
> diff --git a/repository.h b/repository.h
> index a057653981c..45de85d18ef 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -147,6 +147,7 @@ struct repository {
>  };
>  
>  extern struct repository *the_repository;
> +extern char *the_cwd;
>  
>  /*
>   * Define a custom repository layout. Any field can be NULL, which
> diff --git a/setup.c b/setup.c
> index 347d7181ae9..4466fa55af3 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -887,6 +887,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
>  		set_git_dir(gitdirenv, 1);
>  		if (chdir(worktree))
>  			die_errno(_("cannot chdir to '%s'"), worktree);
> +		the_cwd = xstrdup(cwd->buf + offset);
>  		strbuf_addch(cwd, '/');
>  		free(gitfile);
>  		return cwd->buf + offset;
> @@ -940,6 +941,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>  	/* Make "offset" point past the '/' (already the case for root dirs) */
>  	if (offset != offset_1st_component(cwd->buf))
>  		offset++;
> +	the_cwd = xstrdup(cwd->buf + offset);
>  	/* Add a '/' at the end */
>  	strbuf_addch(cwd, '/');
>  	return cwd->buf + offset;
