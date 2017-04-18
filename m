Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25971FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 16:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbdDRQT3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 12:19:29 -0400
Received: from siwi.pair.com ([209.68.5.199]:40979 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbdDRQT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 12:19:27 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B6F028454B;
        Tue, 18 Apr 2017 12:19:26 -0400 (EDT)
Subject: Re: [PATCH v10 3/3] read-cache: speed up add_index_entry during
 checkout
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <20170414191230.52825-1-git@jeffhostetler.com>
 <20170414191230.52825-4-git@jeffhostetler.com>
 <d9f1acc8-03e3-abc6-af9d-da55a33218fa@web.de>
 <28ef82b9-ab7a-ccaf-7bae-4eaa332725f8@jeffhostetler.com>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <42739319-599f-b761-bfaa-9563e427ae8f@jeffhostetler.com>
Date:   Tue, 18 Apr 2017 12:19:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <28ef82b9-ab7a-ccaf-7bae-4eaa332725f8@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/17/2017 10:53 AM, Jeff Hostetler wrote:
>
>
> On 4/15/2017 1:55 PM, René Scharfe wrote:
>> Am 14.04.2017 um 21:12 schrieb git@jeffhostetler.com:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Very nice, especially the perf test!  But can we unbundle the different
>> optimizations into separate patches with their own performance numbers?
>> Candidates IMHO: The change in add_index_entry_with_check(), the first
>> hunk in has_dir_name(), the loop shortcuts.  That might also help find
>> the reason for the slight slowdown of 0006.3 for the kernel repository.
>
> Let me take a look at this and see if it helps.

Last night I pushed up version 11 which has the 3 parts
of read-cache.c in 3 commits (but still in the same patch
series).  This should allow for more experimentation.

The add_index_entry_with_check() shows a gain.  For the
operations in p0006 on linux.git, the short-cut was being
taken 57993 of 57994 times.

The top of has_dir_name() -- by itself -- does not, but
the short-cut only triggers when the paths have no
prefix in common -- which only happens when the top-level
directory changes.  On linux.git, this was 19 of 57993.
However, it does set us up for the next part.

The 3 loop body short-cuts hit 54372, 3509, and 86 (sum
57967) times.  So in p0006, the search was only attempted
7 times (57993 - 19 - 57967) most of the time.


WRT the slowdown of 0006.3 on linux.git, I suspect this is
I/O noise.  In the commit message for part 2 in V11, I
show 2 runs on linux.git that show wide variance in the 0006.3
times.  And given the nature of that test, the speed up in the
lookups is completely hidden by the I/O of the full checkouts.
When I step up to a repo with 4M files, the results are very
clear.

https://public-inbox.org/git/20170417213734.55373-6-git@jeffhostetler.com/


