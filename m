Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2508520966
	for <e@80x24.org>; Fri,  7 Apr 2017 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbdDGNvo (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 09:51:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:49248 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933243AbdDGNvn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 09:51:43 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A2D3684643;
        Fri,  7 Apr 2017 09:51:41 -0400 (EDT)
Subject: Re: [PATCH v1] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
References: <20170406203732.47714-1-git@jeffhostetler.com>
 <20170406203732.47714-2-git@jeffhostetler.com>
 <CAGZ79kafbRQo2Of0H162ue5YzL7uA2PDu=sTy0=cEOejGTJhyw@mail.gmail.com>
 <20170407051935.4usaxtmco7lqm4ew@sigill.intra.peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fa94cfb3-ac5e-13f1-4c06-f0f3f1a2d1df@jeffhostetler.com>
Date:   Fri, 7 Apr 2017 09:51:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170407051935.4usaxtmco7lqm4ew@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/7/2017 1:19 AM, Jeff King wrote:
> On Thu, Apr 06, 2017 at 03:48:07PM -0700, Stefan Beller wrote:
>
>> On Thu, Apr 6, 2017 at 1:37 PM,  <git@jeffhostetler.com> wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Teach traverse_trees_recursive() to not do redundant ODB
>>> lookups when both directories refer to the same OID.
>>
>> And the reason for this is that omitting the second lookup
>> saves time, i.e. a lookup in the ODB of a sufficiently large
>> repo is slow.
>>
>> My kneejerk line of thinking:
>> * yes, it sounds good to reduce the number of ODB accesses.
>> * But if we consider ODB lookups to be slow and we perform
>>   a structured access, how about a cache in front of the ODB?
>> * We already have that! (sort of..) 9a414486d9 (lookup_object:
>>   prioritize recently found objects, 2013-05-01)
>> * Instead of improving the caching, maybe change the
>>   size of the problem: We could keep the objects of different types
>>   in different hash-tables.
>
> I don't think this is using lookup_object() at all, though. It goes
> straight to fill_tree_descriptor(), which will read the object contents
> from disk. So our time is going to:
>
>   1. Finding the object in the odb (ideally a binary search in a single
>      pack index, but less optimal when there are many packs).
>
>   2. Reconstructing the object. This means zlib-inflating from disk, but
>      it may also mean delta reconstruction.
>
> I think there _are_ some caches at play here, though, when you look up
> the same tree back to back. The pack-mru means that we'll always look in
> the correct pack first. And in theory the delta base cache means that
> we'll already have the whole thing reconstructed in memory (though I
> have often been confused by exactly when we put items into that cache,
> so I might be wrong).

This change shaved 500K calls to fill_tree_descriptor() (on the Windows
source tree on a "checkout -b" to the same commit).  I was surprised it
didn't give more of a speed up, so some of that caching may be in play
here, but it's hard to tell.

Also, on my repo I have 100GB+ of packfiles, so that may be messing
with things a bit.

>
> So in theory, this is not all that different than the "just allocate and
> copy the bytes" optimization that's happening here (though I'm not
> surprised that doing it at a higher level can produce some speedup).
>
> I think the more interesting optimization is "just use the same buffer
> without bothering to copy", which is hard for the low-level code to do
> (since it doesn't know what lifetime the caller is expecting).

My first draft did just borrow the buffer right there in traverse_
and it seemed to work just fine.  I was being cautious and copied it
properly in the lower layer.  Since the bufs are freed at the bottom
it felt safe, but I didn't want to overlook anything.  I'll switch it
back.

>
>> object.c has its own hash table, I presume for historical and
>> performance reasons, this would be split up to multiple hash
>> tables.
>
> So I don't think lookup_object() is really relevant here. But I'm also
> not sure that multiple hash tables would really buy us much. In theory
> hash tables are O(1), so multiple smaller tables doesn't help (and might
> hurt, since now we have four O(1) lookups to do). Of course that's a
> minor fiction because of collisions, but we keep the load factor on the
> object.c table pretty low (and that's why things like quadratic probing
> and cuckoo hashing never showed great improvement).

I do wonder now about the initial hash table size and any limits
on it, but that is a question for another day.

Thanks
Jeff

