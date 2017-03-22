Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46D020323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965692AbdCVSnm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:43:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57637 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965566AbdCVSnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:43:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2EA47E046;
        Wed, 22 Mar 2017 14:43:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BI2EjaUWytwgf5p71RJLGqzrMAg=; b=h2PgbZ
        wG5ncnO6X56Z0Og4Q6+X2MvmlnqBxlQcI6JCpAekYWY1fnAMM1Y7WCcwlGTWDMAJ
        4gOeQ1arj6bH/RH+R52LFEvAohF9pveYJV7d9lnpKJkzKEEqUgPQwnO40Dc5xk6c
        57J9kvcKsnjkD7bZGJEntN/8+Bxy7IdVAIEeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eQXzSjSH/9z9+sz1zSpUYsapgjGOKTZs
        46/0gVvDHHX+yQcoBhuYxb1lzZ95ip0rLeOUiwZOokkH8IYH2PIhpKXOOpkGXQIS
        vp+BgIDQZpPiH4+UbtGeUhOrRWSwznES0HsMHt3gZwKCWHKzoNQUrJ4LpZDq0Z0R
        qHXqYpJ8/WM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99D9D7E045;
        Wed, 22 Mar 2017 14:43:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 018B97E044;
        Wed, 22 Mar 2017 14:43:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/3] sequencer: allow the commit-msg hooks to run during a `reword`
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <9b83b6f7012368e970ec2b310f63b4daf66602e5.1490194846.git.johannes.schindelin@gmx.de>
Date:   Wed, 22 Mar 2017 11:43:36 -0700
In-Reply-To: <9b83b6f7012368e970ec2b310f63b4daf66602e5.1490194846.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 22 Mar 2017 16:02:01 +0100
        (CET)")
Message-ID: <xmqq60j1kv8n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7645205C-0F2F-11E7-90D8-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The `reword` command used to call `git commit` in a manner that asks for
> the prepare-commit-msg and commit-msg hooks to do their thing.
>
> Converting that part of the interactive rebase to C code introduced the
> regression where those hooks were no longer run.
>
> Let's fix this.
>
> Note: the flag is called `VERIFY_MSG` instead of the more intuitive
> `RUN_COMMIT_MSG_HOOKS` to indicate that the flag suppresses the
> `--no-verify` flag (which may do other things in the future in addition
> to suppressing the commit message hooks, too).

Yup, this is a sound reasoning.  I would have made it not a "Note"
but just a regular description of the design decision, e.g.

    Call the flag bit "VERIFY_MSG", because this is to suppress the
    "--no-verify" flag (do not call it RUN_COMMIT_MSG_HOOKS, as the
    purpose of the bit does not have to stay only to run the hooks).

or somesuch, but I can go either way.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c                | 12 +++++++++---
>  t/t7504-commit-msg-hook.sh |  2 +-
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 1abe559fe86..377af91c475 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -606,6 +606,7 @@ N_("you have staged changes in your working tree\n"
>  #define EDIT_MSG    (1<<1)
>  #define AMEND_MSG   (1<<2)
>  #define CLEANUP_MSG (1<<3)
> +#define VERIFY_MSG  (1<<4)
>  
>  /*
>   * If we are cherry-pick, and if the merge did not result in
> @@ -642,8 +643,9 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	}
>  
>  	argv_array_push(&cmd.args, "commit");
> -	argv_array_push(&cmd.args, "-n");
>  
> +	if (!(flags & VERIFY_MSG))
> +		argv_array_push(&cmd.args, "-n");

OK, so by default we pass "--no-verify" but selected callers can
set the bit in the flags word to disable it.  That sounds sensible,
especially given that the original callers, cherry-pick and revert, 
did want "--no-verify".  "reword" in "rebase -i" is currently the
only one we want to supress "--no-verify" and the place that does so
are all shown in this patch.

Just to see if there are other callers that may want to do the same
suppressing of "--no-verify" as a follow-up, I looked at the whole
file after applying the patch, and I think everything looked good
as-is.

>  	if ((flags & AMEND_MSG))
>  		argv_array_push(&cmd.args, "--amend");
>  	if (opts->gpg_sign)
> @@ -993,7 +995,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  			write_author_script(msg.message);
>  		res = fast_forward_to(commit->object.oid.hash, head, unborn,
>  			opts);
> -		if (res || command != TODO_REWORD)
> +		if (res)
> +			goto leave;
> +		else if (command == TODO_REWORD)
> +			flags |= VERIFY_MSG;
> +		else
>  			goto leave;

Both before and after are your code, but wouldn't this:

	if (res || command != TODO_REWORD)
		goto leave;
+	if (command == TODO_REWORD)
+		flags |= VERIFY_MSG

result in smaller changes relative to the original and still be much
easier to understand than the above?

Thanks.
