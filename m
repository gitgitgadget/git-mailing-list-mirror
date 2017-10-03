Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C6E202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 14:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbdJCOjU (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 10:39:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:56249 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751419AbdJCOjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 10:39:19 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 76B6D845E6;
        Tue,  3 Oct 2017 10:39:18 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 31242845E3;
        Tue,  3 Oct 2017 10:39:18 -0400 (EDT)
Subject: Re: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18
 patches)
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
 <CAP8UFD1WiceKDX9s0hszXXKy+TOxAOvHZyr002HMYkkgbFgD7w@mail.gmail.com>
 <xmqq8tgsipi5.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cb818dcf-beab-10ac-5e58-f56377af4f6a@jeffhostetler.com>
Date:   Tue, 3 Oct 2017 10:39:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tgsipi5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/3/2017 4:50 AM, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> Could you give a bit more details about the use cases this is designed for?
>> It seems that when people review my work they want a lot of details
>> about the use cases, so I guess they would also be interesting in
>> getting this kind of information for your work too.
>>
>> Could this support users who would be interested in lazily cloning
>> only one kind of files, for example *.jpeg?
> 
> I do not know about others, but the reason why I was not interested
> in finding out "use cases" is because the value of this series is
> use-case agnostic.
> 
> At least to me, the most interesting part of the series is that it
> allows you to receive a set of objects transferred from the other
> side that lack some of objects that would otherwise be required to
> be here for connectivity purposes, and it introduces a mechanism to
> allow object transfer layer, gc and fsck to work well together in
> the resulting repository that deliberately lacks some objects.  The
> transfer layer marks the objects obtained from a specific remote as
> such, and gc and fsck are taught not to try to follow a missing link
> or diagnose a missing link as an error, if a missing link is
> expected using the mark the transfer layer left.
> 
> and it does so in such a way that it is use-case agnostic.  The
> mechanism does not care how the objects to be omitted were chosen,
> and how the omission criteria were negotiated between the sender and
> the receiver of the pack.
> 
> I think the series comes with one filter that is size-based, but I
> view it as a technology demonstration.  It does not have to be the
> primary use case.  IOW, I do not think the series is meant as a
> declaration that size-based filtering is the most important thing
> and other omission criteria are less important.
> 
> You should be able to build path based omission (i.e. narrow clone)
> or blobtype based omission.  Depending on your needs, you may want
> different object omission criteria.  It is something you can build
> on top.  And the work done on transfer/gc/fsck in this series does
> not have to change to accommodate these different "use cases".
> 

Agreed.

There are lots of reasons for wanting partial clones (and we've been
flinging lots of RFCs at each other that each seem to have a different
base assumption (small-blobs-only vs sparse-checkout vs <whatever>))
and not reaching consensus or closure.

The main thing is to allow the client to use partial clone to request
a "subset", let the server deliver that "subset", and let the client
tooling deal with an incomplete view of the repo.

As I see it there are the following major parts to partial clone:
1. How to let git-clone (and later git-fetch) specify the desired
    subset of objects that it wants?  (A ref-relative request.)
2. How to let the server and git-pack-objects build that incomplete
    packfile?
3. How to remember in the local config that a partial clone (or
    fetch) was used and that missing object should be expected?
4. How to dynamically fetch individual missing objects individually?
     (Not a ref-relative request.)
5. How to augment the local ODB with partial clone information and
    let git-fsck (and friends) perform limited consistency checking?
6. Methods to bulk fetching missing objects (whether in a pre-verb
    hook or in unpack-tree)
7. Miscellaneous issues (e.g. fixing places that accidentally cause
    a missing object to be fetched that don't really need it).

My proposal [1] includes a generic filtering mechanism that handles 3
types of filtering and makes it easy to add other techniques as we
see fit.  It slips in at the list-objects / traverse_commit_list
level and hides all of the details from rev-list and pack-objects.
I have a follow on proposal [2] that extends the filtering parameter
handling to git-clone, git-fetch, git-fetch-pack, git-upload-pack
and the pack protocol.  That takes care of items 1 and 2 above.

Jonathan's proposal [3] includes code to update the local config,
dynamically fetch individual objects, and handle the local ODB and
fsck consistency checking.  That takes care of items 3, 4, and 5.

As was suggested above, I think we should merge our efforts:
using my filtering for 1 and 2 and Jonathan's code for 3, 4, and 5.
I would need to eliminate the "relax" options in favor of his
is_promised() functionality for index-pack and similar.  And omit
his blob-max-bytes changes from pack-objects, the protocol and
related commands.

That should be a good first step.

We both have thoughts on bulk fetching (mine in pre-verb hooks and
his in unpack-tree).  We don't need this immediately, but can wait
until the above is working to revisit.

[1] https://github.com/jeffhostetler/git/pull/3
[2]https://github.com/jeffhostetler/git/pull/4
[3] https://github.com/jonathantanmy/git/tree/partialclone3

Thoughts?

Thanks,
Jeff
