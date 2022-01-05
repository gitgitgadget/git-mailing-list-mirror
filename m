Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE1EC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbiAEU7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:59:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51756 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiAEU72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:59:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C7C9100062;
        Wed,  5 Jan 2022 15:59:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zwDSg6dRGaG1eN9sz3KEmZsOliqQnJFd4TvzV5
        iGxOY=; b=kEZ9ZUJ5w59kqqUbG2b/Jfq/XlBORqmbdleXTVcE/WkKZJFdVcf/XS
        H71rKN1+f1zXJ7Ijqo3AmEJEjAbrFmYu2IkfD+U2JVHvlUU+zRZ1PT9QO34pVAqc
        JC9/zkmDd2eUqDQcXsZvMoJWr8YHpbLVkgjpcmrT6/ZxOgy72qhFA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34271100061;
        Wed,  5 Jan 2022 15:59:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C386100060;
        Wed,  5 Jan 2022 15:59:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v2 1/2] t7508: add tests capturing racy timestamp handling
References: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
        <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
        <7d58f80611193f8696d99e317fe6b1e53ac740f7.1641388523.git.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 12:59:25 -0800
In-Reply-To: <7d58f80611193f8696d99e317fe6b1e53ac740f7.1641388523.git.gitgitgadget@gmail.com>
        (Marc Strapetz via GitGitGadget's message of "Wed, 05 Jan 2022
        13:15:22 +0000")
Message-ID: <xmqqczl5hpaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E22810A-6E6A-11EC-9C97-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Marc Strapetz <marc.strapetz@syntevo.com>
>
> "git status" fixes racy timestamps regardless of the worktree being
> dirty or not. The new test cases capture this behavior.
>
> Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
> ---
>  t/t7508-status.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 05c6c02435d..652cbb5ed2e 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1656,4 +1656,32 @@ test_expect_success '--no-optional-locks prevents index update' '
>  	! grep ^1234567890 out
>  '
>  
> +test_expect_success 'racy timestamps will be fixed for clean worktree' '
> +	echo content >racy-dirty &&
> +	echo content >racy-racy &&
> +	git add racy* &&
> +	git commit -m "racy test files" &&
> +	# let status rewrite the index, if necessary; after that we expect
> +	# no more index writes unless caused by racy timestamps; note that
> +	# timestamps may already be racy now (depending on previous tests)
> +	git status &&
> +	test-tool chmtime =1234567890 .git/index &&
> +	test-tool chmtime --get .git/index >out &&
> +	grep ^1234567890 out &&

If file contents were 1234567890999, this will still hit, but I do
not think that is what you wanted to see.  Perhaps

	git status &&
	echo 1234567890 >expect &&
	test-tool chmtime=$(cat expect) .git/index &&
	test-tool chmtime --get .git/index >actual &&
	test_cmp expect actual

or something?  But I think you inherited this bogosity from the
previous test, so I am OK to add a few more copies of the same
bogosity to the test.

Somebody later has to step in and clean them all up, though.  When
that happens, we should document how the magic 1234567890 timestamp
was chosen near its first use.

I think it is because it is a timestamp in year 2009, so as long as
your filetime clock is reasonably accurate, a write to the file
would never get such a low timestamp.

> +	git status &&
> +	test-tool chmtime --get .git/index >out &&
> +	! grep ^1234567890 out

