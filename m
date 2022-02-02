Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55632C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbiBBVah (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:30:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50579 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiBBVag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:30:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A7ED17A4E1;
        Wed,  2 Feb 2022 16:30:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=c6C9tqZolsNuqk2tm+8TitMCvDw2SQJkTq4x3utQJuc=; b=VQLa
        TI7KG0OtXmGyFdB4/qWwKHuedzqWaIrolVdRnSvssuB6IUAiZZU3baCkKchqDGBV
        WsxDA8l+3FniVlKfWFXPs6h/qFNgXEqALr1EcDJQ/bmSex2PejwB0ibSZEQZlyR9
        GwyqGV6h8yTQufV09UtI1vMVdbD5tx/Y6Z2JplY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 328BC17A4E0;
        Wed,  2 Feb 2022 16:30:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8793817A4DE;
        Wed,  2 Feb 2022 16:30:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 03/13] merge-tree: add option parsing and initial
 shell for real merge function
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <63f42df21aec5bda50e4414493eb59dcb64e5558.1643479633.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 13:30:32 -0800
Message-ID: <xmqqsft1x8g7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A77F4D4-846F-11EC-BEFF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct merge_tree_options {
> +	int mode;
> +};

> +static int real_merge(struct merge_tree_options *o,
> +		      const char *branch1, const char *branch2)
> +{
> +	die(_("real merges are not yet implemented"));
> +}
> +
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc != 4)
> -		usage(merge_tree_usage);
> -	return trivial_merge(argc, argv);
> +	struct merge_tree_options o = { 0 };
> +	int expected_remaining_argc;
> +
> +	const char * const merge_tree_usage[] = {
> +		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
> +		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
> +		NULL
> +	};
> +	struct option mt_options[] = {
> +		OPT_CMDMODE(0, "write-tree", &o.mode,
> +			    N_("do a real merge instead of a trivial merge"),
> +			    'w'),

Given the length of the second line in the usage[] array, it would
make more sense to have "'w')," on the same line to make it match
better with the following one.

> +		OPT_CMDMODE(0, "trivial-merge", &o.mode,
> +			    N_("do a trivial merge only"), 't'),
> +		OPT_END()
> +	};
> +
> +	/* Parse arguments */
> +	argc = parse_options(argc, argv, prefix, mt_options,
> +			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (o.mode) {
> +		expected_remaining_argc = (o.mode == 'w' ? 2 : 3);
> +		if (argc != expected_remaining_argc)
> +			usage_with_options(merge_tree_usage, mt_options);
> +	} else {
> +		if (argc < 2 || argc > 3)
> +			usage_with_options(merge_tree_usage, mt_options);
> +		o.mode = (argc == 2 ? 'w' : 't');
> +	}

We are not planning to have tons of different command modes, but the
above looks quite brittle in assuming that 'w' and 't' are the only
ones, and not having an easy way to extend the part without major
rewrite when the assumption will have to be broken.  I wonder:

	switch (o.cmd_mode) {
        default:
		BUG("unexpected cmdmode %c", o.cmd_mode);
	case 0:
		switch (argc) {
		default:
			usage_with_options(merge_tree_usage, mt_options);
		case 2: 
			o.cmd_mode = 'w';
			break;
		case 3:
			o.cmd_mode = 't';
			break;
		}
                expected_remaining_argc = argc;
		break;
	case 'w':
		expected_remaining_argc = 2;
                break;
	case 't':
		expected_remaining_argc = 3;
 		break;
	}

        if (argc != expected_remaining_argc)
		usage_with_options(merge_tree_usage, mt_options);

even though it is a tad longer with more boilerplate, is easlier to
manage.

> +	/* Do the relevant type of merge */
> +	if (o.mode == 'w')
> +		return real_merge(&o, argv[0], argv[1]);
> +	else
> +		return trivial_merge(argv[0], argv[1], argv[2]);
>  }
> diff --git a/git.c b/git.c
> index 5ff21be21f3..6090a1289db 100644
> --- a/git.c
> +++ b/git.c
> @@ -558,7 +558,7 @@ static struct cmd_struct commands[] = {
>  	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> -	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
> +	{ "merge-tree", cmd_merge_tree, RUN_SETUP },

This affects git_support_parseopt_helper function in the completion
script, but it by itself is very unlikely to break existing tests on
the completion, as the bit only affects how the command line options
are completed, and the command didn't have any command line options
to be tested before this series ;-)

>  	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
>  	{ "mktree", cmd_mktree, RUN_SETUP },
>  	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
