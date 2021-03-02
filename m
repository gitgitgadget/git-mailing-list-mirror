Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C044BC433DB
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6621164EBA
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448764AbhCCGfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:12542 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233189AbhCBXwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 18:52:33 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0C8833F4133;
        Tue,  2 Mar 2021 18:50:52 -0500 (EST)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BF00B3F4131;
        Tue,  2 Mar 2021 18:50:51 -0500 (EST)
Subject: Re: [PATCH v4 10/12] unix-socket: create
 `unix_stream_server__listen_with_lock()`
To:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <b443e11ac32fd3082a59ada42ada8c8973fa0b8a.1613598529.git.gitgitgadget@gmail.com>
 <YDipqpvCoE0WnJSi@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d29f0f18-a292-8090-fe69-70576aa10506@jeffhostetler.com>
Date:   Tue, 2 Mar 2021 18:50:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YDipqpvCoE0WnJSi@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/26/21 2:56 AM, Jeff King wrote:
> On Wed, Feb 17, 2021 at 09:48:46PM +0000, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create a version of `unix_stream_listen()` that uses a ".lock" lockfile
>> to create the unix domain socket in a race-free manner.
> 
> The "unix_stream_server__listen_with_lock" name is quite a mouthful.  My
> first question was: don't we have an "options" struct that we can use to
> tell it we're interested in using the locking strategy?
> 
> But I do find it a little weird for the feature to be at this layer at
> all. I'd have thought it would make more sense in the simple-ipc layer
> that implements the unix-socket backend, where app-level logic like
> "it's OK to just connect to this socket and hang up in order to ping it"
> might be more appropriate. We might even want to have a more robust
> check (e.g., an actual "ping" that expects the server to say "yes, I'm
> here").

I think when I started this, the "safe listen" was much closer to the
original `unix_stream_listen()` and it made sense to keep it nearby,
but as it evolved (and we added lockfiles and etc.) it grew to be more
like its own level between the original socket code and the simple-ipc
layer.  Pulling it out into its own source file is probably a good idea
for clarity.

I was thinking that the "ping" is just to see if a server is listening
or not.  (And I viewed that as kind of a hack, but it works.)  If we
start sending data back and forth, we get into protocols and blocking
and stuff that this layer (even if we move it up a level) doesn't know
about.

I'll pull this out into a new file.


> 
> (But also see below where I am less certain about this...)
> 
>> Unix domain sockets have a fundamental problem on Unix systems because
>> they persist in the filesystem until they are deleted.  This is
>> independent of whether a server is actually listening for connections.
>> Well-behaved servers are expected to delete the socket when they
>> shutdown.  A new server cannot easily tell if a found socket is
>> attached to an active server or is leftover cruft from a dead server.
>> The traditional solution used by `unix_stream_listen()` is to force
>> delete the socket pathname and then create a new socket.  This solves
>> the latter (cruft) problem, but in the case of the former, it orphans
>> the existing server (by stealing the pathname associated with the
>> socket it is listening on).
> 
> Nicely explained.
> 
>> We cannot directly use a .lock lockfile to create the socket because
>> the socket is created by `bind(2)` rather than the `open(2)` mechanism
>> used by `tempfile.c`.
>>
>> As an alternative, we hold a plain lockfile ("<path>.lock") as a
>> mutual exclusion device.  Under the lock, we test if an existing
>> socket ("<path>") is has an active server.  If not, create a new
>> socket and begin listening.  Then we rollback the lockfile in all
>> cases.
> 
> Make sense.
> 
>> +static int is_another_server_alive(const char *path,
>> +				   const struct unix_stream_listen_opts *opts)
>> +{
>> +	struct stat st;
>> +	int fd;
>> +
>> +	if (!lstat(path, &st) && S_ISSOCK(st.st_mode)) {
>> +		/*
>> +		 * A socket-inode exists on disk at `path`, but we
>> +		 * don't know whether it belongs to an active server
>> +		 * or whether the last server died without cleaning
>> +		 * up.
>> +		 *
>> +		 * Poke it with a trivial connection to try to find
>> +		 * out.
>> +		 */
>> +		fd = unix_stream_connect(path, opts->disallow_chdir);
>> +		if (fd >= 0) {
>> +			close(fd);
>> +			return 1;
>> +		}
>> +	}
> 
> The lstat() seems redundant here. unix_stream_connect() will tell us
> whether there is something to connect to or not. (It's also racy with
> respect to the actual connect, but since you're doing this under lock, I
> don't think that matters).

I agree.  I'll get rid of the lstat().


> 
>> +struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
>> +	const char *path,
>> +	const struct unix_stream_listen_opts *opts)
>> +{
>> +	struct lock_file lock = LOCK_INIT;
>> +	int fd_socket;
>> +	struct unix_stream_server_socket *server_socket;
>> +
>> +	/*
>> +	 * Create a lock at "<path>.lock" if we can.
>> +	 */
>> +	if (hold_lock_file_for_update_timeout(&lock, path, 0,
>> +					      opts->timeout_ms) < 0) {
>> +		error_errno(_("could not lock listener socket '%s'"), path);
>> +		return NULL;
>> +	}
> 
> Would you want to ping to see if it's alive before creating the lock?
> That would be the fast-path if we assume that a server will usually be
> there once started. Or is that supposed to happen in the caller (in
> which case I'd again wonder if this really should be happening in the
> simple-ipc code).

Starting a server should not happen that often, so I'm not sure it
matters.  And yes, a server once started should run for a long time.
Pinging without the lock puts us back in another race, so we might as
well lock first.

> 
>> +	/*
>> +	 * If another server is listening on "<path>" give up.  We do not
>> +	 * want to create a socket and steal future connections from them.
>> +	 */
>> +	if (is_another_server_alive(path, opts)) {
>> +		errno = EADDRINUSE;
>> +		error_errno(_("listener socket already in use '%s'"), path);
>> +		rollback_lock_file(&lock);
>> +		return NULL;
>> +	}
> 
> Wouldn't this be a "success" case for a caller? They did not open the
> server themselves, but they are presumably happy that there is one there
> now to talk to. So do we actually want to print an error to stderr?
> Likewise, how do they tell the difference between this NULL and the NULL
> we returned above because we couldn't take the lock? Or the NULL we
> return below because there is some error creating a listening socket?
> 
> I'd think in those three cases you'd want:
> 
>    - if lock contention, pause a moment and wait for the winner to spin
>      up and serve requests
> 
>    - if another server is live while we hold the lock, then we raced them
>      and they won. Release the lock and start using them.
> 
>    - if we really tried to call unix_stream_listen() and that failed,
>      give up now. There is some system error that is not likely to be
>      fixed by trying anything more (e.g., ENAMETOOLONG).

Yes, I want to move the error messages out of these library layers.

And yes, if another server is running, our server instance should
shutdown gracefully.  Other client processes can just talk to them
rather than us.

> 
>> +	server_socket = xcalloc(1, sizeof(*server_socket));
>> +	server_socket->path_socket = strdup(path);
>> +	server_socket->fd_socket = fd_socket;
> 
> What do we need this server_socket for? The caller already knows the
> path; they fed it to us. We do need to return the descriptor, but we
> could do that directly.

I wanted a wrapper struct to persist a copy of the pathname near
the fd.  Later when we get ready to shutdown, we can close and unlink
without worrying whether our caller kept their copy of the path buffer.

This also lets me have the pathname to poll and check for theft during
the accept thread's event loop.

> 
>> +	lstat(path, &server_socket->st_socket);
> 
> This lstat I guess is part of your "periodically check to see if we're
> still the one holding the socket" strategy. We _shouldn't_ need that
> anymore, with the dotlocking, but I'm OK with it as a
> belt-and-suspenders check. But why are we filling in the lstat here?
> This seems like something that the unix-socket code doesn't really need
> to know about (though you do at least provide the complementary
> "was_stolen" function here, so that part makes sense).

The dotlock is only on disk for the duration of the socket setup.
We do the rollback (to delete the lockfile) once we have the socket
open and ready for business.

The lstat gives me the inode of the socket on disk and we can watch
it with future lstat's in the event loop and see if it changes and
detect theft and auto-shutdown.

> 
> Again, I guess I'd find it less weird if it were happening at a layer
> above. Maybe I'm really just complaining that this is in unix-socket.c.
> I guess it is a separate unix_stream_server data type. Arguably that
> should go in a separate file, but I guess the whole conditional
> compilation of unix-socket.c makes that awkward. So maybe this is the
> least-bad thing.

Yeah, I'll move it out.

And yes, the whole conditional compilation thing was something I was
hesitating on, but it really isn't that bad.  (But I should not brag
here until all of the build servers have had their say....)

> 
>> +	/*
>> +	 * Always rollback (just delete) "<path>.lock" because we already created
>> +	 * "<path>" as a socket and do not want to commit_lock to do the atomic
>> +	 * rename trick.
>> +	 */
>> +	rollback_lock_file(&lock);
>> +
>> +	return server_socket;
>> +}
> 
> OK, this part makes sense to me.
> 
>> +void unix_stream_server__free(
>> +	struct unix_stream_server_socket *server_socket)
>> +{
>> +	if (!server_socket)
>> +		return;
>> +
>> +	if (server_socket->fd_socket >= 0) {
>> +		if (!unix_stream_server__was_stolen(server_socket))
>> +			unlink(server_socket->path_socket);
>> +		close(server_socket->fd_socket);
>> +	}
>> +
>> +	free(server_socket->path_socket);
>> +	free(server_socket);
>> +}
> 
> OK, this makes sense. We only remove it if we're still the ones holding
> it. That's not done under lock, though, so it's possibly racy (somebody
> steals from us while _they_ hold the lock; we check and see "not stolen"
> right before they steal it, and then we unlink their stolen copy).

Right, I didn't bother with the lock here.  I don't think we need it.

We technically still have the socket open and are listening on it when
we lstat and unlink it.  The other process should create the lock and
try to connect.  That should hang in the kernel because of the accept()
grace period.  Then we close the socket and the client's connection
request errors because we didn't accept it.  They will see the error
as no one is listening and then create their own socket.

> 
>> +int unix_stream_server__was_stolen(
>> +	struct unix_stream_server_socket *server_socket)
>> +{
>> +	struct stat st_now;
>> +
>> +	if (!server_socket)
>> +		return 0;
>> +
>> +	if (lstat(server_socket->path_socket, &st_now) == -1)
>> +		return 1;
>> +
>> +	if (st_now.st_ino != server_socket->st_socket.st_ino)
>> +		return 1;
>> +
>> +	/* We might also consider the ctime on some platforms. */
>> +
>> +	return 0;
>> +}
> 
> You probably should confirm that st.dev matches, too, since that is the
> namespace for st.ino. Maybe also double check that it's still a socket
> with S_ISSOCK(st_mode)?

Good point.

> 
> -Peff
> 

Thanks for all the careful study.  I'll push up a new series to
address them shortly.

Jeff
