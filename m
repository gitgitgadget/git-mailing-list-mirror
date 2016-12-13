Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41F7209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 21:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbcLMVai (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:30:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63791 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752941AbcLMVah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:30:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 362DE57EAD;
        Tue, 13 Dec 2016 16:30:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m1bbWOYmjs6ojJ5RucSWOsK6n00=; b=N+xYhJ
        SPn5QNdeg0nX0p53OcJnr69HYwNDkufNohxJmEOIKIW4o4Q4+znd8WGr2lnsgV+L
        lM/B+9y1W5k1c5HaHIAE1WYtOCaEBpNbInMhZ5kL/0OTWc/p/v96CGOj3YOpzUpo
        QHxZRm7rIWOgFcELtEPTkxx1HcOoXXOQ3dYJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XnBAuEqVh6KFNUgI0WGzb7MkP9y4UU30
        UPifoAWU8besjgRAWnLXe/qiLQS8MPU5MGb4Cvh/NCYoe43Ts+nWfL7Zk0snGqX0
        fTLMM0z6YuaworGNpzuM7IgEGR/mystc6kwC3o0Oh/9EYRfA4L/NyCio7J4riG0i
        5mt3jrLPWhI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14EDA57EAC;
        Tue, 13 Dec 2016 16:30:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B5DA57EAA;
        Tue, 13 Dec 2016 16:30:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 03/34] sequencer (rebase -i): implement the 'edit' command
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <a1361151ad1dad8f4dc3c412c7ed30f625d67ba0.1481642927.git.johannes.schindelin@gmx.de>
Date:   Tue, 13 Dec 2016 13:30:34 -0800
In-Reply-To: <a1361151ad1dad8f4dc3c412c7ed30f625d67ba0.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:29:40 +0100
        (CET)")
Message-ID: <xmqqbmwf1pqd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 624F9ADE-C17B-11E6-8E46-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -43,6 +44,20 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
>   */
>  static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
>  /*

It is minor, but please have a blank line to separate the logical
blocks.  If you have "comment for thing A" before "thing A", then 
having a blank after that before "comment for thing B" and "thing B"
that follow would help.  Otherwise "thing A" immediately followed by
"comment for thing B" are (mis)read together, leading to nonsense.

> + * When an "edit" rebase command is being processed, the SHA1 of the
> + * commit to be edited is recorded in this file.  When "git rebase
> + * --continue" is executed, if there are any staged changes then they
> + * will be amended to the HEAD commit, but only provided the HEAD
> + * commit is still the commit to be edited.  When any other rebase
> + * command is processed, this file is deleted.
> + */
> +static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
> +/*
> + * When we stop at a given patch via the "edit" command, this file contains
> + * the long commit name of the corresponding patch.

If you abbreviate an object name to 38-hex that is still long but
that is not full; if you meant full 40-hex, better spell it out as
"full"---that conveys useful information to programmers (e.g. they
can just use get_sha1_hex()).

But I think you are writing short_commit_name() to it?  So perhaps
"an abbreviated commit object name"?

> @@ -1301,9 +1318,87 @@ static int save_opts(struct replay_opts *opts)
>  	return res;
>  }
>  
> +static int make_patch(struct commit *commit, struct replay_opts *opts)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct rev_info log_tree_opt;
> +	const char *commit_buffer = get_commit_buffer(commit, NULL), *subject, *p;
> +	int res = 0;
> +
> +	p = short_commit_name(commit);
> +	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
> +		return -1;
> +
> +	strbuf_addf(&buf, "%s/patch", get_dir(opts));
> +	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
> +	init_revisions(&log_tree_opt, NULL);
> +	log_tree_opt.abbrev = 0;
> +	log_tree_opt.diff = 1;
> +	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
> +	log_tree_opt.disable_stdin = 1;
> +	log_tree_opt.no_commit_id = 1;
> +	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
> +	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
> +	if (!log_tree_opt.diffopt.file)
> +		res |= error_errno(_("could not open '%s'"), buf.buf);
> +	else {
> +		res |= log_tree_commit(&log_tree_opt, commit);
> +		fclose(log_tree_opt.diffopt.file);
> +	}
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "%s/message", get_dir(opts));
> +	if (!file_exists(buf.buf)) {
> +		find_commit_subject(commit_buffer, &subject);
> +		res |= write_message(subject, strlen(subject), buf.buf, 1);
> +		unuse_commit_buffer(commit, commit_buffer);
> +	}
> +	strbuf_release(&buf);
> +
> +	return res;
> +}

OK.  This seems to match what scripted make_patch does in a handful
of lines.  We probably should have given you a helper to reduce
boilerplate that sets up log_tree_opt so that this function does not
have to be this long, but that is a separate topic.

Does it matter output_format is set to FORMAT_PATCH here, though?
With --no-commit-id set, I suspect there is no log message or
authorship information given to the output.

As you are only interested in seeing the patch/diff in this file and
the log is stored in a separate "message" file, as long as "patch"
file gets the patch correctly, it is not a problem, but it just
looked strange to see FORMAT_PATCH there.

