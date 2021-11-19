Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C6EC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhKSXKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:10:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53271 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhKSXKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:10:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D481BF2F14;
        Fri, 19 Nov 2021 18:07:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=djX2EfpNjoyblb+uMQkmpLgX/gRKaBtFv/6nln
        qb3Nk=; b=CPvoEvimNi3eE/8FNgA0QQiV0QoZM3VogF0Glvu9MSWnthURkcb0rp
        1GDncvWkbN6thLnbCcj7uwsSxtYyGY8acCFxaixcokYu9lZ+1F3h73WIX2xZTRYF
        9Byk3rylM0ohyFrAhtvipanAMKfzZR2TT1gPp4rJn8KEToQ96zB8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB90DF2F13;
        Fri, 19 Nov 2021 18:07:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E71CDF2F12;
        Fri, 19 Nov 2021 18:07:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v7 2/2] am: support --empty=<option> to handle empty
 patches
References: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
        <9e60e77c041bca28a50d706c865eb776e5fe2ec2.1637298299.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 15:07:03 -0800
In-Reply-To: <9e60e77c041bca28a50d706c865eb776e5fe2ec2.1637298299.git.gitgitgadget@gmail.com>
        (Aleen via GitGitGadget's message of "Fri, 19 Nov 2021 05:04:58
        +0000")
Message-ID: <xmqqpmqvoico.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 696E60F8-498D-11EC-B806-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aleen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'An empty input file is error regardless of --empty option' '

Titles of all the other tests seem to begin with lowercase, so "An
empty" -> "an empty", probably.

> +	test_must_fail git am --empty=drop empty.patch 2>actual &&
> +	echo Patch format detection failed. >expected &&

Quote for exactness, like the next test does.

    echo "Patch format detection failed." >expected

> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'invalid when passing the --empty option alone' '
> +	git checkout empty-commit^ &&
> +	test_must_fail git am --empty empty-commit.patch 2>err &&
> +	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
> +	test_cmp expected err
> +'

This mode of failure of "am" may not leave ".git/rebase-apply"
behind right now, or it may leave one in the future.  We do not want
to worry about left-over cruft to interfere with the next test, so
cleaning after ourselves with test_when_finished would be a good
idea, i.e.

    test_expect_success 'invalid when passing the --empty option alone' '
            test_when_finished "git am --abort || :" &&
            git checkout empty-commit^ &&
            test_must_fail git am --empty empty-commit.patch 2>err &&
            echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
            test_cmp expected err
    '

> +test_expect_success 'a message without a patch is an error (default)' '
> +	test_when_finished "git am --abort || :" &&
> +	test_must_fail git am empty-commit.patch >err &&
> +	grep "Patch is empty" err &&
> +	rm -fr .git/rebase-apply
> +'

And the point of test_when_finished is to run the clean-up even when
other steps in the test fails.  For example, "test_must_fail git am"
may fail to fail for any reason.  Or "grep" after it may fail.
Because the pieces in a single test is strung together with &&, any
such failure means the control would NOT reach "rm -fr".  

Since we have test_when_finished that cleans up after ourselves even
in such a case, the last "rm -fr" step is unnecessary.

> +test_expect_success 'a message without a patch is an error where an explicit "--empty=die" is given' '
> +	test_when_finished "git am --abort || :" &&
> +	test_must_fail git am --empty=die empty-commit.patch >err &&
> +	grep "Patch is empty." err &&
> +	rm -fr .git/rebase-apply
> +'

Likewise.

Other than that (and po/ that should not be part of this patch),
things are looking good.

Thanks.
