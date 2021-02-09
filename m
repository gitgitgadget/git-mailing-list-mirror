Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37B8C43381
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8810564EC0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhBIRkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:40:43 -0500
Received: from siwi.pair.com ([209.68.5.199]:37061 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233022AbhBIRkI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:40:08 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A8E903F40B7;
        Tue,  9 Feb 2021 12:39:23 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 684DA3F4096;
        Tue,  9 Feb 2021 12:39:23 -0500 (EST)
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
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <87eb64b1-a61b-f2cc-f689-6ab0b5ee83d0@jeffhostetler.com>
Date:   Tue, 9 Feb 2021 12:39:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YCK5K/nK4tGnTvou@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/9/21 11:32 AM, Jeff King wrote:
> On Fri, Feb 05, 2021 at 06:28:13PM -0500, Jeff Hostetler wrote:
> 
>>> OK. I'm still not sure of the endgame here for writing non-racy code to
>>> establish the socket (which is going to require either some atomic
>>> renaming or some dot-locking in the caller).  But it's plausible to me
>>> that this option will be a useful primitive.
>>
>> In part 14/14 in `ipc-unix-sockets.c:create_listener_socket()` I have
>> code in the calling layer to (try to) handle both the startup races
>> and basic collisions with existing long-running servers already using
>> the socket.
> 
> There you make a temp socket and then try to rename it into place.  But
> because rename() overwrites the destination, it still seems like two
> creating processes can race each other. Something like:
> 
>    0. There's no "foo" socket (or maybe there is a stale one that
>       nobody's listening on).
> 
>    1. Process A wants to become the listener. So it creates foo.A.
> 
>    2. Process B likewise. It creates foo.B.
> 
>    3. Process A renames foo.A to foo. It believes it will now service
>       clients.
> 
>    4. Process B renames foo.B to foo. Now process A is stranded but
>       doesn't realize it.
> 

Yeah, in my version two processes could still create uniquely named
sockets and then do the rename trick.  But they capture the inode
number of the socket before they do that.  They periodically lstat
the socket to see if the inode number has changed and if so, assume
it has been stolen from them.  (A bit of a hack, I admit.)

And I was assuming that 2 servers starting at about the same time
are effectively equivalent -- it doesn't matter which one dies, since
they both should have the same amount of cached state.  Unlike the
case where a long-running server (with lots of state) is replaced by
a newcomer.


> I.e., I don't think this is much different than an unlink+create
> strategy. You've eliminated the window where a process C shows up during
> steps 3 and 4 and sees no socket (because somebody else is in the midst
> of a non-atomic unlink+create operation). But there's no atomicity
> between the "ping the socket" and "create the socket" steps.
> 
>> But you're right, it might be good to revisit that as a primitive at
>> this layer.  We only have 1 other caller right now and I don't know
>> enough about `credential-cache--daemon` to know if it would benefit
>> from this or not.
> 
> Yeah, having seen patch 14, it looks like your only new caller always
> sets the new unlink option to 1. So it might not be worth making it
> optional if you don't need it (especially because the rename trick,
> assuming it's portable, is superior to unlink+create; and you'd always
> be fine with an unlink on the temp socket).


I am wondering if we can use the .LOCK file magic to our advantage
here (in sort of an off-label use).  If we have the server create a
lockfile "<path>.LOCK" and if successful leave it open/locked for the
life of the server (rather than immediately renaming it onto <path>)
and let the normal shutdown code rollback/delete the lockfile in the
cleanup/atexit.

If the server successfully creates the lockfile, then unlink+create
the socket at <path>.

That would give us the unique/exclusive creation (on the lock) that
we need.  Then wrap that with all the edge case cleanup code to
create/delete/manage the peer socket.  Basically if the lock exists,
there should be a live server listening to the socket (unless there
was a crash...).

And yes, then I don't think I need the `preserve_existing` bit in the
opts struct.

> 
> The call in credential-cache--daemon is definitely racy. It's pretty
> much the same thing: it pings the socket to see if it's alive, but is
> still susceptible to the problem above. I was was never too concerned
> about it, since the whole point of the daemon is to hang around until
> its contents expire. If it loses the race and nobody contacts it, the
> worst case is it waits 30 seconds for somebody to give it data before
> exiting. It would benefit slightly from switching to the rename
> strategy, but the bigger race would remain.
> 
> -Peff
> 
