Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9688C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82693608FE
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhGMSrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:47:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:14544 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhGMSrc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:47:32 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 579C83F47F5;
        Tue, 13 Jul 2021 14:44:42 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1E31F3F40B7;
        Tue, 13 Jul 2021 14:44:42 -0400 (EDT)
Subject: Re: [PATCH v3 14/34] fsmonitor--daemon: implement 'start' command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com>
 <87a6n5d600.fsf@evledraar.gmail.com>
 <80fb703d-0f88-110e-5a5c-e8e9a90bbc17@jeffhostetler.com>
 <87sg0i2iid.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <55e15a7a-b15e-78bd-b3c3-4adff3363edd@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 14:44:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87sg0i2iid.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/13/21 1:54 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 13 2021, Jeff Hostetler wrote:
> 
>> My response here is in addition to Dscho's remarks on this topic.
>> He makes excellent points that I'll just #include here.  I do want
>> to add my own $0.02 here.
>>
>> On 7/1/21 6:18 PM, Ævar Arnfjörð Bjarmason wrote:
>>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>>

>>>> +/*
>>>> + * This is adapted from `wait_or_whine()`.  Watch the child process and
>>>> + * let it get started and begin listening for requests on the socket
>>>> + * before reporting our success.
>>>> + */
>>>> +static int wait_for_background_startup(pid_t pid_child)
>>>> +{
>>>> +	int status;
>>>> +	pid_t pid_seen;
>>>> +	enum ipc_active_state s;
>>>> +	time_t time_limit, now;
>>>> +
>>>> +	time(&time_limit);
>>>> +	time_limit += fsmonitor__start_timeout_sec;
>>>> +
>>>> +	for (;;) {
>>>> +		pid_seen = waitpid(pid_child, &status, WNOHANG);
>>>> +
>>>> +		if (pid_seen == -1)
>>>> +			return error_errno(_("waitpid failed"));
>>>> +		else if (pid_seen == 0) {
>>>> +			/*
>>>> +			 * The child is still running (this should be
>>>> +			 * the normal case).  Try to connect to it on
>>>> +			 * the socket and see if it is ready for
>>>> +			 * business.
>>>> +			 *
>>>> +			 * If there is another daemon already running,
>>>> +			 * our child will fail to start (possibly
>>>> +			 * after a timeout on the lock), but we don't
>>>> +			 * care (who responds) if the socket is live.
>>>> +			 */
>>>> +			s = fsmonitor_ipc__get_state();
>>>> +			if (s == IPC_STATE__LISTENING)
>>>> +				return 0;
>>>> +
>>>> +			time(&now);
>>>> +			if (now > time_limit)
>>>> +				return error(_("fsmonitor--daemon not online yet"));
>>>> +		} else if (pid_seen == pid_child) {
>>>> +			/*
>>>> +			 * The new child daemon process shutdown while
>>>> +			 * it was starting up, so it is not listening
>>>> +			 * on the socket.
>>>> +			 *
>>>> +			 * Try to ping the socket in the odd chance
>>>> +			 * that another daemon started (or was already
>>>> +			 * running) while our child was starting.
>>>> +			 *
>>>> +			 * Again, we don't care who services the socket.
>>>> +			 */
>>>> +			s = fsmonitor_ipc__get_state();
>>>> +			if (s == IPC_STATE__LISTENING)
>>>> +				return 0;
>>>> +
>>>> +			/*
>>>> +			 * We don't care about the WEXITSTATUS() nor
>>>> +			 * any of the WIF*(status) values because
>>>> +			 * `cmd_fsmonitor__daemon()` does the `!!result`
>>>> +			 * trick on all function return values.
>>>> +			 *
>>>> +			 * So it is sufficient to just report the
>>>> +			 * early shutdown as an error.
>>>> +			 */
>>>> +			return error(_("fsmonitor--daemon failed to start"));
>>>> +		} else
>>>> +			return error(_("waitpid is confused"));
>>>> +	}
>>>> +}
>>> Ditto this. could we extend the wait_or_whine() function (or some
>>> extended version thereof) to do what you need with callbacks?
>>> It seems the main difference is just being able to pass down a flag
>>> for
>>> waitpid(), and the loop needing to check EINTR or not depending on
>>> whether WNOHANG is passed.
>>> For e.g. the "We don't care about the WEXITSTATUS()" you'd get that
>>> behavior with an adjusted wait_or_whine(). Wouldn't it be better to
>>> report what exit status it exits with e.g. if the top-level process is
>>> signalled? We do so in trace2 for other things we spawn...
>>>
>>
>> Again, I don't want to mix my usage here with the existing code
>> and destabilize all existing callers.  Here we are spinning to give
>> the child a chance to *start* and confirm that it is in a listening
>> state and ready for connections.  We do not wait for the child to
>> exit (unless it dies quickly without becoming ready).
>>
>> We want to end our wait as soon as we confirm that the child is
>> ready and return.  All I really need from the system is `waitpid()`.
> 
> Will this code behave correctly if the daemon we start is signalled per
> the WIFSIGNALED() cases the code this is derived handles, but this does
> not?

We're only waiting until the child gets started and is able to receive
requests -- what happens to it after we have confirmed that it is ready
is not our concern (after all, the parent is about to exit anyway and
the child is going to continue on).

If waitpid() gives us a WIFSIGNALED (or any other WIF*() state) before
we have spoken to it, we will return a "failed to start".

But again, that signal would have to arrive immediately after we spawned
it and *before* we could talk to it.  If the child is signaled after we
confirmed it was ready, we don't care because the parent process will be
gone.

(If the child is signaled or is killed (or crashes or whatever), the
next Git command (like "status") that tries to talk to it will re-start
it implicitly -- the `git fsmonitor--daemon start` command here is an
explicit start.)


> 
> But sure, I just meant to point out that the flip side to "destabilize
> all existing callers" is reviewing new code that may be subtly buggy,
> and those subtle bugs (if any) would be smoked out if we were forced to
> extend run-command.c, i.e. to use whatever feature(s) this needs for all
> existing callers.
> 

That would/could have a massive footprint.  And I've already established
that my usage here is sufficiently different from existing uses that the
result would be a mess. IMHO.

Jeff
