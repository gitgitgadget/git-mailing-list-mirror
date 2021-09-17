Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97949C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE2461250
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbhIQTnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:43:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:41509 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235944AbhIQTnS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:43:18 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5D2E53F4096;
        Fri, 17 Sep 2021 15:41:55 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b109:12e8:cc1c:b3d3:708a:a5be])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CE0C13F404F;
        Fri, 17 Sep 2021 15:41:54 -0400 (EDT)
Subject: Re: [PATCH 7/7] t/helper/simple-ipc: convert test-simple-ipc to use
 start_bg_command
To:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <57f29feaadb4a732892cd193b2a1d3c838f09421.1631738177.git.gitgitgadget@gmail.com>
 <YULQ8DJFKlrOml8Z@nand.local>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <aaad241c-4014-729c-32c9-df7039439a77@jeffhostetler.com>
Date:   Fri, 17 Sep 2021 15:41:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YULQ8DJFKlrOml8Z@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/21 1:06 AM, Taylor Blau wrote:
> On Wed, Sep 15, 2021 at 08:36:17PM +0000, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Convert test helper to use `start_bg_command()` when spawning a server
>> daemon in the background rather than blocks of platform-specific code.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   t/helper/test-simple-ipc.c | 193 ++++++++-----------------------------
>>   1 file changed, 40 insertions(+), 153 deletions(-)
>>
>> diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
>> index 91345180750..59a950f3b00 100644
>> --- a/t/helper/test-simple-ipc.c
>> +++ b/t/helper/test-simple-ipc.c
>> @@ -9,6 +9,7 @@
>>   #include "parse-options.h"
>>   #include "thread-utils.h"
>>   #include "strvec.h"
>> +#include "run-command.h"
>>
>>   #ifndef SUPPORTS_SIMPLE_IPC
>>   int cmd__simple_ipc(int argc, const char **argv)
>> @@ -274,178 +275,64 @@ static int daemon__run_server(void)
>>   	return ret;
>>   }
>>
>> -#ifndef GIT_WINDOWS_NATIVE
>> -/*
>> - * This is adapted from `daemonize()`.  Use `fork()` to directly create and
>> - * run the daemon in a child process.
>> - */
>> -static int spawn_server(pid_t *pid)
>> -{
>> -	struct ipc_server_opts opts = {
>> -		.nr_threads = cl_args.nr_threads,
>> -	};
>> +static start_bg_wait_cb bg_wait_cb;
> 
> This whole patch is delightful to read, as the new implementation is so
> much cleaner as a result of the earlier work in this series.
> 
> Am I correct in assuming that this is to encourage a compiler error if
> bg_wait_cb does not satisfy the type of start_bg_wait_cb? If so, then I
> think we are already getting that by trying to pass bg_wait_cb to
> start_bg_command().

I use that trick to get the compiler to give me a compiler error at the
point of the function declaration.

For example, If I add an arg to the function that doesn't match what's
in the prototype definition, I get:

t/helper/test-simple-ipc.c:280:12: error: conflicting types for 'bg_wait_cb'
static int bg_wait_cb(const struct child_process *cp, void *cb_data, int 
foo)
            ^
t/helper/test-simple-ipc.c:278:25: note: previous declaration is here
static start_bg_wait_cb bg_wait_cb;
                         ^
1 error generated.

Yes, we may get an error when the function pointer is referenced in
start_bg_command() or if we're using it to initialize a vtable or
something, but those errors are further away from the actual error
(and sometimes they can be a little cryptic).

Also, it helps document that this function's signature is predefined
for a reason.

It's a quirky trick I know, but it has served me well over the years.
	
> 
> E.g., applying this (intentionally broken) diff on top:
> 
> --- 8< ---
> 
> diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
> index 59a950f3b0..3aed787206 100644
> --- a/t/helper/test-simple-ipc.c
> +++ b/t/helper/test-simple-ipc.c
> @@ -275,9 +275,7 @@ static int daemon__run_server(void)
>   	return ret;
>   }
> 
> -static start_bg_wait_cb bg_wait_cb;
> -
> -static int bg_wait_cb(void *cb_data, const struct child_process *cp)
> +static int bg_wait_cb(const void *cb_data, const struct child_process *cp)
>   {
>   	int s = ipc_get_active_state(cl_args.path);
> 
> --- >8 ---
> 
> and then compiling still warns of a mismatched type when calling
> start_bg_command().
> 
>> -	*pid = fork();
>> -
>> -	switch (*pid) {
>> -	case 0:
>> -		if (setsid() == -1)
>> -			error_errno(_("setsid failed"));
>> -		close(0);
>> -		close(1);
>> -		close(2);
>> -		sanitize_stdfds();
>> +static int bg_wait_cb(void *cb_data, const struct child_process *cp)
>> +{
>> +	int s = ipc_get_active_state(cl_args.path);
>>
>> -		return ipc_server_run(cl_args.path, &opts, test_app_cb,
>> -				      (void*)&my_app_data);
>> +	switch (s) {
>> +	case IPC_STATE__LISTENING:
>> +		/* child is "ready" */
>> +		return 0;
>>
>> -	case -1:
>> -		return error_errno(_("could not spawn daemon in the background"));
>> +	case IPC_STATE__NOT_LISTENING:
>> +	case IPC_STATE__PATH_NOT_FOUND:
>> +		/* give child more time */
>> +		return 1;
>>
>>   	default:
> 
> I'm always a little hesitant to have default cases when switch over enum
> types, since it suppresses the warning when there's a new value of that
> type. But we already have a similar default in client__probe_server().

Do all compilers now handle switching over an enum and detect unhandled
cases?  Once upon a time that wasn't the case IIRC.

>...
> 
> Ditto.
> 
> Thanks,
> Taylor
> 
