Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E666C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08C921655
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dAV+XKdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLTViF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:38:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50922 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfLTViF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 16:38:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CC7A9A8A6;
        Fri, 20 Dec 2019 16:38:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pGtrC1ZeLEL/R3q0y/DH2P0of7Q=; b=dAV+XK
        dxQR6kcsUfKcQ/AdoaJlariouEKZv0KIOnF9+PcZi7hL2EiuTsc3oo9U6Hc7I+G5
        Y8NX6oDvGPzVOuEBBAtjY4Xw5D/DQOA/H56TmIVkx0ElXgYHEnVqQWHZj+2yTro3
        l3xw5ApuzcJKgH6yleaFVWUOQpD+FbijUOvp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x9BVvyZJh5MhL8icQeBygYkC/CImRag0
        jCoqIyrzjGs3xGJpEpqnOy1RIO+kZfQFOxZoTOh3/s+kSbfbwxLQv2LejATmJ85T
        cwWxIVMnz8Z6RGirq5BrBNe8IEq9B1AZfaxdqD0s9ifYaQ1Kr1n7N7jgOgP8gejx
        +qALyd29Hqk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8431A9A8A5;
        Fri, 20 Dec 2019 16:38:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A44AF9A89D;
        Fri, 20 Dec 2019 16:38:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, liu.denton@gmail.com,
        plroskin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/15] rebase: fix handling of restrict_revision
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <b84faa86846cba6fb3f4bfa1d4f216fbce3867eb.1576861788.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 13:37:58 -0800
In-Reply-To: <b84faa86846cba6fb3f4bfa1d4f216fbce3867eb.1576861788.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 20 Dec 2019
        17:09:38 +0000")
Message-ID: <xmqqa77m8yq1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FED4D1A8-2370-11EA-9FDE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> restrict_revision in the original shell script was an excluded revision
> range.  It is also treated that way by the am-backend.  In the
> conversion from shell to C (see commit 6ab54d17be3f ("rebase -i:
> implement the logic to initialize $revisions in C", 2018-08-28)), the
> interactive-backend accidentally treated it as a positive revision
> rather than a negated one.
>
> This was missed as there were no tests in the testsuite that tested an
> interactive rebase with fork-point behavior.

Thanks.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/rebase.c  |  4 ++--
>  t/t3400-rebase.sh | 20 +++++++++++++++++++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index cc8f3f008f..b320bb3a30 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -364,8 +364,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>  
>  	argv_array_pushl(&make_script_args, "", revisions, NULL);
>  	if (opts->restrict_revision)
> -		argv_array_push(&make_script_args,
> -				oid_to_hex(&opts->restrict_revision->object.oid));
> +		argv_array_pushf(&make_script_args, "^%s",
> +				 oid_to_hex(&opts->restrict_revision->object.oid));
>  
>  	ret = sequencer_make_script(the_repository, &todo_list.buf,
>  				    make_script_args.argc, make_script_args.argv,
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 79762b989a..71fd6396cd 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -165,11 +165,29 @@ test_expect_success 'rebase works with format.useAutoBase' '
>  	git rebase master
>  '
>  
> -test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
> +test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--merge)' '
>  	git checkout -b default-base master &&
>  	git checkout -b default topic &&
>  	git config branch.default.remote . &&
>  	git config branch.default.merge refs/heads/default-base &&
> +	git rebase --merge &&
> +	git rev-parse --verify default-base >expect &&
> +	git rev-parse default~1 >actual &&
> +	test_cmp expect actual &&
> +	git checkout default-base &&
> +	git reset --hard HEAD^ &&
> +	git checkout default &&
> +	git rebase --merge &&
> +	git rev-parse --verify default-base >expect &&
> +	git rev-parse default~1 >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
> +	git checkout -B default-base master &&
> +	git checkout -B default topic &&
> +	git config branch.default.remote . &&
> +	git config branch.default.merge refs/heads/default-base &&
>  	git rebase &&
>  	git rev-parse --verify default-base >expect &&
>  	git rev-parse default~1 >actual &&
