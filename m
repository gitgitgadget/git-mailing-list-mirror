Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CB0C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F0D6145D
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 15:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhD3QAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 12:00:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:26606 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhD3QAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 12:00:01 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1F13F3F413F;
        Fri, 30 Apr 2021 11:59:13 -0400 (EDT)
Received: from HCIPROD2.AZHCI.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id ADB3E3F413E;
        Fri, 30 Apr 2021 11:59:12 -0400 (EDT)
Subject: Re: [PATCH 09/23] fsmonitor--daemon: implement daemon command options
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <2b291d805d59b54203d939e048bb568782d5e17b.1617291666.git.gitgitgadget@gmail.com>
 <91a0fc4b-505a-fa2b-c797-5e420e836642@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <673017fa-36b9-3a26-f1de-155cc2608cff@jeffhostetler.com>
Date:   Fri, 30 Apr 2021 11:59:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <91a0fc4b-505a-fa2b-c797-5e420e836642@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 11:47 AM, Derrick Stolee wrote:
...
> 
>> +
>>   static int is_ipc_daemon_listening(void)
>>   {
>>   	return fsmonitor_ipc__get_state() == IPC_STATE__LISTENING;
>>   }
>>   
>> +static int try_to_run_foreground_daemon(void)
>> +{
>> +	/*
>> +	 * Technically, we don't need to probe for an existing daemon
>> +	 * process, since we could just call `fsmonitor_run_daemon()`
>> +	 * and let it fail if the pipe/socket is busy.
>> +	 *
>> +	 * However, this method gives us a nicer error message for a
>> +	 * common error case.
>> +	 */
>> +	if (is_ipc_daemon_listening())
>> +		die("fsmonitor--daemon is already running.");
> Here, it seems like we only care about IPC_STATE_LISTENING, while
> earlier I mentioned that I ended up in IPC_STATE__NOT_LISTENING,
> and my manually running of the daemon helped.
> 
>> +	return !!fsmonitor_run_daemon();
>> +}
> 
> You are ignoring the IPC_STATE__NOT_LISTENING and creating a new
> process, which is good. I'm just wondering why that state exists
> and what is the proper way to handle it?

I'll revisit this and clarify.

> 
>> +
>> +#ifndef GIT_WINDOWS_NATIVE
> 
> You are already creating a platform-specific mechanism for the
> filesystem watcher. Shouldn't the implementation of this method
> be part of that file in compat/fsmonitor/?
> 
> I guess the biggest reason is that macOS and Linux share this
> implementation, so maybe this is the cleanest approach.

This has to do with how to spawn a background process and
disassociate from the console and all that.

On Windows, the "git fsmonitor--daemon --start" process[1] must
start a child process[2] with "git fsmonitor--daemon --run" and
then the [1] can exit (to let the caller/shell continue) while
[2] is free to continue.

On Unix, the "git fsmonitor-daemon --start" process[1] can
fork() a child process[2] and [2] can just call the _run_daemon()
code.  We don't need to exec the child, so this is a bit faster.

This code is platform-specific, so maybe it should go elsewhere,
but it has knowledge of fsmonitor--daemon-specific command line
args and private functions (`fsmonitor_run_daemon()`) and it knows
that it is not a library function.  So it made sense to keep it
close to the fsmonitor--daemon main entry point.


It didn't feel right to make these 2 versions of
`spawn_background_fsmonitor_daemon()` more generic (such as putting
them near `daemonize()`), because they know too much about
fsmonitor--daemon.

I did the same thing in `t/helper/test-simple-ipc.c` where I
created variants of this that started the test-tool in the background.
36a7eb6876 (t0052: add simple-ipc tests and t/helper/test-simple-ipc 
tool, 2021-03-22)


I thought about putting them inside `compat/fsmonitor/*.c`
but that has different problems.  Those files are concerned strictly
with the FS layer and how to get FS notification events from the
kernel and translating them into something cross-platform.  They
are, in a sense, a "driver" for that FS.  Process spawning is outside
of their scope.

And as you say, MacOS and Linux can both use the same process
spawning code, but will have vastly different FS layers.

So I left them here.


Thanks,
Jeff
