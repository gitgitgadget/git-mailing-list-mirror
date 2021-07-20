Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632DCC636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 23:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4637061007
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 23:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhGTXN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 19:13:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52029 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhGTXNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 19:13:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC3EFD4FF0;
        Tue, 20 Jul 2021 19:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BRqr9eb7nSkTPpD2VVKWpAiPqQYDQEDt9w8b+W
        Iz5R8=; b=E1QGfVZAXhCAXBqUaftGZWdBzaqFa+lI7MwgnZLUE9p1MIDTzqklca
        KVSCHZ+mZeTGonRRRk8DeIklYkIZEEWhXvRbsCzIWEFsGCd25JlarR5tArwQnJAU
        3IiCkAvw3Spa0ahoTrcg4rg7RABZdqX0rJxSsbwliUQN4vaiavFFo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2DC4D4FEF;
        Tue, 20 Jul 2021 19:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44BA0D4FEE;
        Tue, 20 Jul 2021 19:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/9] pull: make --rebase and --no-rebase override
 pull.ff=only
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <b379fea097d65a28f1791f7f2f9432b6689a977f.1626536508.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 16:53:46 -0700
In-Reply-To: <b379fea097d65a28f1791f7f2f9432b6689a977f.1626536508.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 17 Jul 2021
        15:41:44 +0000")
Message-ID: <xmqqpmvcfsol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B95AA514-E9B5-11EB-849C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Fix the last few precedence tests failing in t7601 by now implementing
> the logic to have --[no-]rebase override a pull.ff=only config setting.

Because we only have opt_rebase and opt_ff, unless we are in a very
early part of the code, we cannot tell if "opt_rebase >= 0" we see
came from the command line or from the configuration, and because
pull.rebase, pull.ff, --rebase=<kind>, and <--ff|--ff-only|--no-ff>
have intricate interactions among them, we'd probably need to behave
differently depending on where "opt_rebase >= 0" came from.

The new code works only because we haven't called config_get_rebase()
yet in this part.  If we swapped the order of "if ff is not set,
then figure it out from the configuration" (the code you are
extending) and "if rebase is not set, read from the configuration",
then the logic would not work.

The resulting code looks correct, but it is subtle and may deserve
an in-code comment.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/pull.c               | 5 ++++-
>  t/t7601-merge-pull-config.sh | 4 ++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 5ba376a7487..7e7c90f6a10 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -966,8 +966,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	parse_repo_refspecs(argc, argv, &repo, &refspecs);
>  
> -	if (!opt_ff)
> +	if (!opt_ff) {
>  		opt_ff = xstrdup_or_null(config_get_ff());

		/*
		 * Do we have --rebase=<kind> or --no-rebase from the
		 * command line (note that we haven't read pull.rebase yet)?
		 * If so, defeat the configured pull.ff=only; instead of
		 * failing to integrate divergent histories, we want the
		 * rebase or merge to happen.
		 */

> +		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only"))
> +			opt_ff = "--ff";
> +	}

Thanks.
