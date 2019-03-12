Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB11D20248
	for <e@80x24.org>; Tue, 12 Mar 2019 22:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfCLWP3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 18:15:29 -0400
Received: from avasout01.plus.net ([84.93.230.227]:49109 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfCLWP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 18:15:28 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 3pgEhGj0zcPek3pgFh1ktU; Tue, 12 Mar 2019 22:15:27 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=R84t5+ZX c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=EBOSESyhAAAA:8 a=nSW2fyJCgFrdw3EUlbgA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC/PATCH] packfile: use extra variable to clarify code in
 use_pack()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <e561b83f-cf1c-eef8-7651-8519ce105491@ramsayjones.plus.com>
 <b4106d4b-5f9e-4577-c8ed-641df33d4fb5@ramsayjones.plus.com>
 <20190312202605.GA24350@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <1fbd29f2-3385-58d8-e69d-d7df80e214db@ramsayjones.plus.com>
Date:   Tue, 12 Mar 2019 22:15:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312202605.GA24350@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG/2Mzl8QWfKCKF6hivsgecz7OgYV9jmun+qNlQYlWRMjoCGCcVmXyALBhy5nm26SFx3maVHxpBAxFvwe7Egb18G9fis3rnyXlV+8sdnwRLKDCGTJzZZ
 A88V6QJrsWSOXUWDX87cfEVqV/h8q9lP1+qzim11JxNPw99JTbeaMyeumtUAPUc0qbI79EokBgtjFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/03/2019 20:26, Jeff King wrote:
> On Tue, Mar 12, 2019 at 05:39:13PM +0000, Ramsay Jones wrote:
> 
>> On 12/03/2019 16:55, Ramsay Jones wrote:
>>> From: Jeff King <peff@peff.net>
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> 
> Could definitely use a commit message. I think it's something like:
> 
>   We use the "offset" variable for two purposes. It's the offset into
>   the packfile that the caller provides us (which is rightly an off_t,
>   since we might have a packfile much larger than memory). But later we
>   also use it as the offset within a given mmap'd window, and that
>   window cannot be larger than a size_t.
> 
>   For the second use, the fact that we have an off_t leads to some
>   confusion when we assign it to the "left" variable, is a size_t. It is
>   in fact correct (because our earlier "offset -= win->offset" means we
>   must be within the pack window), but using a separate variable of the
>   right type makes that much more obvious.
> 
> You'll note that I snuck in the assumption that "left" is a size_t,
> which as you noted is not quite valid yet. :)

Looks good to me! :-D

>> Heh, of course I should have tried applying on top of today's
>> codebase before sending it out! :(
>>
>> Having just done so, it quickly showed that this patch assumes
>> that the 'left' parameter to use_pack() has been changed from
>> an 'unsigned long *' to an 'size_t *' as part of the series
>> that was being discussed in the above link.
> 
> Yep. Until then,  I do not think there is much point (and in fact I'd
> suspect this code behaves incorrectly on Windows, where "unsigned long"
> is too short; hopefully they clamp pack windows to 4GB by default
> there, which would work around it).
> 
> But I would be very happy if you wanted to resurrect the "left" patch
> and then do this on top. :)

It actually applies on top of the 'pu' branch, because the 'left'
patch is commit 5efde212fc ("zlib.c: use size_t for size", 2018-10-18).

If you recall, this was going to be just the first step in a series
of patches to replace 'unsigned long' as the type used for various
'size' or 'length' variables.

So, if I add the above commit message, it could apply on top of the
current 'mk/use-size-t-in-zlib' branch.

I may not get to that tonight (busy with something else), but I can
hopefully do that tomorrow.

ATB,
Ramsay Jones

