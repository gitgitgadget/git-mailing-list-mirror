Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFE9C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 23:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9904C60F6C
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 23:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhIJXqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 19:46:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60943 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhIJXqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 19:46:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39C29E8D6A;
        Fri, 10 Sep 2021 19:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VlWVFkd4/non
        0MlhYH2iSoXPwbSQgy39ENtZUPf9u8o=; b=V59vrZ8uoSNVZ7e68Buj8u1sm30T
        A8aTzucxbQK1jmyzJQgG7ReARbOc2XLOPQhBrSC1H0VZxxDK1LnR2mpYd1iO7VgU
        YQbvxZExjrEJj93x1U8NxjTvs8NfIDPwvzrd9wzN+lBPMpEsEh1MTQuX6LHto+aF
        LMeMKGsuChxvDMc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2746CE8D68;
        Fri, 10 Sep 2021 19:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54F7CE8D67;
        Fri, 10 Sep 2021 19:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/5] help: correct logic error in combining --all and
 --config
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
        <patch-v2-4.5-32d73d5273c-20210910T112545Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 16:45:05 -0700
In-Reply-To: <patch-v2-4.5-32d73d5273c-20210910T112545Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Sep
 2021 13:28:45
        +0200")
Message-ID: <xmqqy284ov0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20565066-1291-11EC-97E7-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a bug in the --config option that's been there ever since its
> introduction in 3ac68a93fd2 (help: add --config to list all available
> config, 2018-05-26). Die when --all and --config are combined,
> combining them doesn't make sense.
>
> The code for the --config option when combined with an earlier
> refactoring done to support the --guide option in
> 65f98358c0c (builtin/help.c: add --guide option, 2013-04-02) would
> cause us to take the "--all" branch early and ignore the --config
> option.
>
> Let's instead list these as incompatible, both in the synopsis and
> help output, and enforce it in the code itself.

Of course, "git help -c -a" might be a good enough UI to ask for
these variables that are usually hidden due to being deprecated, but
implementing that would be a much larger surgery (I do not think the
config_name_list[] has enough information as the process to generate
it discards the deprecated ones), so this is OK, I think.

> @@ -548,18 +549,34 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
>  	int nongit;
>  	enum help_format parsed_help_format;
>  	const char *page;
> +	int need_config =3D 0;
> =20
>  	argc =3D parse_options(argc, argv, prefix, builtin_help_options,
>  			builtin_help_usage, 0);
>  	parsed_help_format =3D help_format;
> =20
> +	/* Incompatible options */
> +	if (show_all && show_config)
> +		usage_msg_opt(_("--config and --all cannot be combined"),
> +			      builtin_help_usage, builtin_help_options);
> +
> +	if (show_config && show_guides)
> +		usage_msg_opt(_("--config and --guides cannot be combined"),
> +			      builtin_help_usage, builtin_help_options);
> +
>  	/* Options that take no further arguments */
> +	if (argc && show_config)
> +		usage_msg_opt(_("--config cannot be combined with command or guide n=
ames"),
> +			      builtin_help_usage, builtin_help_options);
>  	if (argc && show_guides)
> -		usage_msg_opt(_("--guides cannot be combined with other options"),
> +		usage_msg_opt(_("--guides cannot be combined with command or guide n=
ames"),
>  			      builtin_help_usage, builtin_help_options);

This almost makes me wonder if we should be using OPT_CMDMODE and
taking advantage of its built-in "X and Y are incompatible"
detection.

> -	if (show_all) {
> +	need_config =3D show_all || show_config;
> +	if (need_config)
>  		git_config(git_help_config, NULL);

This change does not seem to be explained. =20

We didn't handle help-config when "git help -c" was asked, but now
we do, because...?

> +	if (show_all) {
>  		if (verbose) {
>  			setup_pager();
>  			list_all_cmds_help();
> @@ -570,6 +587,14 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
>  		list_commands(colopts, &main_cmds, &other_cmds);
>  	}
> =20
> +	if (show_guides)
> +		list_guides_help();
> +
> +	if (show_all || show_guides) {
> +		printf("%s\n", _(git_more_info_string));
> +		return 0;
> +	}

As guides, all and config are mutually exclusive, it is unclear what
we gain by moving these two above.  The resulting code does not seem
to be more clear then before.

If anything,=20

	switch (show_mode) {
	case HELP_ALL_MODE:
		... the body of the first "if" ...
		printf("%s\n", _(git_more_info_string));
		return 0;
	case HELP_GUIDES_MODE:
		list_guides_help();
		printf("%s\n", _(git_more_info_string));
		return 0;
	case HELP_CONFIG_MODE:
		... the body of the follwing "if" ...
		return 0;
	default: /* show a manual page */
		break;
	}

may make it easier to follow.

>  	if (show_config) {
>  		int for_human =3D show_config =3D=3D 1;
> =20
> @@ -583,14 +608,6 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
>  		return 0;
>  	}
> =20
> -	if (show_guides)
> -		list_guides_help();
> -
> -	if (show_all || show_guides) {
> -		printf("%s\n", _(git_more_info_string));
> -		return 0;
> -	}
> -
>  	if (!argv[0]) {
>  		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>  		list_common_cmds_help();
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 595bf81f133..cbc9b64f79f 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -35,7 +35,12 @@ test_expect_success 'basic help commands' '
>  '
> =20
>  test_expect_success 'invalid usage' '
> -	test_expect_code 129 git help -g git-add

> +	test_expect_code 129 git help -g git-add &&
> +	test_expect_code 129 git help -c git-add &&
> +	test_expect_code 129 git help -g git-add &&

Why two "-g git-add"?

> +
> +	test_expect_code 129 git help -a -c &&
> +	test_expect_code 129 git help -g -c
>  '
> =20
>  test_expect_success "works for commands and guides by default" '
