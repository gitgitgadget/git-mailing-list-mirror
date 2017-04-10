Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB1120960
	for <e@80x24.org>; Mon, 10 Apr 2017 21:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdDJV0I (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 17:26:08 -0400
Received: from siwi.pair.com ([209.68.5.199]:31402 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751585AbdDJV0H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 17:26:07 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0697B844FE;
        Mon, 10 Apr 2017 17:26:05 -0400 (EDT)
Subject: Re: [PATCH v2] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <20170407155306.42375-1-git@jeffhostetler.com>
 <20170407155306.42375-2-git@jeffhostetler.com>
 <23662d7b-84a9-4b71-1aa5-5d3d111f5c3d@web.de>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ea0aa4ea-1c28-c1dd-db92-d4758b9dca88@jeffhostetler.com>
Date:   Mon, 10 Apr 2017 17:26:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <23662d7b-84a9-4b71-1aa5-5d3d111f5c3d@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/8/2017 10:06 AM, René Scharfe wrote:
> Am 07.04.2017 um 17:53 schrieb git@jeffhostetler.com:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach traverse_trees_recursive() to not do redundant ODB
>> lookups when both directories refer to the same OID.
>>
>> In operations such as read-tree, checkout, and merge when
>> the differences between the commits are relatively small,
>> there will likely be many directories that have the same
>> SHA-1.  In these cases we can avoid hitting the ODB multiple
>> times for the same SHA-1.
>>
>> This patch handles n=2 and n=3 cases and simply copies the
>> data rather than repeating the fill_tree_descriptor().
>>
>> ================
>> On the Windows repo (500K trees, 3.1M files, 450MB index),
>> this reduced the overall time by 0.75 seconds when cycling
>> between 2 commits with a single file difference.
>>
>> (avg) before: 22.699
>> (avg) after:  21.955
>> ===============
>>
>> ================
>> Using the p0004-read-tree test (posted earlier this week)
>> with 1M files on Linux:
>>
>> before:
>> $ ./p0004-read-tree.sh
>> 0004.5: switch work1 work2 (1003037)       11.99(8.12+3.32)
>> 0004.6: switch commit aliases (1003037)    11.95(8.20+3.14)
>>
>> after:
>> $ ./p0004-read-tree.sh
>> 0004.5: switch work1 work2 (1003037)       11.02(7.71+2.78)
>> 0004.6: switch commit aliases (1003037)    10.95(7.57+2.82)
>> ================
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   unpack-trees.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 3a8ee19..143c5d9 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -531,6 +531,11 @@ static int switch_cache_bottom(struct
>> traverse_info *info)
>>       return ret;
>>   }
>>   +static inline int are_same_oid(struct name_entry *name_j, struct
>> name_entry *name_k)
>> +{
>> +    return name_j->oid && name_k->oid && !oidcmp(name_j->oid,
>> name_k->oid);
>> +}
>> +
>>   static int traverse_trees_recursive(int n, unsigned long dirmask,
>>                       unsigned long df_conflicts,
>>                       struct name_entry *names,
>> @@ -554,10 +559,20 @@ static int traverse_trees_recursive(int n,
>> unsigned long dirmask,
>>       newinfo.df_conflicts |= df_conflicts;
>>         for (i = 0; i < n; i++, dirmask >>= 1) {
>> -        const unsigned char *sha1 = NULL;
>> -        if (dirmask & 1)
>> -            sha1 = names[i].oid->hash;
>> -        buf[i] = fill_tree_descriptor(t+i, sha1);
>> +        if (i > 0 && are_same_oid(&names[i], &names[i-1])) {
>> +            /* implicitly borrow buf[i-1] inside tree_desc[i] */
>> +            memcpy(&t[i], &t[i-1], sizeof(struct tree_desc));
>
> An assignment would be simpler:
>
>             t[i] = t[i - 1];

True, but this might be a coin toss.  Maybe we should
see what the generated assembly looks like for each ??

>
>> +            buf[i] = NULL;
>> +        } else if (i > 1 && are_same_oid(&names[i], &names[i-2])) {
>> +            /* implicitly borrow buf[i-2] inside tree_desc[i] */
>> +            memcpy(&t[i], &t[i-2], sizeof(struct tree_desc));
>
> Similar case.
>
>> +            buf[i] = NULL;
>
> What makes the previous two entries special, or differently put: Why not
> just check *all* previous entries?  MAX_UNPACK_TREES is 8; the number of
> comparisons would just about double in the worst case and stay the same
> for three trees or less.  The order of four trees or more wouldn't
> matter anymore.

I tried to hit the common cases.  This loop runs a lot
and I didn't want to put an O(n^2) thing in there to
look for any matching peer.  Most of the time we are
in a simple 2 or 3 way effort.  I didn't want to pay
for the looping/branching overhead for the obscure [4..8]
efforts.

>
>> +        } else {
>> +            const unsigned char *sha1 = NULL;
>> +            if (dirmask & 1)
>> +                sha1 = names[i].oid->hash;
>> +            buf[i] = fill_tree_descriptor(t+i, sha1);
>> +        }
>>       }
>>         bottom = switch_cache_bottom(&newinfo);
>>
