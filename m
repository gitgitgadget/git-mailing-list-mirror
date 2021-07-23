Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5452C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A4660E97
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhGWSmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:42:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51219 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSmD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:42:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C12E7D57F7;
        Fri, 23 Jul 2021 15:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UPM8u5xh6gmfHSRN/gP0V/D0x3Dmzaaxb84PfZ
        5xhcg=; b=RqdXE6Z4R0cQvA3l6yv7QvzxR4gUShgtaMbFPNLyz0FhcqMcdh9MSc
        yHGtLk2ZpiXMMW22JYUax/jc2RgsfLkcXztsnFhWmOt9aKIa+ECpczUbLiXbzYGq
        WjQMdWFrYoqMV+yEKgKBscwtEKI6jyiMRetUczOXdjg+LgnWGziyI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7DE6D57F6;
        Fri, 23 Jul 2021 15:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39A8AD57F5;
        Fri, 23 Jul 2021 15:22:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 4/4] merge: apply autostash if merge strategy fails
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
        <e02b945ce8595a8d7b1b4ad9c382a1beeb040ed4.1627042470.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:22:34 -0700
In-Reply-To: <e02b945ce8595a8d7b1b4ad9c382a1beeb040ed4.1627042470.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Fri, 23 Jul 2021
        12:14:30 +0000")
Message-ID: <xmqqk0lgn8cl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55B2991C-EBEB-11EB-A0B2-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As explained in a03b55530a, and made more abvious by the tests added in
> that commit, the autostash is then applied if the merge succeeds, either
> directly or by committing (after conflict resolution or if '--no-commit'
> was given), or if the merge is aborted with 'git merge --abort'. In some
> other cases, like the user calling 'git reset --merge' or 'git merge
> --quit', the autostash is not applied, but saved in the stash list.

OK.

> However, there exists a scenario that creates an autostash but does not
> apply nor save it to the stash list: if the chosen merge strategy
> completely fails to handle the merge, i.e. 'try_merge_strategy' returns
> 2.
>
> Apply the autostash in that case also. An easy way to test that is to
> try to merge more than two commits but explicitely ask for the 'recursive'
> merge strategy.

We know that the recursive that barfs when asked to merge more than
one "other" histories will fail before touching the index or the
working tree, but I do not think the merge-strategy protocol makes
any guarantee as to what half-modified state the strategy would
leave the index and the working tree in.

So this change at the first glance looks risky, but at least we have
a call to restore_state() before you added an apply_autostash().
The restore_state() call is the same as the one is used between
application of a strategy that has failed the same way in the loop,
so we should be able to trust it to bring the state back to the
pristine (i.e. after autostash removed the local changes).

I think this change makes sense, too.

(I didn't look at 1/4 and 2/4)

Thanks.



> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  builtin/merge.c  | 1 +
>  t/t7600-merge.sh | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 788a6b0cd55..d44c14a21a3 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1709,6 +1709,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		else
>  			fprintf(stderr, _("Merge with strategy %s failed.\n"),
>  				use_strategies[0]->name);
> +		apply_autostash(git_path_merge_autostash(the_repository));
>  		ret = 2;
>  		goto done;
>  	} else if (best_strategy == wt_strategy)
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 216113d3537..2ef39d3088e 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -732,6 +732,14 @@ test_expect_success 'octopus merge with --autostash' '
>  	test_cmp result.1-3-5-9 file
>  '
>  
> +test_expect_success 'failed merge (exit 2) with --autostash' '
> +	git reset --hard c1 &&
> +	git merge-file file file.orig file.5 &&
> +	test_must_fail git merge -s recursive --autostash c2 c3 2>err &&
> +	test_i18ngrep "Applied autostash." err &&
> +	test_cmp result.1-5 file
> +'
> +
>  test_expect_success 'conflicted merge with --autostash, --abort restores stash' '
>  	git reset --hard c3 &&
>  	cp file.1 file &&
