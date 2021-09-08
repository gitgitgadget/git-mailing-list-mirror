Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D060C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155BE61139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhIHQeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:34:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50778 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhIHQeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:34:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9B46165F6F;
        Wed,  8 Sep 2021 12:33:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MKu6oFKQ6N4owp+cSKe45sAEjwhKxySMb2Gouc
        vebYg=; b=uJxdys1a27OS+HR1oC2Ztl2S7TPu0XV8GJXChwRScRdnS7MGNi8u8W
        PD/RUZy2oTnPlASe++RqsdV02tbyxhdEAY1Z/KGx4Z09trhpNvSUoQFeSDFgrMI2
        MOObqN/eMzYWpxdviHqpQyQmFGFUevxoIAoXAqP/u0W+H+Sdgka38=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D15FE165F6E;
        Wed,  8 Sep 2021 12:33:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 19B7A165F6D;
        Wed,  8 Sep 2021 12:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] t4151: document a pair of am --abort bugs
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
        <b8a418bc63ab0a4add25724a11eb5f992e3d4472.1631067429.git.gitgitgadget@gmail.com>
        <xmqq8s077doe.fsf@gitster.g>
        <CABPp-BGD9WdeiquX0eiMz2458pDhJpjOXGyUOqoXu52ohZVCsQ@mail.gmail.com>
Date:   Wed, 08 Sep 2021 09:33:09 -0700
In-Reply-To: <CABPp-BGD9WdeiquX0eiMz2458pDhJpjOXGyUOqoXu52ohZVCsQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 8 Sep 2021 01:00:43 -0700")
Message-ID: <xmqq1r5z58oq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74D0953C-10C2-11EC-B59C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Sep 8, 2021 at 12:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > +test_expect_failure 'git am --abort returns us to a clean state' '
>> > +     git checkout changes &&
>> > +     git format-patch -1 --stdout conflicting >changes.mbox &&
>> > +     test_must_fail git am --3way changes.mbox &&
>> > +
>> > +     # Make a change related to the rest of the am work
>> > +     echo related change >>file-2 &&
>> > +
>> > +     # Abort, and expect the related change to go away too
>> > +     git am --abort &&
>> > +     git status --porcelain -uno >actual &&
>> > +     test_must_be_empty actual
>>
>> This test makes me worried.  It is perfectly normal for "am" to be
>> asked to work in a dirty working tree as long as the index is clean
>> and the working tree files that are involved in the patch are
>> unmodified.
>
> Ah, I think I am just too used to rebase where it refuses to start if
> the working tree isn't clean, assumed the same with am (which I don't
> use that much), and then projected from there.
>
> I'll drop the second test; thanks for the explanation.

Actually, if you test that unrelated dirty files are kept, then the
test is a welcome addition.  "returns us to a 'clean' state" needs a
bit different title, though.

Thanks.
