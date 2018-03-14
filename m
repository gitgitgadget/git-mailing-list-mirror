Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047611F404
	for <e@80x24.org>; Wed, 14 Mar 2018 23:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCNXBF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 19:01:05 -0400
Received: from avasout04.plus.net ([212.159.14.19]:39074 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeCNXBF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 19:01:05 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id wFOIeLlmhsD7bwFOJe4ACL; Wed, 14 Mar 2018 23:01:03 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=AAXekuwYsL1poPAibkcA:9
 a=Amy_1Hol_JFa0R6y:21 a=aDXymo67-RmlwDpY:21 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] http: fix an unused variable warning for 'curl_no_proxy'
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <517c4210-c381-899e-b13a-00f8e4caba74@ramsayjones.plus.com>
 <20180314221544.GA20167@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d290f115-20b8-2c47-79a1-0fc92e046a94@ramsayjones.plus.com>
Date:   Wed, 14 Mar 2018 23:01:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314221544.GA20167@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLfxRPe3ve9IIeY8XP9u6Ux5ahZXVZUVmdrD9pTakcrJQJpv38ki3n5O+UUXIAXCf70YAFQ6hUraVAAoieHJsri6FsSeI67bZ19zJs7wWNPg5usbecph
 S5TunvWSF8Yrgutsgi9NilGD5km8y7pESAeavcfN+RVivLXQ2vanGrjyzQ/yqgVFdTogt3WRGxHEGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/03/18 22:15, Jeff King wrote:
> On Wed, Mar 14, 2018 at 09:56:06PM +0000, Ramsay Jones wrote:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Junio,
>>
>> I happened to be building git on an _old_ laptop earlier this evening
>> and gcc complained, thus:
>>
>>       CC http.o
>>   http.c:77:20: warning: ‘curl_no_proxy’ defined but not used [-Wunused-variable]
>>    static const char *curl_no_proxy;
>>                       ^
>> The version of libcurl installed was 0x070f04. So, while it was fresh in my
>> mind, I applied and tested this patch.
> 
> Makes sense. This #if would go away under my "do not support antique
> curl versions" proposal. I haven't really pushed that forward since Tom
> Christensen's patches to actually make the thing build (and presumably
> since he is building on antique versions he can't turn on -Werror
> anyway, since IIRC it tends to have some false positives).

Yes, I suspected this would be removed by your proposed update (hence
the cc:), but I didn't know what the ETA on your patches was. Is this
worth doing, or are you about to re-visit that series?

> I agree with Jonathan that this explanation should be in the commit
> message. The patch itself looks OK, although:
> 
>> diff --git a/http.c b/http.c
>> index 8c11156ae..a5bd5d62c 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -69,6 +69,9 @@ static const char *ssl_key;
>>  #if LIBCURL_VERSION_NUM >= 0x070908
>>  static const char *ssl_capath;
>>  #endif
>> +#if LIBCURL_VERSION_NUM >= 0x071304
>> +static const char *curl_no_proxy;
>> +#endif
>>  #if LIBCURL_VERSION_NUM >= 0x072c00
>>  static const char *ssl_pinnedkey;
>>  #endif
>> @@ -77,7 +80,6 @@ static long curl_low_speed_limit = -1;
>>  static long curl_low_speed_time = -1;
>>  static int curl_ftp_no_epsv;
>>  static const char *curl_http_proxy;
>> -static const char *curl_no_proxy;
> 
> I'm not sure whether our ordering of these variables actually means
> much, but arguably it makes sense to keep the proxy-related variables
> near each other, even if one of them has to be surrounded by an #if.
> 
> I guess you were going for ordering the #if's in increasing version
> order. I'm not sure the existing code follows that pattern very well.

Yes, that was the idea, but I was already in two minds about that!
In the end I went with this, because not all of the proxy variables
are together anyway. ;-) (see, for example, 'proxy_auth' and 
'curl_proxyuserpwd' around line #113).

So, I don't mind placing the #ifdef around the current definition
(rather than moving it up), if you would prefer that. (It will have
to be tomorrow, since I have put that laptop away now!).

ATB,
Ramsay Jones

