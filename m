Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345BC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D3E61037
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbhHZQzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:55:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64292 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243058AbhHZQzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 12:55:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DE90E5BF5;
        Thu, 26 Aug 2021 12:54:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ivIHtvJFoTwshwpYihb1yelAsz7wViFDmsXaas
        GRebY=; b=pvSalkaRO3rGDRV3Gmjr1rDrvxi0Dz55/JCHIlqkcgWCk7h5a0RlWD
        jcmUcV8EJpBLYMFPRO/YMDOrIEn8Amx2BLYCiFIF0Sko6xYEG+lbJvqZ0vRidTfw
        +JgT5rTLl3cdvmdaBDaVAS45E681e3Iy5up5L5DqKIibR7VVut9RE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85571E5BF4;
        Thu, 26 Aug 2021 12:54:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 101A9E5BF3;
        Thu, 26 Aug 2021 12:54:15 -0400 (EDT)
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
Date:   Thu, 26 Aug 2021 09:54:14 -0700
In-Reply-To: <CAFQ2z_Mwj0+uWO-Ly8MTHmidjf=1P-9K1n2f0DSNzN=Or2t=bw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 26 Aug 2021 09:26:01 +0200")
Message-ID: <xmqq5yvsf8p5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3ED3C870-068E-11EC-BE89-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Aug 25, 2021 at 11:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> > +test_expect_success 'branch --delete --force removes dangling branch' '
>> > +     test_when_finished "rm -f .git/refs/heads/dangling" &&
>> > +     echo $ZERO_OID >.git/refs/heads/dangling &&
>> > +     git branch --delete --force dangling &&
>> > +     test_path_is_missing .git/refs/heads/dangling
>> > +'
>>
>> This goes against the spirit of the series merged at c9780bb2 (Merge
>> branch 'hn/prep-tests-for-reftable', 2021-07-13).
>>
>> Can we creat the dangling ref and test the lack of "dangling" ref in
>> the end in a less transparent way?
>
> agreed. Try the ref-store test-helper's update-ref command?

I thought the approach taken by dc474899 (t4202: mark bogus head
hash test with REFFILES, 2021-05-31) to hide it behind a
prerequisite was good enough, but if we can ensure the same
behaviour under the reftable backend, that is even better.

Thanks.

