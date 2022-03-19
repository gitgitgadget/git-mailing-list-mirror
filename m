Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACA8C433F5
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 07:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbiCSHOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 03:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiCSHOR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 03:14:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7405DFAD
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 00:12:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72CE610C459;
        Sat, 19 Mar 2022 03:12:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0P4iou2Fgwyq
        ltiZ5pflX0Bm/r4ry3Gij9xa5H+Krp4=; b=TTqoLzaGPx4hK66bwSxoeEbNv+/t
        2NXcJ8/jtsY6bbm0GjIAEQZYZ552kRW0aoNWAtgRdELzYt2Sea4Fh7HnpXGuAdGb
        AcSw/bZ5ZQMippcj/4zD3zDarfl5pWS1BLN0cXb1Pwjh5WMMO6jezD+n+BRvU4JZ
        HsyK0PiOrqccec4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AD1E10C458;
        Sat, 19 Mar 2022 03:12:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CBCF310C457;
        Sat, 19 Mar 2022 03:12:54 -0400 (EDT)
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
        <xmqqczij9jeg.fsf@gitster.g> <xmqq8rt77zp7.fsf@gitster.g>
        <220319.86v8waetae.gmgdl@evledraar.gmail.com>
Date:   Sat, 19 Mar 2022 00:12:53 -0700
In-Reply-To: <220319.86v8waetae.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 19 Mar 2022 00:07:12 +0100")
Message-ID: <xmqqilsa76ve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF462362-A753-11EC-B05E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> emit certain output.  We may assert the ideal future world like so:
>>
>> 	test_expect_success 'make sure foo works the way we want' '
>> 		preparatory step &&
>> 		test_must_fail git foo --bad-option >error &&
>> 		grep "expected error message" error &&
>> 		! grep "unwanted error message" error &&
>> 		git foo >output &&
>> 		grep expected output &&
>> 		! grep unwanted output
>> 	'
>>
>> Let's also imagine that right now, option parsing in "git foo",
>> works but the main execution of the command does not work.
>>
>> With test_expect_todo, you have to write something like this
>> to document the current breakage:
>>
>> 	test_expect_todo 'document breakage' '
>> 		preparatory step &&
>> 		test_must_fail git foo --bad-option >error &&
>> 		grep "expected error message" error &&
>> 		! grep "unwanted error message" error &&
>> 		test_must_fail git foo >output &&
>> 		! grep expected output &&
>> 		grep unwanted output
>> 	'
>>
>> You can see that this makes one thing unclear.
>>
>> Among the two test_must_fail and two !, which one(s) document the
>> breakage?  In other words, which one of these four negations do we
>> wish to lift eventually?  The answer is the latter two (we said that
>> handling of "--bad-option" is already working), but it is not obvious
>> in the above test_expect_todo test sequence.
>>
>> I'd suggest we allow our test to be written this way:
>>
>> 	test_expect_success 'make sure foo works the way we want' '
>> 		preparatory step &&
>> 		test_must_fail git foo --bad-option >error &&
>> 		grep "expected error message" error &&
>> 		! grep "unwanted error message" error &&
>> 	test_ki git foo >output &&
>> 	test_ki grep expected output &&
>> 	test_ki ! grep unwanted output
>> 	'
>>
>> and teach test_expect_success that an invocation of test_ki ("known
>> issue"---a better name that is NOT test_must_fail very much welcome)
>> means we hope this test someday passes without test_ki but not
>> today, i.e. what your test_expect_todo means, and we unfortunately
>> have to expect that the lines annotated with test_ki would "fail".

> Have you had the time to look past patch 1/7 of this series? 2/7
> introduces a "test_todo" helper, the "test_expect_todo" is just the
> basic top-level primitive.

No, and I do not have to.  I care about the most basic form first,
and if you cannot get it right, it is not interesting.  You can
consider the test_ki above as the primitive form of your "test_todo"
that says "I want the command to give true, but I know it currently
gives false".

And quite honestly, I am not interested in _how_ it currently
happens to break.  We may want the command being tested to
eventually count three commits, but due to a bug, it may only count
one.  You may say "test_todo count --want 3 --expect 1 blah", but
the "expect" part is much less interesting than the fact that the
command being tested on _that_ line (not the whole sequence run with
test_expect_failure) is clearly documented to want 3 but currently
is broken, and it can be clearly distinguished from the normal
test_must_fail or ! that documents that we do want a failure out of
the command being tested there.

So with or without the "higher level" wrappers, how else, other than
the way I showed in the message you are responding to as a rewrite
of the example to use test_expect_todo, that uses two test_must_fail
and two ! and makes which ones are expected failure and which ones
are documentation of the current breakage, do you propose to write
the equivalent?  It may be that your test_todo may be a different
way to spell the test_ki marker I showed above, and if that is the
case it is perfectly fine, but I want it to be THE primitive, not
test_must_fail or !, to mark a single command in the test that
currently does not work as expected.

> I don't think we can categorically replace all of the
> "test_expect_failure" cases, because in some of those it's too much of =
a
> hassle to assert the exact current behavior, or we don't really care.
>
> But I think for most cases instead of a:
>
> 	test_ki ! grep unwanted output
>
> It makes more sense to do (as that helper does):
>
> 	test_todo grep --want yay --expect unwanted -- output

My take is the complete opposite.  We can and should start small,
and how exactly the current implementation happens to be broken does
not matter most of the time.

