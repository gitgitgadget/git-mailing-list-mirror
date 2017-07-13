Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8BFF202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdGMPFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:05:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:22499 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdGMPFL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:05:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0D94784533;
        Thu, 13 Jul 2017 11:05:10 -0400 (EDT)
Received: from [10.160.98.223] (unknown [167.220.148.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D0C978452E;
        Thu, 13 Jul 2017 11:05:09 -0400 (EDT)
Subject: Re: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1499800530.git.jonathantanmy@google.com>
 <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
 <890a36fc-be16-83bc-fec6-94e21d0f7d0a@jeffhostetler.com>
 <20170712192831.GG93855@aiede.mtv.corp.google.com>
 <4b326d17-3896-a374-9d7a-d0c89954c943@jeffhostetler.com>
Message-ID: <e44c0778-326e-9f9c-ecb3-eba5da170bd0@jeffhostetler.com>
Date:   Thu, 13 Jul 2017 11:05:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4b326d17-3896-a374-9d7a-d0c89954c943@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/13/2017 10:48 AM, Jeff Hostetler wrote:
> 
> 
> On 7/12/2017 3:28 PM, Jonathan Nieder wrote:
>> Hi,
>>
>> Jeff Hostetler wrote:
>>
>>> My primary concern is scale and managing the list of objects over time.
>> [...]
>>>                                                                   For
>>> example, on the Windows repo we have (conservatively) 100M+ blobs (and
>>> growing).  Assuming 28 bytes per, gives a 2.8GB list to be manipulated.
>>>
>>> If I understand your proposal, newly-omitted blobs would need to be
>>> merged into the promised-blob list after each fetch.  The fetch itself
>>> may not have that many new entries, but inserting them into the existing
>>> list will be slow.
>>
>> This is a good point.  An alternative would be to avoid storing the
>> list and instead use a repository extension that treats all missing
>> blobs in the repository similarly to promised blobs (with a weaker
>> promise, where the server is allowed to return 404).  The downsides:
>>
>> - blob sizes are not available without an additional request, e.g. for
>>    directory listings
>>
>> - the semantics of has_object_file become more complicated.  If it
>>    is allowed to return false for omitted blobs, then callers have to
>>    be audited to tolerate that and try to look up the blob anyway.
>>    If it has to contact the server to find out whether an omitted blob
>>    is available, then callers have to be audited to skip this expensive
>>    operation when possible.
>>
>> - similarly, the semantics of sha1_object_info{,_extended} become more
>>    complicated.  If they are allowed to return -1 for omitted blobs,
>>    then callers have to be audited to handle that. If they have to
>>    contact the server to find the object type and size, it becomes
>>    expensive in a way that affects callers.
>>
>> - causes futile repeated requests to the server for objects that don't
>>    exist.  Caching negative lookups is fussy because a later push could
>>    cause those objects to exist --- though it should be possible for
>>    fetches to invalidate entries in such a cache using the list of
>>    promised blobs sent by the server.
> 
> Also good points. :-)
> 
> Would it be better to:
> [] let fetch-pack/index-pack on the client compute the set of missing
>     objects based upon the commit range in the response.
> [] build a "pack-<id>.promised" as a peer of the "pack-<id>.[pack,idx]"
>     files.
> [] Use Jonathan's binary format with (-1LL) for the sizes, but also add
>     a flags/object-type word.  Since the local commit/object traversal
>     usually knows the type of object (either by context or the mode field
>     in the parent entry), index-pack can set it immediately.
> [] Repack would "do the right thing" when building new packfiles from
>     existing packfiles (and merge/prune/etc. a new promise file).
> 
> Conceptually, these "pack-<id>.promised" files would be read-only once
> created, like the corresponding .pack/.idx files.  But since we have a
> fixed record size, we could let the dynamic object size requests update
> the sizes in-place.   (And if an update failed for some reason, the
> client could just go on and use the result (as we do when trying to
> update mtime info in the index).)
> 
> This gives us the full set of omitted objects without the network
> overhead and without the overhead of merging them into a single list.
> And we defer the cost of getting an object's size until we actually
> need the info.
> 
> 
>> [...]
>>> In such a "sparse clone", it would be nice to omit unneeded tree objects
>>> in addition to just blobs.   I say that because we are finding with GVFS
>>> on the Windows repo, that even with commits-and-trees-only filtering,
>>> the number of tree objects is overwhelming.  So I'm also concerned about
>>> limiting the list to just blobs.  If we need to have this list, it
>>> should be able to contain any object.  (Suggesting having an object type
>>> in the entry.)
>>
>> Would it work to have a separate lists of blobs and trees (either in
>> separate files or in the same file)?
>>
>> One option would be to add a version number / magic string to the start
>> of the file.  That would allow making format changes later without a
>> proliferation of distinct repository extensions.
> 
> As I suggested above, we could just put them in the same file with a
> flags/object-type field.
> 
> Without getting too nerdy here, we could even say that the size doesn't
> need to be a int:64 -- definitely bigger than int:32, but we don't need
> the full int:64.  We could make the size a int:40 or int:48 and use the
> rest of the QWORD for flags/object-type.
> 
> 
>> [...]
>>> I assume that we'll also need a promised-blob.lock file to control
>>> access during list manipulation.  This is already a sore spot with the
>>> index; I'd hate to create another one.
>>
>> Can you say more about this concern?  My experience with concurrent
>> fetches has already not been great (since one fetch process is not
>> aware of what the other has fetched) --- is your concern that the
>> promised-blob facility would affect pushes as well some day?
> 
> [I wrote this before I wrote the multi-peer-file suggestion above.]
> 
> I'm assuming that anyone adding a new promised-blob to the single file
> will use the standard "read foo, write foo.lock, rename" trick.  If we
> have a large number of omitted blobs, this file will be large and the
> insert will take a non-trivial amount of time.
> 
> Concurrent fetches does sound a bit silly, so we only have to worry
> about the time to copy the bits on disk.
> 
> If other operations (such as demand loading missing blobs in a log or
> diff) need to remove promised-blobs from the list as they create
> loose blobs, then they will get stuck on the lock.  I suppose we could
> just say that the promised-blob list may have false-positives in it
> (because lookups in it won't happen until the packed and loose objects
> have been searched and failed) and just wait for GC to clean it.
> 
> And there's always that stale lock problem where something dies holding
> the lock and doesn't delete it.
> 
> Some of these could be addressed with a DB or something that allows
> incremental and atomic updates rather than a regular index-like
> flat file, but I don't want to dive into that here.
> 
> 
>>> I also have to wonder about the need to have a complete list of omitted
>>> blobs up front.  It may be better to just relax the consistency checks
>>> and assume a missing blob is "intentionally missing" rather than
>>> indicating a corruption somewhere.
>>
>> We've discussed this previously on list and gone back and forth. :)
>>
>>>                                      And then let the client do a later
>>> round-trip to either demand-load the object -or- demand-load the
>>> existence/size info if/when it really matters.
>>
>> The cost of demand-loading this existence/size information is what
>> ultimately convinced me of this approach.
>>
>> But I can see how the tradeoffs differ between the omit-large-blobs
>> case and the omit-all-blobs case.  We might end up having to support
>> both modes. :(
> 
> I think I've been in both camps myself.
> 
> I'm not sure it would be that hard to support both (other than being
> unfortunate), assuming pack-objects could build the same binary data
> as I suggested be computed by fetch-pack/index-pack above.  It could
> then just be a run-time decision.
> 
> I could even see it being useful -- do the initial clone with
> client-side computation (because you're getting mostly ancient data
> that you don't care about) and then let fetches use server-side
> computation (because you're more likely to care about the sizes of
> objects near your branch heads).
> 
> 
>>> Maybe we should add a verb to your new fetch-blob endpoint to just get
>>> the size of one or more objects to help with this.
>>
>> No objections from me, though we don't need it yet.

I think it would also be helpful to consider more than one type of size
request.
[1] get the size of a single objects
[2] get the sizes of a set of objects
[3] get the sizes for all objects directly referenced by a tree.
     if both sides have a tree object, then we don't need to send a list
     blobs -- just ask for all the blobs referenced by the tree object.
     the server could just return an array of sizes ordered by blob
     position in the tree.
[4] recursive version of [3].
[5] recursive for a commit (basically just a convenience on [4] and the
     tree root).

This would let the clone do a client-side computation and then (in a
request to the new end-point) get the sizes of everything in HEAD, for
example.

Thanks
Jeff
