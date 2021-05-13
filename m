Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D967C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2371F613F2
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhEMWxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 18:53:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56836 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhEMWw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 18:52:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66B57133D13;
        Thu, 13 May 2021 18:51:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rgPMALMA7uDwvGZ6V8HQRdt4AV30R+nhwCLwzC
        oMC70=; b=dN2DzDPZWm9txIcwNhSHvX64RCbYZxwA8xpVt97GeYLu9jF7EMsM8z
        751WCyr2qHtFVIdO18we+GjQCkj2VaTHcRDN6YfQzTnMyUjNq48RtT4ib5+dUG8j
        eswA0wQHGJOEqVsDCUV2BAR0E0YlOzt83Iqjv79qOYwTA6YK2sSus=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53BEC133D11;
        Thu, 13 May 2021 18:51:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79206133D10;
        Thu, 13 May 2021 18:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin: use git_read_line_interactively to prompt
References: <20210513214152.34792-1-firminmartin24@gmail.com>
        <20210513214152.34792-3-firminmartin24@gmail.com>
Date:   Fri, 14 May 2021 07:51:43 +0900
In-Reply-To: <20210513214152.34792-3-firminmartin24@gmail.com> (Firmin
        Martin's message of "Thu, 13 May 2021 23:41:52 +0200")
Message-ID: <xmqqr1ia8cxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAE7BB6C-B43D-11EB-A29A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

> diff --git a/builtin/am.c b/builtin/am.c
> index 8355e3566f..32eae4eb2e 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1643,7 +1643,7 @@ static int do_interactive(struct am_state *state)
>  	assert(state->msg);
>  
>  	for (;;) {
> -		char reply[64];
> +		struct strbuf reply = STRBUF_INIT;

If you call this reply_strbuf, and introduce "const char *reply",
and ...

>  		puts(_("Commit Body is:"));
>  		puts("--------------------------");
> @@ -1656,17 +1656,17 @@ static int do_interactive(struct am_state *state)
>  		 * input at this point.
>  		 */
>  		printf(_("Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "));
> -		if (!fgets(reply, sizeof(reply), stdin))
> +		if (git_read_line_interactively(&reply) == EOF)
>  			die("unable to read from stdin; aborting");

... assign "reply = reply_strbuf.buf" here, you do not have to
change anything below.

> -		if (*reply == 'y' || *reply == 'Y') {
> +		if (reply.len && !strncasecmp(reply.buf, "yes", reply.len)) {

And we shouldn't sneak an unrelated change like this into a patch
whose purpose is to allow reading from the standard input instead of
always from "/dev/tty".

As I explained earlier, git_read_line_interactively() is usable only
when we know that the standard input is *not* used for the data we
are operating on and is available to be used for simulating
interactive input.  Since "git am -i" never reads the mailbox from
the standard input, the use of the helper here is acceptable.

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1fdb7d9d10..134347eb39 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -340,7 +340,7 @@ static int decide_next(const struct bisect_terms *terms,
>  
>  	if (missing_good && !missing_bad &&
>  	    !strcmp(current_term, terms->term_good)) {
> -		char *yesno;
> +		struct strbuf yesno = STRBUF_INIT;
>  		/*
>  		 * have bad (or new) but not good (or old). We could bisect
>  		 * although this is less optimum.
> @@ -353,8 +353,9 @@ static int decide_next(const struct bisect_terms *terms,
>  		 * translation. The program will only accept English input
>  		 * at this point.
>  		 */
> -		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
> -		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
> +		printf(_("Are you sure [Y/n]? "));
> +		git_read_line_interactively(&yesno);

The use of this helper here is also OK as the standard input to "git
bisect" is available for simulating interactive input.

> +		if (yesno.len && !strncasecmp(yesno.buf, "no", yesno.len))
>  			return -1;
>  		return 0;
>  	}

It may make sense to have a thin wrapper around this pattern, e.g.

	static int ask_yesno(const char *question)
	{
		struct strbuf answer = STRBUF_INIT;
		printf("%s [Y/n]? ", question);
		git_read_line_interactively(&answer);
                return !(answer.buf[0] == 'N' || answer.buf[0] == 'n');
	}

so that the above caller can become

		return ask_yesno(_("Are you sure")) ? 0 : -1;

and ...

> -	yesno = git_prompt(_("Do you want me to do it for you "
> -			     "[Y/n]? "), PROMPT_ECHO);
> -	res = tolower(*yesno) == 'n' ?
> +	printf(_("Do you want me to do it for you [Y/n]? "));
> +	git_read_line_interactively(&yesno);
> +	res = (yesno.len && strncasecmp(yesno.buf, "no", yesno.len)) ?
>  		-1 : bisect_start(terms, empty_strvec, 0);

... this caller can become

	if (ask_yesno(_("Do you want me to do it for you")))
		res = bisect_start(terms, empty_strvec, 0);
	else
		res = -1;

Thanks.
