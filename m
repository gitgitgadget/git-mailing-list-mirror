Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D2BC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 23:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98B061058
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 23:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbhIAXKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 19:10:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56355 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242052AbhIAXKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 19:10:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB19514B15B;
        Wed,  1 Sep 2021 19:09:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3xKNNZv7TyNwd9a6YJ4KVRQ0JR3rS1las2Tle9xclBc=; b=sIAr
        w0TRbxNmnZOur+uxQlLpg11evJ3Pp6Gvan8vnuF2R5fzDPF74cbEy7A9ypb75/0a
        AJIQpzVzxgceWDUrtz5ta10x9IpH7e8plKrneBdz0o11iH7hTnCIb3jYG4rPFc4j
        RUmQZLdq4zGxwEbgbiXLhL91mnfrthh3Wkf1UtI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C68B814B159;
        Wed,  1 Sep 2021 19:09:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F179C14B157;
        Wed,  1 Sep 2021 19:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 2/3] test-lib-functions: optionally keep HOME, TERM
 and SHELL in 'test_pause'
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
        <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
        <328b5d6e76f598590d24b35ec23b5fd854c6cf05.1630503102.git.gitgitgadget@gmail.com>
        <xmqq7dg0oxdm.fsf@gitster.g>
        <CABPp-BFEvSXHAzFFs8VaWK5QUTj6Zyow9863p=qM6G8v3OPy1g@mail.gmail.com>
Date:   Wed, 01 Sep 2021 16:09:46 -0700
Message-ID: <xmqqa6kvoptx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3F9C006-0B79-11EC-AD09-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Because a new process instance of $PAUSE_SHELL is run, the options
>> you add when inserting test_pause does not affect what happens in
>> the tests after you exit the $PAUSE_SHELL [*], right?
>
> I think the warning was less about what happens after test_pause is
> complete and the testcase resumes, and more intended to convey that if
> the user tries to manually copy & paste snippets of code from the test
> into $PAUSE_SHELL, then the use of these flags can cause the result of
> those pasted commands to differ.

But the difference of TERM and SHELL are much smaller issue when one
cuts and pastes the lines from the test script.  Even if you do not
use -s or -t options, shell variables and helpers won't be available
to the interactive session given by test_pause, and that is a much
bigger difference between the "real" shell environment that is
running the tests and the user's shell environment test_pause gives
us.  That is why I think the WARNING should be attached _directly_
to the description of test_pause and not to individual "this uses
different X environment compared to the real shell environment
running the tests" options.

The updated $HOME does deserve a special mention, as .gitconfig from
it would further affect the tests and hide the bug you are hunting
for, and the CAUTION is a good thing to have, even if you do not
plan to modify anything in the test_pause sight-seeing session.
