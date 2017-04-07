Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFD720966
	for <e@80x24.org>; Fri,  7 Apr 2017 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753758AbdDGSFB (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 14:05:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:48978 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbdDGSE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 14:04:59 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7151184645;
        Fri,  7 Apr 2017 14:04:58 -0400 (EDT)
Subject: Re: [PATCH v6 1/3] read-cache: add strcmp_offset function
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <20170406163442.36463-1-git@jeffhostetler.com>
 <20170406163442.36463-2-git@jeffhostetler.com>
 <97be34a6-ecdb-9820-1315-4cb5ed3b9101@web.de>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2244d0d6-5909-a5b1-6606-4b22331dca59@jeffhostetler.com>
Date:   Fri, 7 Apr 2017 14:04:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <97be34a6-ecdb-9820-1315-4cb5ed3b9101@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/2017 7:07 PM, René Scharfe wrote:
> Am 06.04.2017 um 18:34 schrieb git@jeffhostetler.com:
>> diff --git a/read-cache.c b/read-cache.c
>> index 9054369..e8f1900 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -887,6 +887,26 @@ static int has_file_name(struct index_state *istate,
>>       return retval;
>>   }
>>   +
>> +/*
>> + * Like strcmp(), but also return the offset of the first change.
>> + * If strings are equal, return the length.
>> + */
>> +int strcmp_offset(const char *s1, const char *s2, int *first_change)
>> +{
>> +    int k;
>> +
>> +    if (!first_change)
>> +        return strcmp(s1, s2);
>> +
>> +    for (k = 0; s1[k] == s2[k]; k++)
>> +        if (s1[k] == '\0')
>> +            break;
>> +
>> +    *first_change = k;
>> +    return ((unsigned char *)s1)[k] - ((unsigned char *)s2)[k];
>> +}
>
> I like how this is shaping up to become a reusable function, but I only
> found one other possible use case (in read-cache.c::ce_write_entry),
> which somehow irritates me.  Either I didn't look hard enough (likely),
> we haven't got fitting code just yet, or this function isn't meant to be
> exported -- in the latter case its interface doesn't have to be polished
> as much.  (Just a thought, don't let me stop you.)
>
> Assuming strcmp_offset() is a library-grade function then its
> first_change parameter should point to a size_t instead of an int, no?

yes, size_t. thanks.

>
> Casting away the const qualifier in the return line is a bit iffy.  Why
> not cast after dereferencing, like this?
>
>     return (unsigned char)s1[k] - (unsigned char)s2[k];

Good point.

Thanks
Jeff
