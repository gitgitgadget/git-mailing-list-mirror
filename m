Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969D11F461
	for <e@80x24.org>; Fri, 19 Jul 2019 22:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfGSWgZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 18:36:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58860 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfGSWgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 18:36:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87E831629E9;
        Fri, 19 Jul 2019 18:36:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zRBnx7viHeC+9MH14zsQlI4QCns=; b=Pmc+4o
        IR1rNj4nfAOLgIDW96XOkEdQFg0lVvcWfyy8SLWx7vMb83YNlbyqU+qx7bcmTpIp
        kV6lQKLxM8Wm721lQjb8Y64ebP0rD75NJgnpfcBoukotH3zunHTsXY+bb1I3GdPd
        VVfCG/IawdEMjmrKMhM6y5EbMUbwzCxMRvj2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DFQvl3iLYPOvAr0kM38eGx89Li5dYAJQ
        s2DWAPiI148hy6o59fM6BW3+cgI7gcEKeGcCfPTkfKsNIIrAovbVX9twfUdqabnj
        Xgg4p0UJsRU5taixGOfjkCRGMU7vw4cuEgd5tdzs5WE34+1S/IAopa88EJIksa0O
        gnnvCfRuu1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F1C51629E8;
        Fri, 19 Jul 2019 18:36:17 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEEAD1629E6;
        Fri, 19 Jul 2019 18:36:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 2/2] rebase -i: support --committer-date-is-author-date
References: <20190712185357.21211-1-rohit.ashiwal265@gmail.com>
        <20190718190314.20549-1-rohit.ashiwal265@gmail.com>
        <20190718190314.20549-3-rohit.ashiwal265@gmail.com>
Date:   Fri, 19 Jul 2019 15:36:15 -0700
In-Reply-To: <20190718190314.20549-3-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Fri, 19 Jul 2019 00:33:14 +0530")
Message-ID: <xmqqwogdtzxc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F19D232-AA75-11E9-BDB0-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> @@ -1688,10 +1699,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		    state_dir_base, cmd_live_rebase, buf.buf);
>  	}
>  
> +	if (options.committer_date_is_author_date)
> +		options.flags |= REBASE_FORCE;
> +
>  	for (i = 0; i < options.git_am_opts.argc; i++) {
>  		const char *option = options.git_am_opts.argv[i], *p;
> -		if (!strcmp(option, "--committer-date-is-author-date") ||
> -		    !strcmp(option, "--ignore-date") ||
> +		if (!strcmp(option, "--ignore-date") ||
>  		    !strcmp(option, "--whitespace=fix") ||
>  		    !strcmp(option, "--whitespace=strip"))
>  			options.flags |= REBASE_FORCE;

This is needed here, because am-opts no longer has the
committer-date-is-author-date passed through with the
parse_options() call in cmd_rebase(), which makes sense.

> diff --git a/sequencer.c b/sequencer.c
> index a2d7b0925e..a65f01a422 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -986,10 +999,17 @@ static int run_git_commit(struct repository *r,
>  
>  		if (res <= 0)
>  			res = error_errno(_("could not read '%s'"), defmsg);
> -		else
> +		else {
> +			if (opts->committer_date_is_author_date) {
> +				char *date = read_author_date_or_die();
> +				setenv("GIT_COMMITTER_DATE", date, 1);
> +				free(date);
> +			}

Hmph, are we sure that author-script is always available at this
point so that a call to read_author_date_or_die() is safe?  There
are three callers to the run_git_commit() function and I am not sure
if codepaths that reach all of them prepared the input to the
read_author_script() helper.

> @@ -1019,6 +1039,11 @@ static int run_git_commit(struct repository *r,
>  		argv_array_push(&cmd.args, "--amend");
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> +	if (opts->committer_date_is_author_date) {
> +		char *date = read_author_date_or_die();
> +		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s", date);
> +		free(date);
> +	}
>  	if (defmsg)
>  		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>  	else if (!(flags & EDIT_MSG))
> @@ -1467,6 +1492,12 @@ static int try_to_commit(struct repository *r,
>  
>  	reset_ident_date();
>  
> +	if (opts->committer_date_is_author_date) {
> +		char *date = read_author_date_or_die();
> +		setenv("GIT_COMMITTER_DATE", date, 1);
> +		free(date);
> +	}
> +

In the same function, we seem to be grabbing the author ident by
calling get_author(message), where the message is an in-core copy of
a commit object, which suggests me that we may not necessarily be
working with the on-disk information read_author_date_or_die() is
prepared to deal with.  Are we sure we have the needed information
on disk so that read_author_date_or_die() will read the correct
information from the disk?

> @@ -2538,6 +2569,11 @@ static int read_populate_opts(struct replay_opts *opts)
>  			opts->signoff = 1;
>  		}
>  
> +		if (file_exists(rebase_path_cdate_is_adate())) {
> +			opts->allow_ff = 0;
> +			opts->committer_date_is_author_date = 1;
> +		}
> +
>  		if (file_exists(rebase_path_reschedule_failed_exec()))
>  			opts->reschedule_failed_exec = 1;
>  
> @@ -2620,6 +2656,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>  		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
>  	if (opts->signoff)
>  		write_file(rebase_path_signoff(), "--signoff\n");
> +	if (opts->committer_date_is_author_date)
> +		write_file(rebase_path_cdate_is_adate(), "%s", "");
>  	if (opts->reschedule_failed_exec)
>  		write_file(rebase_path_reschedule_failed_exec(), "%s", "");

These two are propagating the option across rebase invocations, and
they should be correct (as correct as how correctly other options
are propagated ;-)).

> @@ -3437,6 +3475,12 @@ static int do_merge(struct repository *r,
>  		argv_array_push(&cmd.args, git_path_merge_msg(r));
>  		if (opts->gpg_sign)
>  			argv_array_push(&cmd.args, opts->gpg_sign);
> +		if (opts->committer_date_is_author_date) {
> +			char *date = read_author_date_or_die();
> +			argv_array_pushf(&cmd.env_array,
> +					 "GIT_COMMITTER_DATE=%s", date);
> +			free(date);

This codepath does have read_env_script() which reads from the
author script an earlier call to write_author_script() would have
left on disk (at least when do_merge() is called with 'commit'
argument, anyway), so we should be able to read from it (or the
existing code is already buggy---and this patch just makes it
slightly worse by depending on a wrong assumption even more).  OK.

