Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7F9C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C280F2311F
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392166AbhALSge (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:36:34 -0500
Received: from siwi.pair.com ([209.68.5.199]:58352 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbhALSgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 13:36:33 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2021 13:36:33 EST
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 716CA3F40F5;
        Tue, 12 Jan 2021 13:26:00 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 22A153F40F4;
        Tue, 12 Jan 2021 13:26:00 -0500 (EST)
Subject: Re: [PATCH 00/10] [RFC] Simple IPC Mechanism
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <87bldu5cbh.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7b32caeb-0989-d638-5830-89ea4a2be506@jeffhostetler.com>
Date:   Tue, 12 Jan 2021 13:25:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87bldu5cbh.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/12/21 11:50 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jan 12 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> This series introduces a multi-threaded IPC mechanism called "Simple IPC".
>> This is a library-layer feature to make it easy to create very long running
>> daemon/service applications and for unrelated Git commands to communicate
>> with them. Communication uses pkt-line messaging over a Windows named pipe
>> or Unix domain socket.
>>
>> On the server side, Simple IPC implements a (platform-specific) connection
>> listener and worker thread-pool to accept and handle a series of client
>> connections. The server functionality is completely hidden behind the
>> ipc_server_run() and ipc_server_run_async() APIs. The daemon/service
>> application only needs to define an application-specific callback to handle
>> client requests.
>>
>> Note that Simple IPC is completely unrelated to the long running process
>> feature (described in sub-process.h) where the lifetime of a "sub-process"
>> child is bound to that of the invoking parent process and communication
>> occurs over the child's stdin/stdout.
>>
>> Simple IPC will serve as a basis for a future builtin FSMonitor daemon
>> feature.
> 
> I only skimmed this so far. In the past we had a git-read-cache--daemon
> -> git-index-helper[1] -> watchman. The last iteration of that seems to
> be the [3] re-roll from Ben Peart in 2017. I used/tested that for a
> while and had some near-production use-cases of it.
> 
> How does this new series relate to that past work (if at all), and (not
> having re-read the old threads) were there reasons those old patch
> serieses weren't merged in that are addressed here, mitigated etc?
> 
> 1. https://lore.kernel.org/git/1402406665-27988-1-git-send-email-pclouds@gmail.com/
> 2. https://lore.kernel.org/git/1457548582-28302-1-git-send-email-dturner@twopensource.com/
> 3. https://lore.kernel.org/git/20170518201333.13088-1-benpeart@microsoft.com/
> 4. https://lore.kernel.org/git/87bmhfwmqa.fsf@evledraar.gmail.com/
> 

I'm starting with the model used by the existing FSMonitor feature
that Ben Peart and Kevin Willford added to Git.

Item [3] looks to be an earlier draft of that effort.  The idea there
was to add the fsmonitor hook that could talk to a daemon like Watchman
and quickly update the in-memory cache-entry flags without the need to
lstat() and similarly update the untracked-cache.  An index extension
was added to remember the last fsmonitor response processed.

Currently in Git, we have a fsmonitor hook (usually a perl script) that
talks to Watchman and translates the Watchman response back into
something that the Git client can understand.  This comes back as a
list of files that have changed since some timestamp (or in V2, relative
to some daemon-specific token).

Items [1,2] are not related to that.  That was a different effort to
quickly fetch a read-only copy of an already-parsed index via shared
memory.  In the last version I saw, there were 2 daemons.  index-helper
kept a fresh view of the index in shared memory and could give it to
the Git client.  The client could just mmap the pre-parsed index and
avoid calling `read_index()`.  Index-helper would drive Watchman to
keep track of cache-entries as they changed and handle the lstat's.

I'm not familiar with [4] (and I only quickly scanned it).  There are
several ideas for finding slow spots while reading the index.  I don't
want to go into all of them, but several are obsolete now.  They didn't
contribute to the current effort.


The Simple IPC series (and a soon to be submitted fsmonitor--daemon
series) are intended to be a follow on to FSMonitor effort that is
currently in Git.

1. Build a git-native daemon to watch the file system and avoid needing
a third-party tool.  This doesn't preclude the use of Watchman, but
having a builtin tool might simplify engineering support costs when
deploying to a large team.

2. Use direct IPC between the Git command and the daemon to avoid the
expense of the Hook API (which is expensive on Windows).

3. Make the daemon Git-aware.  For example, it might want to pre-filter
ignored files.  (This might not be present in V1.  And we might extend
the daemon to do more of this as we improve performance.)

Jeff
