Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C309C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 21:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbiCNVnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiCNVnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 17:43:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69C31DC5
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 14:42:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24391112178;
        Mon, 14 Mar 2022 17:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Em6WlQxyMu2htfxJBkOwfyHWdTkduPl1wznjjW
        TmKNQ=; b=dDmMtQ0tdDg5+Qti5tAMAp8MjTw+AlWwFum/56FM7aokinYNHzby0r
        d9n7Y4ZBVgi6H9LKp8pXTcLW0Yi9gsOInKdVo6bfS/8WOqjQ/WzFPzXrVb8+YJoh
        1Wi4yyl10NHy9P7Lm4p8Z5Lno+3eoNTrwlnN0mi14mx+W3EBWnd6w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C36B112177;
        Mon, 14 Mar 2022 17:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BA21112176;
        Mon, 14 Mar 2022 17:42:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
References: <xmqq4k41vdwe.fsf@gitster.g>
        <20220314154638.59046-1-chakrabortyabhradeep79@gmail.com>
        <e38ebbfd-3ce4-6900-97e4-74b987c08b7d@github.com>
Date:   Mon, 14 Mar 2022 21:42:35 +0000
In-Reply-To: <e38ebbfd-3ce4-6900-97e4-74b987c08b7d@github.com> (Derrick
        Stolee's message of "Mon, 14 Mar 2022 12:25:41 -0400")
Message-ID: <xmqqsfrknrck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9E87982-A3DF-11EC-80C5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> 	git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
>> 
>> Derrick told me to not depend on other flags like
>> `-c fetch.negotiationAlgorithm` etc. as they might be changed or omitted
>> and as it makes sense to me also. That's why I didn't specify those things.
>
> This reason is something that could be mentioned in the commit message
> to motivate the change to the helper.
>
>>> I wonder if it was more like this that the original wanted to grep for:
>>>
>>> 	grep '"event":"child_start".*\["git","pack-objects",.*\]'
>> 
>> I don't know about other cases, but in my case, atleast I really wanted
>> it.
>> 
>> So, In this scenerio, should I stick with `test_subcommand_inexact` or I
>> have to see other helper functions (or make my own) for it?
>
> As I mentioned earlier, it seems that
>
> 	test_subcommand_inexact ! git fetch
>
> would actually work for your needs without changing the helper. We will see
> whether or not the helper needs to be updated in a way that that line would
> not work anymore.

Ah, that is because the current implementation of the helper
sprinkles ".*" in between each and every pair of parameters, so the
resulting pattern \["git".*"fetch".*\] would not be prevented from
matching by the presence of "-c var.iable=value"?

In any case, the _inexact helper may need to be rethought, or at
least documented better what inexact-ness it wants to allow.  With
no concrete goals written down, my guess was that it wanted to
ensure only the earlier command names and options, while ignoring
the later arguments.  And that was where my "adding .* in between
looks wrong, and stripping trailing comma with ${expt%,} is nonsense"
comment came from.

Thanks.
