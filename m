Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55892036B
	for <e@80x24.org>; Wed,  4 Oct 2017 05:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbdJDF6R (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 01:58:17 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:23518 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdJDF6R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 01:58:17 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3y6QDl0ZhHz5tlP;
        Wed,  4 Oct 2017 07:58:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4731F2127;
        Wed,  4 Oct 2017 07:58:14 +0200 (CEST)
Subject: Re: [PATCH 3/3] sub-process: allocate argv on the heap
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-4-t.gummerer@gmail.com>
 <85456f81-9e9f-d0e4-86f7-9f546691dee3@kdbg.org>
 <xmqq7ewbecek.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d25458d1-6244-93b0-367d-c2a4efb9d267@kdbg.org>
Date:   Wed, 4 Oct 2017 07:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq7ewbecek.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.2017 um 06:59 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 03.10.2017 um 21:57 schrieb Thomas Gummerer:
>>> diff --git a/sub-process.c b/sub-process.c
>>> index 6dde5062be..4680af8193 100644
>>> --- a/sub-process.c
>>> +++ b/sub-process.c
>>> @@ -77,7 +77,9 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
>>>    {
>>>    	int err;
>>>    	struct child_process *process;
>>> -	const char *argv[] = { cmd, NULL };
>>> +	const char **argv = xmalloc(2 * sizeof(char *));
>>> +	argv[0] = cmd;
>>> +	argv[1] = NULL;
>>>      	entry->cmd = cmd;
>>>    	process = &entry->process;
>>>
>>
>> Perhaps this should become
>>
>> 	argv_array_push(&process->args, cmd);
>>
>> so that there is no new memory leak?
> 
> Sounds like a good idea (if I am not grossly mistaken as to what is
> being suggested).
> 
> Here is what I am planning to queue.
> 
> -- >8 --
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 3 Oct 2017 22:24:57 +0200
> Subject: [PATCH] sub-process: use child_process.args instead of child_process.argv
> 
> Currently the argv is only allocated on the stack, and then assigned to
> process->argv.  When the start_subprocess function goes out of scope,
> the local argv variable is eliminated from the stack, but the pointer is
> still kept around in process->argv.
> 
> Much later when we try to access the same process->argv in
> finish_command, this leads us to access a memory location that no longer
> contains what we want.  As argv0 is only used for printing errors, this
> is not easily noticed in normal git operations.  However when running
> t0021-conversion.sh through valgrind, valgrind rightfully complains:
> 
> ==21024== Invalid read of size 8
> ==21024==    at 0x2ACF64: finish_command (run-command.c:869)
> ==21024==    by 0x2D6B18: subprocess_exit_handler (sub-process.c:72)
> ==21024==    by 0x2AB41E: cleanup_children (run-command.c:45)
> ==21024==    by 0x2AB526: cleanup_children_on_exit (run-command.c:81)
> ==21024==    by 0x54AD487: __run_exit_handlers (in /usr/lib/libc-2.26.so)
> ==21024==    by 0x54AD4D9: exit (in /usr/lib/libc-2.26.so)
> ==21024==    by 0x11A9EF: handle_builtin (git.c:550)
> ==21024==    by 0x11ABCC: run_argv (git.c:602)
> ==21024==    by 0x11AD8E: cmd_main (git.c:679)
> ==21024==    by 0x1BF125: main (common-main.c:43)
> ==21024==  Address 0x1ffeffec00 is on thread 1's stack
> ==21024==  1504 bytes below stack pointer
> ==21024==
> 
> These days, the child_process structure has its own args array, and
> the standard way to set up its argv[] is to use that one, instead of
> assigning to process->argv to point at an array that is outside.
> Use that facility automatically fixes this issue.
> 
> Reported-by: Thomas Gummerer <t.gummerer@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   sub-process.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sub-process.c b/sub-process.c
> index fcc4832c14..648b3a3943 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -74,13 +74,12 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
>   {
>   	int err;
>   	struct child_process *process;
> -	const char *argv[] = { cmd, NULL };
>   
>   	entry->cmd = cmd;
>   	process = &entry->process;
>   
>   	child_process_init(process);
> -	process->argv = argv;
> +	argv_array_push(&process->args, cmd);
>   	process->use_shell = 1;
>   	process->in = -1;
>   	process->out = -1;
> 

Thank you very much! That looks good. Just to be on the safe side:

Signed-off-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
