Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709D31F462
	for <e@80x24.org>; Fri,  7 Jun 2019 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfFGR6K (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 13:58:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:42083 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731052AbfFGR6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 13:58:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 83BF23F47F8;
        Fri,  7 Jun 2019 13:58:08 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:5d6e:aba4:2027:955c] (unknown [IPv6:2001:4898:a800:1012:ea2:aba4:2027:955c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D731B3F4135;
        Fri,  7 Jun 2019 13:58:07 -0400 (EDT)
Subject: Re: [PATCH v2 4/9] list-objects-filter: implement composite filters
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com, Junio C Hamano <gitster@pobox.com>
References: <20190601003603.90794-1-matvore@google.com>
 <20190601003603.90794-5-matvore@google.com>
 <0005347e-ceed-ac9e-ad0d-b7b11bc55d38@jeffhostetler.com>
 <20190606223251.GA7246@comcast.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5dc58484-b206-dfe0-981a-437d0a162444@jeffhostetler.com>
Date:   Fri, 7 Jun 2019 13:58:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606223251.GA7246@comcast.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/6/2019 6:32 PM, Matthew DeVore wrote:
> On Mon, Jun 03, 2019 at 05:51:28PM -0400, Jeff Hostetler wrote:
>> Since we are assuming 'compose' is an AND operation, there may be an
>> opportunity to short-cut some of this loop for blobs.  That is, if the
>> object is a blob and any filter rejects it, it is omitted, so we don't
>> need to keep looping for that object.  (Tree objects cannot be short-cut
>> this way because a tree may appear at different depths or in different
>> sparse "cones" and may have to be reconsidered.)
> 
> Blobs are also treated almost the same way as tree objects in tree:<depth>
> filters - they can be included by tree:<depth> - so they also need to be
> reconsidered when found at different depths.
> 
> But I agree it's always true that if some prior filter has excluded a blob, the
> later filters don't even need to be *called at all* for that blob, unless
> perhaps it's found under a different tree later. I also think it may be too
> early to implement this optimization, since filter in a later release may just
> want to "know" about a blob even if it must be excluded in the final result.
> 
> Does the optimization apply to trees as well? Does a tree:<depth> filter still
> want to consider children of tree X if tree X has already been excluded by
> another filter? If it doesn't want to consider, we can short-circuit the checks
> very aggressively. If it does want to consider, we want the short-circuiting to
> be customizable at least for trees.
> 
> A minor point - I don't think that short-circuiting the for loop (breaking out
> early) is important, since it will be very rare that a combine: filter has more
> than 4 or so sub-filters anyway. Calling the filter_fn implementation and
> letting that do internal short-circuiting (informed by the previous filters'
> results) can, however, skip a lot of computation.
> 
>> So you could add an "affects blobs only" bit to the per-filter data
>> and try this out.  For example a "compose:blob:none+sparse:foo" should
>> perform better than "compose:sparse:foo+blob:none" but give the same
>> results.
> 
> Does "affects blobs only" mean the filter includes all non-blob objects?
> 

I just meant that the blobs:none and blobs:limit filters give you a hard
omit.  Other filters later in the chain cannot change or override that
answer (because of the AND assumption); it doesn't matter how deep or
shallow the blob is the tree.

In the case of the tree:depth filter, a blob deep in the tree should
be provisionally omitted in case it appears later in a shallow tree
and should be included.  The tree filter can't do a hard omit on a blob
(just like it can't do a hard omit on a tree node).

WRT your question about a later filter "just wanting to know" about
a blob, I'm not sure.

So yeah, let's wait on this.  We can always add it later as an
optimization if/when it becomes a perf problem (and we have more
experience using them in practice).

Jeff


