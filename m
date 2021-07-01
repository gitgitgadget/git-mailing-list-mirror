Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9853C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDADD61405
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 18:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhGASb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:31:56 -0400
Received: from siwi.pair.com ([209.68.5.199]:33690 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhGASb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 14:31:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5E36A3F40E4;
        Thu,  1 Jul 2021 14:29:24 -0400 (EDT)
Received: from HOLO-STUX-BVT04.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1D1933F40D9;
        Thu,  1 Jul 2021 14:29:24 -0400 (EDT)
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <87fswyc4dz.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
Date:   Thu, 1 Jul 2021 14:29:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87fswyc4dz.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 1:40 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> Here is V3 of my patch series to add a builtin FSMonitor daemon to Git. I
>> rebased this series onto v2.32.0.
>>
>> V3 addresses most of the previous review comments and things we've learned
>> from our experimental testing of V2. (A version of V2 was shipped as an
>> experimental feature in the v2.32.0-based releases of Git for Windows and
>> VFS for Git.)
>>
>> There are still a few items that I need to address, but that list is getting
>> very short.
> 
> ...
>>    fsmonitor-fs-listen-win32: stub in backend for Windows
>>    fsmonitor-fs-listen-macos: stub in backend for MacOS
> 
> I left some light comments on the repo-settings.c part of this to follow
> up from a previous round.

Thanks.

> 
> Any other testing of it is stalled by there being no linux backend for
> it as part of this series. I see from spelunking repos that Johannes had
> a WIP compat/fsmonitor/linux.c which looks like it could/should mostly
> work, but the API names all changed since then, and after a short try I
> gave up on trying to rebase it.

The early Linux version was dropped because inotify does not give
recursive coverage -- only the requested directory.  Using inotify
requires adding a watch to each subdirectory (recursively) in the
worktree.  There's a system limit on the maximum number of watched
directories (defaults to 8K IIRC) and that limit is system-wide.

Since the whole point was to support large very large repos, using
inotify was a non-starter, so I removed the Linux version from our
patch series.  For example, the first repo I tried it on (outside
of the test suite) had 25K subdirectories.

I'm told there is a new fanotify API in recent Linux kernels that
is a better fit for what we need, but we haven't had time to investigate
it yet.

> 
> I'd really prefer for git not to have features that place free platforms
> at a disadvantage against proprietary platforms if it can be avoided,
> and in this case the lack of a Linux backend also means much less
> widespread testing of the feature among the development community / CI.
> 

This feature is always going to have platform-specific components,
so the lack of one platform or another should not stop us from
discussing it for the platforms that can be supported.

And given the size and complexity of the platform-specific code,
we should not assume that "just test it on Linux" is sufficient.
Yes, there are some common/shared routines/data structures in the
daemon, but hard/tricky parts are in the platform layer.

Jeff
