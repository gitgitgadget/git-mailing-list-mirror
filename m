Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C857C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B1E2073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F0CfpxGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgC3RvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:51:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57913 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgC3RvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 13:51:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B214533A4;
        Mon, 30 Mar 2020 13:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P3lMCcK9C7sEu+5vfubUm7rYbhU=; b=F0Cfpx
        GpxaKytbx5P3W6EiHmrdT0rJ12zpP1Hnkb65iDjEDrPul2DtfG0Wi8EdpmCt3jFC
        OG6/V/7ddxjTA83V8davL4aqUOLrBq5+FfwDh36MI1C2v/+xuw5+a06jkbZB/72M
        nE9wSmUjqILOU7CvUSTCePSmqsY915DbwPovw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rNR4qu3py38tGwh1dCKn89zkMGzRevzl
        i2FqRkoFOeJ7ctxglQkMAQXxu44m95EPiCelEk/SAD2oiOK9xYyBGW83Pv0MAOFF
        lAS/ZSkUwk6ODoAbWGR6Hu6B2e3DmeuS37Gq3OS6e5RT8zjJ3YJAWTvFGC24NPna
        EZ8iNu1JPGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61724533A3;
        Mon, 30 Mar 2020 13:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8365533A2;
        Mon, 30 Mar 2020 13:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        jan.steffens@gmail.com
Subject: Re: [PATCH v1 1/2] sequencer: don't abbreviate a command if it doesn't have a short form
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
        <20200330124236.6716-1-alban.gruin@gmail.com>
        <20200330124236.6716-2-alban.gruin@gmail.com>
Date:   Mon, 30 Mar 2020 10:50:56 -0700
In-Reply-To: <20200330124236.6716-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 30 Mar 2020 14:42:35 +0200")
Message-ID: <xmqqeet991fj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 021B78D4-72AF-11EA-8B13-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>  static char command_to_char(const enum todo_command command)
>  {
> -	if (command < TODO_COMMENT && todo_command_info[command].c)
> +	if (command < TODO_COMMENT)
>  		return todo_command_info[command].c;
>  	return comment_line_char;
>  }

This is not a new issue, and it may not even be an issue at all, but
it is curious that command_to_string() barfs with "unknown command"
when fed an int outside enum todo_command or TODO_COMMENT iteslf,
while this returns comment_line_char.  Makes a reader wonder if both
of them should be dying the same way.

> @@ -4963,6 +4963,8 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
>  		max = num;
>  
>  	for (item = todo_list->items, i = 0; i < max; i++, item++) {
> +		char cmd;
> +
>  		/* if the item is not a command write it and continue */
>  		if (item->command >= TODO_COMMENT) {
>  			strbuf_addf(buf, "%.*s\n", item->arg_len,
> @@ -4971,8 +4973,9 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
>  		}
>  
>  		/* add command to the buffer */
> -		if (flags & TODO_LIST_ABBREVIATE_CMDS)
> -			strbuf_addch(buf, command_to_char(item->command));
> +		cmd = command_to_char(item->command);
> +		if (flags & TODO_LIST_ABBREVIATE_CMDS && cmd)

Even though the precedence rule may not require it, for
readability's sake, it would be easier to see the association if
this is written with an extra set of parentheses, i.e.

		if ((flags & TODO_LIST_ABBREVIATE_CMDS) && cmd)

> +			strbuf_addch(buf, cmd);
>  		else
>  			strbuf_addstr(buf, command_to_string(item->command));

The logic is quite clear.  If there is an abbreviation and the user
prefers to see it, we use it, but otherwise we'll give the full
spelling.

We are sure we will never get TODO_COMMENT here in item->command at
this point (the loop would have already continued after adding it to
the buffer), so it does not affect us that command_to_string() would
die.  For that matter, if we made command_to_char() die, just like
command_to_string() would, nobody will get hurt and the resulting
code would become saner.  But obviously it is outside the scope of
this fix (#leftoverbits).

Thanks.
