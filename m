Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E959C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 20:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbiCRUvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 16:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbiCRUvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 16:51:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE1107ABC
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 13:50:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4F171070CC;
        Fri, 18 Mar 2022 16:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9acgLdTRAzFC7M3Qq1voFw3cc6r4zVfIIq0qg7
        C11WA=; b=ZratZe6+M1imJjy5i2oFP7iaWw+5+NcYL6URBMBBbgiS0PyJTuFHqc
        w6Aev/vhbLgCROVodriPdgCS44J5M73mFW6fkHvf6f6eI52JB+oiyQdudVSgaJL9
        5Gvws8PvAcBXRetBcDQHkDiRZdMve/QydEJnJFD/5XxBLRMDBb/tw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD1521070CA;
        Fri, 18 Mar 2022 16:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FC0D1070C9;
        Fri, 18 Mar 2022 16:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
        <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
        <xmqqczij9jeg.fsf@gitster.g>
Date:   Fri, 18 Mar 2022 13:50:12 -0700
In-Reply-To: <xmqqczij9jeg.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        18 Mar 2022 11:59:19 -0700")
Message-ID: <xmqq8rt77zp7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 020044B8-A6FD-11EC-8086-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Marking the step that demonstrates the current shortcomings with
> "MUST FAIL" is a bad taste, but let's pretend that we didn't notice
> it ;-).  Other than that, it looks like an improvement.
> ...
>> +test_expect_failure () {
>> +	_test_expect_todo test_expect_failure "$@"
>> +}
>> +
>> +test_expect_todo () {
>> +	_test_expect_todo test_expect_todo "$@"
>> +}
>
> It is a bit surprising that _test_expect_todo does not share more of
> its implementation with test_expect_success, but let's pretend we
> didn't see it.

With a bit more tweak, I think this can be made palatable:

 * introduce something that is *NOT* test_must_fail but behaves like
   so, but with a bit of magic (see below).

 * do not introduce test_expect_todo, but use an improved version of
   test_expect_success.

Let's illustrate what I mean by starting from an example that we
want to have _after_ fixing an known breakage.  Let's say we expect
that our test preparation succeeds, 'git foo' fails when given a bad
option, 'git foo' runs successfully, and the command is expected to
emit certain output.  We may assert the ideal future world like so:

	test_expect_success 'make sure foo works the way we want' '
		preparatory step &&
		test_must_fail git foo --bad-option >error &&
		grep "expected error message" error &&
		! grep "unwanted error message" error &&
		git foo >output &&
		grep expected output &&
		! grep unwanted output
	'

Let's also imagine that right now, option parsing in "git foo",
works but the main execution of the command does not work.

With test_expect_todo, you have to write something like this
to document the current breakage:

	test_expect_todo 'document breakage' '
		preparatory step &&
		test_must_fail git foo --bad-option >error &&
		grep "expected error message" error &&
		! grep "unwanted error message" error &&
		test_must_fail git foo >output &&
		! grep expected output &&
		grep unwanted output
	'

You can see that this makes one thing unclear.

Among the two test_must_fail and two !, which one(s) document the
breakage?  In other words, which one of these four negations do we
wish to lift eventually?  The answer is the latter two (we said that
handling of "--bad-option" is already working), but it is not obvious
in the above test_expect_todo test sequence.

I'd suggest we allow our test to be written this way:

	test_expect_success 'make sure foo works the way we want' '
		preparatory step &&
		test_must_fail git foo --bad-option >error &&
		grep "expected error message" error &&
		! grep "unwanted error message" error &&
	test_ki git foo >output &&
	test_ki grep expected output &&
	test_ki ! grep unwanted output
	'

and teach test_expect_success that an invocation of test_ki ("known
issue"---a better name that is NOT test_must_fail very much welcome)
means we hope this test someday passes without test_ki but not
today, i.e. what your test_expect_todo means, and we unfortunately
have to expect that the lines annotated with test_ki would "fail".

To readers, test_ki should appear as if an annotation to a single
command that highlights what we want to eventually be able to fix,
and when the issue around the line marked as test_ki is fixed, we
can signal the fact by removing it from the beginning of these lines
(that is why the last one is "test_ki !" and not "!  test_ki").

To the test framework and the shell that is running the test,
test_ki would be almost identical to test_must_fail, i.e. runs the
rest of the command, catch segv and report, but otherwise the
failure from that "rest of the command" execution is turned into
"success" that lets &&-chain to continue.  In addition, it tells
the test_expect_success running it that a success of the test piece
should be shown as TODO (expected failure).

Hmm?


