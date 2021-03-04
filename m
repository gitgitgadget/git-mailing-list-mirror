Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C00C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF0064F8F
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 15:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhCDPPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:15:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:52250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233253AbhCDPOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 10:14:40 -0500
Received: (qmail 27198 invoked by uid 109); 4 Mar 2021 15:13:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Mar 2021 15:13:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9614 invoked by uid 111); 4 Mar 2021 15:13:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Mar 2021 10:13:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Mar 2021 10:13:59 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 10/12] unix-socket: create
 `unix_stream_server__listen_with_lock()`
Message-ID: <YED5N1QnnVQ6qbE6@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <b443e11ac32fd3082a59ada42ada8c8973fa0b8a.1613598529.git.gitgitgadget@gmail.com>
 <YDipqpvCoE0WnJSi@coredump.intra.peff.net>
 <d29f0f18-a292-8090-fe69-70576aa10506@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d29f0f18-a292-8090-fe69-70576aa10506@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 02, 2021 at 06:50:51PM -0500, Jeff Hostetler wrote:

> I was thinking that the "ping" is just to see if a server is listening
> or not.  (And I viewed that as kind of a hack, but it works.)  If we
> start sending data back and forth, we get into protocols and blocking
> and stuff that this layer (even if we move it up a level) doesn't know
> about.

Right. Definitely the higher up the stack the ping happens, the more
value it has. But I also see the appeal of keeping this as its own
layer.

> > > +	if (hold_lock_file_for_update_timeout(&lock, path, 0,
> > > +					      opts->timeout_ms) < 0) {
> > > +		error_errno(_("could not lock listener socket '%s'"), path);
> > > +		return NULL;
> > > +	}
> > 
> > Would you want to ping to see if it's alive before creating the lock?
> > That would be the fast-path if we assume that a server will usually be
> > there once started. Or is that supposed to happen in the caller (in
> > which case I'd again wonder if this really should be happening in the
> > simple-ipc code).
> 
> Starting a server should not happen that often, so I'm not sure it
> matters.  And yes, a server once started should run for a long time.
> Pinging without the lock puts us back in another race, so we might as
> well lock first.

Definitely you need to ping under lock to avoid races. But I was
thinking of an additional optimistic ping before we take the lock. I
agree that starting the server should be rare, which is why I think
there's value in seeing "is it up" before taking any lock.

But I suspect your thinking is that this ping happens in the caller
anyway, before we hit any of this unix_socket_listen() code at all.  And
that makes sense to me. In fact, I guess it has to happen that way,
because "try to connect" and "try to spin up a server" are likely
happening in two separate processes entirely (we only spawn the second
one if the first one failed its ping).

> > I'd think in those three cases you'd want:
> > 
> >    - if lock contention, pause a moment and wait for the winner to spin
> >      up and serve requests
> > 
> >    - if another server is live while we hold the lock, then we raced them
> >      and they won. Release the lock and start using them.
> > 
> >    - if we really tried to call unix_stream_listen() and that failed,
> >      give up now. There is some system error that is not likely to be
> >      fixed by trying anything more (e.g., ENAMETOOLONG).
> 
> Yes, I want to move the error messages out of these library layers.
> 
> And yes, if another server is running, our server instance should
> shutdown gracefully.  Other client processes can just talk to them
> rather than us.

Right, that makes sense. Again, I was thinking earlier of the whole "try
to connect, but spin up a server otherwise" thing happening in a single
process. But by the time we get to the listen code, we have probably
already spawned a server process, and have redirected its stderr
somewhere. And likewise the caller doesn't even care that much if the
server reports an error because it somebody else won the race. It only
cares that after a few connect attempts it manages to talk to
_somebody_.

> > > +	lstat(path, &server_socket->st_socket);
> > 
> > This lstat I guess is part of your "periodically check to see if we're
> > still the one holding the socket" strategy. We _shouldn't_ need that
> > anymore, with the dotlocking, but I'm OK with it as a
> > belt-and-suspenders check. But why are we filling in the lstat here?
> > This seems like something that the unix-socket code doesn't really need
> > to know about (though you do at least provide the complementary
> > "was_stolen" function here, so that part makes sense).
> 
> The dotlock is only on disk for the duration of the socket setup.
> We do the rollback (to delete the lockfile) once we have the socket
> open and ready for business.
> 
> The lstat gives me the inode of the socket on disk and we can watch
> it with future lstat's in the event loop and see if it changes and
> detect theft and auto-shutdown.

Right, I gradually came to the understanding of what your extra layer
was trying to accomplish while reading (sometimes I'll go back and edit
earlier comments in my review before sending out the mail, but in this
case it seemed less confusing to leave my train of thought in place.
That might not have been correct, though. ;) ).

I think if everybody is abiding by the lock system to create the socket,
we probably don't strictly _need_ the theft detection. But it might not
hurt as a belt-and-suspenders, or for cases where somebody thinks the
socket is stale but it isn't (perhaps due to listen backlog or
something while trying to do the connect() ping).

> > > +void unix_stream_server__free(
> > > +	struct unix_stream_server_socket *server_socket)
> > > +{
> > > +	if (!server_socket)
> > > +		return;
> > > +
> > > +	if (server_socket->fd_socket >= 0) {
> > > +		if (!unix_stream_server__was_stolen(server_socket))
> > > +			unlink(server_socket->path_socket);
> > > +		close(server_socket->fd_socket);
> > > +	}
> > > +
> > > +	free(server_socket->path_socket);
> > > +	free(server_socket);
> > > +}
> > 
> > OK, this makes sense. We only remove it if we're still the ones holding
> > it. That's not done under lock, though, so it's possibly racy (somebody
> > steals from us while _they_ hold the lock; we check and see "not stolen"
> > right before they steal it, and then we unlink their stolen copy).
> 
> Right, I didn't bother with the lock here.  I don't think we need it.
> 
> We technically still have the socket open and are listening on it when
> we lstat and unlink it.  The other process should create the lock and
> try to connect.  That should hang in the kernel because of the accept()
> grace period.  Then we close the socket and the client's connection
> request errors because we didn't accept it.  They will see the error
> as no one is listening and then create their own socket.

I think there are still some races (at least if we believe that anything
can be stolen in the first place). Something like:

  - process A holds the socket but plans to exit

  - process B takes the lock

  - process B tries to ping us, but it doesn't work for some reason
    (this part is vague, but it's also the thing that makes stealing
    possible at all)

  - process A calls was_stolen(), which says "no"

  - process B decides nobody is there, so it unlinks the socket and
    creates its own

  - process A calls unlink(), removing B's socket

A is OK with this; it was exiting anyway. But it just stranded B, who
_thinks_ it owns the socket, but doesn't.

Again, there's a vagueness to "B somehow doesn't see A as listening" in
the middle step. But without that step, I don't see how you'd really
have stealing in the first place.

-Peff
