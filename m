Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595EC208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 16:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbdIEQdY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 12:33:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:18958 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdIEQdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 12:33:24 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F096C84566;
        Tue,  5 Sep 2017 12:33:22 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9BE5784564;
        Tue,  5 Sep 2017 12:33:22 -0400 (EDT)
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com, peff@peff.net
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
 <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9ec32edc-5aeb-53c0-7888-541f7a9db8bf@jeffhostetler.com>
Date:   Tue, 5 Sep 2017 12:33:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/1/2017 7:31 PM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Wed, 30 Aug 2017, Jeff Hostetler wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> This is to address concerns raised by ThreadSanitizer on the mailing
>> list about threaded unprotected R/W access to map.size with my previous
>> "disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).
>> See:
>> https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/
>>
>> Add API to hashmap to disable item counting and to disable automatic
>> rehashing.  Also include APIs to re-enable item counting and automatica
>> rehashing.
>>
>> When item counting is disabled, the map.size field is invalid.  So to
>> prevent accidents, the field has been renamed and an accessor function
>> hashmap_get_size() has been added.  All direct references to this field
>> have been been updated.  And the name of the field changed to
>> map.private_size to communicate thie.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
> 
> The Git contribution process forces me to point out lines longer than 80
> columns. I wish there was already an automated tool to fix that, but we
> (as in "the core Git developers") have not yet managed to agree on one. So
> I'll have to ask you to identify and fix them manually.

I'm not sure which lines you're talking about, but I'll
give it another scan and double check.

There's not much I can do about the public-inbox.org URL.

> 
>> @@ -253,6 +253,19 @@ static inline void hashmap_entry_init(void *entry, unsigned int hash)
>>   }
>>   
>>   /*
>> + * Return the number of items in the map.
>> + */
>> +inline unsigned int hashmap_get_size(struct hashmap *map)
>> +{
>> +	if (map->do_count_items)
>> +		return map->private_size;
>> +
>> +	/* TODO Consider counting them and returning that. */
> 
> I'd rather not. If counting is disabled, it is disabled.
> 
>> +	die("hashmap_get_size: size not set");
> 
> Before anybody can ask for this message to be wrapped in _(...) to be
> translateable, let me suggest instead to add the prefix "BUG: ".

Good point.  Thanks.

> 
>> +static inline void hashmap_enable_item_counting(struct hashmap *map)
>> +{
>> +	void *item;
>> +	unsigned int n = 0;
>> +	struct hashmap_iter iter;
>> +
>> +	hashmap_iter_init(map, &iter);
>> +	while ((item = hashmap_iter_next(&iter)))
>> +		n++;
>> +
>> +	map->do_count_items = 1;
>> +	map->private_size = n;
>> +}
> 
> BTW this made me think that we may have a problem in our code since
> switching from my original hashmap implementation to the bucket one added
> in 6a364ced497 (add a hashtable implementation that supports O(1) removal,
> 2013-11-14): while it is not expected that there are many collisions, the
> "grow_at" logic still essentially assumes the number of buckets to be
> equal to the number of hashmap entries.
> 
> Your code simply reiterates that assumption, so I do not blame you for
> anything here, nor ask you to change your patch.

I'm not sure what you're saying here.  The iterator iterates over
all entries (and handles walking collision chains), so my newly
computed count should be correct and all of this is independent of
the "grow-at" and table-size logic.

I'm not forcing a rehash when counting is enabled.  I'm just
reestablishing the expected state.  The next insert may cause
a rehash, but I'm not forcing it.

However, there is an assumption that the caller pre-allocated sufficient
table-size space to avoid poor performance for the duration of the
non-counting period.

> 
> But it does look a bit weird to assume so much about the nature of our
> data, without having any real-life numbers. I wish I had more time so that
> I could afford to run a couple of tests on this hashmap, such as: what is
> the typical difference between bucket count and entry count, or the median
> of the bucket sizes when the map is 80% full (i.e. *just* below the grow
> threshold).

Personally, I think the 80% threshold is too aggressive (and the
default size is too small), but that's a different question.

The hashmap in question contains directory pathnames, so the
distribution will be completely dependent on the shape of the
data.

FWIW, I created a tool to dump some of this data.  See:
     t/helper/test-lazy-init-name-hash.c

> 
>> diff --git a/name-hash.c b/name-hash.c
>> index 0e10f3e..829ff59 100644
>> --- a/name-hash.c
>> +++ b/name-hash.c
>> @@ -580,9 +580,11 @@ static void lazy_init_name_hash(struct index_state *istate)
>>   			NULL, istate->cache_nr);
>>   
>>   	if (lookup_lazy_params(istate)) {
>> -		hashmap_disallow_rehash(&istate->dir_hash, 1);
>> +		hashmap_disable_item_counting(&istate->dir_hash);
>> +		hashmap_disable_auto_rehash(&istate->dir_hash);
>>   		threaded_lazy_init_name_hash(istate);
>> -		hashmap_disallow_rehash(&istate->dir_hash, 0);
>> +		hashmap_enable_auto_rehash(&istate->dir_hash);
>> +		hashmap_enable_item_counting(&istate->dir_hash);
> 
> By your rationale, it would be enough to simply disable and re-enable
> counting...
> 
> The rest of the patch looks just dandy to me.
> 
> Thanks,
> Dscho
> 

thanks
Jeff

