Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D35CC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7294D2073B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MaS+52cK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgEDPzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:55:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58988 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgEDPzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 11:55:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6E6B49CDB;
        Mon,  4 May 2020 11:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1pHhw1Itt13WkAdKJ3kD3b7PjLw=; b=MaS+52
        cKXDBbVYkU6d+Eyj46hq9XFglyqTyN9e8WlVVyY1IxM3zmxaITgXnsPlC1EwsmBN
        4IQbuy7cYXcUaDG9AZ+Abq+l/HJ51r0RowZYcefKERJmUc0WYlkEu3eeGqR/8nCV
        kcPZyzvZKPEbtsa7JLjzV4Qoiu8BSmFREJTWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e3t+gNWTTKRuEEScnqih2RqZ91F7tdEO
        GNG9IdtgKnKn1alrnous8TZilePuR6cLGRrluBqPMrQRVYfe9biKOt1dydS5430I
        UbOL96sC5SBUQTxG+FrlamgkHvGWnG7eR5bHkA6FadlKpBWWHDNLNBe2LR91hCkE
        oqx/6BVQjms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEC2A49CDA;
        Mon,  4 May 2020 11:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E55249CD9;
        Mon,  4 May 2020 11:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        liu.denton@gmail.com, peff@peff.net, heba.waly@gmail.com
Subject: Re: [PATCH v3] submodule: port subcommand 'set-url' from shell to C
References: <20200504072705.15261-1-shouryashukla.oo@gmail.com>
Date:   Mon, 04 May 2020 08:55:12 -0700
In-Reply-To: <20200504072705.15261-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 4 May 2020 12:57:05 +0530")
Message-ID: <xmqqd07jitjz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3E0640A-8E1F-11EA-8BB0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Convert submodule subcommand 'set-url' to a builtin. Port 'set-url'to
> 'submodule--helper.c' and call the latter via 'git-submodule.sh'.

OK.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1a4b391c88..6fd459988e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2246,6 +2246,51 @@ static int module_config(int argc, const char **argv, const char *prefix)
>  	usage_with_options(git_submodule_helper_usage, module_config_options);
>  }
>  
> +static int module_set_url(int argc, const char **argv, const char *prefix)
> +{
> +	int quiet = 0;
> +
> +	const char *newurl = NULL;
> +	const char *path = NULL;
> +
> +	struct strbuf config_entry = STRBUF_INIT;
> +
> +	struct option set_url_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
> +		OPT_END()
> +	};
> +
> +	const char *const usage[] = {
> +		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
> +		NULL
> +	};

I do not see much point in leaving blank lines between the above
variable declarations. In fact, it is somewhat irritating to see.
Drop them.

Initializing "quiet" to 0 is good, because parse_options() may not
see any "-q" or "--quiet" on the command line, and you do not want
to leave the variable uninitialized.

Initializing "newurl" and "path" on the other hand are totally
unnecessary.  In fact, it will defeat the chance in the future to be
helped by compiler warning when somebody accidentally loses the
assignment to one of these variables.  Don't initialize them
unnecessarily.

> +	argc = parse_options(argc, argv, prefix, set_url_options,
> +			     usage, 0);
> +
> +	if (quiet)
> +		quiet |= OPT_QUIET;

This is bogus.  "command --quiet --quiet" would count-up quiet twice
and would make it 2, and you or OPT_QUIET==1 in to make it 3, but
your intention is quite clear that you want to pass 1 to
sync_submodule() in such a case.

Didn't I give you a review a few days ago and suggested a way to
make this whole thing unnecessary?

> +	if (argc!=2){
> +		usage_with_options(usage, set_url_options);
> +		return 1;
> +	}

Style.

> +	path = argv[0];
> +	newurl = argv[1];

These assign to path and newurl before they are used below, which
means that they can be left uninitialized above without risking use
of an uninitialized variable.

> +	strbuf_addstr(&config_entry, "submodule.");
> +	strbuf_addstr(&config_entry, path);
> +	strbuf_addstr(&config_entry, ".url");

strbuf_addf()?

Usually an "entry" is not just the name of it but also its contents,
so unless you are handing a struct that holds a <name, value> tuple
i.e. ("submodule.<path>.url", newurl), it is better not to call this
anything-entry.  It is a name of a variable, and on the next line
you'll give the variable a vlue.  Perhaps config_name or something?

> +	config_set_in_gitmodules_file_gently(config_entry.buf, newurl);
> +	sync_submodule(path, prefix, quiet);
> +
> +	strbuf_release(&config_entry);
> +
> +	return 0;
> +}
> +

I get a feeling that perhaps my review message on the previous round
did not reach you?  It's here:

  https://lore.kernel.org/git/xmqq5zdfmryd.fsf@gitster.c.googlers.com/

Thanks.
