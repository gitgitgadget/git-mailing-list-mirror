Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE76C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 21:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B0264EFA
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 21:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhBXVP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 16:15:57 -0500
Received: from siwi.pair.com ([209.68.5.199]:51444 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232544AbhBXVPy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 16:15:54 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D13433F412C;
        Wed, 24 Feb 2021 16:15:12 -0500 (EST)
Received: from msranlcmt20.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A117C3F4107;
        Wed, 24 Feb 2021 16:15:12 -0500 (EST)
Subject: Re: [PATCH] dir: fix malloc of root untracked_cache_dir
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.884.git.1614177117508.gitgitgadget@gmail.com>
 <xmqqk0qxz0s5.fsf@gitster.g> <YDa/hT8g8FvmpXYT@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <581ece66-6a93-eda6-67bf-3bb49f553dfc@jeffhostetler.com>
Date:   Wed, 24 Feb 2021 16:15:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YDa/hT8g8FvmpXYT@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/21 4:05 PM, Jeff King wrote:
> On Wed, Feb 24, 2021 at 12:08:42PM -0800, Junio C Hamano wrote:
> 
>>> Use FLEX_ALLOC_STR() to allocate the `struct untracked_cache_dir`
>>> for the root directory.  Get rid of unsafe code that might fail to
>>> initialize the `name` field (if FLEX_ARRAY is not 1).  This will
>>> make it clear that we intend to have a structure with an empty
>>> string following it.
>> [...]
>> The problematic code was introduced in 2015, a year before these
>> FLEX_ALLOC_*() helpers were introduced.  The result is of course
>> correct and much easier to read, as the necessary "ask for a region
>> of calloc'ed memory with an additional byte for terminating NUL
>> beyond strlen()" is hidden in the helper.
> 
> When I added the FLEX_ALLOC_* helpers, I audited for existing callers to
> convert. But I did so by looking for places where we were doing manual
> size computations. The bug here was that it was not doing any
> computation at all (when it need to be doing "+1"). So that's my guess
> why it got overlooked (which is not super important, but may give a hint
> about how to look for similar bugs).


There's another call to xmalloc() at [1] that does the st_add3()
thing that I didn't change.  It was correctly computing the size
so I didn't want to change it for no reason.  That and the 2 memcpy()s
made it feel like we should have a different FLEX_ macro for this
case -- more of a FLEX_DUP... or something.  But I didn't want to
distract from my bug fix here.

[1] https://github.com/git/git/blob/master/dir.c#L3290

Jeff
