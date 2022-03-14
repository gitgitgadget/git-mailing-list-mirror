Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12631C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 21:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiCNVhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiCNVhL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 17:37:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD493E0D6
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 14:36:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E87DB1890D6;
        Mon, 14 Mar 2022 17:36:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NiINgMuOQOEzAZ45erKo+ILfSw2lxJKV63sbaB
        P3ynU=; b=MxueQvqWJtqxQRmoof0CpqnM1ed9Bta62eohdaxTke+nbQlUEIlJ3h
        AEd4NlyuVRUf696k2EM+UgapjBjgckeoP+5Fqs4ylKTO8XpPXbyr0o8HF/tpF6T5
        MGyXeggfS0Kg68i+lJChOehyjSVbdh8ezw0t4T3wV68HZYvpGEY1E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E07C11890D5;
        Mon, 14 Mar 2022 17:36:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F52A1890D3;
        Mon, 14 Mar 2022 17:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
References: <xmqq4k41vdwe.fsf@gitster.g>
        <20220314154638.59046-1-chakrabortyabhradeep79@gmail.com>
Date:   Mon, 14 Mar 2022 21:35:57 +0000
In-Reply-To: <20220314154638.59046-1-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Mon, 14 Mar 2022 21:16:38 +0530")
Message-ID: <xmqqwngwnrnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCA5CC60-A3DE-11EC-AE1F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Is this "doesn't" (documenting current behaviour, without saying if
>> it is wrong or is desired) or "shouldn't" (documenting the desired
>> behaviour, which the current implementation may or may not satisfy)?
>
> The current behaviour is okay and this commit adds the test case for it.
> So, in that sense, I think "shouldn't" is better word.
>
>> That's mouthful.
>
> Sorry if the test name is very long. But, I couldn't think of shorter
> test name than this - to explain what the test case is.

"exact rename does not need to fetch the blob lazily"

>> Lose SP after '>'.
>>
>> 		git -C partial.git log --follow -- new-file.txt >"$(pwd)/trace.txt" &&
>
> Okay.
>
>> Looking at the implementation of the helper, it seems to be prepared
>> to handle negation itself.  Shouldn't this be
>>
>>	test_subcommand_inexact ! fetch <trace.txt
>>
>> instead?
>
> Oops, completely missed it. Correcting it :)
>
>> Why can't you specify what should NOT come before "fetch" in your
>> use of this helper?
>
> Below is the event triggered for non-exact OID rename -
>
> 	git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
>
> Derrick told me to not depend on other flags like
> `-c fetch.negotiationAlgorithm` etc. as they might be changed or omitted
> and as it makes sense to me also. That's why I didn't specify those things.
>
>> I wonder if it was more like this that the original wanted to grep for:
>>
>>	grep '"event":"child_start".*\["git","pack-objects",.*\]'
>
> I don't know about other cases, but in my case, atleast I really wanted
> it.
>
> So, In this scenerio, should I stick with `test_subcommand_inexact` or I
> have to see other helper functions (or make my own) for it?

If you are doing just a single grep, I am not sure why grepping for
"fetch" alone without any helper is insufficient.  In any case,
butchering the "inexcat" helper to loosen it for other existing
users of the same helper does not sound like a good direction to go.

Thanks.




