Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45155C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 16:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLOQCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLOQCI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 11:02:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143062A40F
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:02:08 -0800 (PST)
Received: from [192.168.1.90] (unknown [86.121.236.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 44EF56602C6F;
        Thu, 15 Dec 2022 16:02:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671120126;
        bh=PgFraaA6xdzVOMzDUUmbpFZplMNFosQxHDZwEfo4ljA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OFfUo+Gznec75fUVTDeJk60tEdGoPsGlcBwq+EMW8diYyw03ZEIdJb8zR1j+qZbYm
         d+ilwZAplh3SRtNuz6GWUW8VQO6lkqhTk+OTcHoqyZFJqZvPu4rcmemVbkdZkx2DoK
         +XnQNrDzpsHCz5rkrsJJIpTns2LWbTtdYLQsJ0uJtFwC84KgLFIkdbbGn2ZeO+mnxi
         9wKrWwtggnziaTvXFgszFiPPRE+XiLqpaYXtp3dAVDRiTBFpsYRrf2j8owdiU7BMTd
         6VmfDms50fRymJgyqevgPHbQeONQBrp2Rri+pfo9/f97i6wcTxbVdcAcsAhk0hBO8c
         hn9ALAmPY6Acw==
Message-ID: <ee59112a-bd07-53cc-dfe3-6ee6f2342287@collabora.com>
Date:   Thu, 15 Dec 2022 18:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 0/1] rebase --onto detection of already applied
 commits
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
 <xmqqlencqhxy.fsf@gitster.g>
 <f4b485c8-3bc4-fb0c-3f7a-084daac7c14d@collabora.com>
 <51209c56-c82e-c393-6983-2a8c1a7388d3@dunelm.org.uk>
 <9e06bfd1-3e63-2414-e18c-6901fbb290e3@collabora.com>
 <3c5cb346-e6b4-7b85-6d3e-4b625cc21a94@dunelm.org.uk>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3c5cb346-e6b4-7b85-6d3e-4b625cc21a94@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 12/15/22 17:40, Phillip Wood wrote:
> Hi Cristian
> 
> On 13/12/2022 15:34, Cristian Ciocaltea wrote:
>> Hi Phillip,
>>
>> On 12/13/22 15:04, Phillip Wood wrote:
>>> Hi Christian
>>>
>>> On 13/12/2022 10:37, Cristian Ciocaltea wrote:
>>>> Currently '--onto' works as if the user provided the 
>>>> '--reapply-cherry-picks' flag,
>>>
>>> --onto does not affect the cherry-pick detection. When running
>>>
>>>      git rebase --onto new-base upstream feature
>>>
>>> any commits in upstream have been cherry-picked from feature they 
>>> will not be rebased. What it does not do is look for cherry-picks in 
>>> onto...feature. It would be nice to add that but I'm not sure it is 
>>> straight forward to do so and still exclude commits that have been 
>>> cherry-picked from feature to upstream.
>>
>> The proposed patch enables looking for commits into new-base..feature 
>> range and excluding the ones reachable from upstream. Since this is a 
>> change in the existing behavior, we might need to introduce a new flag 
>> to enable it. I previously suggested to use 
>> '--no-reapply-cherry-picks' for this purpose, but now it's pretty 
>> obvious this will be a source of confusion, since the "cherry-picks" 
>> term refers to the commits picked from feature to upstream instead of 
>> new-base, as you already mentioned.
>>
>> I agree it would be nice to support both exclusion ranges, but I'm not 
>> sure how complicated the implementation would be, since I don't have 
>> any previous experience with the Git internals. Could this be added as 
>> a separate feature at a later point?
> 
> If we can I'd rather add code that excludes cherry-pick both ranges. To 
> remove the cherry-picks that are in upstream and new-base you could 
> rework the todo list generation as follows
> 
> 1. Calculate the merge-base $mb of feature and upstream
> 2. Store the list of commits $mb..feature in an array and in a hash
>     table indexed their patch-id.
> 3. Walk $mb..upstream calculating the patch-id for each commit and
>     removing any commit in the list from step 2 that matches.
> 4. If onto is equal to upstream skip to step 7
> 5. Calculate the merge-base $mb of feature and onto.
> 6. Walk $mb..new-base calculating the patch-id for each commit and
>     removing any commit in the list from step 2 that matches.
> 7. Generate the todo list using the modified list of commits from step
>     2.
> 
> I don't have much time at the moment but I can try and help a bit more 
> in the New Year if you want.

Thank you for the implementation hints and your availability to help 
further! I will try to put this in practice and let you know as soon as 
I get something working.

Kind regards,
Cristian

> Best Wishes
> 
> Phillip
