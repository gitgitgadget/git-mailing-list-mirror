Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA1F1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 20:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbfGRUEq (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 16:04:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51223 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391130AbfGRUEq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 16:04:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E45415A7A5;
        Thu, 18 Jul 2019 16:04:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=isUem5t4oB8GccHbde8wWDJbSvQ=; b=R5CLRa
        TNW3KBxrwD0MVQL/SWJf6WxZ9tIzrOsfyjrVjduvlfu8Evqru0VcXkzc2CDOD6Re
        TFfag3YGP3FpNQIvCW8wGAYVhu8xvo3+lz+GsLkkfTmZHUe05gC2pP7INr1HhmB2
        iRz1X4X4zYQvSp/9tRBA1QvR/cZeDUHDGhOvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cY8zMHguwT2rujIKfilWbl6jx+e2Y0kt
        Be+pc67+1pZPHVYAnc6CEaNno8+Fjp7nejZJb20vH7gLMlKLSuHXVrjnCLMPzfe2
        cTw9Jf1+yFVa6ZJqu/6FgLf9uvNnb0cDm3aj6/5DL2d6fvB8514fiiZf0c5Ao+Uz
        SA7L0kqi1m8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45D1515A7A3;
        Thu, 18 Jul 2019 16:04:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A084415A7A2;
        Thu, 18 Jul 2019 16:04:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 5/9] sequencer: move the code writing total_nr on the disk to a new function
References: <20190717143918.7406-1-alban.gruin@gmail.com>
        <20190717143918.7406-6-alban.gruin@gmail.com>
Date:   Thu, 18 Jul 2019 13:04:42 -0700
In-Reply-To: <20190717143918.7406-6-alban.gruin@gmail.com> (Alban Gruin's
        message of "Wed, 17 Jul 2019 16:39:14 +0200")
Message-ID: <xmqqk1cfxg6d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48B95338-A997-11E9-962C-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> The total amount of commands can be used to show the progression of the
> rebasing in a shell.  This number is written to the disk by
> read_populate_todo() when the todo list is loaded from
> sequencer_continue() or pick_commits(), but not by complete_action(),
> which releases its todo list before calling sequencer_continue(), which
> reloads it immediatly afterwards.
>
> To avoid to reload the todo list from the disk, sequencer_continue()
> will be modified to accept a todo list, and if it is not null,
> read_populate_todo() will not be called.

That may be good as a plan, but readers who are reading this step
are left puzzled as the changes so far do not seem to have much to
do with that change.  Perhaps this paragraph belongs to the step
that actually makes that modification?

> This moves the part writing total_nr to a new function so it can be
> called by complete_action().

So without 3/9 and 4/9, we have been simply writing out wrong
number?  Good.

>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index ec9c3d4dc5..d66b80d49f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2343,6 +2343,16 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
>  	sequencer_remove_state(&opts);
>  }
>  
> +static void todo_list_write_total_nr(struct todo_list *todo_list)
> +{
> +	FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
> +
> +	if (f) {
> +		fprintf(f, "%d\n", todo_list->total_nr);
> +		fclose(f);
> +	}
> +}
> +
>  static int read_populate_todo(struct repository *r,
>  			      struct todo_list *todo_list,
>  			      struct replay_opts *opts)
> @@ -2388,7 +2398,6 @@ static int read_populate_todo(struct repository *r,
>  
>  	if (is_rebase_i(opts)) {
>  		struct todo_list done = TODO_LIST_INIT;
> -		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
>  
>  		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
>  		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
> @@ -2400,10 +2409,7 @@ static int read_populate_todo(struct repository *r,
>  			+ count_commands(todo_list);
>  		todo_list_release(&done);
>  
> -		if (f) {
> -			fprintf(f, "%d\n", todo_list->total_nr);
> -			fclose(f);
> -		}
> +		todo_list_write_total_nr(todo_list);
>  	}
>  
>  	return 0;
