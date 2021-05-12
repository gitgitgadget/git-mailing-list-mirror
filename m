Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37D4C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8394610A1
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhELDTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:19:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53097 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDTD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:19:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91927123459;
        Tue, 11 May 2021 23:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V5kKdHCm4+oQQbVK+XdpxAyClZivpjdtYgjtT1
        3v+ck=; b=L5WgrCYWAnGBiTZa7BY0BhHsZJCLVQHd8exJ6qTHD/hs3eW8FEDk++
        mwzevmxEm261K+VlGWb0Q8dLQyKc3K2pqUfKpbgc7aFGM2vnT9ey/oigOnwH50l0
        GSooJx7sQQ/1rHG8khS3p3IpVFuVBTmUUED/IrmvkjnF4EbQJxmao=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89640123458;
        Tue, 11 May 2021 23:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF6A0123457;
        Tue, 11 May 2021 23:17:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 4/8] t7300: add testcase showing unnecessary
 traversal into ignored directory
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <dc3d3f2471410aa55da4dbc8e2747192888bce5f.1620503945.git.gitgitgadget@gmail.com>
        <xmqq7dk7rwcc.fsf@gitster.g>
        <CABPp-BFV6R9GNeZVbiKx_Tazq+6LuBNCzLcsEq63MfG5YD0hFQ@mail.gmail.com>
        <xmqqsg2sj3id.fsf@gitster.g>
        <CABPp-BEJQ5RQdvm58xrNcWm9VdPrUF8_-bym-M424bs7xR=8Gg@mail.gmail.com>
Date:   Wed, 12 May 2021 12:17:51 +0900
In-Reply-To: <CABPp-BEJQ5RQdvm58xrNcWm9VdPrUF8_-bym-M424bs7xR=8Gg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 11 May 2021 19:07:40 -0700")
Message-ID: <xmqqy2ckhc80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3537118-B2D0-11EB-8384-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> If you'd like, I can add another patch in the series with this change
> so that all readdir() calls in dir.c have such ignore '.' and '..'
> logic.  Or, we could perhaps introduce a new readdir() wrapper that
> does nothing other than ignore '.' and '..' and have all three of
> these callsites use that new wrapper.

Yeah, it is good to be consistent (either implementation).

>> So dropping the test for number of visited paths would be nicer from
>> portability's point of view ;-)
>
> Yep, makes sense.  I already did that in v4, which means it'll
> continue to pass with or without the above proposed change to
> read_cached_dir().

Yup.
