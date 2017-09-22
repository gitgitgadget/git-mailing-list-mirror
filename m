Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70626202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 21:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbdIVVTw (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 17:19:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:13322 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752125AbdIVVTw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 17:19:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 580F5845FC;
        Fri, 22 Sep 2017 17:19:51 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 25DBB845FA;
        Fri, 22 Sep 2017 17:19:51 -0400 (EDT)
Subject: Re: RFC: Design and code of partial clones (now, missing commits and
 trees OK) (part 2/3)
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
 <5d295ab3-310e-321e-6e88-69484eb9ce8a@jeffhostetler.com>
 <20170921155150.1d57d89e@twelve2.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5b251b02-fe00-3d99-8ae2-d6df0193ebe0@jeffhostetler.com>
Date:   Fri, 22 Sep 2017 17:19:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170921155150.1d57d89e@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/21/2017 6:51 PM, Jonathan Tan wrote:
> On Thu, 21 Sep 2017 13:59:43 -0400
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> (part 2)
>>
>> Additional overall comments on:
>> https://github.com/jonathantanmy/git/commits/partialclone2
>>
>> {} I think it would help to split the blob-max-bytes filtering and the
>>      promisor/promised concepts and discuss them independently.
>>
>>      {} Then we can talk about about the promisor/promised
>> functionality independent of any kind of filter.  The net-net is that
>> the client has missing objects and it doesn't matter what filter
>> criteria or mechanism caused that to happened.
>>
>>      {} blob-max-bytes is but one such filter we should have.  This
>> might be sufficient if the goal is replace LFS (where you rarely ever
>>         need any given very very large object) and dynamically loading
>>         them as needed is sufficient and the network round-trip isn't
>>         too much of a perf penalty.
>>
>>      {} But if we want to do things like a "sparse-enlistments" where
>> the client only needs a small part of the tree using sparse-checkout.
>>         For example, only populating 50,000 files from a tree of 3.5M
>> files at HEAD, then we need a more general filtering.
>>
>>      {} And as I said above, how we chose to filter should be
>> independent of how the client handles promisor/promised objects.
> 
> I agree that they are independent. (I put everything together so that
> people could see how they work together, but they can be changed
> independently of each other.)
> 
>> {} Also, if we rely strictly on dynamic object fetching to fetch
>> missing objects, we are effectively tethered to the server during
>> operations (such as checkout) that the user might not think about as
>> requiring a network connection.  And we are forced to keep the same
>> limitations of LFS in that you can't prefetch and go offline (without
>> actually checking out to your worktree first).  And we can't bulk or
>> parallel fetch objects.
> 
> I don't think dynamic object fetching precludes any other more optimized
> way of fetching or prefetching - I implemented dynamic object fetching
> first so that we would have a fallback, but the others definitely can be
> implemented too.

yes, we need that as a fallback/default for the odd cases where we
can't predict perfectly.  Like during a blame or history or a merge.

I didn't mean to say we didn't need it, but rather that we should
try to minimize it.

> 
>> {} I think it would also help to move the blob-max-bytes calculation
>> out of pack-objects.c : add_object_entry() [1].  The current code
>> isolates the computation there so that only pack-objects can do the
>> filtering.
>>
>>      Instead, put it in list-objects.c and traverse_commit_list() so
>> that pack-objects and rev-list can share it (as Peff suggested [2] in
>>      response to my first patch series in March).
>>
>>      For example, this would let the client have a pre-checkout hook,
>> use rev-list to compute the set of missing objects needed for that
>> commit, and pipe that to a command to BULK fetch them from the server
>> BEFORE starting the actual checkout.  This would allow the savy user
>> to manually run a prefetch before going offline.
>>
>> [1]
>> https://github.com/jonathantanmy/git/commit/68e529484169f4800115c5a32e0904c25ad14bd8#diff-a8d2c9cf879e775d748056cfed48440cR1110
>>
>> [2]
>> https://public-inbox.org/git/20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net/
> 
> In your specific example, how would rev-list know, on the client, to
> include (or exclude) a large blob in its output if it does not have it,
> and thus does not know its size?
> 

The client doesn't have the size. It just knows it is missing and it
needs it. It doesn't matter why it is missing.  (But I guess the client
could assume it is because it is large.)

So rev-list on the client could filter the objects it has by size.

I added that to rev-list primarily to demonstrate and debug the
filtering concept (it's easier than playing with packfiles).  But
it can be used to drive client-side queries and bulk requests.

> My reason for including it in pack-objects.c is because I only needed it
> there and it is much simpler, but I agree that if it can be used
> elsewhere, we can put it in a more general place.
> 
>> {} This also locks us into size-only filtering and makes it more
>>      difficult to add other filters.  In that the add_object_entry()
>>      code gets called on an object after the traversal has decided
>>      what to do with it.  It would be difficult to add tree-trimming
>>      at this level, for example.
> 
> That is true.
> 
>> {} An early draft of this type of filtering is here [3].  I hope to
>> push up a revised draft of this shortly.
>>
>> [3]
>> https://public-inbox.org/git/20170713173459.3559-1-git@jeffhostetler.com/
> 
> OK - I'll take a look when that is done (I think I commented on an
> earlier version on that).
> 

FYI I just posted my RFC this afternoon.
https://public-inbox.org/git/20170922204211.GA24036@google.com/T/


Thanks
Jeff

