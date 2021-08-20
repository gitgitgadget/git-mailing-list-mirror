Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A994C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 23:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334F460F91
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 23:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhHTXct (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 19:32:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56325 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhHTXcs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 19:32:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 998A6D1497;
        Fri, 20 Aug 2021 19:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gxQsbRGEQ3PhhIjAXoi7UMb9iobQoo6Dc9eUJn
        jyAlE=; b=Kx+Kz5dmUcG1UZvWoTuIVok8yRBz5scRzWcZc0p+FkTXueqroE1/CO
        QA4gw/K3HzduENUEiVeJzOxcedJjoC0Cf/Hi+lDja1fYs8jK9Z9/1xmLFVIfzWmL
        imHvzYL+0IXlMoqTJ5o+c8L3ymKAQ5jvR5DUxmtolL+KSzxK9FiXE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9074FD1496;
        Fri, 20 Aug 2021 19:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F27F1D1495;
        Fri, 20 Aug 2021 19:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
        <xmqqzgte62ud.fsf@gitster.g>
        <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com>
        <CABPp-BEtOWUGCcn3B0On80=tMZ_Re9ScHnBiwPPPFY=x2TwG5Q@mail.gmail.com>
Date:   Fri, 20 Aug 2021 16:32:08 -0700
In-Reply-To: <CABPp-BEtOWUGCcn3B0On80=tMZ_Re9ScHnBiwPPPFY=x2TwG5Q@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Aug 2021 14:23:04 -0700")
Message-ID: <xmqq7dgfu1zb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D652034E-020E-11EC-8070-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Aug 18, 2021 at 11:42 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> >     It seems to me that it would let us live in the future in a more
>> >     comprehensive way if we tweaked merge_recursive() and/or
>> >     merge_recursive_generic() so that all internal callers, not just
>> >     builtin/merge.c, would redirect to the ort machinery when say
>> >     GIT_TEST_REPLACE_RECURSIVE_WITH_ORT environment exists, and
>> >     doing it that way we do not need to sprinkle "-srecursive" and
>> >     "-sort" everywhere in our tests at randomly chosen places to
>> >     give test coverage to both strategies.
>
> GIT_TEST_MERGE_ALGORITHM already does this; the testsuite already had
> `-s recursive` sprinkled everywhere (due to contrast with `-s
> resolve`), but since I wanted to use all existing recursive tests as
> ort tests, then rather than tweaking all the test files and copying
> tests and whatnot, we decided to just have GIT_TEST_MERGE_ALGORITHM
> reinterpret "recursive" to whatever GIT_TEST_MERGE_ALGORITHM says.

I somehow thought that direct calls to merge_recursive() and
merge_recursive_generic() are not affected with that environment
variable, so you cannot influence what happens during "git am -3"
and "git stash apply" with that, but perhaps I was not reading the
code correctly.

It seems that merge_recursive() and merge_ort_recursive() are
interface compatible and the latter can serve as a drop-in
replacement for the former?
