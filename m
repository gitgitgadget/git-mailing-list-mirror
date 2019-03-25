Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D2420248
	for <e@80x24.org>; Mon, 25 Mar 2019 17:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfCYRSX (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 13:18:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:24917 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbfCYRSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 13:18:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7B6D63F4023;
        Mon, 25 Mar 2019 13:18:21 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:9c07:30b3:cc1f:41dc] (unknown [IPv6:2001:4898:8010:2:853b:30b3:cc1f:41dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 30A393F4022;
        Mon, 25 Mar 2019 13:18:21 -0400 (EDT)
Subject: Re: [PATCH v3 0/4] multi-pack-index: fix verify on large repos
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
References: <pull.166.v2.git.gitgitgadget@gmail.com>
 <pull.166.v3.git.gitgitgadget@gmail.com>
 <xmqqy357pizb.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2eaa3617-326d-4f26-6bc0-7192a12ab192@jeffhostetler.com>
Date:   Mon, 25 Mar 2019 13:18:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqy357pizb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/2019 1:37 AM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Teach "multi-pack-index verify" to handle cases where the number of
>> packfiles exceeds the open file handle limit.
>>
>> The first commit fixes a problem that prevented the LRU-style
>> close_one_pack() mechanism from working which caused midx verify to run out
>> of file descriptors.
>>
>> The second commit teaches midx verify to sort the set of objects to verify
>> by packfile rather than verifying them in OID order. This eliminates the
>> need to have more than one packfile/idx open at the same time.
>>
>> With the second commit, runtime on 3600 packfiles went from 12 minutes to 25
>> seconds.
> 
> These reference to the first and second commit might have become
> stale across interations, but logically it makes sense---the first
> point is about correctness (i.e. do not die by running out of fds)
> and the second one is about usable-performance.
> 
> But in this round (possibly in the previous one, too?) the "group
> objects by packfile" one addresses both points?
> 


Sorry, I forgot to remote the stale content in the cover letter for
the V3 version.

This version just has the sorting by packfile commit and because it only
keeps 1 packfile open at a time, it does not need the change to add 
packfiles to the packed-git list because it does not trigger the
close_one_pack() problem.

We suspect there are other places (not-yet-observed) where the design of
the all-packs and packed-git lists will lead to similar fd exhaustion
errors and want to fix it properly in the packfile and/or midx code.
We'll address this potential problem in a future patch series.

Jeff
