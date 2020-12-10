Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74027C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F0523BC7
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgLJCEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:04:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51175 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgLJCEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:04:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD0448A835;
        Wed,  9 Dec 2020 21:03:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O+Bm/cuasQiK3o6C7qwS0HrSUsI=; b=qj8czr
        PeA7cgbuiYIp1se5R3iBfBmvVzGcjO7UDm7WK4LXmFQzub6iLnNqYIKDvogHpdpt
        SN7q8ldeyc/mqXjph/IbFQHk0Ey3C1O19jC4c9VieNiXWwR24J7M8oguZ2zmaWX/
        aMiiLsrtBmJwQCipJ2oQbseJjLV+1oq+m7BHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DJT1trWOLDDOsVo4cmJJ/netep0Ly3dn
        ZYYHdpuQ/Wuh8NvQzghlirvdL4e1Pfxj42xYSni7OeYyH6N1Qx0Ue//Et9ZCkacz
        xKNzkKKyuGB+4hmQy8HD54/e2ZhKh4kYMVeNtJ1vAg2zY1tDNQmZXbvDqtnR0Vq1
        6kE7tABOAJA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5DB98A833;
        Wed,  9 Dec 2020 21:03:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 372BD8A831;
        Wed,  9 Dec 2020 21:03:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/7] diffcore-rename: remove unnecessary if-clause
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <f96bb36930a6e5e42f0d3b9c5dfa3b2cc27c1f9d.1607223276.git.gitgitgadget@gmail.com>
        <X9FLaiuWpYely6es@nand.local>
Date:   Wed, 09 Dec 2020 18:03:39 -0800
In-Reply-To: <X9FLaiuWpYely6es@nand.local> (Taylor Blau's message of "Wed, 9
        Dec 2020 17:10:50 -0500")
Message-ID: <xmqqtusuxvr8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC31366C-3A8B-11EB-AF7F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Sun, Dec 06, 2020 at 02:54:31AM +0000, Elijah Newren via GitGitGadget wrote:
>> From: Elijah Newren <newren@gmail.com>
>>
>> diffcore-rename had two different checks of the form
>>
>>     if ((a < limit || b < limit) &&
>>         a * b <= limit * limit)
>>
>> Since these are all non-negative integers, this can be simplified to
>>
>>     if (a * b <= limit * limit)
>
> Makes sense.

I've always assumed that the original was for correctness (if a and
b are both larger than limit, a*b could end up being smaller than
limit*limit when the result of multiplication of the former wraps
around but not the latter) ...

>> The only advantage of the former would be in avoiding a couple
>> multiplications in the rare case that both a and b are BOTH very large.
>> I see no reason for such an optimization given that this code is not in
>> any kind of loop.  Prefer code simplicity here and change to the latter
>> form.
>
> If you were really paranoid, you could perform these checks with
> unsigned_mult_overflows(), but I don't think that it's worth doing so
> here.

... and in no way as an optimization.

So, I dunno.
