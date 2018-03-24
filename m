Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7844C1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 16:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCXQHr (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 12:07:47 -0400
Received: from avasout01.plus.net ([84.93.230.227]:33241 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeCXQHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 12:07:46 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id zlhoehh85MLyGzlhpe4HT6; Sat, 24 Mar 2018 16:07:45 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=HInt6Llv c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=sUX920SBAAAA:8 a=Mmd5JyoMsccPSZXjmIYA:9 a=QEXdDO2ut3YA:10
 a=egVJUTT-lD9PU5ZP4Sin:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH 1/1] json-writer: incorrect format specifier
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Wink Saville <wink@saville.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jeffhost@microsoft.com
References: <cover.1521868951.git.wink@saville.com>
 <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
 <4f4221d9-2ad9-2282-d26f-412ba0bfd719@ramsayjones.plus.com>
Message-ID: <c8628770-71d7-42f4-4bc5-444ea0160d26@ramsayjones.plus.com>
Date:   Sat, 24 Mar 2018 16:07:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4f4221d9-2ad9-2282-d26f-412ba0bfd719@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJkzP5AId2jD3XLPIibjajWCzCDqIj1SLBhhCT4EUVO4EQYHXmeXOdAc6XXTHGfBLWgayAibkkO6ZlGdt9luRfCm0b80mb3Uv/RftetBxDnwr/6Nqdsg
 MJEzYGu4R5XcnOssL+bVV4VezJYmY7zUo/9GEvAphrsTpbJ0fwY+i/9wRJ2E+1mUA8TahT45vfB22w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/03/18 15:14, Ramsay Jones wrote:
> 
> 
> On 24/03/18 05:37, Wink Saville wrote:
>> In routines jw_object_uint64 and jw_object_double strbuf_addf is
>> invoked with strbuf_addf(&jw->json, ":%"PRIuMAX, value) where value
>> is a uint64_t. This causes a compile error on OSX.
>>
>> The correct format specifier is PRIu64 instead of PRIuMax.
>>
>> Signed-off-by: Wink Saville <wink@saville.com>
>> ---
>>  json-writer.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/json-writer.c b/json-writer.c
>> index 89a6abb57..04045448a 100644
>> --- a/json-writer.c
>> +++ b/json-writer.c
>> @@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
>>  	maybe_add_comma(jw);
>>  
>>  	append_quoted_string(&jw->json, key);
>> -	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
>> +	strbuf_addf(&jw->json, ":%"PRIu64, value);
> 
> In this code-base, that would normally be written as:
> 
> 	strbuf_addf(&jw->json, ":%"PRIuMAX, (uintmax_t) value);

heh, I should learn not to reply in a hurry, just before
going out ...

I had not noticed that 'value' was declared with an 'sized type'
of uint64_t, so using PRIu64 should be fine. Well, except that
you may have to add a 'fallback' definition of PRIu64 to one of
the 'compat/mingw.h', 'compat/msvc.h' or 'git-compat-util.h'
header files. (see e.g. PRId64 at compat/mingw.h:429).

[About a decade ago, I heard microsoft were implementing C99
'real soon now' ;-) ]

ATB,
Ramsay Jones


