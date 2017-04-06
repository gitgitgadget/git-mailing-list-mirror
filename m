Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A0D1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 15:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbdDFP6P (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 11:58:15 -0400
Received: from siwi.pair.com ([209.68.5.199]:24815 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753899AbdDFP6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 11:58:13 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5E58984647;
        Thu,  6 Apr 2017 11:58:12 -0400 (EDT)
Subject: Re: [PATCH v5 2/4] read-cache: add strcmp_offset function
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170406141912.14536-1-szeder.dev@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3f88c428-6d04-6ef5-f7bc-952daad2703a@jeffhostetler.com>
Date:   Thu, 6 Apr 2017 11:58:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170406141912.14536-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/2017 10:19 AM, SZEDER Gábor wrote:
>> Add strcmp_offset() function to also return the offset of the
>> first change.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>  cache.h      |  1 +
>>  read-cache.c | 29 +++++++++++++++++++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/cache.h b/cache.h
>> index 80b6372..4d82490 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -574,6 +574,7 @@ extern int write_locked_index(struct index_state *, struct lock_file *lock, unsi
>>  extern int discard_index(struct index_state *);
>>  extern int unmerged_index(const struct index_state *);
>>  extern int verify_path(const char *path);
>> +extern int strcmp_offset(const char *s1_in, const char *s2_in, int *first_change);
>>  extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
>>  extern void adjust_dirname_case(struct index_state *istate, char *name);
>>  extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
>> diff --git a/read-cache.c b/read-cache.c
>> index 9054369..b3fc77d 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>
> read-cache.c is probably not the best place for such a general string
> utility function, though I'm not sure where its most apropriate place
> would be.

Yeah, I looked and didn't see any place so I left it here
near it's first usage for now.

>
>> @@ -887,6 +887,35 @@ static int has_file_name(struct index_state *istate,
>>  	return retval;
>>  }
>>
>> +
>> +/*
>> + * Like strcmp(), but also return the offset of the first change.
>
> This comment doesn't tell us what will happen with the offset
> parameter if it is NULL or if the two strings are equal.  I don't
> really care about the safety check for NULL: a callsite not interested
> in the offset should just call strcmp() instead.  I'm fine either way.
> However, setting it to 0 when the strings are equal doesn't seem quite
> right, does it.

Good catch. I'll add a null check.

When the strings are equal, I'm not sure any one value is
better than another.  I could leave it undefined or set it
to the length.  That might be more useful since we have it on
hand and it might save the caller a strlen() later.

>
>> + */
>> +int strcmp_offset(const char *s1_in, const char *s2_in, int *first_change)
>> +{
>> +	const unsigned char *s1 = (const unsigned char *)s1_in;
>> +	const unsigned char *s2 = (const unsigned char *)s2_in;
>> +	int diff = 0;
>> +	int k;
>> +
>> +	*first_change = 0;
>> +	for (k=0; s1[k]; k++)
>> +		if ((diff = (s1[k] - s2[k])))
>> +			goto found_it;
>> +	if (!s2[k])
>> +		return 0;
>> +	diff = -1;
>> +
>> +found_it:
>> +	*first_change = k;
>> +	if (diff > 0)
>> +		return 1;
>> +	else if (diff < 0)
>> +		return -1;
>> +	else
>> +		return 0;
>> +}
>
> The implementation seems to me a bit long-winded, with more
> conditional statements than necessary.  How about something like this
> instead?  Much shorter, no goto and only half the number of
> conditionals to reason about, leaves *first_change untouched when the
> two strings are equal, and deals with it being NULL.
>
> int strcmp_offset(const char *s1, const char *s2, int *first_change)
> {
> 	int k;
>
> 	for (k = 0; s1[k] == s2[k]; k++)
> 		if (s1[k] == '\0')
> 			return 0;
>
> 	if (first_change)
> 		*first_change = k;
> 	return ((unsigned char *)s1)[k] - ((unsigned char *)s2)[k];
> }
>

Let me give that a try.  Thanks!
Jeff

