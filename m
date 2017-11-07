Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A2A20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 04:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbdKGEw1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 23:52:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58123 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752482AbdKGEw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 23:52:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5A3CA7F41;
        Mon,  6 Nov 2017 23:52:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h53OON7s186AaxEmrca7E0pRfIw=; b=rVIzvh
        AKoUFrE7IVcMcwEKqrQu5daIatdE5jfKLLQ1KDZYhZLVSiRkkRWcVqrRGX/uuroV
        bJEkJm4gmUry7yor4RW4GygKV2LLBuN+2lrXOx11NAH27sEJZPZIWB/+ETDDlEnI
        lx+U+DOwAUQL3Pilav2CnEtHPjPjcq6oAGUpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R6AkBzIesVpof7Uw6L7fJPHeeVJvzWp0
        /JVyzD18Ls8fUkxUt8Kt8X7TPuznn3PoF39vtgNDkxqzif5NPXK9BrBUWZfgX4IY
        IyeQnggvqMmdXH10w+2sPilNg0CIKtUEWDSISoGSJWTzv4vbifnGfVVAIJt3Li0o
        GRCoYCN7t2w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B815A7F3F;
        Mon,  6 Nov 2017 23:52:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 204A1A7F3E;
        Mon,  6 Nov 2017 23:52:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 6/8] sequencer: simplify adding Signed-off-by: trailer
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171106112709.2121-1-phillip.wood@talktalk.net>
        <20171106112709.2121-7-phillip.wood@talktalk.net>
Date:   Tue, 07 Nov 2017 13:52:18 +0900
In-Reply-To: <20171106112709.2121-7-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Mon, 6 Nov 2017 11:27:07 +0000")
Message-ID: <xmqq375qg071.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FC03D32-C377-11E7-94BF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> diff --git a/sequencer.c b/sequencer.c
> index ae24405c23d021ed7916e5e2d9df6de27f867a2e..3e4c3bbb265db58df22cfcb5a321fb74d822327e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -477,9 +477,6 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  			_(action_name(opts)));
>  	rollback_lock_file(&index_lock);
>  
> -	if (opts->signoff)
> -		append_signoff(msgbuf, 0, 0);
> -
>  	if (!clean)
>  		append_conflicts_hint(msgbuf);
>  

This function is called from only one place,  do_pick_commit(), and
then the message returned from here in msgbuf is written to
merge_msg(), even when the merge conflicted.

And when the merge conflicts, sequencer would stop and gives the
control back to you---the MERGE_MSG file would have had the sign-off
when you conclude the conflict resolution.

With the new code, we instead add the sign-off before calling the
function to compensate for the above change, so MERGE_MSG file would
have the sign-off as before, when the sequencer stops.

> @@ -657,8 +654,6 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  		argv_array_push(&cmd.args, "--amend");
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> -	if (opts->signoff)
> -		argv_array_push(&cmd.args, "-s");
>  	if (defmsg)
>  		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>  	if ((flags & CLEANUP_MSG))

This has two callers.  

The caller in do_pick_commit() is a bit curious; as we saw already,
the message file should already have the sign-off and then we used
to give another "-s" here.  Were we depending on "-s" to become
no-op when the last sign-off is by the same person, I wonder?  In
any case, the removal of "-s" from here won't hurt that caller.

The other caller is commit_staged_changes() which is called when
doing "rebase -i continue".  I am not quite sure where the contents
stored in the file rebase_path_message() comes from.  The function
error_failed_squash() moves SQUASH_MSG to it and then makes a copy
of it to MERGE_MSG, but that should only be relevant for squashed
commit and no other cases, so...?

I need to block a bit more time to read the relevant code to comment
on this step, especially on this removal.

Thanks for working on this, anyway.

> @@ -1347,6 +1342,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		}
>  	}
>  
> +	if (opts->signoff)
> +		append_signoff(&msgbuf, 0, 0);
> +
>  	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
>  		res = -1;
>  	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
