Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C04C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 22:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCFA6108B
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 22:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhHRWWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:22:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63462 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhHRWWw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 18:22:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D5F5715119C;
        Wed, 18 Aug 2021 18:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=leI4bX2RFUe6RsdXEMsJLygeANBuH/BJf+Fc0j
        lKukQ=; b=R5MJmOPHOyhl30GWD4ZsJWoDh1ajKdrq/4G07E5Y/YM8v7TdoJyBMd
        2zvSYPqUNrUqYYypnMgpYpjYZCHuTrO7LVf+dHa4CMr84V7C6awmuP2A29amITPY
        M6YJzPEfJ4tmYX/LDrCSuE72WL24pNq5C/576bUsK3bfJaiz/yjBA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF63315119B;
        Wed, 18 Aug 2021 18:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F591151199;
        Wed, 18 Aug 2021 18:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
In-Reply-To: <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com> (Derrick
        Stolee's message of "Wed, 18 Aug 2021 14:42:09 -0400")
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
        <xmqqzgte62ud.fsf@gitster.g>
        <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 18 Aug 2021 15:22:12 -0700
Message-ID: <xmqqbl5u4cmj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD27E912-0072-11EC-BF7D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/18/2021 2:10 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> The sparse index will be compatible with the ORT merge strategy, so
>>> let's use it explicitly in our tests.
>> 
>> Unless you mean that the sparse index will only be compatible with
>> ort, but will never be with recursive, I do not quite see why this
>> is taking us into a good direction.  Is this because we want to gain
>> test coverage for ort early, before we flip the default to ort [*1*]?
>
> The sparse index will _work_ with the recursive merge strategy, it will
> just continue to be slow, and likely slower than if we had a full index.
> This is because the recursive merge algorithm will expand a sparse index
> into a full one before doing any of its logic (hence my confidence that
> it will work).

Ah, thanks for explanation.  The tests being touched are not about
correctness of the merge results but the damage the operation would
make to the sparseness of the index, and because in the longer term
the recursive backend is on its way out, we do want to focus on
testing how ORT performs.

> I could also change this patch to stop using ORT _all the time_ and
> instead let the GIT_TEST_MERGE_ALGORITHM decide which is tested.

No, that's OK.

It was unclear from the proposed log message (hence my questions),
but if it is made clear that we have a good reason why we want to
see how the sparse-index works with ORT, explicitly testing with ORT
like your patch does is the right thing to do, I would think.

With GIT_TEST_MERGE_ALGORITHM set to ort and exported, it is
puzzling why some "git merge" invocations gets "-s ort" in the same
patch, though.

Thanks.
