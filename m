Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71FCC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11086109E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbhIWSA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:00:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:25850 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242579AbhIWSAW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 14:00:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 485493F40DA;
        Thu, 23 Sep 2021 13:58:49 -0400 (EDT)
Received: from WIN10-A.eucom.mil (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 04D803F40E4;
        Thu, 23 Sep 2021 13:58:48 -0400 (EDT)
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <87r1df497s.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2df757dc-bb19-555f-767e-6a4de9852bdb@jeffhostetler.com>
Date:   Thu, 23 Sep 2021 13:58:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87r1df497s.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/23/21 11:03 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 20 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> +	switch (sbgr) {
>> +	case SBGR_READY:
>> +		return 0;
>>   
>> -		else if (pid_seen == pid_child) {
>> -			/*
>> -			 * The new child daemon process shutdown while
>> -			 * it was starting up, so it is not listening
>> -			 * on the socket.
>> -			 *
>> -			 * Try to ping the socket in the odd chance
>> -			 * that another daemon started (or was already
>> -			 * running) while our child was starting.
>> -			 *
>> -			 * Again, we don't care who services the socket.
>> -			 */
>> -			s = ipc_get_active_state(cl_args.path);
>> -			if (s == IPC_STATE__LISTENING)
>> -				return 0;
>> +	default:
>> +	case SBGR_ERROR:
>> +	case SBGR_CB_ERROR:
>> +		return error("daemon failed to start");
> 
> There was a discussion on v1 about the "default" being redundant here
> and hiding future compiler checks, this is another "not sure what you
> thought of that" case (per [1]).
> 
> Interestingly in this case if I drop the "default" my local gcc
> uncharacteristically complains about a missing "return" in this
> function, but clang doesn't. I needed to add a BUG() to shut up the
> former. Maybe I'm wrong, but perhaps it's a sign of some deeper
> trouble. This is with gcc/clang 10.2.1-6/11.0.1-2.

The issue of whether C needs a "default" case in switch statements
on an enum is one I didn't have bandwidth to think about (and is
completely independent of my series).

I was thinking that as a later task, someone could investigate which
compilers do and do not generate errors for missing enum values in
the switch.  Perhaps that leads to a macro in config.mak.uname on
a system-by-system basis that "does the right thing".

Then one could have something like:

     switch (e) {
     DEFAULT_HANDLER;
     case e1: ...
     case e2: ...
     }


> 
> 1. https://lore.kernel.org/git/87v92r49mt.fsf@evledraar.gmail.com/
> 
> I played with the diff below on top of this, I can't remember if it was
> noted already, but the way you declare function ptrs and use them isn't
> the usual style:
> 
> -- >8 --
> diff --git a/run-command.c b/run-command.c
> index 76bbef9d96d..5c831545201 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1903,7 +1903,7 @@ void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
>   }
>   
>   enum start_bg_result start_bg_command(struct child_process *cmd,
> -				      start_bg_wait_cb *wait_cb,
> +				      start_bg_wait_cb wait_cb,
>   				      void *cb_data,
>   				      unsigned int timeout_sec)
>   {
> diff --git a/run-command.h b/run-command.h
> index 17b1b80c3d7..e8a637d1967 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -527,7 +527,7 @@ enum start_bg_result {
>    * Returns 0 if child is "ready".
>    * Returns -1 on any error and cause start_bg_command() to also error out.
>    */
> -typedef int(start_bg_wait_cb)(const struct child_process *cmd, void *cb_data);
> +typedef int (*start_bg_wait_cb)(const struct child_process *cmd, void *cb_data);

By defining the typedef WITHOUT the star, we get a function type.

We can then use it for forward function declarations.

But additionally, when declare a function that takes a function
pointer or when we define a vtable of function pointers, they look
like pointers.

start_bg_wait_cb *pfn = my_cb;

int foo(struct child_process *cmd, start_bg_wait_cb *cb);

Or if we look a the target vtable in Trace2.  This looks like
a structure of (function) pointers.

struct tr2_tgt {
	tr2_tgt_init_t                          *pfn_init;
	tr2_tgt_term_t                          *pfn_term;
	...
};

So I prefer to leave the star out of function typedef and then
we can use the typedef in both contexts.

Jeff
