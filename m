Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A22F820285
	for <e@80x24.org>; Sun, 27 Aug 2017 15:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdH0Prs (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 11:47:48 -0400
Received: from avasout07.plus.net ([84.93.230.235]:34726 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH0Prr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 11:47:47 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 2Fnl1w0010M91Ur01Fnmm2; Sun, 27 Aug 2017 16:47:46 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=ZTg09mnBD_C4ZXrySNoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: cat-file timing window on Cygwin
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20170825112529.GA10378@dinwoodie.org>
 <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
 <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
 <20170826185337.hrcswjuunon54kgj@sigill.intra.peff.net>
 <20170826211104.GC10378@dinwoodie.org>
 <c5f3fe2d-6d76-7c08-2a50-fb10c66adc48@ramsayjones.plus.com>
 <20170827113358.GF10378@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0822303f-63b1-13e2-be43-8e2e4dab478e@ramsayjones.plus.com>
Date:   Sun, 27 Aug 2017 16:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170827113358.GF10378@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/08/17 12:33, Adam Dinwoodie wrote:
> On Sun, Aug 27, 2017 at 03:06:31AM +0100, Ramsay Jones wrote:
>> On 26/08/17 22:11, Adam Dinwoodie wrote:
>>> On Sat, Aug 26, 2017 at 11:53:37AM -0700, Jeff King wrote:
>>>> Interesting. I find it a little hard to believe there's so obvious a bug
>>>> as "fflush(NULL) flushes stdin", but well...that's what it seems like.
>>>>
>>>> If that's truly what it is, this is the minimal reproduction I came up
>>>> with:
>>>>
>>>> -- >8 --
>>>> #include <stdio.h>
>>>>
>>>> int main(void)
>>>> {
>>>> 	char buf[256];
>>>> 	while (fgets(buf, sizeof(buf), stdin)) {
>>>> 		fprintf(stdout, "got: %s", buf);
>>>> 		fflush(NULL);
>>>> 	}
>>>> 	return 0;
>>>> }
>>>> -- 8< --
>>>>
>>>> If this really is the bug, then doing something like "seq 10 | ./a.out"
>>>> would drop some of the input lines.
>>>
>>> ...yep.  It does.  Specifically, I consistently only get the firsts
>>> line:
>>>
>>>     $ seq 10 | ./a.exe
>>>     got: 1
>>>     
>>>     $ 
>>>
>>> If I introduce a delay between the lines of stdin (which I tested by
>>> just typing stdin from the keyboard), it works as expected.
>>>
>>> Looks like this one will need to go to the Cygwin mailing list; I'll
>>> take it there shortly.  Thank you all for your help getting this far!
>>
>> This is apparently fixed in cygwin v2.8.3 [see commit 78ade082fe,
>> ('Revert "errno: Stop using _impure_ptr->_errno completely"', 19-07-2017),
>> commit 9cc89b0438 ("cygwin: Use errno instead of _impure_ptr->_errno", 19-07-2017), commit a674199fc9 ("cygwin: Bump DLL version to 2.8.3",
>> 19-07-2017) and commit d2ae2f00b8 ("cygwin: add fflush fix to release
>> notes", 19-07-2017)].
>>
>> I haven't had a chance to try v2.8.3 yet (it's 3am and I'm about to
>> go get some sleep).
> 
> Cygwin 2.8.3 hasn't been released yet, 

Heh, yes, I found that out myself this afternoon. ;-)

>                                         but I've just tested the latest
> development snapshot with Jeff's simple test case, and it works as
> expected, so I'm going to assume the Git test will start passing once
> that version of the Cygwin DLL is released too.

Hmm, I'm not keen on installing "snapshot"(s), so I think I will
wait for the release to test it. (However, as a matter of interest,
how would I obtain/install/test this snapshot release - is it a
'low-risk' exercise?)

ATB,
Ramsay Jones


