Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6392C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 15:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbiCVPCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiCVPCh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 11:02:37 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7193B3D5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 08:01:10 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 860313F4155;
        Tue, 22 Mar 2022 11:01:09 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 460B23F413F;
        Tue, 22 Mar 2022 11:01:09 -0400 (EDT)
Subject: Re: [PATCH v2 00/27] Builtin FSMonitor Part 3
To:     rsbecker@nexbridge.com,
        =?UTF-8?Q?=27Torsten_B=c3=b6gershausen=27?= <tboegi@web.de>,
        'Jeff Hostetler via GitGitGadget' <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, 'Derrick Stolee' <derrickstolee@github.com>,
        '??var Arnfj??r?? Bjarmason' <avarab@gmail.com>,
        'Jeff Hostetler' <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <20220313104230.ctwbskywcq5jxv36@tb-raspi4>
 <2bb125d3-cef7-9d47-efa8-61a1aaba5316@jeffhostetler.com>
 <060401d83d79$f2540780$d6fc1680$@nexbridge.com>
 <e8ab7689-f6eb-9fda-e7aa-87fc2c4ee601@jeffhostetler.com>
 <063f01d83df8$a3102e40$e9308ac0$@nexbridge.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <29f4b39b-1ad0-41fa-3470-c7afbeb613cf@jeffhostetler.com>
Date:   Tue, 22 Mar 2022 11:01:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <063f01d83df8$a3102e40$e9308ac0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/22 10:25 AM, rsbecker@nexbridge.com wrote:
> On March 22, 2022 10:11 AM, Jeff Hostetler wrote:
>> On 3/21/22 7:18 PM, rsbecker@nexbridge.com wrote:
>>> On March 21, 2022 6:06 PM, Jeff Hostetler wrote:
>>>> On 3/13/22 6:42 AM, Torsten Bögershausen wrote:
>>>>> Hej Jeff,
>>>>>
>> [...]
>>>>
>>>> It looks like the ...Cloned bit was added to the SDK in 10.13 [1].
>>>> All the other bits were defined sometime between 10.5 and 10.10.
>>>>
>>>> I'll add something in V7 to guard that bit.  I think 10.10 is old
>>>> enough that we don't need to special case those bits too.
>>>
>>> I realize it is a bit late in the game, but would you consider a pre-hook and post-
>> hook that automatically run with fsmonitor kicks off/terminates. I am thinking
>> about use cases where this is integrated into more complex processes and it
>> would be nice to have notifications of what fsmonitor is doing and when.
>>>
>>> Thanks,
>>> Randall
>>>
>>
>> I hadn't really considered having a pre/post hook for the daemon.
>> I'm not opposed to it; I just hadn't thought about it.
>>
>> By this I assume you mean something inside the fsmonitor--daemon process that
>> invokes the hooks when it is starting/stopping.
>> As opposed to something in a client command (like status) before it implicitly
>> started a daemon process.  The latter method would not give you post-hook
>> events because the daemon usually outlives the client command.
>>
>> Perhaps you could elaborate on what you would use these hooks for or how they
>> would be helpful.  It would be easy to add pre/post hooks in the main thread of
>> the daemon.  However, I worry about the prehook slowing the startup of the
>> daemon -- since the client status command might be waiting for it to become
>> ready.  I also have a "health" thread in part3 that would be a candidate for
>> pre/post and any other periodic hooks that might be useful.
>> But again, before I suggest a design for this, it would be good to know what kind of
>> things you would want to do with them.
> 
> Some examples of what I have in mind. There are more, but this covers what I have in mind urgently:
> 
> 1. Setting up a lock file (semaphore) just before fsmonitor runs that will cause any scripts that might change the state of the repository on the fly to suspend until fsmonitor is done.

The builtin fsmonitor--daemon is a long-running process.  It is
either explicitly started by the user or implicitly started by
clients commands, like "git status", lazily after it is enabled
in the config.  It runs until explicitly stopped (or the workdir
is deleted).

It is designed to be running and watch the filesystem for changes.

Later client commands can ask it for what has changed on disk
since the previous request (checkpoint).  And the only way to
capture that info is to watch the file system as things happen.
(Unless we have a really deep journal, but that often requires
admin access, so we don't use that.)

The fsmonitor daemon is unlike other subordinate commands in Git.
For example, "git fetch" might synchronously invoke "git index-pack"
and communicate over the child's stdin/stdout.  And that child is
bound to a single parent process.

When the daemon starts, it disassociates from the console and
opens a socket or named pipe and listens for requests (REST-like) 
commands.  It is designed to respond to multiple clients concurrently
and over a long time period -- like a daemon or service process.

> 2. Ensuring that in-flight scripts that do stuff are finished or not leaving the repo in a transitional state before fsmonitor runs - holding fsmonitor until the pre-hook finishes.
> 3. Notifying syslog or some other paging system if something has gone horribly wrong - as in fsmonitor found something bad in the index.

fsmonitor doesn't read the index.  it's only watching and summarizing
file system events.  And can enumerate the list of changed paths between
two checkpoints in response to a client request.


> 4. Clearing any semaphores created earlier (example 1).

The daemon isn't designed to ever "be done" and hence there are no
on-disk lock files/semaphores.  There might be some opportunities
for startup/shutdown to do some cleanup (temp files and the like),
but I think it is premature to talk about that right now.

Hope this helps,
Jeff


> 
> Regards,
> Randall
> 
