Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C90C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235A16136F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhHWSTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:19:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:13258 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhHWSTi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 14:19:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6A3183F47FA;
        Mon, 23 Aug 2021 14:18:55 -0400 (EDT)
Received: from RUN-100764.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 010AF3F47F8;
        Mon, 23 Aug 2021 14:18:54 -0400 (EDT)
Subject: Re: [PATCH] sparse-index: copy dir_hash in ensure_full_index()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
 <87h7fgfdah.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8058589d-f84f-2fdc-6057-8242cde9df61@jeffhostetler.com>
Date:   Mon, 23 Aug 2021 14:18:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87h7fgfdah.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/23/21 10:25 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Aug 16 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Copy the 'index_state->dir_hash' back to the real istate after expanding
>> a sparse index.
>>
>> A crash was observed in 'git status' during some hashmap lookups with
>> corrupted hashmap entries.  During an index expansion, new cache-entries
>> are added to the 'index_state->name_hash' and the 'dir_hash' in a
>> temporary 'index_state' variable 'full'.  However, only the 'name_hash'
>> hashmap from this temp variable was copied back into the real 'istate'
>> variable.  The original copy of the 'dir_hash' was incorrectly
>> preserved.  If the table in the 'full->dir_hash' hashmap were realloced,
>> the stale version (in 'istate') would be corrupted.
>>
>> The test suite does not operate on index sizes sufficiently large to
>> trigger this reallocation, so they do not cover this behavior.
>> Increasing the test suite to cover such scale is fragile and likely
>> wasteful.
> 
> How large does the index need to be to trigger this? I don't know if a
> test here is useful, but FWIW if we had such a test then the EXPENSIVE
> prereq + GIT_TEST_LONG=true might be a good fit for it.
> 

There would need to be enough directories in the repo to cause
the dir_hash to grow during an insert into the dir_hash.
IIRC the hashmap table is initialized to 64 and auto reallocs when
it hits 80% capacity, so somewhere in the area of 50 directories
at minimum.

Whether the error is observed would also depend on free() trashing
the contents of the memory and/or whether the memory was recycled
by something else.

Jeff

