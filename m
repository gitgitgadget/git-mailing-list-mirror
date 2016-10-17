Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484501F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936522AbcJQRgZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:36:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50255 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933254AbcJQRgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:36:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D335468CD;
        Mon, 17 Oct 2016 13:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=raFDp/X2Zmbb4DPZV0KXjV/17VM=; b=N/ehqo
        bkMkGZoWeAiWezrSwJ+YN5mtS1byKQr5AL3mf+KAzBWZj+ngKYId/MaPwEXzEw0A
        F4OaqjuwwCxSjvWCGeqDVdIpzjcLjKFym99vzFaUlDvFS3DYhThk9EnXgren8EUK
        wW9/N/x+DCHtcnG8GKDa0V0RH2vMTlumKMt50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AH/m2QAuLtTDiCnwHS38wloAoGAxkk6R
        vr1fNF+W5mE97N7eDLakVCUBcHQ3gBg+DwSoCo2PCioF5k6PyfjRrDSrR74nNDfI
        8I1TTzrR95UBUNhzqMkZf/hftTBUFMopRfJuNjzAw3ay3Al134379iPWxeuIPHHJ
        j2RV7vngraw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45533468CB;
        Mon, 17 Oct 2016 13:36:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAD16468C9;
        Mon, 17 Oct 2016 13:36:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] test-lib: detect common misuse of test_expect_failure
References: <xmqqk2day2ry.fsf@gitster.mtv.corp.google.com>
        <20161014235718.2rbejrzs5axhopt7@sigill.intra.peff.net>
Date:   Mon, 17 Oct 2016 10:36:19 -0700
In-Reply-To: <20161014235718.2rbejrzs5axhopt7@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 14 Oct 2016 19:57:18 -0400")
Message-ID: <xmqqa8e2x4h8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 380B6900-9490-11E6-8705-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I like the general idea, but I'm not sure how this would interact with
> the tests in t0000 that test the test suite.

I tried but gave up adding a new test for this to t0000 ;-)

>>  test_expect_failure () {
>> +	if test "$test_in_progress" = 1
>> +	then
>> +		error "bug in the test script: did you mean test_must_fail instead of test_expect_failure?"
>> +	fi
>
> This follows existing practice for things like the &&-lint-checker, and
> bails out on the whole test script.

Yes, you guessed correctly where the above came from.

> That sometimes makes it hard to find
> the problematic test, especially if you're running via something like
> "prove", because it doesn't make valid TAP output.

Yeah, true.

> It might be nicer if we just said "this test is malformed, and therefore
> fails", and then you get all the usual niceties for recording and
> finding the failed test.
>
> I don't think it would be robust enough to try to propagate the error up
> to the outer test_expect_success block (and anyway, you'd also want to
> know about it in a test_expect_failure block; it's a bug in the test,
> not a known breakage). But perhaps error() could dump some TAP-like
> output with a "virtual" failed test.
>
> Something like:
> ...
> which lets "make prove" collect the broken test number.
>
> It would perhaps need to cover the case when $test_count is "0"
> separately. I dunno. It would be nicer still if we could continue
> running other tests in the script, but I think it's impossible to
> robustly jump back to the outer script.
>
> These kinds of "bug in the test suite" are presumably rare enough that
> the niceties don't matter that much, but I trigger the &&-checker
> reasonably frequently (that and test_line_count, because I can never
> remember the correct invocation).
>
> Anyway. That's all orthogonal to your patch. I just wondered if we could
> do better, but AFAICT the right way to do better is to hook into
> error(), which means your patch would not have to care exactly how it
> fails.

Yeah, the change to error() may be a good thing to do, but it has
quite a many callers in t/*lib*.sh and definitely deserves to be a
separate patch, not tied to this single test.
