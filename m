Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD0C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiAZUBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:01:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63822 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiAZUBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:01:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FC3C177C1A;
        Wed, 26 Jan 2022 15:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6/2BOK6PzAyJV3Fx3uBy11zrN7VCqAiwAZKp8Y
        tN2Cc=; b=g2zwprpBh0+kVEDWjMrbgweKkITpcnS2IFXnQh7hEkYLpKAmssq0/e
        dTScO5REorRgxw/sjUCggRQPAQq+jS1wUKDRftN455UrBaq06WHDxuOwHYozZ4mo
        pMiOXwO4tulqVwkhQaJm/7osSEnzvNO3MIJ7bjklXV80+OPp6p/dg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48FED177C19;
        Wed, 26 Jan 2022 15:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B507D177C17;
        Wed, 26 Jan 2022 15:01:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer, stash: fix running from worktree subdir
References: <pull.1205.git.git.1643161426138.gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 12:01:28 -0800
In-Reply-To: <pull.1205.git.git.1643161426138.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 26 Jan 2022 01:43:45
        +0000")
Message-ID: <xmqqfspaqnaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C06AE392-7EE2-11EC-8F04-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In commits bc3ae46b42 ("rebase: do not attempt to remove
> startup_info->original_cwd", 2021-12-09) and 0fce211ccc ("stash: do not
> attempt to remove startup_info->original_cwd", 2021-12-09), we wanted to
> allow the subprocess to know which directory the parent process was
> running from, so that the subprocess could protect it.  However...
>
> When run from a non-main worktree, setup_git_directory() will note
> that the discovered git directory
> (/PATH/TO/.git/worktree/non-main-worktree) does not match
> DEFAULT_GIT_DIR_ENVIRONMENT (see setup_discovered_git_dir()), and
> decide to set GIT_DIR in the environment.  This matters because...
>
> Whenever git is run with the GIT_DIR environment variable set, and
> GIT_WORK_TREE not set, it presumes that '.' is the working tree.  So...
>
> This combination results in the subcommand being very confused about
> the working tree.  Fix it by also setting the GIT_WORK_TREE environment
> variable along with setting cmd.dir.
>
> A possibly more involved fix we could consider for later would be to
> make setup.c set GIT_WORK_TREE whenever (a) it discovers both the git
> directory and the working tree and (b) it decides to set GIT_DIR in the
> environment.  I did not attempt that here as such would be too big of a
> change for a 2.35.1 release.
>
> Test-case-by: Glen Choo <chooglen@google.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     [2.35 regression] sequencer, stash: fix running from worktree subdir

Thanks.  This is the kind of fix we all should be concentrating on
in the first week after the release.

Very much appreciated.

Will queue.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1ef2017c595..86cd0b456e7 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1539,8 +1539,12 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  			struct child_process cp = CHILD_PROCESS_INIT;
>  
>  			cp.git_cmd = 1;
> -			if (startup_info->original_cwd)
> +			if (startup_info->original_cwd) {
>  				cp.dir = startup_info->original_cwd;
> +				strvec_pushf(&cp.env_array, "%s=%s",
> +					     GIT_WORK_TREE_ENVIRONMENT,
> +					     the_repository->worktree);
> +			}
>  			strvec_pushl(&cp.args, "clean", "--force",
>  				     "--quiet", "-d", ":/", NULL);
>  			if (include_untracked == INCLUDE_ALL_FILES)
> diff --git a/sequencer.c b/sequencer.c
> index 6abd72160cc..5213d16e971 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4223,8 +4223,11 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
>  
>  	cmd.git_cmd = 1;
>  
> -	if (startup_info->original_cwd)
> +	if (startup_info->original_cwd) {
>  		cmd.dir = startup_info->original_cwd;
> +		strvec_pushf(&cmd.env_array, "%s=%s",
> +			     GIT_WORK_TREE_ENVIRONMENT, r->worktree);
> +	}
>  	strvec_push(&cmd.args, "checkout");
>  	strvec_push(&cmd.args, commit);
>  	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 23dbd3c82ed..71b1735e1dd 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -416,4 +416,25 @@ test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink'
>  	mv actual_logs .git/logs
>  '
>  
> +test_expect_success 'rebase when inside worktree subdirectory' '
> +	git init main-wt &&
> +	(
> +		cd main-wt &&
> +		git commit --allow-empty -m "initial" &&
> +		mkdir -p foo/bar &&
> +		test_commit foo/bar/baz &&
> +		mkdir -p a/b &&
> +		test_commit a/b/c &&
> +		# create another branch for our other worktree
> +		git branch other &&
> +		git worktree add ../other-wt other &&
> +		cd ../other-wt &&
> +		# create and cd into a subdirectory
> +		mkdir -p random/dir &&
> +		cd random/dir &&
> +		# now do the rebase
> +		git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
> +	)
> +'
> +
>  test_done
>
> base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
