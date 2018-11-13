Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5E11F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 13:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbeKMXDc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 18:03:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63210 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733149AbeKMXDc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 18:03:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02F73229E0;
        Tue, 13 Nov 2018 08:05:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dIcZSuRTkODoFsxYZG8vG1A9BKc=; b=laidF9
        q2Tu2wqNkiN+ighkYchvYLde5GCWQRunycU0i5fbPS7JVDvakB4xQQ5rsbmA+yCr
        4yJe2qTPSvIR1ptP5A7SbSbGgzKi3jE9RDCbdhMml81DDc4TBbNZKbzr0V+WgAs+
        psx1Hs5q5zbHehJuZeCkXQHp9yhd/cr7ykxZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IL/rlRIUE63TgmwO/vevitXqY+tgRLn9
        g59Gq1oNdebOU/G/qwVpFkDlLobzN696oOoK320Z9IUz+coBYl7Fqut9RDRJBnL1
        6SIkH+WVlIZxmtmm7Vtcud57Q7MqyHmUfcSTKGU8eq7OlNO1sYF4P5tXMR9UUdvn
        AS4EsYcFM7s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE063229DF;
        Tue, 13 Nov 2018 08:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0A672229DE;
        Tue, 13 Nov 2018 08:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] rebase: really just passthru the `git am` options
References: <pull.76.git.gitgitgadget@gmail.com>
        <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542112703.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Nov 2018 22:05:22 +0900
In-Reply-To: <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542112703.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 13 Nov 2018
        04:38:26 -0800 (PST)")
Message-ID: <xmqqlg5xunzh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8FC43FE-E744-11E8-8869-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> However, there is a much better way (that I was unaware of, at the time
> when I mentored Pratik to implement these options): OPT_PASSTHRU_ARGV.
> It is intended for exactly this use case, where command-line options
> want to be parsed into a separate `argv_array`.
>
> Let's use this feature.
>
> Incidentally, this also allows us to address a bug discovered by Phillip
> Wood, where the built-in rebase failed to understand that the `-C`
> option takes an optional argument.

The resulting code does show what is going on more clearly.  I
wonder if we can do the same for -S as well?  It needs to be passed
to other backends, so I guess it is not such a good idea.

> -		.git_am_opt = STRBUF_INIT,
> +		.git_am_opts = ARGV_ARRAY_INIT,

Yes, this is much nicer.

> @@ -856,10 +858,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
>  			N_("GPG-sign commits"),
>  			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> -		OPT_STRING_LIST(0, "whitespace", &whitespace,
> -				N_("whitespace"), N_("passed to 'git apply'")),
> -		OPT_SET_INT('C', NULL, &opt_c, N_("passed to 'git apply'"),
> -			    REBASE_AM),
>  		OPT_BOOL(0, "autostash", &options.autostash,
>  			 N_("automatically stash/stash pop before and after")),
>  		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
> @@ -884,6 +882,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			 N_("rebase all reachable commits up to the root(s)")),
>  		OPT_END(),
>  	};
> +	int i;
>  
> +	for (i = 0; i < options.git_am_opts.argc; i++) {

Yes, this is very nice way to first collect and then inspect them
separately.

> +		const char *option = options.git_am_opts.argv[i];
> +		if (!strcmp(option, "--committer-date-is-author-date") ||
> +		    !strcmp(option, "--ignore-date") ||
> +		    !strcmp(option, "--whitespace=fix") ||
> +		    !strcmp(option, "--whitespace=strip"))
> +			options.flags |= REBASE_FORCE;
>  	}

Overall very nicely done.  Perhaps we'll see a test or two from
Philip?

Thanks.
