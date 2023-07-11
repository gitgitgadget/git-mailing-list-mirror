Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A085BEB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 18:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjGKSxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKSxF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 14:53:05 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF23BC
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 11:52:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC5091977A2;
        Tue, 11 Jul 2023 14:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oil3XqUOnAt6CUEAeGFhIt6GkSTVoub8LQEurB
        EIrjM=; b=jiCN66e3jSjBVicVg0I1g4elTMOwUCETtXhVWaAARsLNjh4qTa9pui
        un3rKVCvHuHDWi/3oQszAxxiJqKkxxWm9g9C6CRjnBwGshBtFZMS2GFBbcqqNJ7+
        ayz2/ei0G7v2hscZKaNMMDLt5JR+sf2C0fR8Y8wXeSTtZYfYxv/iU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3B711977A1;
        Tue, 11 Jul 2023 14:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 299E71977A0;
        Tue, 11 Jul 2023 14:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH v3 2/3] t1092: add tests for `git check-attr`
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-1-cheskaqiqi@gmail.com>
        <20230711133035.16916-3-cheskaqiqi@gmail.com>
Date:   Tue, 11 Jul 2023 11:52:57 -0700
In-Reply-To: <20230711133035.16916-3-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Tue, 11 Jul 2023 09:30:34 -0400")
Message-ID: <xmqqedlexoty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 271460D8-201C-11EE-AA96-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> Add smudge/clean filters in .gitattributes files inside the affected
> sparse directories in test 'merge with conflict outside cone', make sure
> it behaves as expected when path is outside of sparse-checkout.

Please rewrite "as expected" into a more concrete form.  What is the
expectation when path is outside of sparse-checkout?  The attributes
file does not need to be read and that can be observed by the filter
program not triggering?  The attribute file does get read and that
can be observed by the filter program running?

> Add tests for `git check-attr`, make sure it behaves as expected when
> path is both inside or outside of sparse-checkout definition.

Ditto.

> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 40 ++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Thanks.

>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 8a95adf4b5..839e08d8dd 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1006,6 +1006,17 @@ test_expect_success 'merge with conflict outside cone' '
>  
>  	test_all_match git checkout -b merge-tip merge-left &&
>  	test_all_match git status --porcelain=v2 &&
> +
> +	echo "a filter=rot13" >>.gitattributes &&
> +	run_on_sparse mkdir folder1 &&
> +	run_on_all cp ../.gitattributes ./folder1 &&
> +	git -C full-checkout add folder1/.gitattributes &&
> +	run_on_sparse git add --sparse folder1/.gitattributes &&
> +	run_on_all git commit -m "add .gitattributes" &&
> +	test_sparse_match git sparse-checkout reapply &&
> +	git config filter.rot13.clean "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
> +	git config filter.rot13.smudge "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
> +
>  	test_all_match test_must_fail git merge -m merge merge-right &&
>  	test_all_match git status --porcelain=v2 &&
>  
> @@ -2259,4 +2270,33 @@ test_expect_success 'worktree is not expanded' '
>  	ensure_not_expanded worktree remove .worktrees/hotfix
>  '
>  
> +test_expect_success 'check-attr with pathspec inside sparse definition' '
> +	init_repos &&
> +
> +	echo "a -crlf myAttr" >>.gitattributes &&
> +	run_on_all cp ../.gitattributes ./deep &&
> +
> +	test_all_match git check-attr -a -- deep/a &&
> +
> +	test_all_match git add deep/.gitattributes &&
> +	test_all_match git check-attr -a --cached -- deep/a
> +'
> +
> +test_expect_success 'check-attr with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	echo "a -crlf myAttr" >>.gitattributes &&
> +	run_on_sparse mkdir folder1 &&
> +	run_on_all cp ../.gitattributes ./folder1 &&
> +	run_on_all cp a folder1/a &&
> +
> +	test_all_match git check-attr -a -- folder1/a &&
> +
> +	git -C full-checkout add folder1/.gitattributes &&
> +	run_on_sparse git add --sparse folder1/.gitattributes &&
> +	run_on_all git commit -m "add .gitattributes" &&
> +	test_sparse_match git sparse-checkout reapply &&
> +	test_all_match git check-attr  -a --cached -- folder1/a
> +'
> +
>  test_done
