Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7EDB209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938560AbcLMUpy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:45:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62021 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938531AbcLMUcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:32:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FF5955F5D;
        Tue, 13 Dec 2016 15:32:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1JR87M3FWzEh4TQWqbsH47t4xO0=; b=BXj6Kf
        8uhIlg8jDzr5f4Tl6WXbYHqp0BQt7PGDxG+3BrSLtfz2nJlDlIZ0TD70FyaMmoP9
        0Dp+Ezpqo7et+na+kGSp7wB3jQMhNQ6hpt2RlhvuQ0EzjJ8NWdFGu+eKzdN++eJv
        vHMmX239Km4d2TMfnRxOmtCPJa7aJbNac2DTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AdZP7KT0KwOJNN2LxgPVEhxtjJReGqUB
        N8ZuDMM8Qc7MgHY7XFowGvv5mY9Ime+b41k1EukUpaUoVpOrO4w8EioUGNrYGYrz
        1tl7EbqBXFbNATk0G3qq/LDe2oUTft+TQhCTWwpzHjo6yPzKF9pDyzdZhvN5K8N0
        /aWOhZJiHh0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1833455F5C;
        Tue, 13 Dec 2016 15:32:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8762155F5B;
        Tue, 13 Dec 2016 15:32:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 01/34] sequencer: support a new action: 'interactive rebase'
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de>
Date:   Tue, 13 Dec 2016 12:32:07 -0800
In-Reply-To: <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:29:14 +0100
        (CET)")
Message-ID: <xmqqk2b31sfs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37F6CF1C-C173-11E6-BF0C-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  static inline int is_rebase_i(const struct replay_opts *opts)
>  {
> -	return 0;
> +	return opts->action == REPLAY_INTERACTIVE_REBASE;
>  }
>  
>  static const char *get_dir(const struct replay_opts *opts)
>  {
> +	if (is_rebase_i(opts))
> +		return rebase_path();
>  	return git_path_seq_dir();
>  }
>  
>  static const char *get_todo_path(const struct replay_opts *opts)
>  {
> +	if (is_rebase_i(opts))
> +		return rebase_path_todo();
>  	return git_path_todo_file();
>  }
>  
> @@ -168,7 +179,15 @@ int sequencer_remove_state(struct replay_opts *opts)
>  
>  static const char *action_name(const struct replay_opts *opts)
>  {
> -	return opts->action == REPLAY_REVERT ? N_("revert") : N_("cherry-pick");
> +	switch (opts->action) {
> +	case REPLAY_REVERT:
> +		return N_("revert");
> +	case REPLAY_PICK:
> +		return N_("cherry-pick");
> +	case REPLAY_INTERACTIVE_REBASE:
> +		return N_("rebase -i");
> +	}
> +	die(_("Unknown action: %d"), opts->action);
>  }

This case statement which looks perfectly sensible---it says that
there are three equal modes the subsystem operates in.  

This is just a mental note and not a suggestion to change anything
immediately, but it makes me wonder if git_dir/get_todo_path would
also want to do so, moving towards retiring is_rebase_i() which is
"everything else vs one oddball which is rebase-i" mindset.

> @@ -395,7 +414,10 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  
>  	if (active_cache_changed &&
>  	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> -		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> +		/*
> +		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
> +		 * "rebase -i".
> +		 */

IIRC, the "TRANSLATORS:" comment has to deviate from our coding
style due to tool limitation and has to be done like this:

> +		/* TRANSLATORS: %s will be "revert", "cherry-pick" or
> +		 * "rebase -i".
> +		 */

> @@ -1204,6 +1226,9 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>  	const char *todo_path = get_todo_path(opts);
>  	int next = todo_list->current, offset, fd;
>  
> +	if (is_rebase_i(opts))
> +		next++;
> +

This is because...?  Everybody else counts 0-based while rebase-i
counts from 1 or something?

>  	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
>  	if (fd < 0)
>  		return error_errno(_("could not lock '%s'"), todo_path);

Everything else in the patch is understandable.  This bit isn't
without explanation, at least to me.
