Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FF91F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbcJKTZS (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:25:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60656 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751516AbcJKTZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:25:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 834DE423CD;
        Tue, 11 Oct 2016 15:07:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xtuKNqdpegX6+1iLQO5hm8o8t4E=; b=LX38vc
        eZFk9dyt+Tf7lGU5LD5BfNT8bosYHwIz5R+VkcP6LkE1+EDScbTMNlVnPZ1wQ6J/
        m0W6RpSH3/MFDHA8DwdU/texVR3Xl0bVxbTMz7yCEmRVrkPM64MbLbVBEfGfHYZQ
        Es0PpE4mkbJ5V6M+Hhxk1jUYgSp0ihG06vryI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GLZ/kvHTLWw8mUf1hoqmyCTXF1vLlJkU
        2mTKfVycI8hPa9LKk1ddTR1WCdGABhu5jYDLbemGFgYtdjWSeK0gTxJ8Kdd694qX
        SJnYPh9FJXSYird89ihR96n7XYO6ZoVSiZus6rWoehUwAcBAXzCbsKZkrcpTm27N
        oiorVhYJpPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A2A7423CC;
        Tue, 11 Oct 2016 15:07:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 04CF8423C9;
        Tue, 11 Oct 2016 15:07:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 12/25] sequencer: remember the onelines when parsing the todo file
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <f22bdcda3f748813e6b9fd08dc65f11c6f9f4b1e.1476120229.git.johannes.schindelin@gmx.de>
Date:   Tue, 11 Oct 2016 12:07:24 -0700
In-Reply-To: <f22bdcda3f748813e6b9fd08dc65f11c6f9f4b1e.1476120229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 10 Oct 2016 19:25:38 +0200
        (CEST)")
Message-ID: <xmqq1szmaemr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F28332F4-8FE5-11E6-9F42-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The `git-rebase-todo` file contains a list of commands. Most of those
> commands have the form
>
> 	<verb> <sha1> <oneline>
>
> The <oneline> is displayed primarily for the user's convenience, as
> rebase -i really interprets only the <verb> <sha1> part. However, there
> are *some* places in interactive rebase where the <oneline> is used to
> display messages, e.g. for reporting at which commit we stopped.
>
> So let's just remember it when parsing the todo file; we keep a copy of
> the entire todo file anyway (to write out the new `done` and
> `git-rebase-todo` file just before processing each command), so all we
> need to do is remember the begin offsets and lengths.
>
> As we will have to parse and remember the command-line for `exec` commands
> later, we do not call the field "oneline" but rather "arg" (and will reuse
> that for exec's command-line).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index afc494e..7ba5e07 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -708,6 +708,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>  struct todo_item {
>  	enum todo_command command;
>  	struct commit *commit;
> +	const char *arg;
> +	int arg_len;
>  	size_t offset_in_buf;

micronit: you can make it to size_t and lose the cast below, no?

>  };
>  
> @@ -759,6 +761,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  	status = get_sha1(bol, commit_sha1);
>  	*end_of_object_name = saved;
>  
> +	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
> +	item->arg_len = (int)(eol - item->arg);
> +
>  	if (status < 0)
>  		return -1;
>  
> @@ -911,6 +916,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>  
>  		item->command = command;
>  		item->commit = commit;
> +		item->arg = NULL;
> +		item->arg_len = 0;
>  		item->offset_in_buf = todo_list->buf.len;
>  		subject_len = find_commit_subject(commit_buffer, &subject);
>  		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
