Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497451FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 22:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755419AbcIKW2b (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 18:28:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58434 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754788AbcIKW2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 18:28:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C01A43B914;
        Sun, 11 Sep 2016 18:28:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=25UMibaM254pQRShLoCK75rsfx0=; b=MljARu
        o8sVXcJd+eDRLGgzUxG0ahzfUyk5QLkQOIYAMvvTiKa5W1+8ZaAkDX7pLkwcP1z3
        BfG62OBr3CSh179AO22T1YTOry6KGP2sPEzQBx2meu8wA1EAEBxanHp3CWBoaeDS
        FmeovdAHb3sdSFYiE1xJGn1TPRGx9b2Wp4UuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qk6xowEyrBDG4loVgTdYkCcyY7YFjgod
        GEKDnOmDIvIyDLcbtBZTec49TVEWDmj14A6H1Xoe6AKt3agHmWuMz658Z3c/1S4M
        dmeAUUROPp4B51mBTO7eVJ7myIfqxp+XTn/EP84YKYb4o7+1iE95+GMm66sz4YMP
        H1O/gzn50Qg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B87923B913;
        Sun, 11 Sep 2016 18:28:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A8203B912;
        Sun, 11 Sep 2016 18:28:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v2 2/4] update-index: use the same structure for chmod as add
References: <20160904113954.21697-1-t.gummerer@gmail.com>
        <20160911103028.5492-1-t.gummerer@gmail.com>
        <20160911103028.5492-3-t.gummerer@gmail.com>
Date:   Sun, 11 Sep 2016 15:28:27 -0700
In-Reply-To: <20160911103028.5492-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 11 Sep 2016 11:30:26 +0100")
Message-ID: <xmqqinu26ph0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10653B3E-786F-11E6-98FC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> @@ -955,10 +941,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
>  			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
>  			(parse_opt_cb *) cacheinfo_callback},
> -		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
> -			N_("override the executable bit of the listed files"),
> -			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
> -			chmod_callback},
> +		OPT_STRING( 0, "chmod", &chmod_arg, N_("(+/-)x"),
> +			N_("override the executable bit of the listed files")),
>  		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
>  			N_("mark files as \"not changing\""),
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
> @@ -1018,6 +1002,15 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(update_index_usage, options);
>  
> +	if (!chmod_arg)
> +		force_mode = 0;
> +	else if (!strcmp(chmod_arg, "-x"))
> +		force_mode = 0666;
> +	else if (!strcmp(chmod_arg, "+x"))
> +		force_mode = 0777;
> +	else
> +		die(_("option 'chmod' expects \"+x\" or \"-x\""));
> +

I am afraid that this changes the behaviour drastically.

"git update-index" is an oddball command that takes options and then
processes them immediately, exactly because it was designed to take

	git update-index --chmod=-x A --chmod=+x B --add C

and say things like "A and B are not in the index and you are
attempting to add them before giving me --add option".

	git update-index --add --chmod=-x A --chmod=+x B C

is expected to add A as non-executable, and B and C as executable.
Many exotic parse-options callback mechanisms used in this command
were invented exactly to support its quirky way of not doing "get a
list of options and use the last one".  And this patch breaks it for
only one option without changing the others.

If we were willing to take such a big backward compatiblity hit in
the upcoming release (which I personally won't be affected, but old
scripts by others need to be audited and adjusted, which I won't
volunteer to do myself), we should make such a change consistently,
e.g. "git update-index A --add --remove B" should no longer error
out when it sees A and it is not yet in the index because "--add"
hasn't been given yet, or A is in the index but is missing from the
working tree because "--remove" hasn't been given yet.  Then it may
be more justifiable if "update-index --chmod=-x A --chmod=+x B"
added A as an executable.  With the current form of this patch, it
is not.

Can we do this "fix" without this change?




