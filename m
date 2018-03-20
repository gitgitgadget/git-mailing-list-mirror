Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FCB1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 22:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeCTWwT (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 18:52:19 -0400
Received: from avasout04.plus.net ([212.159.14.19]:55241 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeCTWwS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 18:52:18 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id yQ76easDssD7byQ77e97xu; Tue, 20 Mar 2018 22:52:17 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=fKQa1YAfMDZumaoXN8wA:9 a=crqOGCLSsL5djPXG:21
 a=k4MH0R6yTuwWr87J:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] read-cache: fix an -Wmaybe-uninitialized warning
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
References: <6d434e76-cfa0-2a6e-f163-b54316a24cee@ramsayjones.plus.com>
 <20180320043652.GC13302@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e3894650-3639-c871-1291-f3efa7fbea0a@ramsayjones.plus.com>
Date:   Tue, 20 Mar 2018 22:52:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320043652.GC13302@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKZlKTn+Af+TUhedInF7cDMguk0acKnuf/s7bq7GyI1t10pLkDgjNtdvk+qbMYIBBFVbhAe1LGbDpyWHLW5gPaixHx8BCTV/CWQmcz8odTp0ANoi/21P
 qygzlfR0J77o7nGJaxuuGb5eMyC5LLIUlFf4fq8VpncA+iL4BdpDq+wwIX6YKdeY/4xRx9pQV7w3lQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/03/18 04:36, Jeff King wrote:
> On Mon, Mar 19, 2018 at 05:56:11PM +0000, Ramsay Jones wrote:
> 
[snip]
>> diff --git a/read-cache.c b/read-cache.c
>> index 2eb81a66b..49607ddcd 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -2104,13 +2104,15 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
>>  			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
>>  {
>>  	int size;
>> -	int saved_namelen = saved_namelen; /* compiler workaround */
>>  	int result;
>> +	unsigned int saved_namelen;
>> +	int stripped_name = 0;
> 
> Maybe too clever, but I think you could just do:
> 
>   unsigned int saved_namelen = 0;
>   ...
> 	saved_namelen = ce_namelen(ce);
>   ...
>   if (saved_namelen)
> 	ce->ce_namelen = saved_namelen;
>   ce->ce_flags &= ~CE_STRIP_NAME;
> 
> the zero-length name case (if that's even legal) would work out the
> same.

Yeah, that was one option that I looked at. The first option
was to initialise saved_namelen to -1 (it was still an int) then
the test became if (saved_namelen >= 0). However, that started
me thinking about the zero-length case - should I assert if
((ce->ce_flags & CE_STRIP_NAME) && (ce_namelen(ce) == 0))? etc.

In the end, I decided that I wanted it to be 'drop dead' obvious
what was going on! Hopefully, the result was just that. :-D

ATB,
Ramsay Jones


