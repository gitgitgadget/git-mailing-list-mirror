Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819532047F
	for <e@80x24.org>; Wed, 27 Sep 2017 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdI0REp (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 13:04:45 -0400
Received: from siwi.pair.com ([209.68.5.199]:28551 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdI0REo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 13:04:44 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B15B084607;
        Wed, 27 Sep 2017 13:04:43 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 604FD84604;
        Wed, 27 Sep 2017 13:04:43 -0400 (EDT)
Subject: Re: [PATCH 03/13] list-objects: filter objects in
 traverse_commit_list
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
References: <20170922202632.53714-1-git@jeffhostetler.com>
 <20170922202632.53714-4-git@jeffhostetler.com>
 <20170926153141.6a8d7e5024eeed5bbda838c8@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d5de0eda-18aa-a796-e7d0-d536d2e59605@jeffhostetler.com>
Date:   Wed, 27 Sep 2017 13:04:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170926153141.6a8d7e5024eeed5bbda838c8@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/26/2017 6:31 PM, Jonathan Tan wrote:
> On Fri, 22 Sep 2017 20:26:22 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create traverse_commit_list_filtered() and add filtering
> 
> You mention _filtered() here, but this patch contains _worker().

thanks.

  
>>   list-objects.h | 30 ++++++++++++++++++++++++++
>>   2 files changed, 80 insertions(+), 16 deletions(-)
>>
>> diff --git a/list-objects.c b/list-objects.c
>> index b3931fa..3e86008 100644
>> --- a/list-objects.c
>> +++ b/list-objects.c
>> @@ -13,10 +13,13 @@ static void process_blob(struct rev_info *revs,
>>   			 show_object_fn show,
>>   			 struct strbuf *path,
>>   			 const char *name,
>> -			 void *cb_data)
>> +			 void *cb_data,
>> +			 filter_object_fn filter,
>> +			 void *filter_data)
> 
> I had some thoughts about modifying "show" (instead of adding "filter",
> as you have done in this patch) to indicate to the caller that the
> corresponding object should not be marked "seen". That does have the
> advantage that we don't have so many callbacks flying around, but it
> also makes things more complicated, so I don't know which is better.

I wanted the filtering function to be independent of the showing function.
As you can see in pack-objects.c and rev-list.c:  All I needed to change
there was to call the new version of the traverse code and not alter the
show function.  The filtering is completely isolated inside the traverse
code.

It also means that the filtering code can do higher-level filtering.
Currently, the show-object callback gets called with each terminal node
(blob) and it has already lost any chance for tree-level optimizations.
The filtering code participates in the treewalk on the commit and can do
subtree elimination.
  
> 
>> +	if (filter) {
>> +		r = filter(LOFT_END_TREE, obj, base->buf, &base->buf[baselen], filter_data);
>> +		if (r & LOFR_MARK_SEEN)
>> +			obj->flags |= SEEN;
>> +		if (r & LOFR_SHOW)
>> +			show(obj, base->buf, cb_data);
>> +	}
> 
> This LOFT_END_TREE was added to support the code in
> list-objects-filter-sparse - would it be OK to completely remove the
> optimization involving the "provisional" omission of blobs? (I don't
> think the exact same tree object will occur multiple times often.) If
> yes, then I think this block can be removed too and will simplify the
> code.

The sparse filter is looking at pathnames and using the same rules
as sparse-checkout to decide which to *include* in the result.  This
is essentially backwards from the other filters which are looking for
reasons to *exclude* a blob.  If I see a {pathname, sha} pair and the
pathname is not wanted (by the sparse-checkout rules), I still don't
know anything about the object -- since the same SHA may appear later
in the treewalk but with a different pathname that *does* match the
patterns and *is* wanted.

The net-net is that I have to mark the blob as "provisionally omitted"
until I've seen all the pathnames associated with it.  Only then can I
say it should be omitted.

Likewise, there are things about the tree object that we cannot
decide until we've seen all possible directory paths that reference it.
For example, if you rename a tree/directory between 2 commits, but make no
other changes within the directory, it will/should have the same SHA in the
second commit.  If one of those paths is included in the sparse-checkout
and one is not, then you need include those blobs (and the tree object)
in the result.  If the treewalk visits the excluded case first, you don't
want to discard the tree object (and shortcut future treewalks) because
the filter won't get a chance to see the included directory path case.

Also, the current code does not attempt to omit tree objects, but a
future version may.  And having the _BEGIN_ and _END_ events means the
filter can keep track of the nesting without the expense of having to
discover it by parsing the pathname looking for slashes as we do elsewhere.

> 
>> +/* See object.h and revision.h */
>> +#define FILTER_REVISIT (1<<25)
> 
> If you do add this, also update object.h. But I don't think this is the
> right place to do it - it's probably better in
> list-objects-filter-sparse.
> 
>> +typedef enum list_objects_filter_result list_objects_filter_result;
>> +typedef enum list_objects_filter_type list_objects_filter_type;
> 
> I don't think Git style is to typedef enums.
> 
>> +void traverse_commit_list_worker(
>> +	struct rev_info *,
>> +	show_commit_fn, show_object_fn, void *show_data,
>> +	filter_object_fn filter, void *filter_data);
> 
> Here (and throughout), as far as I can tell, the style is to indent to
> the character after the opening parenthesis.
> 

right. thanks.

