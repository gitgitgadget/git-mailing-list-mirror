Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D4EC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E561D60FE7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 20:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhGUTh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:37:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53259 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhGUTh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 15:37:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56D1914416B;
        Wed, 21 Jul 2021 16:18:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hO60VHu/I5ooAcKiVuuxaWBcQVgLfy6r9JCDlJ
        E4TNM=; b=QfqtZBhSSeoUzknyijxhmAKpcGROPN525cdVBgZLRM8cEDoS4Xe3n1
        SoMjjKspP0OaXiKduw0vr7vNetHOH/D+fS8QDWWJkRYBq1yXzHJpaB8272OL0QiB
        5Mdi0QOhKxXOVVTihLtIV7wR70j+G23cT+0uS/BYaoAHbZt1sLcwc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EE8114416A;
        Wed, 21 Jul 2021 16:18:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90A99144169;
        Wed, 21 Jul 2021 16:18:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/8] pull: since --ff-only overrides, handle it first
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
        <1a821d3b1ddf22b62b14d3b573015c3d8c90e2de.1626831744.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 13:18:29 -0700
In-Reply-To: <1a821d3b1ddf22b62b14d3b573015c3d8c90e2de.1626831744.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 21 Jul 2021
        01:42:20 +0000")
Message-ID: <xmqqlf5zctey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D169EDB2-EA60-11EB-94DF-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	if (!can_ff) {
> -		if (opt_ff) {
> -			if (!strcmp(opt_ff, "--ff-only"))
> -				die_ff_impossible();
> -		} else {
> -			if (rebase_unspecified && opt_verbosity >= 0)
> -				show_advice_pull_non_ff();
> -		}
> +	/* ff-only takes precedence over rebase */
> +	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
> +		if (!can_ff)
> +			die_ff_impossible();
> +		opt_rebase = REBASE_FALSE;
>  	}
> +	/* If no action specified and we can't fast forward, then warn. */
> +	if (!opt_ff && rebase_unspecified && !can_ff)
> +		show_advice_pull_non_ff();

This part makes sense, but ...

> @@ -1069,13 +1069,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
>  			die(_("cannot rebase with locally recorded submodule modifications"));
>  
> -		if (can_ff) {
> -			/* we can fast-forward this without invoking rebase */
> -			opt_ff = "--ff-only";
> -			ret = run_merge();
> -		} else {
> -			ret = run_rebase(&newbase, &upstream);
> -		}
> +		ret = run_rebase(&newbase, &upstream);

... as I already pointed out, this does not seem to belong to the
change.

What makes this hunk necessary?

We used to use run_merge() to fast-forward, now we let run_rebase()
to first "checkout" their tip, which ends up to be a fast-forward in
the "can_ff" situation.  As a side effect, opt_ff gets contaminated
with the current code, but that would not affect what happens after
this part (i.e. call to rebase_submodules()).
