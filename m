Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0766EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0EB64E63
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhBJVcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 16:32:09 -0500
Received: from siwi.pair.com ([209.68.5.199]:36395 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232439AbhBJVcH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 16:32:07 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 800623F40F1;
        Wed, 10 Feb 2021 16:31:25 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 340DB3F40E6;
        Wed, 10 Feb 2021 16:31:25 -0500 (EST)
Subject: Re: [PATCH v2 11/14] unix-socket: add options to unix_stream_listen()
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <7a6a69dfc20c6ff190cb020931c46bf4d88bab59.1612208747.git.gitgitgadget@gmail.com>
 <YBkmD14Nqqxe4pxG@coredump.intra.peff.net>
 <b7a6f741-c52a-db24-3349-dc69610ce21f@jeffhostetler.com>
 <YCK5K/nK4tGnTvou@coredump.intra.peff.net>
 <87eb64b1-a61b-f2cc-f689-6ab0b5ee83d0@jeffhostetler.com>
 <YCQB4SpYhYA/cKAa@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bca58290-3b23-d08e-e2d5-05ce13c5b842@jeffhostetler.com>
Date:   Wed, 10 Feb 2021 16:31:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YCQB4SpYhYA/cKAa@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/10/21 10:55 AM, Jeff King wrote:
> On Tue, Feb 09, 2021 at 12:39:22PM -0500, Jeff Hostetler wrote:
> 
>> Yeah, in my version two processes could still create uniquely named
>> sockets and then do the rename trick.  But they capture the inode
>> number of the socket before they do that.  They periodically lstat
>> the socket to see if the inode number has changed and if so, assume
>> it has been stolen from them.  (A bit of a hack, I admit.)
> 
> OK, that makes more sense. I saw the mention of the inode stuff in a
> comment, but I didn't see it in the code (I guess if it's a periodic
> check it's not in that initial socket creation function).
> 

Yeah, there's a very slow poll(2) loop in the listen/accept thread
that watches for that and new connections (and quit messages).

>> And I was assuming that 2 servers starting at about the same time
>> are effectively equivalent -- it doesn't matter which one dies, since
>> they both should have the same amount of cached state.  Unlike the
>> case where a long-running server (with lots of state) is replaced by
>> a newcomer.
> 
> Yeah, I agree with that notion in general. I do think it would be easier
> to reason about if the creation were truly race-proof (probably with a
> dot-lock; see below), rather than the later "check if we got replaced"
> thing.  OTOH, that "check" strategy covers a variety of cases (including
> that somebody tried to ping us, decided we weren't alive due to a
> timeout or some other system reason, and then replaced our socket).
> 
> Another strategy there could be having the daemon just decide to quit if
> nobody contacts it for N time units. It is, after all, a cache. Even if
> nobody replaces the socket, it probably makes sense to eventually decide
> that the memory we're holding isn't going to good use.

I have the poll(2) loop set to recheck the inode for theft every 60
seconds (randomly chosen).

Assuming the socket isn't stolen, I want to leave any thoughts of
an auto-shutdown to the application layer above it.  My next patch
series will use this ipc mechanism to build a FSMonitor daemon that
will watch the filesystem for changes and then be able to quickly
respond to a `git status`, so it is important that it be allowed to
run without any clients for a while (such a during a build).  Yes,
memory concerns are important, so I do want it to auto-shutdown if
the socket is stolen (or the workdir is deleted).

> 
>> I am wondering if we can use the .LOCK file magic to our advantage
>> here (in sort of an off-label use).  If we have the server create a
>> lockfile "<path>.LOCK" and if successful leave it open/locked for the
>> life of the server (rather than immediately renaming it onto <path>)
>> and let the normal shutdown code rollback/delete the lockfile in the
>> cleanup/atexit.
>>
>> If the server successfully creates the lockfile, then unlink+create
>> the socket at <path>.
> 
> I don't even think this is off-label. Though the normal use is for the
> .lock file to get renamed into place as the official file, there are a
> few other places where we use it solely for mutual exclusion. You just
> always end with rollback_lock_file(), and never "commit" it.
> 
> So something like:
> 
>    1. Optimistically see if socket "foo" is present and accepting
>       connections.
> 
>    2. If not, then take "foo.lock". If somebody else is holding it, loop
>       with a timeout waiting for them to come alive.
> 
>    3. Assuming we got the lock, then either unlink+create the socket as
>       "foo", or rename-into-place. I don't think it matters that much
>       which.
> 
>    4. Rollback "foo.lock", unlinking it.
> 
> Then one process wins the lock and creates the socket, while any
> simultaneous creators spin in step 2, and eventually connect to the
> winner.
> 
>> That would give us the unique/exclusive creation (on the lock) that
>> we need.  Then wrap that with all the edge case cleanup code to
>> create/delete/manage the peer socket.  Basically if the lock exists,
>> there should be a live server listening to the socket (unless there
>> was a crash...).
> 
> I think you'd want to delete the lock as soon as you're done with the
> setup. That reduces the chances that a dead server (e.g., killed by a
> power outage without the chance to clean up after itself) leaves a stale
> lock sitting around.

Thanks this helps.  I've got a version now that is a slight variation on
what you have here that seems to work nicely and has the short-lived
lock file.  I'll post this shortly.

Jeff

