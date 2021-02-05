Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9B3C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBD764FBA
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhBESDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:03:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhBESA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 13:00:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4144195C9D;
        Fri,  5 Feb 2021 14:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tJEEqUSNWbOKoOA7wLe7KUkzN+w=; b=MhKHiP
        vWpu9bQzGiiBVBIZsD6MjJe+D4hUFHFgpMHFuUjFHjGMoq5sXx//WnRmN/C4ZQ5n
        w5KYhAf1+xuI4jJNlO6mBHXjJyNfV0n+GSBbM9Jtg1iW2NZXp466swfeMGRcE1wC
        HnWBu2LKVG1hcyDrGxpv8f7QSBm7cO9uMeAl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SelnVUDQ+QyuYJBGsQmFjr9y1DcwOxAA
        Yxd/ndz2GXGfaCe/reJwcp9VWCNfDz8YGAfE/7D21gYFiZzDHtVxCawZhtGdaw9l
        gfD2RUVO5nBlkEKEUAbeN3HiZn0svGAKrooCYK1AQpjrT/1EVTKXDtX94aztSYDd
        AOqHd83MmD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36E1C95C9B;
        Fri,  5 Feb 2021 14:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A57CA95C98;
        Fri,  5 Feb 2021 14:42:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
        <xmqq8s834c4s.fsf@gitster.c.googlers.com>
        <7c209432-82e6-7785-a5c1-1068ec3f0378@gmail.com>
Date:   Fri, 05 Feb 2021 11:42:33 -0800
In-Reply-To: <7c209432-82e6-7785-a5c1-1068ec3f0378@gmail.com> (Derrick
        Stolee's message of "Fri, 5 Feb 2021 07:30:42 -0500")
Message-ID: <xmqqa6si1ety.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AA03FB4-67EA-11EB-BD33-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/4/2021 7:00 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> When calculating the sizes of certain chunks, we should use 64-bit
>>> multiplication always. This allows us to properly predict the chunk
>>> sizes without risk of overflow.
>>>
>>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>> ---
>>>  midx.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> This one I find somewhat questionable for multiple reasons.
>> 
>>  * the fourth parameter of add_chunk() is of size_t, not uint64_t;
>>    shouldn't the multiplication be done in type size_t instead?
>
> This is probably appropriate because we will truncate to size_t if
> it is smaller than uint64_t.

In other words, if size_t turns out to be too small, doing
multiplication in uint64_t would not help at all and add_chunk() API
needs its parameter types updated [*].

    side note: I really wish that the language and the compiler
    helped us so that we didn't have to do this---after all, our
    function prototype says the result will be passed as a certain
    type, so it would be nice if the arithmetic to compute that
    result were automatically carried out in a way not to cause
    truncation.

>>  * these mutiplications were introduced in "midx: use chunk-format
>>    API in write_midx_internal()"; that step should use the
>>    arithmetic with cast (if necessary) from the start, no?
>
> I wanted to isolate these changes specifically so we could be
> careful about the multiplications and not be distracted by them
> when converting to the chunk-format API. The multiplications were
> "moved" by that patch, not "introduced".

Hmph, I somehow had an impression that they did not have truncation
issue in the original context, but perhaps I was wrong.  OK.

> I did a full inspection of all multiplications in midx.c and
> found a few more instances of possible overflow. Two are on the
> read side, but they require the object lookup chunk to have size
> 4gb or larger. This is not _that_ far off from possibility! My
> multi-pack-index for the Windows repository is currently ~1.6 GB
> (in total, including the other chunks).

Thanks.
