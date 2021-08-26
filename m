Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E027C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 17:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646D06109E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 17:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbhHZRjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 13:39:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57597 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhHZRjW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 13:39:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F2D5156500;
        Thu, 26 Aug 2021 13:38:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9NLIdCqROvBOVAhWJGMrEJqnLIN8cOknpnUCxc
        Ija3k=; b=fDu5oOgst+5UmQmalbHa2grTWCA/Wla7N09vsduAj5u1Hx8NWk9cOW
        SRsdH6/9jRYPy8UWQWFNiGB3bZXE+YJ7XT3qd0PpPozs3W6iZsKCZGmo9WMeXieS
        TKgUUw0VDLS18jZy366usS6+nhdYKdzi+BkxXTI8tOkNUvq9s7hWk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57B071564FF;
        Thu, 26 Aug 2021 13:38:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E26D1564FE;
        Thu, 26 Aug 2021 13:38:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: [PATCH RESEND] branch: allow deleting dangling branches with
 --force
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
        <xmqqr1ehgq8t.fsf@gitster.g>
        <CAFQ2z_Mwj0+uWO-Ly8MTHmidjf=1P-9K1n2f0DSNzN=Or2t=bw@mail.gmail.com>
        <xmqq5yvsf8p5.fsf@gitster.g>
Date:   Thu, 26 Aug 2021 10:38:29 -0700
In-Reply-To: <xmqq5yvsf8p5.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        26 Aug 2021 09:54:14 -0700")
Message-ID: <xmqq1r6gf6ne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E45B6A8-0694-11EC-89D7-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Han-Wen Nienhuys <hanwen@google.com> writes:
>
>> On Wed, Aug 25, 2021 at 11:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> > +test_expect_success 'branch --delete --force removes dangling branch' '
>>> > +     test_when_finished "rm -f .git/refs/heads/dangling" &&
>>> > +     echo $ZERO_OID >.git/refs/heads/dangling &&
>>> > +     git branch --delete --force dangling &&
>>> > +     test_path_is_missing .git/refs/heads/dangling
>>> > +'
>>>
>>> This goes against the spirit of the series merged at c9780bb2 (Merge
>>> branch 'hn/prep-tests-for-reftable', 2021-07-13).
>>>
>>> Can we creat the dangling ref and test the lack of "dangling" ref in
>>> the end in a less transparent way?
>>
>> agreed. Try the ref-store test-helper's update-ref command?
>
> I thought the approach taken by dc474899 (t4202: mark bogus head
> hash test with REFFILES, 2021-05-31) to hide it behind a
> prerequisite was good enough, but if we can ensure the same
> behaviour under the reftable backend, that is even better.
>
> Thanks.

Having said that, there are a few observations to make about this
test script.

 * It is hopefully becoming harder and harder to check for behaviour
   in broken repositories in a "portable" way, simply because we are
   making it harder to corrupt repository.  We hopefully won't point
   a ref to point at a missing object, we hopefully won't prune an
   object away that is still pointed at by a ref, etc.

 * This script to test "branch" is full of tests that rely on direct
   manipulation of .git/refs/ filesystem hierarchy.

For these two reasons, it probably is OK to accept this patch as-is
and leave the "clean-up" to a later follow-on series, that would
cover both "what's our recommended approach to 'corrupt' the test
repository so that we can use different ref (and other) backends?"
and "make sure the tests in the script are happy with both ref
backends." issues.

Thanks.
