Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0252320282
	for <e@80x24.org>; Fri, 23 Jun 2017 17:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbdFWRQe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 13:16:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:41850 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754141AbdFWRQe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 13:16:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3868084597;
        Fri, 23 Jun 2017 13:16:33 -0400 (EDT)
Received: from [10.160.98.126] (unknown [167.220.148.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AC88484592;
        Fri, 23 Jun 2017 13:16:31 -0400 (EDT)
Subject: Re: [PATCH 1/3] list-objects: add filter_blob to traverse_commit_list
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <20170622203615.34135-1-git@jeffhostetler.com>
 <20170622203615.34135-2-git@jeffhostetler.com>
 <20170622144526.3f5813f5@twelve2.svl.corp.google.com>
 <20170622151028.07827b50@twelve2.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <72257781-5a2c-cdd6-3fb3-7c5e6d883653@jeffhostetler.com>
Date:   Fri, 23 Jun 2017 13:16:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170622151028.07827b50@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/22/2017 6:10 PM, Jonathan Tan wrote:
> On Thu, 22 Jun 2017 14:45:26 -0700
> Jonathan Tan <jonathantanmy@google.com> wrote:
> 
>> On Thu, 22 Jun 2017 20:36:13 +0000
>> Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> In preparation for partial/sparse clone/fetch where the
>>> server is allowed to omit large/all blobs from the packfile,
>>> teach traverse_commit_list() to take a blob filter-proc that
>>> controls when blobs are shown and marked as SEEN.
>>>
>>> Normally, traverse_commit_list() always marks visited blobs
>>> as SEEN, so that the show_object() callback will never see
>>> duplicates.  Since a single blob OID may be referenced by
>>> multiple pathnames, we may not be able to decide if a blob
>>> should be excluded until later pathnames have been traversed.
>>> With the filter-proc, the automatic deduping is disabled.
>>
>> Comparing this approach (this patch and the next one) against mine [1],
>> I see that this has the advantage of (in pack-objects) avoiding the
>> invocation of add_preferred_base_object() on blobs that are filtered
>> out, avoiding polluting the "to_pack" data structure with information
>> that we do not need.
>>
>> But it does add an extra place where blobs are filtered out (besides
>> add_object_entry()), which makes it harder for the reader to keep track
>> of what's going on. I took a brief look to see if filtering could be
>> eliminated from add_object_entry(), but that function is called from
>> many places, so I couldn't tell.
>>
>> Anyway, I think both approaches will work (this patch's and mine [1]).
>>
>> [1] https://public-inbox.org/git/6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com/
> 
> Also it should be mentioned somewhere that this does not cover the
> bitmap case - a similar discussion should be included in one of the
> patches, like I did in [1].
> 
> And looking back at my original cover letter [2], I wrote:
> 
>> This is similar to [1] except that this
> [...]
>> is slightly more comprehensive in
>> that the read_object_list_from_stdin() codepath is also covered in
>> addition to the get_object_list() codepath. (Although, to be clear,
>> upload-pack always passes "--revs" and thus only needs the
>> get_object_list() codepath).
> 
> (The [1] in the quote above refers to one of Jeff Hostetler's patches,
> [QUOTE 1].)
> 
> The same issue applies to this patch (since
> read_object_list_from_stdin() invokes add_object_entry() directly
> without going through the traversal mechanism) and probably warrants at
> least some description in one of the commit messages.
> 
> [1] https://public-inbox.org/git/6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com/
> [2] https://public-inbox.org/git/cover.1496361873.git.jonathantanmy@google.com/
> 
> [QUOTE 1] https://public-inbox.org/git/1488994685-37403-3-git-send-email-jeffhost@microsoft.com/
> 


Thanks for the quick feedback.  I'll dig into each of these comments
as I work on my next draft.

Jeff
