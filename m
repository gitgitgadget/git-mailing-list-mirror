Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7DEC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0051610CC
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhJMRS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:18:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50089 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhJMRSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 13:18:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C027153C65;
        Wed, 13 Oct 2021 13:16:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6TJkAf7mM8ep4VqM/z9q3dgF6Lr/WKJ247AO4L
        JP2yU=; b=Wrj9WQpXdvwHXCRvt1Hk4ZD0THh8hjydzVUdxBLKzzDzymGgnbgEfU
        VCxTGKE6rbkbM56OTDTaqa9nBDGpACOYFDbR9MPstPQumiJZHxzbf+vJwLHZPekm
        lovlSEMMCqV2RhJNweogM41vgPZhsyt4KH6XQ+sbuzFPN9Wr9LtTs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53B55153C64;
        Wed, 13 Oct 2021 13:16:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B07C9153C63;
        Wed, 13 Oct 2021 13:16:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: test-lib.sh musings: test_expect_failure considered harmful
References: <87tuhmk19c.fsf@evledraar.gmail.com> <xmqq4k9m6vkw.fsf@gitster.g>
        <d643863c-7683-fe4b-e4f2-3fefc475006b@gmail.com>
Date:   Wed, 13 Oct 2021 10:16:18 -0700
In-Reply-To: <d643863c-7683-fe4b-e4f2-3fefc475006b@gmail.com> (Derrick
        Stolee's message of "Wed, 13 Oct 2021 09:05:08 -0400")
Message-ID: <xmqq4k9kj15p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4836B2E8-2C49-11EC-996D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> But even with the shortcomings of expect_failure, it still is much
>> better than claiming that we expect a bogus outcome.
>> 
>> Improving the shortcomings of expect_failure would be a much better
>> use of our time than advocating an abuse of expect_sucess, I would
>> think.
>
> I agree that test_expect_failure has these drawbacks. I've recently
> been using _expect_success to document "bad" behavior so we can verify
> that behavior changes when that behavior is fixed. But it does have
> the drawback of looking like we claim the result is by design.

Yeah, I think I saw (and I think I used the same technique myself)
people expect a bad output with test_expect_success with an in-code
(not in-log) comment that explicitly says "This documents the
current behaviour, which is wrong", and that is a very acceptable
solution, I would think.

> One possible way to correct this is to create a "test_expected_failure"
> helper that could be placed on the step(s) of the &&-chain that are
> expected to fail. The helper could set some variable to true if the
> failure is hit, and false otherwise. It can also convert a failure
> into a positive result. Then, test_expect_failure could look for that
> variable's value (after verifying that the &&-chain returns success)
> to show that all expected failures completed correctly.

Yup, I would very much like the direction, and further imagine that
the above approach can be extended to ...

> This could have the side-effect of having a "fixed" test_expect_failure
> show as a failed test, not a "TODO" message.

... avoid such downside.  Perhaps call that magic "we know this step
fails currently" test_known_breakage and declare that we deprecate
the use of test_expect_failure in new tests.  Such a test might look
like this:

    test_expect_success 'commit error message should not duplicate' '
	test_when_finished "chmod -R u+rwx ." &&
	chmod u-rwx .git/objects/ &&
	orig_head=$(git rev-parse HEAD) &&
	test_must_fail git commit --allow-empty -m "read-only" 2>rawerr &&
	grep "insufficient permission" rawerr >err &&
	test_known_breakage test_line_count = 1 err &&
	new_head=$(git rev-parse HEAD) &&
	test "$orig_head" = "$new_head"
    '

which may use your trick to turn both failure and success to OK (to
let the remainder of the test to continue) but signal the
surrounding test_expect_success to say either "TODO know breakage"
or "Fixed".

Thanks.

