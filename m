Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C49C433DB
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 03:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2E664E0A
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 03:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhBFC7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 21:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhBFCrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 21:47:53 -0500
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Feb 2021 15:35:04 PST
Received: from siwi.pair.com (siwi.pair.com [IPv6:2607:f440::d144:5c7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053AC08ED82
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 15:35:04 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9FF483F4098;
        Fri,  5 Feb 2021 18:28:14 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3F6DC3F4096;
        Fri,  5 Feb 2021 18:28:14 -0500 (EST)
Subject: Re: [PATCH v2 11/14] unix-socket: add options to unix_stream_listen()
To:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <7a6a69dfc20c6ff190cb020931c46bf4d88bab59.1612208747.git.gitgitgadget@gmail.com>
 <YBkmD14Nqqxe4pxG@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b7a6f741-c52a-db24-3349-dc69610ce21f@jeffhostetler.com>
Date:   Fri, 5 Feb 2021 18:28:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YBkmD14Nqqxe4pxG@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/2/21 5:14 AM, Jeff King wrote:
> On Mon, Feb 01, 2021 at 07:45:44PM +0000, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Update `unix_stream_listen()` to take an options structure to override
>> default behaviors.  This includes the size of the `listen()` backlog
>> and whether it should always unlink the socket file before trying to
>> create a new one.  Also eliminate calls to `die()` if it cannot create
>> a socket.
> 
> I sent a follow-up on the previous patch, but I think this part about
> the die() should be folded in there.
> 
> Likewise I think it would probably be easier to follow if we added the
> backlog parameter and the unlink options in separate patches. The
> backlog thing is small, but the unlink part is subtle and requires
> explanation. That's a good sign it might do better in its own commit.

Yes, that helped having them in 2 patches each with 1 concern.

> 
>> Normally, `unix_stream_listen()` always tries to `unlink()` the
>> socket-path before calling `bind()`.  If there is an existing
>> server/daemon already bound and listening on that socket-path, our
>> `unlink()` would have the effect of disassociating the existing
>> server's bound-socket-fd from the socket-path without notifying the
>> existing server.  The existing server could continue to service
>> existing connections (accepted-socket-fd's), but would not receive any
>> futher new connections (since clients rendezvous via the socket-path).
>> The existing server would effectively be offline but yet appear to be
>> active.
>>
>> Furthermore, `unix_stream_listen()` creates an opportunity for a brief
>> race condition for connecting clients if they try to connect in the
>> interval between the forced `unlink()` and the subsequent `bind()` (which
>> recreates the socket-path that is bound to a new socket-fd in the current
>> process).
> 
> OK. I'm still not sure of the endgame here for writing non-racy code to
> establish the socket (which is going to require either some atomic
> renaming or some dot-locking in the caller).  But it's plausible to me
> that this option will be a useful primitive.

In part 14/14 in `ipc-unix-sockets.c:create_listener_socket()` I have
code in the calling layer to (try to) handle both the startup races
and basic collisions with existing long-running servers already using
the socket.

But you're right, it might be good to revisit that as a primitive at
this layer.  We only have 1 other caller right now and I don't know
enough about `credential-cache--daemon` to know if it would benefit
from this or not.

> 
> The implementation looks correct, though here are a few small
> observations/questions/nits:
> 
>> -int unix_stream_listen(const char *path)
>> +int unix_stream_listen(const char *path,
>> +		       const struct unix_stream_listen_opts *opts)
>>   {
>> -	int fd, saved_errno;
>> +	int fd = -1;
>> +	int saved_errno;
>> +	int bind_successful = 0;
>> +	int backlog;
>>   	struct sockaddr_un sa;
>>   	struct unix_sockaddr_context ctx;
>>   
>> -	unlink(path);
>> -
>>   	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
>>   		return -1;
> 
> We can return directly here, because we know there is nothing to clean
> up. Which I thought mean that here...
> 
>> +
>>   	fd = socket(AF_UNIX, SOCK_STREAM, 0);
>>   	if (fd < 0)
>> -		die_errno("unable to create socket");
>> +		goto fail;
> 
> ...we are in the same boat. We did not create a socket, so we can just
> return. That makes our cleanup code a bit simpler. But we can't do that,
> because unix_sockaddr_init() may have done things that need cleaning up
> (like chdir). So what you have here is correct.
> 
> IMHO that is all the more reason to push this (and the similar code in
> unix_stream_connect() added in patch 13) into the previous patch.

Agreed.

> 
>> +	if (opts->force_unlink_before_bind)
>> +		unlink(path);
>>   
>>   	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
>>   		goto fail;
>> +	bind_successful = 1;
> 
> And this one needs to mark a flag explicitly, because we have no other
> visible way of knowing we need to do the unlink. Makes sense.
> 
>> -	if (listen(fd, 5) < 0)
>> +	if (opts->listen_backlog_size > 0)
>> +		backlog = opts->listen_backlog_size;
>> +	else
>> +		backlog = 5;
>> +	if (listen(fd, backlog) < 0)
> 
> The default-to-5 is a bit funny here. We already set the default to 5 in
> UNIX_STREAM_LISTEN_OPTS_INIT. Should it be "0" there, so callers can
> treat that as "use the default", which we fill in here? It probably
> doesn't matter much in practice, but it seems cleaner to have only one
> spot with the magic number.

I'll refactor this a bit.

> 
>> @@ -114,7 +125,10 @@ int unix_stream_listen(const char *path)
>>   fail:
>>   	saved_errno = errno;
>>   	unix_sockaddr_cleanup(&ctx);
>> -	close(fd);
>> +	if (fd != -1)
>> +		close(fd);
>> +	if (bind_successful)
>> +		unlink(path);
>>   	errno = saved_errno;
>>   	return -1;
>>   }
> 
> Should we unlink before closing? I usually try to undo actions in the
> reverse order that they were done. I thought at first it might even
> matter here, such that we'd atomically relinquish the name without
> having a moment where it still points to a closed socket (which might be
> less confusing to somebody else trying to connect). But I guess there
> will always be such a moment, because it's not like we would ever
> accept() or service a request.

I'm not sure it matters, but it does look better to unwind things
in reverse order.  And yes, unlinking first is a little bit safer.

> 
> -Peff
> 
