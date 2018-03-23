Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF4D1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeCWODk (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:03:40 -0400
Received: from avasout04.plus.net ([212.159.14.19]:45596 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeCWODj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:03:39 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id zNI8ehrntsD7bzNI9eAzwt; Fri, 23 Mar 2018 14:03:38 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=J4Yu8uy2W-3EchVqUOsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
 <7a49135b-faad-9856-b757-e3ed4886720d@ramsayjones.plus.com>
 <20180323024609.GA12229@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <478ddd61-4afe-44ae-c2b6-ecd3427a539f@ramsayjones.plus.com>
Date:   Fri, 23 Mar 2018 14:03:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323024609.GA12229@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIt+dF7M9cGfuvarAqbytSJPF3dXDGb8z8/0F+lhPgLV8mEqYm+wAF4PSLjz7D4pO5Cp+NJxSZsowIVNvlFBn45vhuL6d3XkBJ3f0+EcAJJyxDkxSlZ5
 feZcAO1SVNfLpcImigEMTfMNz6QiSC4ZPka4sP2piRLlr55piUrSJ7bl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/03/18 02:46, Jeff King wrote:
> On Fri, Mar 23, 2018 at 01:28:12AM +0000, Ramsay Jones wrote:
> 
>>> Of the used heap after your patches:
>>>
>>>  - ~40% of that is from packlist_alloc()
>>>  - ~17% goes to "struct object"
>>>  - ~10% for the object.c hash table to store all the "struct object"
>>>  - ~7% goes to the delta cache
>>>  - ~7% goes to the pack revindex (actually, there's a duplicate 7%
>>>        there, too; I think our peak is when we're sorting the revindex
>>>        and have to keep two copies in memory at once)
>>
>> which begs the question, how much slower would it be if we
>> replaced the radix-sort with an in-place sort (e.g. heapsort).
>>
>> I hacked up the patch below, just for fun. I don't have any
>> large repos (or enough disk space) to do any meaningful perf
>> tests, but I did at least compile it and it passes the test-suite.
>> (That is no guarantee that I haven't introduced bugs, of course!)
> 
> It might have been easier to just revert 8b8dfd5132 (pack-revindex:
> radix-sort the revindex, 2013-07-11). It even includes some performance
> numbers. :)

But not as much fun! :)

> In short, no, I don't think we want to go back to a comparison-sort. The
> radix sort back then was around 4 times faster for linux.git. And that
> was when there were half as many objects in the repository, so the radix
> sort should continue to improve as the repo size grows.

Yes, I expected radix-sort to be faster.

> The absolute time savings aren't huge for something as bulky as a
> repack, so it's less exciting in this context. But it's also not that
> much memory (7% of the peak here, but as I showed elsewhere, if we can
> stop holding all of the "struct object" memory once we're done with it,
> then this revindex stuff doesn't even factor into the peak).

I didn't see this post until afterwards. So, if it isn't even a
factor in the peak memory use, then it's clear this specific
space/time trade-off also isn't an issue! ;-)

Thanks.

ATB,
Ramsay Jones
