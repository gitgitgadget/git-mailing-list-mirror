Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEFBC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 18:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbhLMSL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:11:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57035 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbhLMSL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4C4BFB7B9;
        Mon, 13 Dec 2021 13:11:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4moQXe/VWLHjHkA9BOT+FQITdSsNT8GA4PE5ZN
        oMc+8=; b=mC5j7vw9E2PJpkhOvwaQF8woifzv1Ts5hUq1no8qTYu2rPAofg25bX
        a64YU1k9Ebb6f/4yaBD7MWorTNG2BXy+N55IJeKFaaIQqmt72hPR4tFk3omp/wNl
        L0sWSn03pznLxayA9L6dsUZCIlDyQ+Oo/5ybjObO8z/UcR5KIsmho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C6EDFB7B8;
        Mon, 13 Dec 2021 13:11:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08B18FB7B7;
        Mon, 13 Dec 2021 13:11:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 03/10] sparse-checkout: add sanity-checks on initial
 sparsity state
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <f3af5edb25d5bed46996a1b826ae0c8306eeb912.1639108573.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 10:11:55 -0800
In-Reply-To: <f3af5edb25d5bed46996a1b826ae0c8306eeb912.1639108573.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 10 Dec 2021
        03:56:06 +0000")
Message-ID: <xmqq7dc8e5n8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 289AAA26-5C40-11EC-BA27-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Most sparse-checkout subcommands (list, add, reapply, disable)
> only make sense when already in a sparse state.  Add a quick check
> that will error out early if this is not the case.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
> Reviewed-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/sparse-checkout.c          | 12 ++++++++++++
>  t/t1091-sparse-checkout-builtin.sh | 10 +++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)

I won't complain too much but some looks a bit questionable to die
on.  For example, when asked to "please disable" something that is
already disabled, I do not think the user's intention includes "if
already disabled, please die"; rather it is "I want the end result
to be in the disabled state", isn't it?

I think what is common among the ones that I find questionable to
die is that they do not use end-user input from argv.  "Please add X
to sparsity patterns" may not make much sense when we are not already
sparse", unlike "Please disable", for example.

    Side note. I suspect that it can be argued that we might just
    auto-enable sparse state upon the first request to add
    something, but I personally feel that is dwimming too much, as
    behaviours of git in normal mode and sparse mode are so
    different.

So, for the same reason, I think "list" that shows "there is
nothing" without an error, when sparse-checkout is not active, would
also be perfectly defensible, and some people may find that dying a
bit too much in such a situation.

Or does the system work differently between

 (A) core_apply_sparse_checkout is true and the sparsity pattern list is
     empty, and
 (B) sparse-checkout is not in effect at all.

If that is the case, please ignore all of the above.

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index e252b82136e..e9f644ac362 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -56,6 +56,9 @@ static int sparse_checkout_list(int argc, const char **argv)
>  	char *sparse_filename;
>  	int res;
>  
> +	if (!core_apply_sparse_checkout)
> +		die(_("this worktree is not sparse"));
> +
>  	argc = parse_options(argc, argv, NULL,
>  			     builtin_sparse_checkout_list_options,
>  			     builtin_sparse_checkout_list_usage, 0);
> @@ -671,6 +674,9 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
>  		OPT_END(),
>  	};
>  
> +	if (!core_apply_sparse_checkout)
> +		die(_("no sparse-checkout to add to"));
> +
>  	repo_read_index(the_repository);
>  
>  	argc = parse_options(argc, argv, prefix,
> @@ -719,6 +725,9 @@ static int sparse_checkout_reapply(int argc, const char **argv)
>  		OPT_END(),
>  	};
>  
> +	if (!core_apply_sparse_checkout)
> +		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
> +
>  	argc = parse_options(argc, argv, NULL,
>  			     builtin_sparse_checkout_reapply_options,
>  			     builtin_sparse_checkout_reapply_usage, 0);
> @@ -740,6 +749,9 @@ static int sparse_checkout_disable(int argc, const char **argv)
>  	struct pattern_list pl;
>  	struct strbuf match_all = STRBUF_INIT;
>  
> +	if (!core_apply_sparse_checkout)
> +		die(_("no active sparse-checkout to disable"));
> +
>  	argc = parse_options(argc, argv, NULL,
>  			     builtin_sparse_checkout_disable_options,
>  			     builtin_sparse_checkout_disable_usage, 0);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 272ba1b566b..90a281bcf64 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -41,7 +41,15 @@ test_expect_success 'setup' '
>  	)
>  '
>  
> -test_expect_success 'git sparse-checkout list (empty)' '
> +test_expect_success 'git sparse-checkout list (not sparse)' '
> +	test_must_fail git -C repo sparse-checkout list >list 2>err &&
> +	test_must_be_empty list &&
> +	test_i18ngrep "this worktree is not sparse" err
> +'
> +
> +test_expect_success 'git sparse-checkout list (not sparse)' '
> +	git -C repo sparse-checkout set &&
> +	rm repo/.git/info/sparse-checkout &&
>  	git -C repo sparse-checkout list >list 2>err &&
>  	test_must_be_empty list &&
>  	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
