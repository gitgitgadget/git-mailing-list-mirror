Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6579C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF0E6109D
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 14:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbhKHPAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:00:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:24751 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240662AbhKHPAq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 10:00:46 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 77B013F4107;
        Mon,  8 Nov 2021 09:58:01 -0500 (EST)
Received: from azhci-node1.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 292763F4114;
        Mon,  8 Nov 2021 09:58:01 -0500 (EST)
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
To:     Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <20211104194619.GA12886@dinwoodie.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2af70f2a-e74c-15a8-6340-e18bf265598c@jeffhostetler.com>
Date:   Mon, 8 Nov 2021 09:58:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211104194619.GA12886@dinwoodie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/4/21 3:46 PM, Adam Dinwoodie wrote:
> On Monday 20 September 2021 at 03:36 pm +0000, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Convert test helper to use `start_bg_command()` when spawning a server
>> daemon in the background rather than blocks of platform-specific code.
>>
>> Also, while here, remove _() translation around error messages since
>> this is a test helper and not Git code.
> 
> As part of testing the v2.34.0-rc0 release candidate on Cygwin, I've
> found this commit -- 05881a6fc9 (t/helper/simple-ipc: convert
> test-simple-ipc to use start_bg_command, 2021-09-20), according to my
> bisecting -- is causing t0052.1 to fail on 32-bit Cygwin.  Somehow this
> is only affecting the 32-bit Cygwin build; the 64-bit build is working
> as expected.
> 
> Specifically, the failure I'm seeing is as below:
> 
> ```
> $ GIT_TRACE=1 sh t0052-simple-ipc.sh -vix
> trace: built-in: git init '/cygdrive/d/git-32/t/trash directory.t0052-simple-ipc'
> Initialized empty Git repository in /cygdrive/d/git-32/t/trash directory.t0052-simple-ipc/.git/
> expecting success of 0052.1 'start simple command server':
> 	test_atexit stop_simple_IPC_server &&
> 	test-tool simple-ipc start-daemon --threads=8 &&
> 	test-tool simple-ipc is-active
> 
> ++ test_atexit stop_simple_IPC_server
> ++ test 0 = 0
> ++ test_atexit_cleanup='{ stop_simple_IPC_server
> 		} && (exit "$eval_ret"); eval_ret=$?; :'
> ++ test-tool simple-ipc start-daemon --threads=8
> trace: run_command: test-tool simple-ipc run-daemon --name=ipc-test --threads=8
> error: daemon failed to start
> error: last command exited with $?=1
> not ok 1 - start simple command server
> #	
> #		test_atexit stop_simple_IPC_server &&
> #		test-tool simple-ipc start-daemon --threads=8 &&
> #		test-tool simple-ipc is-active
> #	
> ++ stop_simple_IPC_server
> ++ test-tool simple-ipc stop-daemon
> ++ exit 1
> ++ eval_ret=1
> ++ :
> ```
> 
> I've had a look at the code changes, and cannot work out what might be
> being handled differently in 32-bit and 64-bit Cygwin environments.
> Given the Cygwin project is considering dropping support for 32-bit
> Cygwin anyway, it might not be worth doing anything about this.  But I
> thought it worth reporting in case there's something obvious to folk
> more familiar with this code.
> 

How odd!  Thanks for the report.  I'll investigate.
Jeff
