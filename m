Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2281FAE2
	for <e@80x24.org>; Mon, 26 Mar 2018 17:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeCZRjV (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:39:21 -0400
Received: from siwi.pair.com ([209.68.5.199]:58752 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbeCZRjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:39:19 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F3DB53F400D;
        Mon, 26 Mar 2018 13:39:18 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id ADBF53F4006;
        Mon, 26 Mar 2018 13:39:18 -0400 (EDT)
Subject: Re: [RFC PATCH 1/1] json-writer: incorrect format specifier
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Wink Saville <wink@saville.com>, git@vger.kernel.org,
        jeffhost@microsoft.com
References: <cover.1521868951.git.wink@saville.com>
 <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
 <4f4221d9-2ad9-2282-d26f-412ba0bfd719@ramsayjones.plus.com>
 <c8628770-71d7-42f4-4bc5-444ea0160d26@ramsayjones.plus.com>
 <xmqqr2o6dayt.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <db400047-ac2e-100c-8d5a-12f1d05b93be@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 13:39:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2o6dayt.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 1:04 PM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>>>> @@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
>>>>   	maybe_add_comma(jw);
>>>>   
>>>>   	append_quoted_string(&jw->json, key);
>>>> -	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
>>>> +	strbuf_addf(&jw->json, ":%"PRIu64, value);
>>>
>>> In this code-base, that would normally be written as:
>>>
>>> 	strbuf_addf(&jw->json, ":%"PRIuMAX, (uintmax_t) value);
>>
>> heh, I should learn not to reply in a hurry, just before
>> going out ...
>>
>> I had not noticed that 'value' was declared with an 'sized type'
>> of uint64_t, so using PRIu64 should be fine.
> 
> But why is this codepath using a sized type in the first place?  It
> is not like it wants to read/write a fixed binary file format---it
> just wants to use an integer type that is wide enough to handle any
> inttype the platform uses, for which uintmax_t would be a more
> appropriate type, no?
> 

[Somehow the conversation forked and this compiler warning
appeared in both the json-writer and the rebase-interactive
threads.  I'm copying here the response that I already made
on the latter.]


I defined that routine to take a uint64_t because I wanted to
pass a nanosecond value received from getnanotime() and that's
what it returns.

My preference would be to change the PRIuMAX to PRIu64, but there
aren't any other references in the code to that symbol and I didn't
want to start a new trend here.

I am concerned that the above compiler error message says that uintmax_t
is defined as an "unsigned long" (which is defined as *at least* 32 bits,
but not necessarily 64.  But a uint64_t is defined as a "unsigned long long"
and guaranteed as a 64 bit value.

So while I'm not really worried about 128 bit integers right now, I'm
more concerned about 32 bit compilers truncating that value without any
warnings.

Jeff
