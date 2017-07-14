Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC38A20357
	for <e@80x24.org>; Fri, 14 Jul 2017 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbdGNUDs (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 16:03:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:40870 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbdGNUDr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 16:03:47 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 96B1E84566;
        Fri, 14 Jul 2017 16:03:46 -0400 (EDT)
Received: from [10.160.98.223] (unknown [167.220.148.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5EC9B8456C;
        Fri, 14 Jul 2017 16:03:46 -0400 (EDT)
Subject: Re: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
References: <cover.1499800530.git.jonathantanmy@google.com>
 <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
 <890a36fc-be16-83bc-fec6-94e21d0f7d0a@jeffhostetler.com>
 <20170713123951.5cab1adc@twelve2.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4d0849b0-1340-5b82-ba3c-03a1f5c42f33@jeffhostetler.com>
Date:   Fri, 14 Jul 2017 16:03:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170713123951.5cab1adc@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/13/2017 3:39 PM, Jonathan Tan wrote:
> On Wed, 12 Jul 2017 13:29:11 -0400
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> My primary concern is scale and managing the list of objects over time.
>>
>> My fear is that this list will be quite large.  If we only want to omit
>> the very large blobs, then maybe not.  But if we want to expand that
>> scope to also omit other objects (such as a clone synchronized with a
>> sparse checkout), then that list will get large on large repos.  For
>> example, on the Windows repo we have (conservatively) 100M+ blobs (and
>> growing).  Assuming 28 bytes per, gives a 2.8GB list to be manipulated.
>>
>> If I understand your proposal, newly-omitted blobs would need to be
>> merged into the promised-blob list after each fetch.  The fetch itself
>> may not have that many new entries, but inserting them into the existing
>> list will be slow.  Also, mmap'ing and bsearch'ing will likely have
>> issues.  And there's likely to be a very expensive step to remove
>> entries from the list as new blobs are received (or locally created).
>>
>> In such a "sparse clone", it would be nice to omit unneeded tree objects
>> in addition to just blobs.   I say that because we are finding with GVFS
>> on the Windows repo, that even with commits-and-trees-only filtering,
>> the number of tree objects is overwhelming.
> 
> I know that discussion has shifted to the possibility of not having this
> list at all, and not sending size information together with the fetch,
> but going back to this...maybe omitting trees *is* the solution to both
> the large local list and the large amount of size information needing to
> be transferred.
> 
> So the large-blob (e.g. Android) and many-blob (e.g. Windows) cases
> would look like this:
> 
>   * Large-blob repositories have no trees omitted and a few blobs
>     omitted, and we have sizes for all of them.
>   * Many-blob repositories have many trees omitted and either all
>     blobs omitted (and we have size information for them, useful for FUSE
>     or FUSE-like things, for example) or possibly no blobs omitted (for
>     example, if shallow clones are going to be the norm, there won't be
>     many blobs to begin with if trees are omitted).

I'm not sure I understand what you're saying here.  Does omitting a tree
object change the set of blob sizes we receive?  Are you saying that if
we omit a tree, then we implicitly omit all the blobs it references and
don't send size info those blobs?  So that the local list only has
reachable objects?  So faulting-in a tree would also have to send size
info for the newly referenced blobs?

Would this make it more similar to a shallow clone (in that none of the
have_object tests work for items beyond the cut point) ?


> This seems better than an intermediate solution for the many-blob
> repository case in which we still keep all the trees but also try to
> avoid sending and storing as much information about the blobs as
> possible, because that doesn't seem to provide us with much savings
> (because the trees as a whole are just as large, if not larger, than the
> blob information).

Or are you saying that by omitting mostly-unused trees (and sending just
their sizes) we can shrink the packfile payload and therefore afford to
send the full set of blob sizes in the promises payload ?


>> So I'm also concerned about
>> limiting the list to just blobs.  If we need to have this list, it
>> should be able to contain any object.  (Suggesting having an object type
>> in the entry.)
> 
> This makes sense - I'll add it in.

Good.  That will solve some cases where the client is just asking if
we have an object and is it of type x.


>> I also have to wonder about the need to have a complete list of omitted
>> blobs up front.  It may be better to just relax the consistency checks
>> and assume a missing blob is "intentionally missing" rather than
>> indicating a corruption somewhere.  And then let the client do a later
>> round-trip to either demand-load the object -or- demand-load the
>> existence/size info if/when it really matters.
>>
>> Maybe we should add a verb to your new fetch-blob endpoint to just get
>> the size of one or more objects to help with this.
> 
> If we allow the omission of trees, I don't think the added complexity of
> demand-loading sizes is worth it.

As you suggested earlier, we're trying to solve 2 different problems.
The "few omitted very large blobs" and the "way too many unneeded blobs"
problems.

For the former case, if you just have a few omitted objects, then a
second round-trip to mget their sizes isn't that much work.

I think for the latter, forcing a full promise-list on clone is just
too much data to send -- data that we likely won't ever need.  If the
client can compute the promise-set from the received packfile, we can
do the "is an object and type" tests completely locally.  It's only
when the client asks for the size do we need to decide whether to fetch
just the size or fetch the actual object.  Either type of request
doesn't seem like that big of a deal.  But we save a lot of IO
(especially during the initial clone, when it hurts the most).

In both cases, we benefit by letting the client decide if/when it
wants them.  And whether it wants the full set or a subset.

I suppose we could make it an option for the upload-pack protocol
to send or not send the promise-set.  That feels a little like a
hack in that it is another knob we have to support, but would let
us work either way.

I think it would be better to have 2 round-trips.  We could also have
an fsck option to verify and back-fill missing sizes if you want to
be able to force them.


> What do you think of doing this:
>   * add a "type" field to the list of promised objects (formerly the list
>     of promised blobs)
>   * retain mandatory size for blobs
>   * retain single file containing list of promised objects (I don't feel
>     too strongly about this, but it has a slight simplicity and
>     in-between-GC performance advantage)
> 

The single promise-set is problematic.  I think it will grow too
large (in our case) and will need all the usual lock juggling
and merging.

I still prefer my suggestion for a per-packfile promise-set for all
of the reasons I stated the other day.  This can be computed quickly
during index-pack, is (nearly) read-only, and doesn't require the
whole file rewrite lock file.  It also has the benefit of being
portable -- in that I can also copy the .promise file if I copy the
.pack and .idx file to another repo.


So to summarize, I think we need:
* an object-list concept
      (that is, we believe that just assuming missing objects
       are "intentionally omitted" has issues.)
* an object-list-entry containing:
      {object-id,
       optional object-size,  (use -1 when unknown)
       object-type}
* server end-point for fetching 1 or more sizes
      (by sending 1 or more object-ids)
* server end-point for fetching 1 or more objects
      (by sending 1 or more object-ids)
      and receiving a packfile or loose object.
* per-packfile object-list (rather than single combined one).
* client-side (index-pack) compute of per-packfile object-list.
* repack to "do the right thing".

Optional:
* pack-protocol option.
* server-side (pack-objects) compute of per-packfile object-list.
* fsck to verify and back-fill all sizes using fetch-sizes.

Don't need:
* fetch-object or fetch-sizes end-points do not need to support
   requests for the set of objects referenced by a directory
   (recursively) from my earlier email.
       keep it simple and just explicitly list the object-ids wanted.
* the client side of fetch-object DOES NOT need to remove
   object-list-entries from the object-list.
       we must assume that the list will have false-positives
       in it as loose objects are created locally.


Thanks,
Jeff
