Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A8DC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiJZONW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiJZONV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:13:21 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE510DE4E
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:13:19 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 261CDCA125E;
        Wed, 26 Oct 2022 10:13:19 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D964ACC831D;
        Wed, 26 Oct 2022 10:13:18 -0400 (EDT)
Subject: Re: [PATCH] index: add trace2 region for clear skip worktree
To:     Junio C Hamano <gitster@pobox.com>,
        Anh Le via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, Anh Le <anh@canva.com>
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
 <xmqq35bbmfz6.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d4103788-5153-11f2-487f-5cc795d261a8@jeffhostetler.com>
Date:   Wed, 26 Oct 2022 10:13:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq35bbmfz6.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/22 11:16 PM, Junio C Hamano wrote:
> "Anh Le via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Anh Le <anh@canva.com>
>>
>> In a large repository using sparse checkout, checking
>> whether a file marked with skip worktree is present
>> on disk and its skip worktree bit should be cleared
>> can take a considerable amount of time. Add a trace2
>> region to surface this information.
>>
>> Signed-off-by: Anh Le <anh@canva.com>
>> ---
>>      index: add trace2 region for clear skip worktree
>>      
>>      In large repository using sparse checkout, checking whether a file
>>      marked with skip worktree is present on disk and its skip worktree bit
>>      should be cleared can take a considerable amount of time. Add a trace2
>>      region to surface this information.
> 
> It is easy to see that the change is no-op from functionality's
> standpoint.  The condition under which ce->ce_flags loses the
> CE_SKIP_WORKTREE bit is the same as before, and the only change is
> that in the iteration a couple of variables are incremented, which
> may (or may not) have performance impact, but shouldn't break
> correctness.
> 
> I am not sure about the value of these counters, honestly.

I suggested adding the counters while the series was still over
on GitGitGadget.

The original goal was to measure the time spent in that loop
with the region_enter/region_leave events.  They will tell you
whether the loop was slow or not and you can compare that with
other (peer or containing) regions to see if it significant.

However, it doesn't tell us anything about WHY it was slow or
was slower than another instance.  The path_count gives us a
simple estimate on the number of lstat() calls -- which is
one of frequent sources of slowness.  Yes, it is bounded by
`istate->cache_nr`, but if I have a repo with 1M cache-entries
and 95% are sparse, this loop is going to be much slower than
if only 5% are sparse.

The restart_count (which we only expect to be 0 or 1), will
tell us whether or not at some point mid-loop we had to fully
inflate the index -- which is another source of slowness.
Granted, `ensure_full_index()` probably contains a region of
its own, so the restart_count here may not absolutely necessary,
but in the context of this loop -- this counter may point to the
other smoking gun.

In the worst case, we walk the entire index and lstat() for a
significant number of skipped-and-not-present files, then near
the end of the loop, we find a skipped-but-present directory
and have to restart the loop.  The second pass will still run
the full loop again.  Will the second pass actually see any
skipped cache-entries?  Will it re-lstat() them?  Could the
`goto restart` just be a `break` or `return`?

I haven't had time to look under the hood here, but I was
hoping that these two counters would help the series author
collect telemetry over many runs and gain more insight into
the perf problem.

Continuing the example from above, if we've already paid the
costs to lstat() the 95% sparse files AND THEN near the bottom
of the loop we have to do a restart, then we should expect
this loop to be doubly slow.  It was my hope that this combination
of counters would help us understand the variations in perf.

WRT the `intmax_t` vs just `int`: either is fine.  I suggested
the former because that is what `trace2_data_intmax()` takes.
I really don't expect any usage to overflow a regular 32bit int.

[...]
>> +	trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_count);
>> +	trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/restart_count", restart_count);

One thing I forgot to mention in my GGG suggestion was to only
emit these data events if the counter is > 0.  We've been trying
to avoid logging zeroes.

>> +	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);
[...]

Jeff
