Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EF01F419
	for <e@80x24.org>; Wed, 13 Dec 2017 22:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbdLMWeo (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 17:34:44 -0500
Received: from siwi.pair.com ([209.68.5.199]:43392 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbdLMWen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 17:34:43 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A1891844CB;
        Wed, 13 Dec 2017 17:34:42 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5A837844C6;
        Wed, 13 Dec 2017 17:34:42 -0500 (EST)
Subject: Re: [PATCH] partial-clone: design doc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171208192636.13678-1-git@jeffhostetler.com>
 <20171208192636.13678-2-git@jeffhostetler.com>
 <xmqqzi6t6kpe.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f3750af4-1343-65a6-2913-a21840e4db89@jeffhostetler.com>
Date:   Wed, 13 Dec 2017 17:34:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi6t6kpe.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/8/2017 3:14 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> First draft of design document for partial clone feature.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
> 
> Thanks.
> 
>> +Non-Goals
>> +---------
>> +
>> +Partial clone is independent of and not intended to conflict with
>> +shallow-clone, refspec, or limited-ref mechanisms since these all operate
>> +at the DAG level whereas partial clone and fetch works *within* the set
>> +of commits already chosen for download.
> 
> It probably is not a huge deal (simply because it is about
> "Non-Goals") but I have no idea what "refspec" and "limited-ref
> mechanism" refer to in the above sentence, and I suspect many others
> share the same puzzlement.

I'll reword this.  There was a question on the list earlier about
having a filter for commits in addition to ones for blobs and trees.

I just wanted to emphasize that we already have ways to filter or
limit commits using --shallow-* or --single-branch in clone and 1 or
more '<refspec>' args in fetch.

  
>> +An object may be missing due to a partial clone or fetch, or missing due
>> +to repository corruption. To differentiate these cases, the local
>> +repository specially indicates packfiles obtained from the promisor
>> +remote. These "promisor packfiles" consist of a "<name>.promisor" file
>> +with arbitrary contents (like the "<name>.keep" files), in addition to
>> +their "<name>.pack" and "<name>.idx" files. (In the future, this ability
>> +may be extended to loose objects[a].)
>> + ...
>> +Foot Notes
>> +----------
>> +
>> +[a] Remembering that loose objects are promisor objects is mainly
>> +    important for trees, since they may refer to promisor blobs that
>> +    the user does not have.  We do not need to mark loose blobs as
>> +    promisor because they do not refer to other objects.
> 
> I fail to see any logical link between the "loose" and "tree".
> Putting it differently, I do not see why "tree" is so special.
> 
> A promisor pack that contains a tree but lacks blobs the tree refers
> to would be sufficient to let us remember that these missing blobs
> are not corruption.  A loose commit or a tag that is somehow marked
> as obtained from a promisor, if it can serve just like a commit or a
> tag in a promisor pack to promise its direct pointee, would equally
> be useful (if very inefficient).
> 
> In any case, I suspect "since they may refer to promisor blobs" is a
> typo of "since they may refer to promised blobs".

right. good point. i was only thinking about the tree==>blob
relationship.


> 
>> +- Currently, dynamic object fetching invokes fetch-pack for each item
>> +  because most algorithms stumble upon a missing object and need to have
>> +  it resolved before continuing their work.  This may incur significant
>> +  overhead -- and multiple authentication requests -- if many objects are
>> +  needed.
>> +
>> +  We need to investigate use of a long-running process, such as proposed
>> +  in [5,6] to reduce process startup and overhead costs.
> 
> Also perhaps in some operations we can enumerate the objects we will
> need upfront and ask for them in one go (e.g. "git log -p A..B" may
> internally want to do "rev-list --objects A..B" to enumerate trees
> and blobs that we may lack upfront).  I do not think having the
> other side guess is a good idea, though.

right.

> 
>> +- We currently only promisor packfiles.  We need to add support for
>> +  promisor loose objects as described earlier.
> 
> The earlier description was not convincing enough to feel the need
> to me; at least not yet.

It seems like we need it if a promisor packfile gets unpacked for any
reason.  But right, I'm not sure how urgent it is.


Thanks
Jeff


