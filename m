Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E870DC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934DE616E9
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhEKTZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:25:17 -0400
Received: from siwi.pair.com ([209.68.5.199]:17828 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhEKTZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:25:16 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B54083F4090;
        Tue, 11 May 2021 15:24:09 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8A4963F4047;
        Tue, 11 May 2021 15:24:09 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: only enable it in non-bare repositories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
 <87mttbx6ie.fsf@evledraar.gmail.com>
 <810dc60c-3730-b5f3-34f6-5cc2ddc9942a@jeffhostetler.com>
 <87k0oex1yi.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e5e162b7-231c-29e1-174c-10d2c151769e@jeffhostetler.com>
Date:   Tue, 11 May 2021 15:24:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87k0oex1yi.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/3/21 1:56 PM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, May 03 2021, Jeff Hostetler wrote:
> 
>> On 5/3/21 9:58 AM, Ævar Arnfjörð Bjarmason wrote:
>>> On Thu, Apr 29 2021, Johannes Schindelin via GitGitGadget wrote:
>>>
>>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>>
>>>> The entire point of the FSMonitor is to monitor the worktree changes in
>>>> a more efficient manner than `lstat()`ing all worktree files every time
>>>> we refresh the index.
>>>>
>>>> But if there is no worktree, FSMonitor has nothing to monitor.
>>>>
>>>> So let's ignore if an FSMonitor is configured (e.g. in `~/.gitconfig`)
>>>> and we're running in a repository without worktree.
>>>>
>>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>> ---
>> ...
>>>>
>>>> base-commit: 14d50074ff19e68e7a8d718b22d138882087bbc9
>>> This is surely a correct fix for now, but wouldn't it in the future
>>> also
>>> be useful to run it in bare repositories e.g. to be able cache lookups
>>> for non-existing loose objects?
>>>
>>
>> No, the FSMonitor feature only expects data for paths within the
>> working directory.  (And is independent of whether the FS change
>> data is provided by my fsmonitor--daemon or provided by a hook-based
>> provider, such as Watchman.)  The FSMonitor feature uses that data to
>> shortcut scans of the working directory.
> 
> Indeed, hence "in the future". I'm not suggesting that it'll do anything
> useful by watching anything in the .git directory now, but that it might
> be an interesting thing to explore.
> 
>> There is no interaction with the contents of the .git/objects
>> directory and I'm not sure how that would work.
> 
> We'd watch .git/objects and .git/objects/{aa..ff}, then when about to
> check for a loose object we'd avoid hitting the FS.
> 
> I don't know how useful that is post-61c7711cfea (sha1-file: use loose
> object cache for quick existence check, 2018-11-12), but e.g. on NFS
> this sort of thing still mattered. I had a "bigger hammer" approach with
> [1] that ran (and still does, I believe) on a big corporate
> installation.
> 
> More generally, if you strace .git access during repo operations you'll
> find we're doing all sorts of existence checks etc. all the time. Loose
> objects, refs, seeing what packs there are (better with the MIDX, but do
> we still fall back?) etc. If we had up-to-date inotify/fsmonitor info we
> could ask the daemon about it.
> 
> 1. https://lore.kernel.org/git/20181028225023.26427-5-avarab@gmail.com/
> 

Interesting.

That's certainly something to look into later.  I know there is
code in the object lookup code to rescan/reload the packfiles or
loose objects (under the assumption that another process just created
a new packfile (and after our process loaded the packed-git list)).
Such a daemon might be helpful to improve something like that.

But I can't think about any of that right now.  I'd like to finish the
current fsmonitor--daemon patch series and let it settle down
before starting to think about an orthogonal use case such as this.

Thanks
Jeff
