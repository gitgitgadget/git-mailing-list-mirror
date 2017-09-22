Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223EE202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbdIVQFG (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:05:06 -0400
Received: from avasout07.plus.net ([84.93.230.235]:33911 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdIVQFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:05:05 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id Cg531w0040M91Ur01g54jY; Fri, 22 Sep 2017 17:05:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=vhG-M06Dpg7HnRSmaBMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/4] cache.h: hex2chr() - avoid -Wsign-compare warnings
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ae537e7e-2c3d-f7f3-28f4-451c37c01bbb@ramsayjones.plus.com>
 <20170922054748.iseinawwwfw56vis@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <89beb424-2cc0-bfe3-7847-c11035bfec70@ramsayjones.plus.com>
Date:   Fri, 22 Sep 2017 17:05:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922054748.iseinawwwfw56vis@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/09/17 06:47, Jeff King wrote:
> On Thu, Sep 21, 2017 at 05:48:38PM +0100, Ramsay Jones wrote:
> 
>> diff --git a/cache.h b/cache.h
>> index a916bc79e..a0e3e362c 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1243,8 +1243,8 @@ static inline unsigned int hexval(unsigned char c)
>>   */
>>  static inline int hex2chr(const char *s)
>>  {
>> -	int val = hexval(s[0]);
>> -	return (val < 0) ? val : (val << 4) | hexval(s[1]);
>> +	unsigned int val = hexval(s[0]);
>> +	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
>>  }
> 
> Ironically, the unsigned return from hexval() comes from internally
> converting the signed char in hexval_table. And then we again return it
> as a signed int from hex2chr().

Yep, my first inclination was to change the return type of
hexval(), but after looking at all its callers, I decided
against that (because it wouldn't help). ;-)

> Would it make sense to return a signed int from hexval()? That would
> make hex2chr just work as it tries to above. I admit that shifting
> signed values is a little funny, but it should be fine here since we
> know they're no larger than 8 bits in the first place.

Indeed, shifting signed values is a no-no, which is why I decided
to go this route.

> As an aside, I also see some uses of hexval() that don't appear to be
> quite as rigorous in checking for invalid characters. A few
> unconditionally shift the first nibble and assume that there will still
> be high bits set. I think that's generally true for twos-complement
> negative numbers, but isn't shifting off the left side of a signed
> integer undefined behavior?

All uses of hexval() that I can see are shifting an unsigned value.
Have I missed something?
> And mailinfo's decode_q_segment() does not seem to check for errors at
> all.

Yes, I noticed that. (I put it on my TODO list).

> Handling those is getting far off your original patch, but I'm having
> trouble figuring out if it's saner for us to consistently stick to
> all-signed or all-unsigned here.

Oh, unsigned, without a doubt. :D

ATB,
Ramsay Jones


