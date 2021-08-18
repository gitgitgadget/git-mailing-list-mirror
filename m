Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763D5C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500B9610A6
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhHRSLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:11:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63977 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhHRSLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 14:11:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BED2114F72E;
        Wed, 18 Aug 2021 14:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i0x6zWqenyn66Gn1A+LLxbHkiECsmc9V6Lwpo3
        4zLWk=; b=WzuMV8RdlM1wLHzJOWBnT1okwfled1bIPfKsJVMDeNbmtVf8ZY2Kcf
        rm9249zWCmJt6aRQ1CqLxiuwvXqPPQ1/GR2Clw9DS0EcH4tuYof0jHAwY3T9QSXh
        X2/gprrSR5/MIAaFd17IASl9gsVXyBhKIF51NQLpjMh5p8gG3005g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B70E014F72D;
        Wed, 18 Aug 2021 14:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0BA7F14F72B;
        Wed, 18 Aug 2021 14:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Aug 2021 11:10:34 -0700
In-Reply-To: <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 17 Aug 2021
        17:08:39 +0000")
Message-ID: <xmqqzgte62ud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95FFEEF2-004F-11EC-9529-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The sparse index will be compatible with the ORT merge strategy, so
> let's use it explicitly in our tests.

Unless you mean that the sparse index will only be compatible with
ort, but will never be with recursive, I do not quite see why this
is taking us into a good direction.  Is this because we want to gain
test coverage for ort early, before we flip the default to ort [*1*]?



[Footnote]

*1* If the answer is "no, it is because sparse index will not work
    with recursive", the please disregard the rest, but just in
    case it is not...

    It seems to me that it would let us live in the future in a more
    comprehensive way if we tweaked merge_recursive() and/or
    merge_recursive_generic() so that all internal callers, not just
    builtin/merge.c, would redirect to the ort machinery when say
    GIT_TEST_REPLACE_RECURSIVE_WITH_ORT environment exists, and
    doing it that way we do not need to sprinkle "-srecursive" and
    "-sort" everywhere in our tests at randomly chosen places to
    give test coverage to both strategies.


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index ddc86bb4152..3e01e70fa0b 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -7,6 +7,11 @@ GIT_TEST_SPARSE_INDEX=
>  
>  . ./test-lib.sh
>  
> +# Force the use of the ORT merge algorithm until testing with the
> +# recursive strategy. We expect ORT to be used with sparse-index.
> +GIT_TEST_MERGE_ALGORITHM=ort
> +export GIT_TEST_MERGE_ALGORITHM
> +
>  test_expect_success 'setup' '
>  	git init initial-repo &&
>  	(
> @@ -501,7 +506,7 @@ test_expect_success 'merge with conflict outside cone' '
>  
>  	test_all_match git checkout -b merge-tip merge-left &&
>  	test_all_match git status --porcelain=v2 &&
> -	test_all_match test_must_fail git merge -m merge merge-right &&
> +	test_all_match test_must_fail git merge -sort -m merge merge-right &&
>  	test_all_match git status --porcelain=v2 &&
>  
>  	# Resolve the conflict in different ways:
> @@ -531,7 +536,7 @@ test_expect_success 'merge with outside renames' '
>  	do
>  		test_all_match git reset --hard &&
>  		test_all_match git checkout -f -b merge-$type update-deep &&
> -		test_all_match git merge -m "$type" rename-$type &&
> +		test_all_match git merge -sort -m "$type" rename-$type &&
>  		test_all_match git rev-parse HEAD^{tree} || return 1
>  	done
>  '
