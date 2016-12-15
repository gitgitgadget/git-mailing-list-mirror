Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2BB71FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 18:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754474AbcLOSnf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 13:43:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64679 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754473AbcLOSnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 13:43:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40D11580AF;
        Thu, 15 Dec 2016 13:42:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jqcKv7RB42rDvALvPJlWwoJTLW8=; b=mLh5OE
        irc8EnT9Bw821Jv2ws9MrVYvdTYEnRF1pypCNqgUAGL+/2Q/QhOfX7QEkuLB9y8O
        fvzDKpSWTNbBG2c2bJyTtMwnGJD62SaZV3Jc9KrwxdH5WTls7+qN43Co0c2bGW4T
        tWl/WMXP/M+c0T4B4BXXMv9cyu+NEti1sjkLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F2UFqAcPVhl4SjS34FjqDdTEQfqGQW2D
        t3MzLzED9jAsKIud7Ffws/Zao6Dqb4rPlY6DDctcXBL5z/TGzPreHC27y+IRltyM
        SM9vY7oq2yFIEhRbK4woAK2FEVJ6bu7CIX5fxYQN4nQOCzJ3WtKQf6mCaiXKOEsy
        HINUOADXzxY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39888580AE;
        Thu, 15 Dec 2016 13:42:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FA97580AD;
        Thu, 15 Dec 2016 13:42:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
Date:   Thu, 15 Dec 2016 10:42:53 -0800
In-Reply-To: <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:30:01 +0100
        (CET)")
Message-ID: <xmqqlgvhuj82.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A5C22CC-C2F6-11E6-969B-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/sequencer.c b/sequencer.c
> index f6e20b142a..271c21581d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -45,6 +45,35 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
>   */
>  static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
>  /*
> + * The commit message that is planned to be used for any changes that
> + * need to be committed following a user interaction.
> + */
> +static GIT_PATH_FUNC(rebase_path_message, "rebase-merge/message")
> +/*
> + * The file into which is accumulated the suggested commit message for
> + * squash/fixup commands. When the first of a series of squash/fixups

The same comment as 03/34 applies here, regarding blank line to
separate logical unit.

> +static int update_squash_messages(enum todo_command command,
> +		struct commit *commit, struct replay_opts *opts)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int count, res;
> +	const char *message, *body;
> +
> +	if (file_exists(rebase_path_squash_msg())) {
> +		char *p, *p2;
> +
> +		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 2048) <= 0)
> +			return error(_("could not read '%s'"),
> +				rebase_path_squash_msg());
> +
> +		if (buf.buf[0] != comment_line_char ||
> +		    !skip_prefix(buf.buf + 1, " This is a combination of ",
> +				 (const char **)&p))
> +			return error(_("unexpected 1st line of squash message:"
> +				       "\n\n\t%.*s"),
> +				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
> +				     buf.buf);
> +		count = strtol(p, &p2, 10);
> +
> +		if (count < 1 || *p2 != ' ')
> +			return error(_("invalid 1st line of squash message:\n"
> +				       "\n\t%.*s"),
> +				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
> +				     buf.buf);
> +
> +		sprintf((char *)p, "%d", ++count);

Do we know the area pointed at p (which is inside buf) long enough
not to overflow?  If the original were 9 and you incremented to get
10, you would need one extra byte.

> +		if (!*p2)
> +			*p2 = ' ';
> +		else {
> +			*(++p2) = 'c';

p2 points into buf; do we know this increment does not step beyond
its end?  What is the meaning of a letter 'c' here (I do not see a
corresponding one in the scripted update_squash_messages)?

> +			strbuf_insert(&buf, p2 - buf.buf, " ", 1);
> +		}
> +	}
> +	else {

Style: "} else {" (I won't repeat this, as it will become too noisy).

> +		unsigned char head[20];
> +		struct commit *head_commit;
> +		const char *head_message, *body;
> +
> +		if (get_sha1("HEAD", head))
> +			return error(_("need a HEAD to fixup"));
> +		if (!(head_commit = lookup_commit_reference(head)))
> +			return error(_("could not read HEAD"));
> +		if (!(head_message = get_commit_buffer(head_commit, NULL)))
> +			return error(_("could not read HEAD's commit message"));
> +
> +		body = strstr(head_message, "\n\n");
> +		if (!body)
> +			body = "";
> +		else
> +			body = skip_blank_lines(body + 2);

I think I saw you used a helper function find_commit_subject() to do
the above in an earlier patch for "edit" in this series.  Would it
make this part (and another one for "commit" we have after this
if/else) shorter?

>  static int do_pick_commit(enum todo_command command, struct commit *commit,
> -		struct replay_opts *opts)
> +		struct replay_opts *opts, int final_fixup)
>  {
> +	int edit = opts->edit, cleanup_commit_message = 0;
> +	const char *msg_file = edit ? NULL : git_path_merge_msg();
>  	unsigned char head[20];
>  	struct commit *base, *next, *parent;
>  	const char *base_label, *next_label;
>  	struct commit_message msg = { NULL, NULL, NULL, NULL };
>  	struct strbuf msgbuf = STRBUF_INIT;
> -	int res, unborn = 0, allow;
> +	int res, unborn = 0, amend = 0, allow;
>  
>  	if (opts->no_commit) {
>  		/*
> @@ -749,7 +885,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	else
>  		parent = commit->parents->item;
>  
> -	if (opts->allow_ff &&
> +	if (opts->allow_ff && !is_fixup(command) &&
>  	    ((parent && !hashcmp(parent->object.oid.hash, head)) ||
>  	     (!parent && unborn)))
>  		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
> @@ -813,6 +949,28 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		}
>  	}
>  
> +	if (is_fixup(command)) {
> +		if (update_squash_messages(command, commit, opts))
> +			return -1;
> +		amend = 1;
> +		if (!final_fixup)
> +			msg_file = rebase_path_squash_msg();
> +		else if (file_exists(rebase_path_fixup_msg())) {
> +			cleanup_commit_message = 1;
> +			msg_file = rebase_path_fixup_msg();
> +		}
> +		else {
> +			const char *dest = git_path("SQUASH_MSG");
> +			unlink(dest);
> +			if (copy_file(dest, rebase_path_squash_msg(), 0666))
> +				return error(_("could not rename '%s' to '%s'"),
> +					     rebase_path_squash_msg(), dest);

Perhaps an error from unlink(dest) before copy_file() should also
result in an error return?  After all, that unlink() was added to
mimick the "cp" in the scripted one and copy_file() does not want
to overwrite an existing destination.

> +			unlink(git_path("MERGE_MSG"));

Errors from this and other unlink() that emulates "rm -f" were
unchecked in the scripted original, so not checking for errors is
not a regression.  I would check for an error if I were writing
this, however, because I know I would forget updating these after I
am done with the series.

> +			msg_file = dest;
> +			edit = 1;
> +		}
> +	}
> +
>  	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
>  		res = do_recursive_merge(base, next, base_label, next_label,
>  					 head, &msgbuf, opts);
> @@ -868,8 +1026,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		goto leave;
>  	}
>  	if (!opts->no_commit)
> -		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
> -				     opts, allow, opts->edit, 0, 0);
> +		res = run_git_commit(msg_file, opts, allow, edit, amend,
> +				     cleanup_commit_message);

The introduction of msg_file variable made this call (actually, the
logic to decide which file is affected) much nicer to understand.

> +	if (!res && final_fixup) {
> +		unlink(rebase_path_fixup_msg());
> +		unlink(rebase_path_squash_msg());
> +	}
>  
> @@ -1475,6 +1660,21 @@ static int do_exec(const char *command_line)
>  	return status;
>  }
>  
> +static int is_final_fixup(struct todo_list *todo_list)
> +{
> +	int i = todo_list->current;
> +
> +	if (!is_fixup(todo_list->items[i].command))
> +		return 0;
> +
> +	while (++i < todo_list->nr)
> +		if (is_fixup(todo_list->items[i].command))
> +			return 0;
> +		else if (todo_list->items[i].command < TODO_NOOP)
> +			break;

What follows NOOP are comment and "drop" which is another comment in
disguise, so this one is excluding all the no-op commands in various
shapes, which makes sense but is clear only to a reader who bothered
to go back to "enum todo_command" and checked that fact.  If a check
for "is it one of the no-op commands?" appears only here, a single
liner comment may be sufficient (but necessary) to help readers.
Otherwise a single-liner helper function (similar to is_fixup() you
have) with a descriptive name would be better than a single liner
comment.




