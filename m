Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CA72047F
	for <e@80x24.org>; Wed, 27 Sep 2017 19:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbdI0TJq (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 15:09:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:21404 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbdI0TJp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 15:09:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7E7B78462D;
        Wed, 27 Sep 2017 15:09:44 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 349C28462B;
        Wed, 27 Sep 2017 15:09:44 -0400 (EDT)
Subject: Re: [PATCH 03/13] list-objects: filter objects in
 traverse_commit_list
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
References: <20170922202632.53714-1-git@jeffhostetler.com>
 <20170922202632.53714-4-git@jeffhostetler.com>
 <20170926153141.6a8d7e5024eeed5bbda838c8@google.com>
 <d5de0eda-18aa-a796-e7d0-d536d2e59605@jeffhostetler.com>
 <20170927110007.9ee2f725c01f0c7465838c04@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1577b87b-d6de-1434-930a-83fde384d4ca@jeffhostetler.com>
Date:   Wed, 27 Sep 2017 15:09:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170927110007.9ee2f725c01f0c7465838c04@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/27/2017 2:00 PM, Jonathan Tan wrote:
> On Wed, 27 Sep 2017 13:04:42 -0400
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> The sparse filter is looking at pathnames and using the same rules
>> as sparse-checkout to decide which to *include* in the result.  This
>> is essentially backwards from the other filters which are looking for
>> reasons to *exclude* a blob.  If I see a {pathname, sha} pair and the
>> pathname is not wanted (by the sparse-checkout rules), I still don't
>> know anything about the object -- since the same SHA may appear later
>> in the treewalk but with a different pathname that *does* match the
>> patterns and *is* wanted.
>>
>> The net-net is that I have to mark the blob as "provisionally omitted"
>> until I've seen all the pathnames associated with it.  Only then can I
>> say it should be omitted.
> 
> How is this different from refraining from marking the blob as
> LOFR_MARK_SEEN? When you would provisionally omit the blob, return
> LOFR_ZERO so that a future iteration will revisit the blob again, and
> when you would include it in the output, return
> LOFR_MARK_SEEN|LOFR_SHOW.

By adding it to the set of provisionally omitted objects, we
have the option to capture a little extra information with it
and refer to that the next time we see the object in the traversal.
For example, in the sparse-checkout case, the first time we see the
object we know the pathname and know that it does not need to be
included.  The second time we see that object, we can see if the
new pathname is the same as the previous one with a simple strcmp
and avoid the expensive is_excluded_from_list() computation.  Keep
in mind that rev-list or pack-objects could be called be on something
like HEAD~100000..HEAD or that there may be 50,000 tips.  So a file
that doesn't change across that range will be visited many times
with the same {pathname, sha}.

Then when the traversal is finished, we have a resulting set of
(now actually) omitted objects.  Which we can iterate over if the
caller is interested in.

> 
>> Likewise, there are things about the tree object that we cannot
>> decide until we've seen all possible directory paths that reference it.
>> For example, if you rename a tree/directory between 2 commits, but make no
>> other changes within the directory, it will/should have the same SHA in the
>> second commit.  If one of those paths is included in the sparse-checkout
>> and one is not, then you need include those blobs (and the tree object)
>> in the result.  If the treewalk visits the excluded case first, you don't
>> want to discard the tree object (and shortcut future treewalks) because
>> the filter won't get a chance to see the included directory path case.
> 
> For trees, I guess it's slightly different in that you do need an extra
> flag to keep track of whether the tree has been shown. So mark SHOWN and
> return LOFR_SHOW on the first time the tree is shown, and LOFR_ZERO
> otherwise. And trees must never be marked as LOFR_MARK_SEEN.

Right now I want to force the tree to be shown the first time it is
visited (because I don't want to do tree filtering yet).  I don't mark
it SEEN yet because we may want to revisit blobs within (say, after a
folder rename like I described previously).

I do, however, mark the tree object as SEEN (in the _END event) when I
can verify that I've included ALL of the children.

So it might be possible that I could change the flags and not use
FILTER_REVISIT on tree objects, I hesitate to do that right now.


Having the FILTER_REVISIT flag on blob objects means I can avoid
doing a hash/oidset lookup on subsequent visits.

  
> (This SHOWN flag might play a similar role to your FILTER_REVISIT.)
> 
> Until now, it seems to me that the _END event is not required.
> 
>> Also, the current code does not attempt to omit tree objects, but a
>> future version may.  And having the _BEGIN_ and _END_ events means the
>> filter can keep track of the nesting without the expense of having to
>> discover it by parsing the pathname looking for slashes as we do elsewhere.
> 
> A feature that omits tree objects would need _END, true. But until
> then, I personally don't think we should add such infrastructure until
> we have a feature that needs it.

The sparse filter is using the _END now to try to help shortcut the
treewalk (when all referenced objects within it are known to already
be included).

The _END event's role may expand with a 4th filter that also filters
tree objects, but I don't want to eliminate it right now.

Thanks
Jeff


