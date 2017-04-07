Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B4820966
	for <e@80x24.org>; Fri,  7 Apr 2017 13:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbdDGN5Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 09:57:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:11781 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754055AbdDGN5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 09:57:14 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4287884643;
        Fri,  7 Apr 2017 09:57:13 -0400 (EDT)
Subject: Re: [PATCH v1] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <20170406203732.47714-1-git@jeffhostetler.com>
 <20170406203732.47714-2-git@jeffhostetler.com>
 <a1e08e20-7fe6-da3c-cd18-74a8bcd266e0@web.de>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b2952bdc-cb93-1317-58b1-a06ea4e14ee8@jeffhostetler.com>
Date:   Fri, 7 Apr 2017 09:57:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <a1e08e20-7fe6-da3c-cd18-74a8bcd266e0@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/2017 8:32 PM, René Scharfe wrote:
> Am 06.04.2017 um 22:37 schrieb git@jeffhostetler.com:
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
>> TODO This change is a first attempt to test that by comparing
>> TODO the hashes of name[i] and name[i-i] and simply copying
>> TODO the tree-descriptor data.  I was thinking of the n=2
>> TODO case here.  We may want to extend this to the n=3 case.
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
>> 0004.5: switch work1 work2 (1003037)       11.17(7.84+2.76)
>> 0004.6: switch commit aliases (1003037)    11.13(7.82+2.72)
>> ================
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   tree-walk.c    |  8 ++++++++
>>   tree-walk.h    |  1 +
>>   unpack-trees.c | 13 +++++++++----
>>   3 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/tree-walk.c b/tree-walk.c
>> index ff77605..3b82f0e 100644
>> --- a/tree-walk.c
>> +++ b/tree-walk.c
>> @@ -92,6 +92,14 @@ void *fill_tree_descriptor(struct tree_desc *desc,
>> const unsigned char *sha1)
>>       return buf;
>>   }
>>   +void *copy_tree_descriptor(struct tree_desc *dest, const struct
>> tree_desc *src)
>> +{
>> +    void *buf = xmalloc(src->size);
>> +    memcpy(buf, src->buffer, src->size);
>> +    init_tree_desc(dest, buf, src->size);
>> +    return buf;
>> +}
>> +
>>   static void entry_clear(struct name_entry *a)
>>   {
>>       memset(a, 0, sizeof(*a));
>> diff --git a/tree-walk.h b/tree-walk.h
>> index 68bb78b..ca4032b 100644
>> --- a/tree-walk.h
>> +++ b/tree-walk.h
>> @@ -43,6 +43,7 @@ int tree_entry(struct tree_desc *, struct name_entry
>> *);
>>   int tree_entry_gently(struct tree_desc *, struct name_entry *);
>>     void *fill_tree_descriptor(struct tree_desc *desc, const unsigned
>> char *sha1);
>> +void *copy_tree_descriptor(struct tree_desc *dest, const struct
>> tree_desc *src);
>>     struct traverse_info;
>>   typedef int (*traverse_callback_t)(int n, unsigned long mask,
>> unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 3a8ee19..50aacad 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -554,10 +554,15 @@ static int traverse_trees_recursive(int n,
>> unsigned long dirmask,
>>       newinfo.df_conflicts |= df_conflicts;
>>         for (i = 0; i < n; i++, dirmask >>= 1) {
>> -        const unsigned char *sha1 = NULL;
>> -        if (dirmask & 1)
>> -            sha1 = names[i].oid->hash;
>> -        buf[i] = fill_tree_descriptor(t+i, sha1);
>> +        if (i > 0 && (dirmask & 1) && names[i].oid && names[i-1].oid &&
>
> Can .oid even be NULL?  (I didn't check, but it's dereferenced in the
> sha1 assignment below, so I guess the answer is no and these two checks
> are not needed.)

yes.  i think the (dirmask&1) is hiding it for name[i].  i put both in
the code above, but it also worked fine just testing both oid's (and
without dirmask).

>
>> +            !hashcmp(names[i].oid->hash, names[i-1].oid->hash)) {
>
> Calling oidcmp would be shorter.

right.

>
>> +            buf[i] = copy_tree_descriptor(&t[i], &t[i-1]);
>
> buf keeps track of the allocations that need to be freed at the end of
> the function.  I assume these buffers are read-only.  Can you use an
> alias here instead of a duplicate by calling init_tree_desc with the
> predecessor's buffer and setting buf[i] to NULL?  Or even just copying
> t[i - 1] to t[i] with an assignment?  That would be shorter and probably
> also quicker.

Yes, my first draft did that.  Just being cautious, but i'll switch it
back since that seems to be the consensus.

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

Thanks
Jeff
