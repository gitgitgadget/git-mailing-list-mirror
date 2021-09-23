Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B9C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD12B611B0
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242640AbhIWSF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:05:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64319 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbhIWSF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 14:05:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03B71D6E57;
        Thu, 23 Sep 2021 14:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jMQMNyxAykjo
        gmRarYdJuEsINddccqku4jn/iCnv3mI=; b=lzB6+SW0ijXZYCZDzJdOOWTDuSMM
        HK6Udd2v5mkB4bBVrvLnJx4jx/EG4JGyuTVEibO14zk3gyEFXFjq3QFy7viJBsM4
        JO8bCDCowdWmRI3Lxe98PGowHgvnZZRuiTa8TilQiwiRdjNESV3xp2lS2KfM/Tf9
        WJb/UHLqrQfdb2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE4E8D6E56;
        Thu, 23 Sep 2021 14:03:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DAFBD6E55;
        Thu, 23 Sep 2021 14:03:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 6/9] help: simplify by moving to OPT_CMDMODE()
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
        <patch-v3-6.9-b52269eeab9-20210921T223223Z-avarab@gmail.com>
Date:   Thu, 23 Sep 2021 11:03:53 -0700
In-Reply-To: <patch-v3-6.9-b52269eeab9-20210921T223223Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Sep
 2021 00:40:36
        +0200")
Message-ID: <xmqqbl4j1852.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D6CA5EE-1C98-11EC-BC0A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +static void no_extra_argc(int argc)
> +{
> +	if (argc)
> +		usage_msg_opt(_("this option doesn't take any other arguments"),
> +			      builtin_help_usage, builtin_help_options);
> +}

The mention of "this option" smells like a loss of information.  I
might expect the --verbose option might take the verbosity level and
ask for

    $ git help --guides --verbose 99

and the above message may give me a false impression that "this
option" refers to "--verbose" that does not take any value.

As long as --all/--guides/--config are understood as "special" and
different from other options, this may be OK, especially given that
the user will get an error message much earlier if you give two or
more of them at the same time, so such an "which option do you
mean?" confusion may not happen very often.

>  int cmd_help(int argc, const char **argv, const char *prefix)
>  {
>  	int nongit;
> @@ -554,28 +570,8 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
>  			builtin_help_usage, 0);
>  	parsed_help_format =3D help_format;
> =20
> +	switch (cmd_mode) {
> +	case HELP_ACTION_ALL:
>  		git_config(git_help_config, NULL);
>  		if (verbose) {
>  			setup_pager();
> @@ -585,25 +581,20 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
>  		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>  		load_command_list("git-", &main_cmds, &other_cmds);
>  		list_commands(colopts, &main_cmds, &other_cmds);
> +		printf("%s\n", _(git_more_info_string));
> +		break;
> +	case HELP_ACTION_GUIDES:
> +		no_extra_argc(argc);
>  		list_guides_help();
>  		printf("%s\n", _(git_more_info_string));
>  		return 0;
> +	case HELP_ACTION_CONFIG_FOR_COMPLETION:
> +		list_config_help(0);
> +		return 0;
> +	case HELP_ACTION_CONFIG:
> +		no_extra_argc(argc);
>  		setup_pager();
> +		list_config_help(1);
>  		printf("\n%s\n", _("'git help config' for more information"));
>  		return 0;
>  	}

