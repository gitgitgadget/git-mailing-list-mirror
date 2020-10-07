Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F23C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 17:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87053206F7
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 17:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qmsPDlq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgJGRV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 13:21:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65366 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgJGRV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 13:21:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A63B97E471;
        Wed,  7 Oct 2020 13:21:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0DTBGZpxlWQdHalUZwnagOz+pxk=; b=qmsPDl
        q9SyIyDD5a5CFtHRejkGuvpSvH73OFUMl6+KwH3NXfDyHC8aZ1onh8xaBpLPW825
        iq5a4PfS05cZZGddxrHcpBpaDSQJ/n5wpASldkFtIuAseAjYPKRqweRugFB41QWK
        qFyGJrwbgebfWIYSGasclDQbMj2WRPZF1oREA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JOjJK3BZ2rlmf8LMGZGhFHiI8JPPJ9st
        FNlBAf1CQ6OBJBKjmu4Sq8k6AwIiq0mG8Nkk8k5hoJVrndCFWq2bePI7+UbERVTO
        2aqLvy49zt3jxiGqqLIMk+uBTnyQxVj4rtbwVL1jgHgAdi0AIKFsD0p7Kgs2JKUU
        WM3M2CqqSrk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DA547E470;
        Wed,  7 Oct 2020 13:21:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 262D87E46F;
        Wed,  7 Oct 2020 13:21:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] help: do not expect built-in commands to be hardlinked
References: <pull.745.git.1602074589460.gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 10:21:51 -0700
In-Reply-To: <pull.745.git.1602074589460.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 07 Oct 2020 12:43:09
        +0000")
Message-ID: <xmqqpn5u2bps.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 971A9458-08C1-11EB-B962-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When building with SKIP_DASHED_BUILT_INS=YesPlease, the built-in
> commands are no longer present in the `PATH` as hardlinks to `git`.
>
> As a consequence, `load_command_list()` needs to be taught to find the
> names of the built-in commands from elsewhere.
>
> This only affected the output of `git --list-cmds=main`, but not the
> output of `git help -a` because the latter includes the built-in
> commands by virtue of them being listed in command-list.txt.
>
> The bug was detected via a patch series that turns the merge strategies
> included in Git into built-in commands: `git merge -s help` relies on
> `load_command_list()` to determine the list of available merge
> strategies.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Fix the command list with SKIP_DASHED_BUILT_INS=YesPlease
>     
>     In a recent patch series
>     [https://lore.kernel.org/git/20201005122646.27994-12-alban.gruin@gmail.com/#r]
>     , the merge strategies were converted into built-ins, which is good.
>     
>     Together with the change where we stop hard-linking the built-in
>     commands in CI builds, this broke t9902.199.
>     
>     The actual root cause is that git merge -s help relies on 
>     load_command_list() to find all available Git commands, and that
>     function had the long-standing bug that it expects the built-in commands
>     to be available in the PATH.
>

That is not a bug in "merge -s help" or "longstanding" at all.  It
has been a quite natural and long-standing expectation to find all
the merge strategies on PATH (after GIT_EXEC_PATH is added to it),
because that was the promise we gave to our users long time ago and
have kept.

The bug is in load_command_list() and it was introduced by the
recent SKIP_DASHED_BUILT_INS series.  We forgot to teach the
function that in the new world order, what we see on disk plus what
we have in the built-in table are the set of subcommands available
to us, and the rule that was valid in the old world order can no
longer be relied upon, and nobody noticed  the breakage while
developing or reviewing.

>  git.c  | 13 +++++++++++++
>  help.c |  2 ++
>  help.h |  1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/git.c b/git.c
> index d51fb5d2bf..a6224badce 100644
> --- a/git.c
> +++ b/git.c
> @@ -641,6 +641,19 @@ static void list_builtins(struct string_list *out, unsigned int exclude_option)
>  	}
>  }
>  
> +void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
> +{
> +	const char *name;
> +	int i;
> +
> +	if (!skip_prefix(prefix, "git-", &prefix))
> +		return;

Do we want to explain that this is for dropping "gitk" and the like
in a comment near here?

> +	for (i = 0; i < ARRAY_SIZE(commands); i++)
> +		if (skip_prefix(commands[i].cmd, prefix, &name))
> +			add_cmdname(cmds, name, strlen(name));
> +}
> +
>  #ifdef STRIP_EXTENSION
>  static void strip_extension(const char **argv)
>  {
> diff --git a/help.c b/help.c
> index 4e2468a44d..919cbb9206 100644
> --- a/help.c
> +++ b/help.c
> @@ -263,6 +263,8 @@ void load_command_list(const char *prefix,
>  	const char *env_path = getenv("PATH");
>  	const char *exec_path = git_exec_path();
>  
> +	load_builtin_commands(prefix, main_cmds);
> +
>  	if (exec_path) {
>  		list_commands_in_dir(main_cmds, exec_path, prefix);
>  		QSORT(main_cmds->names, main_cmds->cnt, cmdname_compare);
> diff --git a/help.h b/help.h
> index dc02458855..5871e93ba2 100644
> --- a/help.h
> +++ b/help.h
> @@ -32,6 +32,7 @@ const char *help_unknown_cmd(const char *cmd);
>  void load_command_list(const char *prefix,
>  		       struct cmdnames *main_cmds,
>  		       struct cmdnames *other_cmds);
> +void load_builtin_commands(const char *prefix, struct cmdnames *cmds);
>  void add_cmdname(struct cmdnames *cmds, const char *name, int len);
>  /* Here we require that excludes is a sorted list. */
>  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
>
> base-commit: 8f7759d2c8c13716bfdb9ae602414fd987787e8d
