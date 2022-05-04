Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F13C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 18:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376328AbiEDSLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 14:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376818AbiEDSK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 14:10:56 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642BD75E7A
        for <git@vger.kernel.org>; Wed,  4 May 2022 10:27:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1100911CF10;
        Wed,  4 May 2022 13:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HDH+kWcmUZryk2zebeguK7DbP6fVTyBOWQqu1I
        mGt7I=; b=OygGXU3ro4MQzLh472iqePD87ZX+n7Msk6cfigbGC2kkn/Ack4wgOH
        S3zur3yuvKOCrwKbRNBY+spzkkbqF/DPJo8lk919W49t7aOmj1mRvMNEhHM5EygX
        yDO8JqZiO4+p334Z5RdYNY/plExgWu3XHDRljLvE+P84UMtSjKXTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04A0211CF0F;
        Wed,  4 May 2022 13:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 528A311CF0D;
        Wed,  4 May 2022 13:27:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v3] t3200: fix antipatterns in existing branch tests
References: <pull.1182.v2.git.1647995031417.gitgitgadget@gmail.com>
        <pull.1182.v3.git.1651344174050.gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 10:27:31 -0700
In-Reply-To: <pull.1182.v3.git.1651344174050.gitgitgadget@gmail.com> (Tao
        Klerks via GitGitGadget's message of "Sat, 30 Apr 2022 18:42:53
        +0000")
Message-ID: <xmqqh765mcn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AFABBC2-CBCF-11EC-AA7E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_set_remote () {
> +	test_config "remote.$1.url" "$2" &&
> +	test_config "remote.$1.fetch" "${3:-"refs/heads/*:refs/remotes/$1/*"}"
> +}
> +

> @@ -389,11 +394,9 @@ EOF
>  '
>  
>  test_expect_success 'git branch with column.*' '
> -	git config column.ui column &&
> -	git config column.branch "dense" &&
> +	test_config column.ui column &&
> +	test_config column.branch "dense" &&
>  	COLUMNS=80 git branch >actual &&
> -	git config --unset column.branch &&
> -	git config --unset column.ui &&

OK these are easy to verify, as we can clearly see that the
intention is for these two settings to affect no later tests.

> @@ -406,9 +409,8 @@ test_expect_success 'git branch --column -v should fail' '
>  '
>  
>  test_expect_success 'git branch -v with column.ui ignored' '
> -	git config column.ui column &&
> +	test_config column.ui column &&
>  	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
> -	git config --unset column.ui &&

Likewise.

> @@ -452,7 +454,7 @@ test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
>  '
>  
>  test_expect_success 'config information was renamed, too' '
> -	test $(git config branch.s.dummy) = Hello &&
> +	test_cmp_config Hello branch.s.dummy &&
>  	test_must_fail git config branch.s/s.dummy
>  '

OK.

> @@ -510,63 +512,57 @@ test_expect_success 'git branch --copy dumps usage' '
>  test_expect_success 'git branch -c d e should work' '
>  	git branch --create-reflog d &&
>  	git reflog exists refs/heads/d &&
> -	git config branch.d.dummy Hello &&
> +	test_config branch.d.dummy Hello &&
>  	git branch -c d e &&
>  	git reflog exists refs/heads/d &&
>  	git reflog exists refs/heads/e &&
> -	echo Hello >expect &&
> -	git config branch.e.dummy >actual &&
> -	test_cmp expect actual &&
> -	echo Hello >expect &&
> -	git config branch.d.dummy >actual &&
> -	test_cmp expect actual
> +	test_cmp_config Hello branch.e.dummy &&
> +	test_cmp_config Hello branch.d.dummy
>  '

This test used to leave both branch.d.dummy and branch.e.dummy behind
for later tests.  Now with this patch, we clean branch.d.dummy
because we use test_config, but branch.e.dummy that was copied by
successful "git branch -c" will still be left.

 - It is unforunate that it is impossible to verify that the change
   in behaviour for branch.d.dummy is correct.  Without checking all
   the remainder of the test (and no, grepping for branch.d.dummy is
   not "checking all the remainder"---a later "branch -c d x" would
   have created brnach.x.dummy in the original, but with this patch,
   it would not), which is time consuming, that is.

   I trust you made sure that branch.d.dummy is never used after
   this test is done---it would have been good to explain it either
   in the proposed log message or after three-dash that you did
   check and how to save reviewer bandwidth.

 - Are you deliberatly leaving branch.e.dummy uncleaned, or is it a
   mere oversight?

>  test_expect_success 'git branch --copy is a synonym for -c' '
>  	git branch --create-reflog copy &&
>  	git reflog exists refs/heads/copy &&
> -	git config branch.copy.dummy Hello &&
> +	test_config branch.copy.dummy Hello &&
>  	git branch --copy copy copy-to &&
>  	git reflog exists refs/heads/copy &&
>  	git reflog exists refs/heads/copy-to &&
> -	echo Hello >expect &&
> -	git config branch.copy.dummy >actual &&
> -	test_cmp expect actual &&
> -	echo Hello >expect &&
> -	git config branch.copy-to.dummy >actual &&
> -	test_cmp expect actual
> +	test_cmp_config Hello branch.copy.dummy &&
> +	test_cmp_config Hello branch.copy-to.dummy
>  '

The same comment for branch.copy.dummy and branch.copy-to.dummy
applies.

I'll stop here for now.  Thanks for starting this clean-up.
