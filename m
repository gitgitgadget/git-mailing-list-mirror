Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141EBC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbiCWVfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiCWVfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:35:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF12BB26
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:33:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E45E1884CA;
        Wed, 23 Mar 2022 17:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sj4OlGO4gp3GGwhGrz87v/PR7LgEZtJgYW0o9T
        f7g/4=; b=oSGEYsH8I/VYcLtGX+nzO/pBiEU+VFry02atkdboYoEHs7b+vuByaN
        /LIqJANEklClmC2kXIs0uHJM7sV140bMoEgOdWTgYQBXwRdW/GCjDpEVZ8hk6THP
        /yu1mLPqEfyMMNoz6MnNQC4ACUvHOlpXpWzWB44JdCvCKwMdGIjzQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 870861884C8;
        Wed, 23 Mar 2022 17:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E79C51884C6;
        Wed, 23 Mar 2022 17:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Victoria Dye <vdye@github.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
        <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
        <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
        <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
        <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
        <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
        <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
        <xmqqo824cbxl.fsf@gitster.g>
        <e127dadb-7b44-55f8-16ea-9fcf94905db8@github.com>
        <xmqq8rt3xgmb.fsf@gitster.g>
        <b64c1805-dff9-3fd3-1e5e-84bd68d4b058@github.com>
        <CAJyCBORkauHAdDiHjQ2Agj3bNhLNPtKk-VW5=bNmBfNuQtv7hA@mail.gmail.com>
        <e61303b8-10ad-5b5b-d48b-cac89ac53d29@github.com>
Date:   Wed, 23 Mar 2022 14:33:39 -0700
In-Reply-To: <e61303b8-10ad-5b5b-d48b-cac89ac53d29@github.com> (Derrick
        Stolee's message of "Wed, 23 Mar 2022 09:10:52 -0400")
Message-ID: <xmqqh77oqrpo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7CF8E76-AAF0-11EC-80A2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/22/2022 4:38 AM, Shaoxuan Yuan wrote:
>> Hi all,
>> 
>> On Tue, Mar 22, 2022 at 3:45 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>> I'm particularly surprised in how much 'git mv' doesn't work very
>>> well in the sparse-checkout environment already, which makes things
>>> more difficult than "just" doing the normal sparse index things.
>>>
>>> It's good that we are discovering them and working to fix them.
>>>
>>> Thanks,
>>> -Stolee
>> 
>> Really appreciate the mentoring and tips here, I'm trying to make some progress
>> now. The problems facing here certainly push me to explore more and know
>> better about the codebase. Appreciate all the help :-)
>
> A thought occurred to me while thinking about these difficulties:
> perhaps it is better to start with 'git rm' since that does only
> half of what 'git mv' does. It should be a smaller lift as a first
> contribution. There is even a clear loop that is marked with "TODO:
> audit for interaction with sparse-index."
>
> As we've discovered in this thread, the direction for integrating
> a builtin with the sparse index should follow this outline:
>
> 0. Test the builtin in t1092 with interactions inside and outside
>    of the sparse-checkout cone.*
>
> 1. Add command_requires_full_index = 0 line to the builtin.
>
> 2. Check for failures and diagnose them.
>
> 3. Check for index expansion and remove them as necessary.
>    (Go back to 2.)
>
> 4. Run performance tests.
>
> (*) This step is the one we failed to focus enough on previously.

Jonathan, I thought you had a radically different approach that
ought to be much safer than the above---do you want to bring it up
for discussion?

> Of course, if you've already gotten really far on 'mv' and don't
> want to switch context, then keep at it.
>
> Thanks,
> -Stolee
