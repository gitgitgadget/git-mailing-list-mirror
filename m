Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F3C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DA96501D
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 16:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhCLQvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 11:51:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:27969 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhCLQvk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 11:51:40 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 97EB63F40D9;
        Fri, 12 Mar 2021 11:51:39 -0500 (EST)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2ED873F4098;
        Fri, 12 Mar 2021 11:51:39 -0500 (EST)
Subject: Re: What to do with fsmonitor-watchman hook and config-based hooks?
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>
References: <CAJoAoZk0fSyPSJZ51wNv4XujPA_-hPfh8eMRQPbyeTXFvKJ9+Q@mail.gmail.com>
 <33a12a7a-d19c-63b8-f21e-db7e517b0f53@gmail.com>
 <YEpxVELGCxtnNxQK@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e019cc71-ac39-44a4-0a23-b3b7decec754@jeffhostetler.com>
Date:   Fri, 12 Mar 2021 11:51:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YEpxVELGCxtnNxQK@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/11/21 2:36 PM, Emily Shaffer wrote:
> On Thu, Mar 11, 2021 at 02:23:03PM -0500, Derrick Stolee wrote:
>>
>> On 3/11/2021 1:42 PM, Emily Shaffer wrote:
>>> Hi folks, I grabbed a bunch of CC from 'git blame fsmonitor.c' so
>>> sorry if you don't care about fsmonitor-watchman anymore... :) Note
>>> that this whole conversation has to do with the series proposed at
>>> https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com.
>>>
>>> When I was looking through the remaining hooks in
>>> Documentation/githooks.txt I noticed that the fsmonitor-watchman hook
>>> is implemented somewhat differently than most other hooks. As I
>>> understand it, to use that hook someone needs to:
>>>
>>> 1. Configure core.fsmonitor with a path to some fsmonitor-watchman
>>> hook. The documentation in 'Documentation/githooks.txt' claims that it
>>> needs to point to '.git/hooks/fsmonitor-watchman' or
>>> '.git/hooks/fsmonitor-watchmanv2', but I don't see that constraint
>>> enforced when the config is read (config.c:git_config_get_fsmonitor()
>>> and fsmonitor.c:query_fsmonitor()), so it seems that core.fsmonitor
>>> can point to wherever it wants. (Plus
>>> 'templates/blt/hooks/fsmonitor-watchman.sample' suggests setting
>>> 'core.fsmonitor' = '.git/hooks/query-watchman'...)
>>> 2. Configure core.fsmonitorhookversion to 1 or 2, to indicate the arg
>>> structure for the executable specified in core.fsmonitor.
>>
>> This is correct.
>>
>>> Because the executable doesn't necessarily live in .git/hooks/,
>>> fsmonitor.c:query_fsmonitor() completely skips the "API" for running
>>> hooks (run-command.h:run_hook_le()) and just uses
>>> run-command.h:capture_command() directly.
>>>
>>> Interestingly, this is really similar to the way config-based hooks
>>> (https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com)
>>> work - but different enough that I think it may be awkward to
>>> transition fsmonitor-watchman to work like everything else. So, some
>>> questions, plus a proposal:
>>
>> You'll want to get Jeff Hostetler's perspective first, but I'm of
>> the opinion that we'll want to stop recommending the Watchman hook
>> when the Git-native FS Monitor feature lands, with some time to
>> let things release and simmer before we remove the core.fsmonitor
>> config option. We would also need a Linux implementation, but that
>> is planned.
>>
>> If we think that the plan of "eventually, FS Monitor won't use hooks"
>> is reasonable, then how much do you want to spend time unifying it
>> with your config-based hooks? Can they live together temporarily?
> 
> Oh, that's useful context. If fsmonitor-watchman hook is going away, I
> don't think it's necessary to convert it at all, unless someone starts
> asking for multihooks or something. There's no practical conflict between
> config-based hooks and the current implementation - it's just a
> surprising inconsistency. I'll be curious to hear Jeff's opinion, of
> course, but given what you're describing, I'm not convinced it's worth
> spending any time on - and when we're ready to stop checking
> core.fsmonitor then the inconsistency will just go away.
> 
> The documentation in githooks.txt could use an update, though. :)
> 
>   - Emily
> 

I don't think it makes sense to have multiple fsmonitors for a given
working directory.  They are fairly expensive to operate (listening
to the kernel for events and building an in-memory database of changed
files) and I'm not sure how two running concurrently (and listening to
the same kernel event stream) would come up with different answers.

The thing about the fsmonitor-watchman or query-watchman hook is that
it is a bash/perl script that talks to a long-running service daemon.
The hook script itself is just a proxy to decode the JSON response from
Watchman and emit it on stdout in a way that the foreground Git command
expects.  Git cannot directly talk to Watchman because it doesn't
currently have the plumbing to talk to it on anything other than a fd
pair that it sets up to give to the hook child.

So your example of a watcher for NTFS and a separate watcher for ext4
means you could maybe have two services running, but the foreground
Git command would only need to spawn a single hook and maybe it would
decide which service to talk to based upon the filesystem type of the
working directory.  Or you set the repo-local config for each repo to
point to a hook script that knew which service to talk to.  Either way
you only need to invoke one hook.

Setting it globally is an option, but fsmonitor is beneficial for large
repos and working directories.  There is an overhead to having it
running and talking to it.  (Spawning a hook written in PERL, having
the hook talk to Watchman via some form of IPC, the hook parsing the 
mess of JSON returned, pumping that data back over stdout to Git, and
having Git apply the results to the ce_flags.)  All of that has to
happen *before* Git actually starts to do anything useful.  For small
repos, all of that overhead costs more than the cost of letting the
foreground `git status` just lstat() everything.  Of course all of this
depends on the speed of your filesystem and the size of your working
directory (and whether you have a sparse-checkout and etc), but there
are lots of repos that just don't need fsmonitor.

So yes, I would leave the existing fsmonitor code as is and not try
to combine it with your current efforts (even if I wasn't working on
a replacement for the fsmonitor-watchman setup).

As Stolee mentioned I'm currently working on a builtin fsmonitor
feature.  It will have a native coded-in-Git-C-code daemon to watch
the filesystem.  Clients, such as `git status`, will directly talk
to it via my "Simple IPC" patch series and completely bypass all of
the hook stuff.

Long term both fsmonitor solutions can co-exist.  Or we can eventually
deprecate the hook version.  Given that, I don't see a need to change
the existing fsmonitor hook code.

Hope this helps,
Jeff

