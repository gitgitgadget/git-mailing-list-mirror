Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96623C43461
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D3361925
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhELBlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 21:41:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58903 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhELBlK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 21:41:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07052C59EB;
        Tue, 11 May 2021 21:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=P2RV9+izZ7pd6J0wGnuHuHbnobWBGWFB/0P0QREC5Jw=; b=ayth
        mG8i/A/UNtLIKtbeCFVSiNwAaPEscqMRJ+YRe99vf+RKxT77V6Cc1CdjsC6WuXe4
        hqvMU9MAu9+5OK77Tok26hR0gBtWxkG3tiEnboeZwaaG+jB64S4SCqcvcjyJCV5u
        Al7fwfwubZ7EsH5bj/XPb71lxcQnM69eDf2mr7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2745C59EA;
        Tue, 11 May 2021 21:36:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FAD8C59E8;
        Tue, 11 May 2021 21:36:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v5] [GSOC] ref-filter: fix read invalid union member bug
References: <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com>
        <pull.949.v5.git.1620747320947.gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 10:36:03 +0900
Message-ID: <xmqq35usivi4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A8452CA-B2C2-11EB-BAC5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> used_atom.u is an union, and it has different members depending on
> what atom the auxiliary data the union part of the "struct
> used_atom" wants to record. At most only one of the members can be
> valid at any one time. Since the code checks u.remote_ref without
> even making sure if the atom is "push" or "push:" (which are only
> two cases that u.remote_ref.push becomes valid), but u.remote_ref
> shares the same storage for other members of the union, the check
> was reading from an invalid member, which was the bug.
>
> Modify the condition here to check whether the atom name
> equals to "push" or starts with "push:", to avoid reading the
> value of invalid member of the union.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

Thanks.

> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 9866b1b57368..309cf699506f 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -117,6 +117,24 @@ test_expect_success '%(color) must fail' '
>  	test_must_fail git for-each-ref --format="%(color)%(refname)"
>  '
>  
> +test_expect_success '%(color:#aa22ac) must successed' '

"succeed".

> +	test_when_finished "cd .. && rm -rf ./test" &&

Not a very good practice to chdir around, even if you have
when-finished clean-up.  Not worth risking "rm -rf" at random
places when for example somebody breaks when-finished.

Instead...

> +	mkdir test &&

Place everything below ...

> +	cd test &&
> +	git init &&
> +	cat >expect <<-\EOF &&
> +	refs/heads/main
> +	EOF
> +	git add . &&
> +	git branch -M main &&

This is in a freshly created repository without commit.  Does
"branch -M" work for such an unborn branch?  Perhaps start this
block like so:

	git init test &&
	(
		cd test &&
		test_commit initial &&
		git branch -M main &&
		cat >expect <<-\EOF &&
		refs/heads/main
                refs/tags/initial
		EOF
		git remote add origin nowhere &&
		...

> +	git commit -m "test" &&
> +	git remote add origin nowhere &&
> +	git config branch.main.remote origin &&
> +	git config branch.main.merge refs/heads/main &&
> +	git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
> +	test_cmp expect actual

... up to here inside a (subshell).

By the way, your use of "git branch -M" makes the test work whether
the default initial branch name is still 'master' or already 'main'
by forcing the branch used for testing to be 'main'.  Clever ;-).

Will queue with all of the above suggestions squashed in; please see
if the result is good when it is pushed out later today.

Thanks.

> +'
> +
>  test_expect_success 'left alignment is default' '
>  	cat >expect <<-\EOF &&
>  	refname is refs/heads/main    |refs/heads/main
>
> base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
