Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A0C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1046121F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhGUOAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:00:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:31768 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232937AbhGUOAT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 10:00:19 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CAFB53F4098;
        Wed, 21 Jul 2021 10:40:55 -0400 (EDT)
Received: from SME-RED-HCI8.sme.test.net (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 95F1F3F4047;
        Wed, 21 Jul 2021 10:40:55 -0400 (EDT)
Subject: Re: [PATCH v3 29/34] fsmonitor--daemon: use a cookie file to sync
 with file system
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <555caca2216dd3e459c118d76b46eb983a58e051.1625150864.git.gitgitgadget@gmail.com>
 <878s2pboha.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8b7e1d69-b89a-239b-af4b-53d90dbec651@jeffhostetler.com>
Date:   Wed, 21 Jul 2021 10:40:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <878s2pboha.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 7:17 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach fsmonitor--daemon client threads to create a cookie file
>> inside the .git directory and then wait until FS events for the
>> cookie are observed by the FS listener thread.
>>
>> This helps address the racy nature of file system events by
>> blocking the client response until the kernel has drained any
>> event backlog.
>>
>> This is especially important on MacOS where kernel events are
>> only issued with a limited frequency.  See the `latency` argument
>> of `FSeventStreamCreate()`.  The kernel only signals every `latency`
>> seconds, but does not guarantee that the kernel queue is completely
>> drained, so we may have to wait more than one interval.  If we
>> increase the frequency, the system is more likely to drop events.
>> We avoid these issues by having each client thread create a unique
>> cookie file and then wait until it is seen in the event stream.
> 
> Is this a guaranteed property of any API fsmonitor might need to work
> with (linux, darwin, Windows) that if I perform a bunch of FS operations
> on my working tree, that if I finish up by touching this cookie file
> that that'll happen last?
> 
> I'd think that wouldn't be the case, i.e. on POSIX filesystems unless
> you run around fsyncing both files and directories you're not guaranteed
> that they're on disk, and even then the kernel might decide to sync your
> cookie earlier, won't it?
> 
> E.g. on Linux you can even have cross-FS watches, and mix & match
> different FS types. I'd expect to get events in whatever
> implementation-defined order the VFS layer + FS decided to sync them to
> disk in & get to firing off an event for me.
> 
> Or do these APIs all guarantee that a linear view of the world is
> presented to the API consumer?
> 


Theoretically, none of these APIs guarantee a complete linear ordering.
We receive events from the FS in the order that the FS decides to
perform the actual IO.  And the inner workings of the FS is private.
Even if we directly read the journal rather than listening for
notifications, we probably still don't know whether the FS reordered
the queue of things heading to disk.

However in practice, the events for the cookie files do tend to arrive
in order.  And the net effect is that the worker thread in the daemon
is sync'd up with IO activity that was initiated before the request.


BTW Watchman also uses cookie files for this same reason.


It should also be noted that some operations are just racy.  If you're
doing a bunch of IO in one window and a 'git status' in another window,
your result will be racy -- status (without FSM) makes 2 passes on the
disk: the first to verify mtimes on items in the index and the second
to look for untracked files.  the status result may be "blurry" (for
lack of a better word).  So the same questions
     "does the FS reorder my IO?",
     "did status see the fully sync'd FS?",
and etc can also be asked in the normal (non FSM) case, right?

So it may be the case that having an fsmonitor (mine, Watchman, etc)
and the untracked-cache, we'll have less skew in status results
because the status process shouldn't have to do any scanning.
But I'm not sure I want to make that assertion yet.

Thanks,
Jeff

