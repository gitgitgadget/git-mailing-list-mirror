Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B998C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 19:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4230761416
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 19:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhGBTJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 15:09:07 -0400
Received: from siwi.pair.com ([209.68.5.199]:52038 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhGBTJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 15:09:07 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9A5BF3F40E6;
        Fri,  2 Jul 2021 15:06:33 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 563893F40DA;
        Fri,  2 Jul 2021 15:06:33 -0400 (EDT)
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        David Turner <David.Turner@twosigma.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <87fswyc4dz.fsf@evledraar.gmail.com>
 <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
 <87czs1d6uy.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9ac45626-f995-a661-2746-6711f996e5a6@jeffhostetler.com>
Date:   Fri, 2 Jul 2021 15:06:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87czs1d6uy.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 5:26 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler wrote:
> 
>> On 7/1/21 1:40 PM, Ævar Arnfjörð Bjarmason wrote:
>>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>>
>>>> Here is V3 of my patch series to add a builtin FSMonitor daemon to Git. I
>>>> rebased this series onto v2.32.0.
>>>>
>>>> V3 addresses most of the previous review comments and things we've learned
>>>> from our experimental testing of V2. (A version of V2 was shipped as an
>>>> experimental feature in the v2.32.0-based releases of Git for Windows and
>>>> VFS for Git.)
>>>>
>>>> There are still a few items that I need to address, but that list is getting
>>>> very short.
>>> ...
>>>>     fsmonitor-fs-listen-win32: stub in backend for Windows
>>>>     fsmonitor-fs-listen-macos: stub in backend for MacOS
>>> I left some light comments on the repo-settings.c part of this to
>>> follow
>>> up from a previous round.
>>
>> Thanks.
>>
>>> Any other testing of it is stalled by there being no linux backend
>>> for
>>> it as part of this series. I see from spelunking repos that Johannes had
>>> a WIP compat/fsmonitor/linux.c which looks like it could/should mostly
>>> work, but the API names all changed since then, and after a short try I
>>> gave up on trying to rebase it.
>>
>> The early Linux version was dropped because inotify does not give
>> recursive coverage -- only the requested directory.  Using inotify
>> requires adding a watch to each subdirectory (recursively) in the
>> worktree.  There's a system limit on the maximum number of watched
>> directories (defaults to 8K IIRC) and that limit is system-wide.
>>
>> Since the whole point was to support large very large repos, using
>> inotify was a non-starter, so I removed the Linux version from our
>> patch series.  For example, the first repo I tried it on (outside
>> of the test suite) had 25K subdirectories.
>>
>> I'm told there is a new fanotify API in recent Linux kernels that
>> is a better fit for what we need, but we haven't had time to investigate
>> it yet.
> 
> That default limit is a bit annoying, but I don't see how it's a blocker
> in any way.
> 
> You simply adjust the limit. E.g. I deployed and tested the hook version
> of inotify (using watchman) in a sizable development environment, and
> written my own code using the API. This was all before fanotify(7)
> existed. IIRC I set most of the limits to 2^24 or 2^20. I've used it
> with really large Git repos, including with David Turner's
> 2015-04-03-1M-git for testing (`git ls-files | wc -l` on that is around
> a quarter-million).
> 
> If you have a humongous repository and don't have root on your own
> machine you're out of luck. But I think most people who'd use this are
> either using their own laptop, or e.g. in a corporate setting where
> administrators would tweak the sysctl limits given the performance
> advantages (as I did).
> 
> Once you adjust the limits Linux deals with large trees just fine, it
> just has overly conservative limits for most things in sysctl. The API
> is a bit annoying, your event loop needs to run around and add watches.
> 
> AFAICT you need Linux 5.1 for fanotify(7) to be useful, e.g. Debian
> stable, RHEL etc. aren't using anything that new. So having an inotify
> backend as well as possibly a fanotify one would be very useful.
> 
> And linux.git's docs suggest that the default limit was bumped from 8192
> to 1M in v5.10, a really recent kernel, so if you've got that you've
> also got fanotify.
> 
> In any case, even if Linux's inotify limit was something hardcoded and
> impossible to change you could still use such an API to test & debug the
> basics of this feature on that platform.

Good points.  If the inotify limits can be increased into the millions
then we can revisit supporting it.  I do worry about possible race
conditions as we have to scan the worktree and add/delete a watch for
each directory, but we don't need to worry about that right now.

I do want to have Linux support eventually, but I was saving it for
a later effort (and/or looking for volunteers).  My IPC-based builtin
daemon complements the existing hook-based fsmonitor support that Ben
Peart and Kevin Willford added a few years ago.  That model (and PERL
hook script and Watchman integration) work fine for Linux, so the
advantages of a builtin monitor aren't as compelling.

For example, on Linux, hook process creation is fast, PERL is fast,
and it is easy to just apt-get a tool like Watchman.  But on
Windows, process creation is slow, NTFS is slow, PERL is available
as part of the Git-for-Windows distribution, and installing third-party
tools like Watchman onto a collection of enterprise users' machines is
a chore, so it made sense of us to pick platforms where the existing
hook model has issues and add other platforms later.

Besides, this patch series is already at 34 commits.  And some of
them are quite large.  Adding another platform would just make it
even larger.

Right now I'm more interested in the larger question of whether
we WANT to have a builtin fsmonitor and do we like the overall
design of what I have here?  Picking up a new platform, whether
it is Linux, or AIX, or Solaris, or Nonstop, or whatever, should
nicely fit into one platform-specific file in compat/fsmonitor
and not take that long.

> 
>>> I'd really prefer for git not to have features that place free
>>> platforms
>>> at a disadvantage against proprietary platforms if it can be avoided,
>>> and in this case the lack of a Linux backend also means much less
>>> widespread testing of the feature among the development community / CI.
>>>
>>
>> This feature is always going to have platform-specific components,
>> so the lack of one platform or another should not stop us from
>> discussing it for the platforms that can be supported.
> 
> (I think per the above that's s/can be/are/)
> 
>> And given the size and complexity of the platform-specific code,
>> we should not assume that "just test it on Linux" is sufficient.
>> Yes, there are some common/shared routines/data structures in the
>> daemon, but hard/tricky parts are in the platform layer.
> 
> I think we're talking past each other a bit here. I'm not saying that
> you can get full or meaningful testing for it on Windows if you test it
> on Linux, or the other way around.
> 
> Of course there's platform-specific stuff, although there's also a lot
> of non-platform-specific stuff, so even a very basic implementation of
> inotify would make reviwing this easier / give access to more reviewers.
> 
> I'm saying that I prefer that Git as a free software project not be in
> the situation of saying the best use-case for a given size/shape of repo
> is to use Git in combination with proprietary operating systems over
> freely licensed ones.

I wouldn't worry about that.  Even without Watchman integration,
Linux runs things so much faster than anything else it's not funny.

If anything, we need things like fsmonitor on Windows to help keep
up with Linux.

> 
> IOW what the FSF has a policy for GNU projects. Now, I think the FSF
> probably goes too far in that (famously removing rather obscure font
> rendering features from Emacs on OSX), but "manage lots of data" is a
> core feature of git.
> 

Jeff
