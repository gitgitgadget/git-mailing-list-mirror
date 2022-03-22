Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E001C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiCVO1r convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 22 Mar 2022 10:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbiCVO0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 10:26:49 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC5E00A
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 07:25:14 -0700 (PDT)
Received: from Mazikeen (ec2-3-96-216-93.ca-central-1.compute.amazonaws.com [3.96.216.93])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22MEPAA5049978
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 22 Mar 2022 10:25:10 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "=?utf-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>,
        "'Jeff Hostetler via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>,
        "'Derrick Stolee'" <derrickstolee@github.com>,
        "'??var Arnfj??r?? Bjarmason'" <avarab@gmail.com>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com> <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com> <20220313104230.ctwbskywcq5jxv36@tb-raspi4> <2bb125d3-cef7-9d47-efa8-61a1aaba5316@jeffhostetler.com> <060401d83d79$f2540780$d6fc1680$@nexbridge.com> <e8ab7689-f6eb-9fda-e7aa-87fc2c4ee601@jeffhostetler.com>
In-Reply-To: <e8ab7689-f6eb-9fda-e7aa-87fc2c4ee601@jeffhostetler.com>
Subject: RE: [PATCH v2 00/27] Builtin FSMonitor Part 3
Date:   Tue, 22 Mar 2022 10:25:04 -0400
Organization: Nexbridge Inc.
Message-ID: <063f01d83df8$a3102e40$e9308ac0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ2rBg+5tIrWhYVzRXa2ZIa9fwxqAIsp5+cAs2ZmAcCmA0zmQIGheWGAeTM0jKrMqrDgA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 22, 2022 10:11 AM, Jeff Hostetler wrote:
>On 3/21/22 7:18 PM, rsbecker@nexbridge.com wrote:
>> On March 21, 2022 6:06 PM, Jeff Hostetler wrote:
>>> On 3/13/22 6:42 AM, Torsten Bögershausen wrote:
>>>> Hej Jeff,
>>>>
>[...]
>>>
>>> It looks like the ...Cloned bit was added to the SDK in 10.13 [1].
>>> All the other bits were defined sometime between 10.5 and 10.10.
>>>
>>> I'll add something in V7 to guard that bit.  I think 10.10 is old
>>> enough that we don't need to special case those bits too.
>>
>> I realize it is a bit late in the game, but would you consider a pre-hook and post-
>hook that automatically run with fsmonitor kicks off/terminates. I am thinking
>about use cases where this is integrated into more complex processes and it
>would be nice to have notifications of what fsmonitor is doing and when.
>>
>> Thanks,
>> Randall
>>
>
>I hadn't really considered having a pre/post hook for the daemon.
>I'm not opposed to it; I just hadn't thought about it.
>
>By this I assume you mean something inside the fsmonitor--daemon process that
>invokes the hooks when it is starting/stopping.
>As opposed to something in a client command (like status) before it implicitly
>started a daemon process.  The latter method would not give you post-hook
>events because the daemon usually outlives the client command.
>
>Perhaps you could elaborate on what you would use these hooks for or how they
>would be helpful.  It would be easy to add pre/post hooks in the main thread of
>the daemon.  However, I worry about the prehook slowing the startup of the
>daemon -- since the client status command might be waiting for it to become
>ready.  I also have a "health" thread in part3 that would be a candidate for
>pre/post and any other periodic hooks that might be useful.
>But again, before I suggest a design for this, it would be good to know what kind of
>things you would want to do with them.

Some examples of what I have in mind. There are more, but this covers what I have in mind urgently:

1. Setting up a lock file (semaphore) just before fsmonitor runs that will cause any scripts that might change the state of the repository on the fly to suspend until fsmonitor is done.
2. Ensuring that in-flight scripts that do stuff are finished or not leaving the repo in a transitional state before fsmonitor runs - holding fsmonitor until the pre-hook finishes.
3. Notifying syslog or some other paging system if something has gone horribly wrong - as in fsmonitor found something bad in the index.
4. Clearing any semaphores created earlier (example 1).

Regards,
Randall

