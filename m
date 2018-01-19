Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8761F404
	for <e@80x24.org>; Fri, 19 Jan 2018 22:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeASWnM (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 17:43:12 -0500
Received: from avasout03.plus.net ([84.93.230.244]:33154 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932523AbeASWnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 17:43:11 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id cfNMe8w2jM9yPcfNNezlAt; Fri, 19 Jan 2018 22:43:10 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=JLgVTfCb c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=fKhZ70tAHYeKd1SSvLcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/6] Bypass GCC attributes on NonStop platform where
 used.
To:     Jeff King <peff@peff.net>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
 <20180119173406.13324-3-randall.s.becker@rogers.com>
 <86c7345f-814d-8d81-bb55-e91fe630e118@ramsayjones.plus.com>
 <20180119212044.GA10303@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f2fd4d75-259b-a5b0-a7f9-74fec79cc970@ramsayjones.plus.com>
Date:   Fri, 19 Jan 2018 22:43:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180119212044.GA10303@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNIVwWsqkQ2VMad1BxX+c96LWQ5cOU5VmB4Wvq5S1Omei4UB9NaaRjTanLV36JywMwlMw0T7wmjYQyJ+mDdCSkToFgCY83goSWeu+IdRJwXnO03kkH43
 luyq6skJUe0GJfUyqvhtvGyEmqjSIuiQfgLsz0pRjnM2ck/OiWCssadd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/01/18 21:20, Jeff King wrote:
> On Fri, Jan 19, 2018 at 08:28:48PM +0000, Ramsay Jones wrote:
> 
>>> diff --git a/remote.c b/remote.c
>>> index 4e93753e1..c18f9de7f 100644
>>> --- a/remote.c
>>> +++ b/remote.c
>>> @@ -11,6 +11,10 @@
>>>  #include "mergesort.h"
>>>  #include "argv-array.h"
>>>  
>>> +#if defined (__TANDEM)
>>> +#define __attribute(a)
>>> +#endif
>>> +
>>
>> Hmm, the only use of __attribute() I can find is in compat/regex/.
>> In particular, there is no use of __attribute() in regex.c.
>> [__attribute__() is used in regex.c]
>>
>> Is this an old patch which is no longer required?
>>
>> puzzled.

heh, I only just noticed that I (twice) wrote regex.c when I meant
remote.c instead. Hopefully, that didn't cause too much confusion!

> I'm puzzled, too. The actual gcc thing is __attribute__(), and we
> already turn that into a noop via macro expansion if __GNUC__ is not
> defined (in git-compat-util.h, but see below).
> 
> __attribute(), without the trailing underscores, is used internally by
> the regex compat code (but it also converts that into a noop on non-GNUC
> platforms)>

Indeed.

> However the logic in git-compat-util is weird:
> 
>   #if defined(__HP_cc) && (__HP_cc >= 61000)
>   #define NORETURN __attribute__((noreturn))
>   #define NORETURN_PTR
>   #elif defined(__GNUC__) && !defined(NO_NORETURN)
>   #define NORETURN __attribute__((__noreturn__))
>   #define NORETURN_PTR __attribute__((__noreturn__))
>   #elif defined(_MSC_VER)
>   #define NORETURN __declspec(noreturn)
>   #define NORETURN_PTR
>   #else
>   #define NORETURN
>   #define NORETURN_PTR
>   #ifndef __GNUC__
>   #ifndef __attribute__
>   #define __attribute__(x)
>   #endif
>   #endif
>   #endif
> 
> Most of the conditional is dealing with NORETURN, but then we stick the
> __attribute()__ handling in the "else" block. Is it possible that this
> platform triggers __HP_cc, but doesn't actually understand
> __attribute__?

That seems unlikely. However, that conditional looks a mess ... ;-)

ATB,
Ramsay Jones


