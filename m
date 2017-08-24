Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58C3208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 07:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbdHXHYT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 24 Aug 2017 03:24:19 -0400
Received: from 4.mo64.mail-out.ovh.net ([46.105.45.191]:52334 "EHLO
        4.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbdHXHYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 03:24:17 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 4C4AD84A66;
        Thu, 24 Aug 2017 09:24:16 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Aug 2017 09:24:15 +0200
Subject: Re: [PATCH v3 4/4] imap-send: use curl by default
To:     Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <peff@peff.net>
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
 <bb94cace-6bc5-2009-7c9d-a6965e3b84c6@morey-chaisemartin.com>
 <xmqqpobmxc3a.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <6c1481b3-5025-a911-bbaf-aaa88343d859@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 09:24:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqpobmxc3a.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS4.indiv2.local (172.16.1.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 9160321642694961143
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtdefgdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 23/08/2017 à 22:28, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:
>
>> Now that curl is enable by default,
> s/enable/&d/; 
>
> But it is unclear what the above really means.  You certainly do not
> mean that [PATCH 1-3/4] somewhere tweaked our Makefile to always use
> libcurl and makes Git fail to build without it, but the above sounds
> as if that were the case.
>
>> use the curl implementation
>> for imap too.
> The Makefile for a long time by default set USE_CURL_FOR_IMAP_SEND
> to YesPlease when the version of cURL we have is recent enough, I
> think.  So I am not sure what you want to add with this change.
It did but apart from allowing the compilation of the code and enabling the --curl option to do something, it had no impact on the default runtime.
>> The goal is to validate feature parity between the legacy and
>> the curl implementation, deprecate thee legacy implementation
> s/thee/the/;

Yes this is confusing.
In the current state, even if build against a curl version supporting imap, curl is not used by default at runtime (unless OpenSSL was not available).
This patch changes this behavior.

>
>> later on and in the long term, hopefully drop it altogether.
>>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>  imap-send.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> Hmph, the patch itself is also confusing.
>
>> diff --git a/imap-send.c b/imap-send.c
>> index a74d011a9..58c191704 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -35,11 +35,11 @@ typedef void *SSL;
>>  #include "http.h"
>>  #endif
>>  
>> -#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
>> -/* only available option */
>> +#if defined(USE_CURL_FOR_IMAP_SEND)
>> +/* Always default to curl if it's available. */
>>  #define USE_CURL_DEFAULT 1
> The original says "we want to use CURL, if Makefile tells us to
> *AND* if Makefile tells us not to use OpenSSL", which does not make
> much sense to me.  I wonder if the original is buggy and should have
> been using "|| defined(NO_OPENSSL)" there instead.  
I think the idea for this was that curl should be used when curl is available and OpenSSL is not (curl being the only solution for secured authentication in this case)

>
> Perhaps that is the bug you are fixing with this patch, and all the
> talk about curl is default we saw above is a red herring?  If that
> is the case, then instead of removing, turning "&&" into "||" may be
> a better fix.  I dunno.

As said before, the goal of this patch is to enable curl by default at runtime when it has been "enabled" at compile time.
I'll reword

Is something like this clearer ?
Author: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Date:   Sun Aug 6 21:30:15 2017 +0200

    imap-send: use curl by default when possible
   
    Set curl as the runtime default when it is available.
    When linked against older curl versions (< 7_34_0) or without curl,
    use the legacy imap implementation.
   
    The goal is to validate feature parity between the legacy and
    the curl implementation, deprecate the legacy implementation
    later on and in the long term, hopefully drop it altogether.
   
    Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>


