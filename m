Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565CCC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3792E6124B
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbhIXQPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:15:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59653 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhIXQPd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 12:15:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14FAFDF403;
        Fri, 24 Sep 2021 12:14:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y2hOGb5Otte+KMDK5cAd3R9LgKWwjGAVB2iZ5b
        atg4Y=; b=lcepbIhPpxEqNAV+i86dDdH08zGNXdNlR+E1s6USdU8u4KdoIT7RTI
        cgBuXd1bSxkHDIOrU9HwNl0XY6oZ5GPf5oQh664d2UDRCD2I+Y2ZQ4xCOButmdcX
        0xDrGh8iTTqcakpSsohkGAlDLpIphDWsWLSEcjuOXsd0GRcVxeW4k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0ABB7DF402;
        Fri, 24 Sep 2021 12:14:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 714E2DF401;
        Fri, 24 Sep 2021 12:13:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/2] rebase: fix todo-list rereading
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
        <pull.1034.v2.git.1632410782.gitgitgadget@gmail.com>
        <0d89c506192a84822a3fbd6c76befac187129ad4.1632410782.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 09:13:58 -0700
In-Reply-To: <0d89c506192a84822a3fbd6c76befac187129ad4.1632410782.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Thu, 23 Sep 2021 15:26:21
        +0000")
Message-ID: <xmqqilyqvtmh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CFF9E1A-1D52-11EC-BA58-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> .... Instead of relying on stat
> data this patch simply reads the possibly edited todo list and
> compares it to the original with memcmp(). This is much faster than
> reparsing the todo list each time.

Nice.  Is that an egg of Columbus or what ;-)

> +	if (strbuf_read_file_or_whine(&buf, get_todo_path(opts)) < 0)
> +		return -1;
> +	offset = get_item_line_offset(todo_list, todo_list->current + 1);
> +	if (buf.len != todo_list->buf.len - offset ||
> +	    memcmp(buf.buf, todo_list->buf.buf + offset, buf.len)) {
>  		/* Reread the todo file if it has changed. */
>  		todo_list_release(todo_list);
>  		if (read_populate_todo(r, todo_list, opts))

As we already have the contents of hte file in the buffer, we could
further refactor the code around read_populate_todo() to tell it not
to reopen and reread the rebase-todo file (which risks toctou race),
but that is OK for now, I would think.

> @@ -4271,6 +4267,7 @@ static int reread_todo_if_changed(struct repository *r,
>  		/* `current` will be incremented on return */
>  		todo_list->current = -1;
>  	}
> +	strbuf_release(&buf);
>  
>  	return 0;
>  }
> diff --git a/sequencer.h b/sequencer.h
> index d57d8ea23d7..cdeb0c6be47 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -116,7 +116,6 @@ struct todo_list {
>  	struct todo_item *items;
>  	int nr, alloc, current;
>  	int done_nr, total_nr;
> -	struct stat_data stat;

Good riddance ;-)

Will queue.  Thanks.
