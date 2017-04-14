Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C209209FA
	for <e@80x24.org>; Fri, 14 Apr 2017 21:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbdDNVGJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 17:06:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:51567 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbdDNVGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 17:06:08 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E7C42844B3;
        Fri, 14 Apr 2017 17:06:06 -0400 (EDT)
Subject: Re: [PATCH v4] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     Jeff King <peff@peff.net>
References: <20170414192554.26683-1-git@jeffhostetler.com>
 <20170414192554.26683-2-git@jeffhostetler.com>
 <20170414195219.qmc4w46t7t6brlp4@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <90b76976-b14c-c1e2-bdd8-8bf1964bce3e@jeffhostetler.com>
Date:   Fri, 14 Apr 2017 17:06:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170414195219.qmc4w46t7t6brlp4@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/14/2017 3:52 PM, Jeff King wrote:
> On Fri, Apr 14, 2017 at 07:25:54PM +0000, git@jeffhostetler.com wrote:
>
>>  	for (i = 0; i < n; i++, dirmask >>= 1) {
>> -		const unsigned char *sha1 = NULL;
>> -		if (dirmask & 1)
>> -			sha1 = names[i].oid->hash;
>> -		buf[i] = fill_tree_descriptor(t+i, sha1);
>> +		if (i > 0 && are_same_oid(&names[i], &names[i - 1]))
>> +			t[i] = t[i - 1];
>> +		else if (i > 1 && are_same_oid(&names[i], &names[i - 2]))
>> +			t[i] = t[i - 2];
>> +		else {
>> +			const unsigned char *sha1 = NULL;
>> +			if (dirmask & 1)
>> +				sha1 = names[i].oid->hash;
>> +			buf[nr_buf++] = fill_tree_descriptor(t+i, sha1);
>> +		}
>
> This looks fine to me.
>
> Just musing (and I do not think we need to go further than your patch),
> we're slowly walking towards an actual object-content cache. The "buf"
> array is now essentially a cache of all oids we've loaded, but it
> doesn't know its sha1s. So we could actually encapsulate all of the
> caching:
>
>   struct object_cache {
> 	  int nr_entries;
> 	  struct object_cache_entry {
> 		  struct object_id oid;
> 		  void *data;
> 	  } cache[MAX_UNPACK_TREES];
>   };
>
> and then ask it "have you seen oid X" rather than playing games with
> looking at "i - 1". Of course it would have to do a linear search, so
> the next step is to replace its array with a hashmap.
>
> And now suddenly we have a reusable object-content cache that you could
> use like:
>
>   struct object_cache = {0};
>   for (...) {
>     /* maybe reads fresh, or maybe gets it from the cache */
>     void *data = read_object_data_cached(&oid, &cache);
>   }
>   /* operation done, release the cache */
>   clear_object_cache(&cache);
>
> which would work anywhere you expect to load N objects and see some
> overlap.
>
> Of course it would be nicer still if this all just happened
> automatically behind the scenes of read_object_data(). But it would have
> to keep an _extra_ copy of each object, since the caller expects to be
> able to free it. We'd probably have to return instead a struct with
> buffer/size in it along with a reference counter.
>
> I don't think any of that is worth it unless there are spots where we
> really expect there to be a lot of cases where we hit the same objects
> in rapid succession. I don't think there should be, though. Our usual
> "caching" mechanism is to create a "struct object", which is enough to
> perform most operations (and has a much smaller memory footprint).
>
> So again, just musing. I think your patch is fine as-is.


Thanks for your help on this one.

I think before I tried to do a cache at this layer,
I would like to look at (or have a brave volunteer
look at) the recursive tree traversal.  In my Windows
tree I have 500K directories, so the full recursive
tree traversal touches them.  My change cuts the ODB
lookups (on a "checkout -b") from 1M to 500K (roughly),
but I still have to do 500K strcmp's to get those
savings.  What would be nice would be to have maybe
an alternate callback -- one which knows the peers
(and everything under them) are equal and let it short
cut as much as it can.  The alternate version of the
above routine would be able to avoid the strcmp's,
but I'm guessing that there would also be savings
when we look within a treenode -- the oidcmp's and
some of the n-way parallel sub-treenode-iteration.
I'm just swag'ing here, but there might be something
here.

Jeff


