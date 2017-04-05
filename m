Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E6620966
	for <e@80x24.org>; Wed,  5 Apr 2017 21:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934293AbdDEVMt (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 17:12:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:43002 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755985AbdDEVMp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 17:12:45 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A2728845D0;
        Wed,  5 Apr 2017 17:12:43 -0400 (EDT)
Subject: Re: [PATCH v1 1/2] string-list: use ALLOC_GROW macro when reallocing
 string_list
To:     Jeff King <peff@peff.net>
References: <20170405195600.54801-1-git@jeffhostetler.com>
 <20170405195600.54801-2-git@jeffhostetler.com>
 <20170405200954.jmjvuzwjploenbho@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e805dfdd-12a4-cb70-d4e6-b5af915d29b5@jeffhostetler.com>
Date:   Wed, 5 Apr 2017 17:12:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170405200954.jmjvuzwjploenbho@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/5/2017 4:09 PM, Jeff King wrote:
> On Wed, Apr 05, 2017 at 07:55:59PM +0000, git@jeffhostetler.com wrote:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Use ALLOC_GROW() macro when reallocing a string_list array
>> rather than simply increasing it by 32.  This is a performance
>> optimization.
>>
>> During status on a very large repo and there are many changes,
>> a significant percentage of the total run time was spent
>> reallocing the wt_status.changes array.
>>
>> This change decreased the time in wt_status_collect_changes_worktree()
>> from 125 seconds to 45 seconds on my very large repository.
>
> Oof. Looks like the original was quadratic. I'm surprised this didn't
> bite us more often. I guess we don't usually use string-lists for big
> lists.

To be fair, I was playing with a repo with 3M files
and I think realloc() is more efficient on Linux, so
I'm not surprised that we haven't seen it even with
repos the size of linux.git.

>
> Aside from the redundant size-check that Stefan pointed out, the patch
> looks obviously correct. I grepped for "alloc +=" and "alloc =.*+' to
> see if there were any other cases, but didn't find any. Obviously that
> is dependent on calling the variable "alloc", but that is normal for us
> (and it does turn up a number of cases that do allocate correctly).
>
> -Peff
>
