Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5282820A26
	for <e@80x24.org>; Thu, 21 Sep 2017 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdIUR7p (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 13:59:45 -0400
Received: from siwi.pair.com ([209.68.5.199]:44589 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbdIUR7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 13:59:44 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4099A845D1;
        Thu, 21 Sep 2017 13:59:44 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C1068845CF;
        Thu, 21 Sep 2017 13:59:43 -0400 (EDT)
Subject: Re: RFC: Design and code of partial clones (now, missing commits and
 trees OK) (part 2/3)
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     peartben@gmail.com, Christian Couder <christian.couder@gmail.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5d295ab3-310e-321e-6e88-69484eb9ce8a@jeffhostetler.com>
Date:   Thu, 21 Sep 2017 13:59:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(part 2)

Additional overall comments on:
https://github.com/jonathantanmy/git/commits/partialclone2

{} I think it would help to split the blob-max-bytes filtering and the
    promisor/promised concepts and discuss them independently.

    {} Then we can talk about about the promisor/promised functionality
       independent of any kind of filter.  The net-net is that the client
       has missing objects and it doesn't matter what filter criteria
       or mechanism caused that to happened.

    {} blob-max-bytes is but one such filter we should have.  This might
       be sufficient if the goal is replace LFS (where you rarely ever
       need any given very very large object) and dynamically loading
       them as needed is sufficient and the network round-trip isn't
       too much of a perf penalty.

    {} But if we want to do things like a "sparse-enlistments" where the
       client only needs a small part of the tree using sparse-checkout.
       For example, only populating 50,000 files from a tree of 3.5M files
       at HEAD, then we need a more general filtering.

    {} And as I said above, how we chose to filter should be independent
       of how the client handles promisor/promised objects.


{} Also, if we rely strictly on dynamic object fetching to fetch missing
    objects, we are effectively tethered to the server during operations
    (such as checkout) that the user might not think about as requiring
    a network connection.  And we are forced to keep the same limitations
    of LFS in that you can't prefetch and go offline (without actually
    checking out to your worktree first).  And we can't bulk or parallel
    fetch objects.


{} I think it would also help to move the blob-max-bytes calculation out
    of pack-objects.c : add_object_entry() [1].  The current code isolates
    the computation there so that only pack-objects can do the filtering.

    Instead, put it in list-objects.c and traverse_commit_list() so that
    pack-objects and rev-list can share it (as Peff suggested [2] in
    response to my first patch series in March).

    For example, this would let the client have a pre-checkout hook, use
    rev-list to compute the set of missing objects needed for that commit,
    and pipe that to a command to BULK fetch them from the server BEFORE
    starting the actual checkout.  This would allow the savy user to
    manually run a prefetch before going offline.

[1] https://github.com/jonathantanmy/git/commit/68e529484169f4800115c5a32e0904c25ad14bd8#diff-a8d2c9cf879e775d748056cfed48440cR1110

[2] https://public-inbox.org/git/20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net/


{} This also locks us into size-only filtering and makes it more
    difficult to add other filters.  In that the add_object_entry()
    code gets called on an object after the traversal has decided
    what to do with it.  It would be difficult to add tree-trimming
    at this level, for example.


{} An early draft of this type of filtering is here [3].  I hope to push
    up a revised draft of this shortly.

[3] https://public-inbox.org/git/20170713173459.3559-1-git@jeffhostetler.com/


Thanks,
Jeff

