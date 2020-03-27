Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AF1C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679D0206F2
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2CPiotj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC0VZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:25:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55257 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgC0VZj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:25:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97874554ED;
        Fri, 27 Mar 2020 17:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7dJ4fvhRyoeUj+9JByawo3PfjYQ=; b=d2CPio
        tj1vtKJE3OKjVjSkcPIsktHwsj0Rl+RY1/7ePU3gGQAuQkum54SX17+UQNtMGqCF
        haSwPe3sHwUc7bLCrgyqJGjXCJnTDziyJY8JTn43jHC0dQ0Z4g6eGbc/PfoPDCg4
        HQXqGF3cjagN0BqsJIhxelUK0Oux0BRYZfkGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aewJerSedAjnRPxxdwCFye3hNK61YVca
        cvnxxw0Hm2k6+WZCBte0V8P8dq4idFG6694k0r2LgIU0XBUWy7mIEsQZaX7BUfd3
        gAQn+PVWe4y32Db6EsNE8haT9BToUCMTyhc87E0ZWhJ64m8eIUNqnslJE5uLDoXr
        qWfIz7JlHdY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F1CF554EC;
        Fri, 27 Mar 2020 17:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1916B554EA;
        Fri, 27 Mar 2020 17:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/9] update-ref: organize commands in an array
References: <cover.1585129842.git.ps@pks.im>
        <50ffc263293571f8af71fd1d253ac238c6909229.1585129842.git.ps@pks.im>
Date:   Fri, 27 Mar 2020 14:25:34 -0700
In-Reply-To: <50ffc263293571f8af71fd1d253ac238c6909229.1585129842.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 25 Mar 2020 10:53:55 +0100")
Message-ID: <xmqqh7y9fq29.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EEB23EA-7071-11EA-9656-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +static const struct parse_cmd {
> +	const char *prefix;
> +	const char *(*fn)(struct ref_transaction *, struct strbuf *, const char *);
> +} commands[] = {

Do not call an array the represents a set of THINGs "type things[]";
instead call it "type thing[]", so that the 0th thing can be
referred to as thing[0], not things[0].

One exception is when the set as a whole is referred to more often
than individual element of an array, in which case "things" (without
the [index]) becomes a sensible way to refer to the set.

> +	{ "update", parse_cmd_update },
> +	{ "create", parse_cmd_create },
> +	{ "delete", parse_cmd_delete },
> +	{ "verify", parse_cmd_verify },
> +	{ "option", parse_cmd_option },
> +};
> +
>  static void update_refs_stdin(struct ref_transaction *transaction)
>  {
>  	struct strbuf input = STRBUF_INIT;
>  	const char *next;
> +	int i;
>  
>  	if (strbuf_read(&input, 0, 1000) < 0)
>  		die_errno("could not read from stdin");
>  	next = input.buf;
>  	/* Read each line dispatch its command */
>  	while (next < input.buf + input.len) {
> +		const struct parse_cmd *cmd = NULL;
> +
>  		if (*next == line_termination)
>  			die("empty command in input");
>  		else if (isspace(*next))
>  			die("whitespace before command: %s", next);
> -		else if (skip_prefix(next, "update ", &next))
> -			next = parse_cmd_update(transaction, &input, next);
> -		else if (skip_prefix(next, "create ", &next))
> -			next = parse_cmd_create(transaction, &input, next);
> -		else if (skip_prefix(next, "delete ", &next))
> -			next = parse_cmd_delete(transaction, &input, next);
> -		else if (skip_prefix(next, "verify ", &next))
> -			next = parse_cmd_verify(transaction, &input, next);
> -		else if (skip_prefix(next, "option ", &next))
> -			next = parse_cmd_option(&input, next);
> -		else
> +
> +		for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +			if (!skip_prefix(next, commands[i].prefix , &next))
> +				continue;
> +			cmd = &commands[i];
> +			break;
> +		}

The only reason why you had to sprinkle

	if (!skip_prefix(next, " ", &next))
		die(_("%s: missing space after command"), cmd);

all over the place is because the table lacks the trailing SP (which
makes sense---after all, you are making a table of commands).  In
other words, it's not like some command called from this dispatcher
would require " " after the command name and some others would not.

So why not avoid touching the parse_cmd_<cmd>() at all (except for
the "option" thing that now needs to take the transaction object for
uniformity), and then verify the presence of " " here, perhaps like
this:

	for (i = 0; i < ARRAY_SIZE(command); i++) {
		const char *eoc;
		if (!skip_prefix(next, commands[i].prefix, &eoc) ||
		    *eoc != ' ')
			continue;
		cmd = &command[i];
                next = eoc;
		break;
	}

Note that you cannot reuse &next here to future-proof the code;
otherwise, you wouldn't be able to add a new command, e.g. "options",
that sits next to the existing command "option", in the future.

> +		if (!cmd)
>  			die("unknown command: %s", next);
>  
> +		if (input.buf[strlen(cmd->prefix)] != line_termination &&
> +		    input.buf[strlen(cmd->prefix)] != '\0' &&
> +		    input.buf[strlen(cmd->prefix)] != ' ')
> +			die("%s: no separator after command", cmd->prefix);

This part of your version does not make sense to me.  If the input
line began with "update" with some separator that is not a SP, the
original would not have matched.  But with this code, "update\0"
would pass this code and cause cmd->fn() to be called, only to get
the input rejected, because next is not pointing to SP.  So why do
you even need this if statement?

> +
> +		next = cmd->fn(transaction, &input, next);
>  		next++;
>  	}

Thanks.
