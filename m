Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C321F428
	for <e@80x24.org>; Tue,  2 Jan 2018 18:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeABSNc (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 13:13:32 -0500
Received: from siwi.pair.com ([209.68.5.199]:53638 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeABSNc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 13:13:32 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2FBE0844DD;
        Tue,  2 Jan 2018 13:13:31 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E815F844DC;
        Tue,  2 Jan 2018 13:13:30 -0500 (EST)
Subject: Re: [PATCH] oidmap.h: strongly discourage using OIDMAP_INIT directly
To:     Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <940d8daa8eb8d42b9f0a3ebf4c25fb6417e71bc8.1513940345.git.johannes.schindelin@gmx.de>
 <20171222171635.GA230194@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <90641fbf-64dd-afda-ef66-857edc6684cf@jeffhostetler.com>
Date:   Tue, 2 Jan 2018 13:13:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20171222171635.GA230194@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/22/2017 12:16 PM, Brandon Williams wrote:
> On 12/22, Johannes Schindelin wrote:
[...]
>> That pattern is violated by OIDMAP_INIT, though. The first call to
>> oidmap_put() or oidmap_get() will succeed, but by mistake rather than by
>> design: The underlying hashmap is not initialized correctly, as the
>> cmpfn function pointer still points to NULL, but since there are no
>> entries to be compared, cmpfn will not be called. Things break down,
>> though, as soon as there is even one entry.
>>
>> Rather than causing confusion, frustration and needless loss of time due
>> to pointless debugging, let's *rename* OIDMAP_INIT so that developers
>> who have gotten used to the pattern `struct xyz a = XYZ_INIT;` won't do
>> that with oidmaps.
>>   
>> -#define OIDMAP_INIT { { NULL } }
>> +/*
>> + * This macro initializes the data structure only incompletely, just enough
>> + * to call oidmap_get() on an empty map. Use oidmap_init() instead.
>> + */
>> +#define OIDMAP_INIT_INCOMPLETELY { { NULL } }

Alternatively, could we define the macro to an expression
that would cause a compiler error?  Then any new code written
would fail to compile.  And we document the issue in a comment
above the macro so no one changes the macro to "fix" it.

(I suggest this as opposed to simply removing the macro
to prevent someone from re-adding it later, since it is the
standard pattern.)

Just a thought,
Jeff
