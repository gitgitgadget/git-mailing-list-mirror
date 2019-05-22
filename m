Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF68E1F462
	for <e@80x24.org>; Wed, 22 May 2019 13:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfEVNXl (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 09:23:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:34154 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbfEVNXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 09:23:41 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7BB213F4047;
        Wed, 22 May 2019 09:23:40 -0400 (EDT)
Received: from [10.160.99.45] (unknown [167.220.149.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 342723F4023;
        Wed, 22 May 2019 09:23:40 -0400 (EDT)
Subject: Re: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
To:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <pull.222.git.gitgitgadget@gmail.com>
 <20190521212744.GC14807@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com>
Date:   Wed, 22 May 2019 09:23:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521212744.GC14807@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/21/2019 5:27 PM, Jeff King wrote:
> On Tue, May 21, 2019 at 12:33:58PM -0700, Jeff Hostetler via GitGitGadget wrote:
> 
>> As Duy suggested, pthread_getspecific() just returns NULL when NO_PTHREADS
>> is defined. And pthread_setspecific() silently does not nothing. So this
>> problem was hidden from view.
>>
>> I have to wonder if we should update pthread_*specific() to call BUG() when
>> NO_PTHREADS is defined as a way to catch unguarded usages easier or make
>> this issue more clear.
> 
> I think it should actually store the data asked for by the caller, as if
> we were the single thread running. We discussed this as the time of
> refactoring NO_PTHREADS, but there was only one caller that would have
> benefited. Now there are two. ;)
> 
> Discussion in the subthread of this patch:
> 
>    https://public-inbox.org/git/20181027071003.1347-2-pclouds@gmail.com/
> 
> -Peff
> 

I was wondering about that too as the proper long term solution.
We would need (as the discussion suggests [1]) to properly
respect/represent the pthread_key_t argument.

For now, I've guarded my usage of pthread_getspecific() in the trace2
(similar to what index-pack does), so its not urgent that we update it.
And I'd rather we take this simple trace2 fix now and not try to combine
it with fixes for the pthread macros.  Especially now as we're in the RC
cycle for 2.22.

I'll make a note to revisit the pthread code after 2.22.

Thanks
Jeff


[1] 
https://public-inbox.org/git/CACsJy8DLW_smOJd6aCoRcJZxQ2Lzut5US=sPadj7=fhne0UHGg@mail.gmail.com/

