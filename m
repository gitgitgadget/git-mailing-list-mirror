Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BDB208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbdHIV3e convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 Aug 2017 17:29:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752166AbdHIV3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:29:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EDE5AF6F;
        Wed,  9 Aug 2017 21:29:31 +0000 (UTC)
Subject: Re: [PATCH 2/4] http: drop support for curl < 7.16.0
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
 <xmqq1sok7i82.fsf@gitster.mtv.corp.google.com>
 <38dfdc54-65ea-694a-4b72-fe0006a008cf@suse.de>
 <20170809211734.dcyo2gppznzk6kng@sigill.intra.peff.net>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Message-ID: <7468c434-88ca-48de-0bda-894baf8020f2@suse.de>
Date:   Wed, 9 Aug 2017 23:29:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <20170809211734.dcyo2gppznzk6kng@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 09/08/2017 à 23:17, Jeff King a écrit :
> On Wed, Aug 09, 2017 at 08:03:05PM +0200, Nicolas Morey-Chaisemartin wrote:
>
>>>> -#if LIBCURL_VERSION_NUM >= 0x071700
>>>> -/* Use CURLOPT_KEYPASSWD as is */
>>>> -#elif LIBCURL_VERSION_NUM >= 0x070903
>>>> -#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
>>>> -#else
>>>> -#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
>>>> -#endif
>>>> -
>>> This part I am not sure.  Don't we still need to substitute
>>> CURLOPT_KEYPASSWD with CURLOPT_SSLKEYPASSWD for versions below
>>> 071700, e.g. 071000 which is 7.16.0?
>> According to the documentation:
>>
>> https://curl.haxx.se/libcurl/c/CURLOPT_KEYPASSWD.html
>> This option was known as CURLOPT_SSLKEYPASSWD up to 7.16.4 and
>> CURLOPT_SSLCERTPASSWD up to 7.9.2.
>>
>>
>> So the patch breaks things (broken for 7.16.[0-4]). But the series
>> does not as the next patch ensure at least 7.19.4
> But the #ifdef above says 071700, which is 7.23.0. I wonder if we just
> got it wrong back then (maybe hex confusion with 7.17.0?). I have a
> build setup for old versions of curl, so I'll double-check that 7.19.4
> builds with KEYPASSWD. And dig in the history to see if there's any
> comment on this mismatch.
>
> -Peff
It seems to be a decimal/hex issue:
docs/libcurl/symbols-in-versions:153:CURLOPT_KEYPASSWD               7.17.0

I guess it should still work because it is now defined like this:
curl.h:#define CURLOPT_SSLKEYPASSWD CURLOPT_KEYPASSWD

If I'm not mistaken on cpp behaviour it means CURLOPT_KEYPASSWD is evaluated to CURLOPT_SSLKEYPASSWD (git define) which is evaluated into CURLOPT_KEYPASSWD (curl define).
It should stop here as CURLOPT_KEYPASSWD was not a defined macro when the curl one was evaluated.
It might be worth cleaning though, specially it wouldn't work anymore if the git macro is ever moved before the curl include.

Nicolas


