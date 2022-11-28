Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEAFC4332F
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 16:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiK1Qh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 11:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiK1Qh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 11:37:58 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD28636A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 08:37:56 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DF407CA126B;
        Mon, 28 Nov 2022 11:37:55 -0500 (EST)
Received: from [10.0.0.2] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9FBFBCC8326;
        Mon, 28 Nov 2022 11:37:55 -0500 (EST)
Message-ID: <6c725ed6-4d74-c260-98fb-dc965b4647ee@jeffhostetler.com>
Date:   Mon, 28 Nov 2022 11:37:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] trace2 tests: guard pthread test with "PTHREAD"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        "Randall S . Becker" <randall.becker@nexbridge.ca>
References: <patch-1.1-f7f21c94a6c-20221124T214813Z-avarab@gmail.com>
 <xmqqilj3edtr.fsf@gitster.g> <221125.867czjo3ud.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <221125.867czjo3ud.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/25/22 3:05 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Nov 25 2022, Junio C Hamano wrote:
> 
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> Since 81071626ba1 (trace2: add global counter mechanism, 2022-10-24)
>>> these tests have been failing when git is compiled with NO_PTHREADS=Y,
>>> which is always the case e.g. if 'uname -s' is "NONSTOP_KERNEL".
>>>
>>> Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>>   t/t0211-trace2-perf.sh | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Makes sense, to sweep the immediate breakage under prerequisite.

This change LGTM.  The test-tool will report an error trying to
create the requested threads, so there will not be any per-thread
output for the grep to match.


>>
>> But why would a global counter need threading?  I know that the
>> counters can optionally report per-thread stats, but that is
>> optional and it would still be useful if we can count events in a
>> single-threaded program, no?

Timers & counters are accumulated in per-thread local storage.
This allows them to work in a lock-free manner.

Timer/Counter usage by a single-threaded program just accumulates
data in the thread local storage of the "main" thread so that the
code is the same in all cases.

Global timers and counters are accumulated from per-thread ones during
thread-exit.  (See calls to `tr2_update_final_timers()` and
`tr2_update_final_counters()` in `trace2_thread_exit_fl()`.)
This is the only step that requires a lock.

There are also calls to those two routines in `tr2main_atexit_handler()`
to accumulate any timer/counter usage in the main thread into the
globals.

The net-net of all of this is that the global (aka final) values
of the timers and counters are always safely computed (and in the
same way) regardless of whether threads were used at any point
during the life of the process.  That is, if "main" was the only
thread, the global/final values are just the values from the main
thread.


> That was my thought as well, but these tests are specifically testing
> how it interacts with threading. The counter mechanism works in general
> without threading.
> 
> The test descriptions don't help, and should really say that they're to
> do with threading in particular, but I wanted to keep this as small as
> possible for rc[12] and the final, so I didn't fix that while-at-it.

There is large comment block above `have_timer_event()` and
`have_counter_event()` in t0211 that explained the purpose of the
test1 and test2 tests for each.  Would it help if that text were moved
down before each of the individual tests rather than where it is now?

Thanks
Jeff
