Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB431F404
	for <e@80x24.org>; Mon, 13 Aug 2018 12:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeHMO7Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:59:24 -0400
Received: from avasout06.plus.net ([212.159.14.18]:54675 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMO7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:59:24 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id pBmhf13ixWLW2pBmifOJVm; Mon, 13 Aug 2018 13:17:20 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=PKzvZo6CAAAA:8 a=7n7QmUcq3Vq5-3k-fKMA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 1/7] Add delta-islands.{c,h}
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER Gabor <szeder.dev@gmail.com>, Jeff King <peff@peff.net>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
 <20180812051151.6425-2-chriscool@tuxfamily.org>
 <2113c74c-b230-6ea1-a980-d6d008bac759@ramsayjones.plus.com>
 <CAP8UFD1tX+rAxQc47o-50Kzo6hnX9mTWH2BPSq9HiO_OgBzYTw@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <7a780fe9-e8bf-804a-82e6-8df81cd5c41c@ramsayjones.plus.com>
Date:   Mon, 13 Aug 2018 13:17:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1tX+rAxQc47o-50Kzo6hnX9mTWH2BPSq9HiO_OgBzYTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMWfa9BcUqRCl/LnKSTEQ9Lu+A0cXQZgL+85ZN6Z2NpBjsLUYwP17qkLagQIzfEMAvIIQblr1g2Skwhaa9Zo4TabmqCJCatU9iQB55ioezRZQ8roOjrI
 uBAYcJ0850Z7J2oSyczgNta9zhnEeGg2VWplJwHZvhXVubRviuOCThi9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/08/18 04:33, Christian Couder wrote:
> On Mon, Aug 13, 2018 at 3:14 AM, Ramsay Jones
[snip]
>> And neither the sha1 or str hash-maps are destroyed here.
>> (That is not necessarily a problem, of course! ;-) )
> 
> The instances are declared as static:
> 
>   static khash_sha1 *island_marks;
> 
>   static kh_str_t *remote_islands;
> 
> so it maybe ok.

Yes, that's fine.

> 
>>> +struct island_bitmap {
>>> +     uint32_t refcount;
>>> +     uint32_t bits[];
>>
>> Use FLEX_ARRAY here? We are slowly moving toward requiring
>> certain C99 features, but I can't remember a flex array
>> weather-balloon patch.
> 
> This was already discussed by Junio and Peff there:
> 
> https://public-inbox.org/git/20180727130229.GB18599@sigill.intra.peff.net/
> 

That is a fine discussion, without a firm conclusion, but I don't
think you can simply do nothing here:

  $ cat -n junk.c
       1	#include <stdint.h>
       2	
       3	struct island_bitmap {
       4		uint32_t refcount;
       5		uint32_t bits[];
       6	};
       7	
  $ gcc --std=c89 --pedantic -c junk.c
  junk.c:5:11: warning: ISO C90 does not support flexible array members [-Wpedantic]
    uint32_t bits[];
             ^~~~
  $ gcc --std=c99 --pedantic -c junk.c
  $ 
  
>>> +};
> 
>>> +int in_same_island(const struct object_id *trg_oid, const struct object_id *src_oid)
>>
>> Hmm, what does the trg_ prefix stand for?
>>
>>> +{
>>> +     khiter_t trg_pos, src_pos;
>>> +
>>> +     /* If we aren't using islands, assume everything goes together. */
>>> +     if (!island_marks)
>>> +             return 1;
>>> +
>>> +     /*
>>> +      * If we don't have a bitmap for the target, we can delta it
>>
>> ... Ah, OK, trg_ => target.
> 
> I am ok to replace "trg" with "target" (or maybe "dst"? or something
> else) and "src" with "source" if you think it would make things
> clearer.

If it had been dst_ (or target), I would not have had a 'huh?'
moment, but it is not all that important.

> 
>>> +static void add_ref_to_island(const char *island_name, const struct object_id *oid)
>>> +{
>>> +     uint64_t sha_core;
>>> +     struct remote_island *rl = NULL;
>>> +
>>> +     int hash_ret;
>>> +     khiter_t pos = kh_put_str(remote_islands, island_name, &hash_ret);
>>> +
>>> +     if (hash_ret) {
>>> +             kh_key(remote_islands, pos) = xstrdup(island_name);
>>> +             kh_value(remote_islands, pos) = xcalloc(1, sizeof(struct remote_island));
>>> +     }
>>> +
>>> +     rl = kh_value(remote_islands, pos);
>>> +     oid_array_append(&rl->oids, oid);
>>> +
>>> +     memcpy(&sha_core, oid->hash, sizeof(uint64_t));
>>> +     rl->hash += sha_core;
>>
>> Hmm, so the first 64-bits of the oid of each ref that is part of
>> this island is added together as a 'hash' for the island. And this
>> is used to de-duplicate the islands? Any false positives? (does it
>> matter - it would only affect performance, not correctness, right?)
> 
> I would think that a false positive from pure chance is very unlikely.
> We would need to approach billions of delta islands (as 2 to the power
> 64/2 is in the order of billions) for the probability to be
> significant. GitHub has less than 50 millions users and it is very
> unlikely that a significant proportion of these users will fork the
> same repo.
> 
> Now if there is a false positive because two forks have exactly the
> same refs, then it is not a problem if they are considered the same,
> because they are actually the same.

Yep, good point.

ATB,
Ramsay Jones
