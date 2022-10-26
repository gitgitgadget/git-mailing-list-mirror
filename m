Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78877C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 18:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiJZS3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiJZS3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 14:29:13 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78360E31A3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:29:11 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8797ECA1253;
        Wed, 26 Oct 2022 14:29:10 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 471A3CC833C;
        Wed, 26 Oct 2022 14:29:10 -0400 (EDT)
Subject: Re: [PATCH] index: add trace2 region for clear skip worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anh Le via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, Anh Le <anh@canva.com>
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
 <xmqq35bbmfz6.fsf@gitster.g>
 <d4103788-5153-11f2-487f-5cc795d261a8@jeffhostetler.com>
 <xmqq8rl2lgl3.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0bb8dc64-aad1-e3c1-66ef-c2e8d6600189@jeffhostetler.com>
Date:   Wed, 26 Oct 2022 14:29:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8rl2lgl3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/26/22 12:01 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> In the worst case, we walk the entire index and lstat() for a
>> significant number of skipped-and-not-present files, then near
>> the end of the loop, we find a skipped-but-present directory
>> and have to restart the loop.  The second pass will still run
>> the full loop again.  Will the second pass actually see any
>> skipped cache-entries?  Will it re-lstat() them?  Could the
>> `goto restart` just be a `break` or `return`?
>>
>> I haven't had time to look under the hood here, but I was
>> hoping that these two counters would help the series author
>> collect telemetry over many runs and gain more insight into
>> the perf problem.
> 
> Without being able to answer these questions, would we be able to
> interpret the numbers reported from these counters?
> 
>> Continuing the example from above, if we've already paid the
>> costs to lstat() the 95% sparse files AND THEN near the bottom
>> of the loop we have to do a restart, then we should expect
>> this loop to be doubly slow.  It was my hope that this combination
>> of counters would help us understand the variations in perf.
> 
> Yes, I understand that double-counting may give some clue to detect
> that, but it just looked roundabout way to do that.  Perhaps
> counting the path inspected during the first iteration and the path
> inspected during the second iteration, separately, without the "how
> many times did we repeat?", would give you a better picture?  "After
> inspecting 2400 paths, we need to go back and then ended up scanning
> 3000 paths in the flattened index in the second round" would be
> easier to interpret than "We needed flattening, and scanned 5400
> paths in total in the two iterations".

Good point and I was wondering about whether we might see "2 x 95%"
values for path_count in really slow cases.  And yes, it would be
better to have `int path_count[2]` and tally each loop pass
independently.

I guess I was looking for a first-order "where is the pain?" knowing
that we could always dig deeper later.  That is, is the lstat's or
is it the ensure-full and index rewrite?  Or both?

We have other places that do lstat() over the cache-entries and have
added code to spread the loop across n threads.  I doubt that is needed
here and I didn't want to lead with it.


> 
>> WRT the `intmax_t` vs just `int`: either is fine.
> 
> I thought "int" was supposed to be natural machine word, while
> incrementing "intmax_t" is allowed to be much slower than "int".
> Do we expect more than 2 billion paths?
> 

You're right.  An `int` would be fine here.

Thanks,
Jeff
