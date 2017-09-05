Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F446208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 16:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbdIEQyr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 12:54:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:18026 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbdIEQyr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 12:54:47 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 56C1A845B6;
        Tue,  5 Sep 2017 12:54:46 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0A245845AA;
        Tue,  5 Sep 2017 12:54:46 -0400 (EDT)
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
 <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
 <20170902081747.lca2kkzpniykdxy2@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <52aa964f-0511-9105-11d9-6e41221eb41e@jeffhostetler.com>
Date:   Tue, 5 Sep 2017 12:54:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170902081747.lca2kkzpniykdxy2@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/2/2017 4:17 AM, Jeff King wrote:
> On Sat, Sep 02, 2017 at 01:31:19AM +0200, Johannes Schindelin wrote:
>> Before anybody can ask for this message to be wrapped in _(...) to be
>> translateable, let me suggest instead to add the prefix "BUG: ".
> 
> Agreed on both (and Jonathan's suggestion to just use BUG()).

will do.  thanks.

> 
>>> +static inline void hashmap_enable_item_counting(struct hashmap *map)
>>> +{
>>> +	void *item;
>>> +	unsigned int n = 0;
>>> +	struct hashmap_iter iter;
>>> +
>>> +	hashmap_iter_init(map, &iter);
>>> +	while ((item = hashmap_iter_next(&iter)))
>>> +		n++;
>>> +
>>> +	map->do_count_items = 1;
>>> +	map->private_size = n;
>>> +}
>>
>> BTW this made me think that we may have a problem in our code since
>> switching from my original hashmap implementation to the bucket one added
>> in 6a364ced497 (add a hashtable implementation that supports O(1) removal,
>> 2013-11-14): while it is not expected that there are many collisions, the
>> "grow_at" logic still essentially assumes the number of buckets to be
>> equal to the number of hashmap entries.
> 
> I'm confused about what the problem is. If I am reading the code
> correctly, "size" is always the number of elements and "grow_at" is the
> table size times a load factor. Those are the same numbers you'd use to
> decide to grow in an open-address table.
> 
> It's true that this does not take into account the actual number of
> collisions we see (or the average per bucket, or however you want to
> count it). But generally nor do open-address schemes (and certainly our
> other hash tables just use load factor to decide when to grow).
> 
> Am I missing something?
> 
> -Peff
> 

Hashmap is not thread-safe by itself.  There are several uses of
it in a threaded context and they all handle their own locking
before accessing the hashmap.  Those usually work by locking the
whole hashmap.

My changes in "lazy-init-name-hash" deviated from that pattern
by locking on individual hash chains.  That is, n locks each
controlling 1/nth of the chains.

https://public-inbox.org/git/1490202865-31325-1-git-send-email-git@jeffhostetler.com/

To do that I had to disable automatic rehashing for the duration
of my threaded computation.  The problem that TSan identified is
that "size" is always incremented during inserts and it doesn't
have any locks protecting it.  So even though auto-rehash was
disabled, we are still counting the number of items in the map.
Not a terrible problem, but still a race.

Jeff

