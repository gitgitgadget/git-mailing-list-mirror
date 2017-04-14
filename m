Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151AF20970
	for <e@80x24.org>; Fri, 14 Apr 2017 13:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdDNNGS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 09:06:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:48878 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbdDNNGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 09:06:16 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4ABB88450C;
        Fri, 14 Apr 2017 09:06:15 -0400 (EDT)
Subject: Re: [PATCH v9 3/3] read-cache: speed up add_index_entry during
 checkout
To:     Junio C Hamano <gitster@pobox.com>
References: <20170411191702.20134-1-git@jeffhostetler.com>
 <20170411191702.20134-4-git@jeffhostetler.com>
 <xmqq37deqpyw.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d233feed-2494-e68b-5fe6-4e1bd43ef423@jeffhostetler.com>
Date:   Fri, 14 Apr 2017 09:06:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq37deqpyw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/11/2017 11:12 PM, Junio C Hamano wrote:
> git@jeffhostetler.com writes:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach add_index_entry_with_check() and has_dir_name()
>> to see if the path of the new item is greater than the
>> last path in the index array before attempting to search
>> for it.
>>
>> During checkout, merge_working_tree() populates the new
>> index in sorted order, so this change will save at least 2
>> binary lookups per file.
>
> Smart and simple.
>
>> diff --git a/read-cache.c b/read-cache.c
>> index 97f13a1..a8ef823 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -918,9 +918,24 @@ static int has_dir_name(struct index_state *istate,
>>  	int stage = ce_stage(ce);
>>  	const char *name = ce->name;
>>  	const char *slash = name + ce_namelen(ce);
>> +	size_t len_eq_last;
>> +	int cmp_last = 0;
>> +
>> +	if (istate->cache_nr > 0) {
>> +		/*
>> +		 * Compare the entry's full path with the last path in the index.
>> +		 * If it sorts AFTER the last entry in the index and they have no
>> +		 * common prefix, then there cannot be any F/D name conflicts.
>> +		 */
>> +		cmp_last = strcmp_offset(name,
>> +			istate->cache[istate->cache_nr-1]->name,
>
> Style?  "istate->cache[istate->cache_nr - 1]->name"
>
>> +			&len_eq_last);
>> +		if (cmp_last > 0 && len_eq_last == 0)
>> +			return retval;
>> +	}
>
> Let me follow the logic aloud.  Say the last entry in the cache is
> "x/y".  If we came here with ce->name == "x", we need to worry about
> nuking the existing entry "x/y".  But if we have "zoo", that cannot
> possibly overlap and we can safely return 0.
>
> That sounds correct, except that it might be playing overly safe.
> If we came here with "xx", we still are safe, but len_eq_last would
> be non-zero.  Probably it is not worth the extra complexity to catch
> it here (rather than letting the loop below to handle it).
>
>>  	for (;;) {
>> -		int len;
>> +		size_t len;
>>
>>  		for (;;) {
>>  			if (*--slash == '/')
>> @@ -930,6 +945,24 @@ static int has_dir_name(struct index_state *istate,
>>  		}
>>  		len = slash - name;
>
> Mental note: cmp_last may be 0, >0 or <0 at this point in the very
> first iteration of the loop.  It is not updated in the loop.  The
> variable len_eq_last are used to carry the information about the
> last entry we learned at the beginning of this function---the new
> special case happens only when the path we are adding sorts later
> than the last existing entry (i.e. cmp_last > 0).
>
>> +		if (cmp_last > 0) {
>> +			/*
>> +			 * If this part of the directory prefix (including the trailing
>> +			 * slash) already appears in the path of the last entry in the
>> +			 * index, then we cannot also have a file with this prefix (or
>> +			 * any parent directory prefix).
>> +			 */
>> +			if (len+1 <= len_eq_last)
>
> Style?  "len + 1".
>
>> +				return retval;
>> +			/*
>> +			 * If this part of the directory prefix (excluding the trailing
>> +			 * slash) is longer than the known equal portions, then this part
>> +			 * of the prefix cannot collide with a file.  Go on to the parent.
>> +			 */
>> +			if (len > len_eq_last)
>> +				continue;
>
> Hmph, is the reasoning used in the two conditionals above sound?
> Does this work correctly even when the last existing entry in the
> cache is marked with CE_REMOVE?

I'll double check my math here.  I also want to think about
the "too conservative" comment above.

WRT if the last entry is CE_REMOVE, I think we are still OK
because we are asking if the given ce is strictly greater than
the last entry so that we can append it rather than searching
for a collision or insertion point.

Thanks,
Jeff
