Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F829C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CBA611BF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbhERN5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:57:17 -0400
Received: from siwi.pair.com ([209.68.5.199]:50691 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234985AbhERN5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:57:16 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 303A03F4165;
        Tue, 18 May 2021 09:55:58 -0400 (EDT)
Received: from MININT-MG8E6GJ.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DC09D3F413A;
        Tue, 18 May 2021 09:55:57 -0400 (EDT)
Subject: Re: [BUG] Unix Builds Requires Pthread Support (was [PATCH v4 00/12]
 Simple IPC Mechanism)
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        =?UTF-8?B?J1NaRURFUiBHw6Fib3In?= <szeder.dev@gmail.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, jeffhost@microsoft.com
References: <009d01d74b44$9efe8a60$dcfb9f20$@nexbridge.com>
 <YKN5lXs4AoK/JFTO@coredump.intra.peff.net>
 <8540e41e-3ba6-8d40-9424-8f62ea785f42@jeffhostetler.com>
 <YKOvBGjAC2kVPVa7@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7d578db0-c1a7-90c5-dd9c-aadf9eae2e3f@jeffhostetler.com>
Date:   Tue, 18 May 2021 09:55:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YKOvBGjAC2kVPVa7@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/18/21 8:11 AM, Jeff King wrote:
> On Tue, May 18, 2021 at 07:21:33AM -0400, Jeff Hostetler wrote:
> 
>>> In the simple-ipc API, there's an explicit "async" interface. But it's
>>> not clear to me how rich it expects the communication with the caller to
>>> be (i.e., whether we could get away with the fork() trick here). Or if
>>> it would be OK for the threading to remain an implementation detail,
>>> with one "worker" upon whom we wait for completion.
>>>
>>
>> TBH I forgot that we still support NO_PTHREAD systems.
>> I seem to remember that we got rid of some of the non-pthread
>> stub functions at one point, but I'm fuzzy on the details.
> 
> You're probably thinking of when we got rid of a bunch of #ifdef code
> paths in index-pack, and replaced it with stubs that turn the pthread
> calls into "do nothing" (so all the ugly stuff is in thread-utils.h
> now). But we still very much support systems that don't handle pthreads
> at all.
> 
>> WRT to "simple ipc" (and future "builtin fsmonitor"), it's heavily
>> threaded.  There's no point in trying to fake it with forks.
>>
>> The server side of simple ipc implements a thread pool.  And
>> the builtin fsmonitor will use a thread to monitor FS events
>> and that thread pool to respond to clients.  All driven from a
>> shared queue of events.
>>
>> It would be a major overhaul to do all that without threads
>> -- and even that assumes that nonstop has a sufficient file
>> system notification mechanism.
> 
> OK, that matches my guess from a brief look at the code. Thanks for
> confirming.
> 
>> So, yes, we should ifdef it out as Peff suggests.
> 
> The patch I sent wasn't really tested beyond confirming that "make
> NO_PTHREADS=1" finished compiling (and that test-tool simple-ipc
> barfed appropriately at runtime).
> 
> Do you want to pick it up from there and produce a polished patch? I
> think we should deal with this prior to the v2.32.0 release (and thanks
> Randall for testing and finding it during the -rc0 period).
> 
> -Peff
> 

yeah, i'll take it from here and get a patch out today.

Thanks!
Jeff

