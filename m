Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35388C4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DAE61285
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFKGaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 02:30:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54532 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKGaF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 02:30:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4DCE149912;
        Fri, 11 Jun 2021 02:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yWdL3iAM8qf15njzI72DZLSj74PLPX1ApIgh/9
        xOqug=; b=K+vzCVb9rsl6AAFPl6ER/1fADP5V73vsd9ojXY8FkNMzBQCXUXsUE0
        TEdoDDMizRgerHgQ1q6XUMgaKVtQGnP+y3J+HMulnafhw6T4y7l2wsq+WKMtugQR
        2qoGYHm/XeNDE2kccyeZVczpM/mcswF/v1Iw15JjVDwgzKm+6vrtQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD151149911;
        Fri, 11 Jun 2021 02:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C735149910;
        Fri, 11 Jun 2021 02:28:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 3/3] builtin/checkout--worker: memset struct to avoid
 MSAN complaints
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
        <cd1e1f6985c77d21ec869e53dc5eb79673caf491.1623343713.git.gitgitgadget@gmail.com>
        <CAPx1GvfF7NZD4RMWWZCfny2gQOt1GY=TUm1HxvC+kwwDsc4Rgw@mail.gmail.com>
Date:   Fri, 11 Jun 2021 15:28:03 +0900
In-Reply-To: <CAPx1GvfF7NZD4RMWWZCfny2gQOt1GY=TUm1HxvC+kwwDsc4Rgw@mail.gmail.com>
        (Chris Torek's message of "Thu, 10 Jun 2021 21:43:27 -0700")
Message-ID: <xmqq7dj0530s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DF5862A-CA7E-11EB-B933-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Thu, Jun 10, 2021 at 9:49 AM Andrzej Hunt via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [snip] Therefore we add a
>> memset to convince MSAN that this memory is safe to read - but only
>> when building with MSAN to avoid this cost in normal usage.
>
> It does not seem likely to be that expensive, and would definitely
> be shorter without all the `#if` testing:
>
>> diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
>> index 289a9b8f89d0..02fa5285988f 100644
>> --- a/builtin/checkout--worker.c
>> +++ b/builtin/checkout--worker.c
>> @@ -56,6 +56,17 @@ static void report_result(struct parallel_checkout_item *pc_item)
>>         struct pc_item_result res;
>
> This could just have `= { 0 }` added.

I'd prefer that very much more than the #if testing, within which //
comments that we do not want in our codebase are enclosed.

Thanks.


