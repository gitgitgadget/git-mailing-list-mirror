Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F9C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 18:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiLBSjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 13:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLBSiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 13:38:25 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E9EE081
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 10:37:41 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DF2B7CA1249;
        Fri,  2 Dec 2022 13:37:40 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 958E9CC831E;
        Fri,  2 Dec 2022 13:37:40 -0500 (EST)
Message-ID: <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
Date:   Fri, 2 Dec 2022 13:37:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
 <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/2/22 1:02 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Dec 02 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> Replace the call to `FSEventStreamScheduleWithRunLoop()` function with
>> the suggested `FSEventStreamSetDispatchQueue()` function.
>>
>> The MacOS version of the builtin FSMonitor feature uses the
>> `FSEventStreamScheduleWithRunLoop()` function to drive the event loop
>> and process FSEvents from the system.  This routine has now been
>> deprecated by Apple.  The MacOS 13 (Ventana) compiler tool chain now
>> generates a warning when compiling calls to this function.  In
>> DEVELOPER=1 mode, this now causes a compile error.
>>
>> The `FSEventStreamSetDispatchQueue()` function is conceptually similar
>> and is the suggested replacement.  However, there are some subtle
>> thread-related differences.
>>
>> Previously, the event stream would be processed by the
>> `fsm_listen__loop()` thread while it was in the `CFRunLoopRun()`
>> method.  (Conceptually, this was a blocking call on the lifetime of
>> the event stream where our thread drove the event loop and individual
>> events were handled by the `fsevent_callback()`.)
>>
>> With the change, a "dispatch queue" is created and FSEvents will be
>> processed by a hidden queue-related thread (that calls the
>> `fsevent_callback()` on our behalf).  Our `fsm_listen__loop()` thread
>> maintains the original blocking model by waiting on a mutex/condition
>> variable pair while the hidden thread does all of the work.
> 
> I just skimmed the code change and didn't see anything out of place, but
> one thing that's missing about this explanation is:
> 
> Ok, it's deprecated, but when was it introduced? I.e. we now presumably
> have a hard dependency on a newer API released with a newer version of
> OSX?
> 
> Is it OK that we're going to throw compilation errors on older versions
> that don't have it? What version is that? Is that older or newer than
> our oldest supported OSX version in general, or is the plan to support
> older OSX, but those users would need to compile without fsmonitor?
> 
> Depending on the answers to the above (hopefully in a re-rolled commit
> message): Should we patch the bit in config.mak.uname where we do the
> OSX version detection? I.e. if we're deprecating an older version anyone
> still on it would be much better off with a straight-up "$(error)" from
> the Makefile, rather than running into a compilation error, only to find
> that we've stopped supporting that older version.

Lots of questions here.  Let me take a quick stab at answering them.
 From [1] the old routine was introduced in 10.5 and marked deprecated
in 10.13.  From [2] the new routine was introduced in 10.6.

10.5 (Leopard) was released October 2007.
10.6 (Snow Leopard) was released August 2009.

So the only people that would be affected by this must be running
exactly 10.5, right?  (Those with 10.4 and before don't have either
API and are already broken regardless.)

So, based on the ages of those two Apple releases, I'd like to think
that we're fine just switching over and not having to ifdef-up the
config.mak.uname.  (If it were a more recent change in the OS, then
yeah the answer would be different.)

Thoughts ???

[1] 
https://developer.apple.com/documentation/coreservices/1447824-fseventstreamschedulewithrunloop
[2] 
https://developer.apple.com/documentation/coreservices/1444164-fseventstreamsetdispatchqueue
[3] https://en.wikipedia.org/wiki/Mac_OS_X_Leopard
[4] https://en.wikipedia.org/wiki/Mac_OS_X_Snow_Leopard
