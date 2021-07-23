Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D6C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E446660E78
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhGWScr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:32:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51645 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWScq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:32:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0C3013A1FC;
        Fri, 23 Jul 2021 15:13:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C8eeNw95U3puBr2+8YTlTHFiMlSkT78El1bbVT
        /x15E=; b=UP9COrjXdZ/2p19Lf+zlCMeuj5wt+Phz0f05n7vVZ0yE9d99FW+SZx
        MDysRd59+YDJqs3qxzu9WQTsp7O7shrfFBjH35XY1QFr+LrrNlpUF4+UflD0YY7D
        TYvduaejjne62QrT2KzCwkVwxB/b9Wh7+AJcu0NF5UAq7vjDnmRaY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A90AB13A1FB;
        Fri, 23 Jul 2021 15:13:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CCED613A1F8;
        Fri, 23 Jul 2021 15:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/4] merge: apply autostash if fast-forward fails
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
        <86becf764243f129c980f073127ec3f08fd4477c.1627042470.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:13:15 -0700
In-Reply-To: <86becf764243f129c980f073127ec3f08fd4477c.1627042470.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Fri, 23 Jul 2021
        12:14:29 +0000")
Message-ID: <xmqqo8asn8s4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08DD83F0-EBEA-11EB-BE02-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Since 'git merge' learned '--autostash' in a03b55530a (merge: teach
> --autostash option, 2020-04-07), 'cmd_merge', in the fast-forward case,
> calls 'create_autostash' before calling 'checkout_fast_forward' if
> '--autostash' is given.
>
> However, if 'checkout_fast_forward' fails, the autostash is not applied
> to the working tree, nor saved in the stash list, since the code simply
> calls 'goto done'.
>
> Be more helpful to the user by applying the autostash in that case.
>
> An easy way to test a failing fast-forward is when we are merging a
> branch that has a tracked file that conflicts with an untracked file in
> the working tree.

I think this one makes sense, as the case that is tested I know
fast-forward (aka two-tree switching) would be atomic. If your
working tree is already broken (e.g. triggers I/O errors in the
middle, some directories having wrong permissions to make them
unwritable by you, etc.), you would also see an error from
fast-forward and you probably cannot tell these two cases apart,
and trying to unstash the local changes may make things even worse,
but I suspect that there isn't much you can do about it.

Thanks.

>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  builtin/merge.c  |  1 +
>  t/t7600-merge.sh | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 74797b6c7a6..788a6b0cd55 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1560,6 +1560,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  					  &head_commit->object.oid,
>  					  &commit->object.oid,
>  					  overwrite_ignore)) {
> +			apply_autostash(git_path_merge_autostash(the_repository));
>  			ret = 1;
>  			goto done;
>  		}
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 1cbc9715a81..216113d3537 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -122,6 +122,8 @@ test_expect_success 'setup' '
>  	c0=$(git rev-parse HEAD) &&
>  	cp file.1 file &&
>  	git add file &&
> +	cp file.1 other &&
> +	git add other &&
>  	test_tick &&
>  	git commit -m "commit 1" &&
>  	git tag c1 &&
> @@ -711,6 +713,15 @@ test_expect_success 'fast-forward merge with --autostash' '
>  	test_cmp result.1-5 file
>  '
>  
> +test_expect_success 'failed fast-forward merge with --autostash' '
> +	git reset --hard c0 &&
> +	git merge-file file file.orig file.5 &&
> +	cp file.5 other &&
> +	test_must_fail git merge --autostash c1 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	test_cmp file.5 file
> +'
> +
>  test_expect_success 'octopus merge with --autostash' '
>  	git reset --hard c1 &&
>  	git merge-file file file.orig file.3 &&
