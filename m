Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3DC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 17:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A92613B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 17:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhD3Rht (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 13:37:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:38243 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhD3Rhs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 13:37:48 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 111963F4163;
        Fri, 30 Apr 2021 13:37:00 -0400 (EDT)
Received: from HCIPROD2.AZHCI.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A79643F4161;
        Fri, 30 Apr 2021 13:36:59 -0400 (EDT)
Subject: Re: [PATCH 12/23] fsmonitor--daemon: create token-based changed path
 cache
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <f1fa803ebe9c9f78608c22e55ec590f8c6775c94.1617291666.git.gitgitgadget@gmail.com>
 <df33c12b-ada3-05dc-3d17-6cc9d205b4cc@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ab661886-076c-4f8b-a65b-db54ca28d4a0@jeffhostetler.com>
Date:   Fri, 30 Apr 2021 13:36:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <df33c12b-ada3-05dc-3d17-6cc9d205b4cc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 4:22 PM, Derrick Stolee wrote:
...
>> +
>> +void fsmonitor_batch__add_path(struct fsmonitor_batch *batch,
>> +			       const char *path)
>> +{
>> +	const char *interned_path = strintern(path);
> 
> This use of interned paths is interesting, although I become
> concerned for the amount of memory we are consuming over the
> lifetime of the process. This could be considered as a target
> for future improvements, perhaps with an LRU cache or something
> similar.

Interning gives us a fixed pointer for any given path.  This
gives us a way to de-dup paths using just pointers rather than
string compares.

Yes, we will accumulate paths in that dictionary, but the set of
paths present in the typical working directory are usually pretty
fixed.

We only generate these for modified paths.  Users don't typically
create/modify/delete that many paths in their source trees during
normal development.

Compilers may generate lots of trash files in their worktree, but
those names are usually repeated (with each "make").  So we might
acculuate a lot of paths for a repo, it should become stable.
However, if they use temp files in the tree, it might invalidate
this statement.

WRT LRUs, that gets us into threading and lock contention problem
and ref-counting.  I have it designed such that parallel threads
read and send the current queue to the client without a lock.  They
only need a quick lock to get the current head pointer; the rest
is done lock free.  Also, purging from the end of the LRU would
put is in contention with the FS listener thread that is adding
new paths to the LRU.

So, yeah, maybe this is something to keep an eye on -- especially
in the monorepo case, but I don't think we need to address it now.

Thanks,
Jeff
