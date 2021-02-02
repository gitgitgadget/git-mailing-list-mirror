Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354BEC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 10:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A5964F55
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 10:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhBBKP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:15:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:44310 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhBBKPY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 05:15:24 -0500
Received: (qmail 12881 invoked by uid 109); 2 Feb 2021 10:14:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 10:14:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 843 invoked by uid 111); 2 Feb 2021 10:14:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 05:14:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 05:14:39 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 11/14] unix-socket: add options to unix_stream_listen()
Message-ID: <YBkmD14Nqqxe4pxG@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <7a6a69dfc20c6ff190cb020931c46bf4d88bab59.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a6a69dfc20c6ff190cb020931c46bf4d88bab59.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:44PM +0000, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Update `unix_stream_listen()` to take an options structure to override
> default behaviors.  This includes the size of the `listen()` backlog
> and whether it should always unlink the socket file before trying to
> create a new one.  Also eliminate calls to `die()` if it cannot create
> a socket.

I sent a follow-up on the previous patch, but I think this part about
the die() should be folded in there.

Likewise I think it would probably be easier to follow if we added the
backlog parameter and the unlink options in separate patches. The
backlog thing is small, but the unlink part is subtle and requires
explanation. That's a good sign it might do better in its own commit.

> Normally, `unix_stream_listen()` always tries to `unlink()` the
> socket-path before calling `bind()`.  If there is an existing
> server/daemon already bound and listening on that socket-path, our
> `unlink()` would have the effect of disassociating the existing
> server's bound-socket-fd from the socket-path without notifying the
> existing server.  The existing server could continue to service
> existing connections (accepted-socket-fd's), but would not receive any
> futher new connections (since clients rendezvous via the socket-path).
> The existing server would effectively be offline but yet appear to be
> active.
> 
> Furthermore, `unix_stream_listen()` creates an opportunity for a brief
> race condition for connecting clients if they try to connect in the
> interval between the forced `unlink()` and the subsequent `bind()` (which
> recreates the socket-path that is bound to a new socket-fd in the current
> process).

OK. I'm still not sure of the endgame here for writing non-racy code to
establish the socket (which is going to require either some atomic
renaming or some dot-locking in the caller).  But it's plausible to me
that this option will be a useful primitive.

The implementation looks correct, though here are a few small
observations/questions/nits:

> -int unix_stream_listen(const char *path)
> +int unix_stream_listen(const char *path,
> +		       const struct unix_stream_listen_opts *opts)
>  {
> -	int fd, saved_errno;
> +	int fd = -1;
> +	int saved_errno;
> +	int bind_successful = 0;
> +	int backlog;
>  	struct sockaddr_un sa;
>  	struct unix_sockaddr_context ctx;
>  
> -	unlink(path);
> -
>  	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
>  		return -1;

We can return directly here, because we know there is nothing to clean
up. Which I thought mean that here...

> +
>  	fd = socket(AF_UNIX, SOCK_STREAM, 0);
>  	if (fd < 0)
> -		die_errno("unable to create socket");
> +		goto fail;

...we are in the same boat. We did not create a socket, so we can just
return. That makes our cleanup code a bit simpler. But we can't do that,
because unix_sockaddr_init() may have done things that need cleaning up
(like chdir). So what you have here is correct.

IMHO that is all the more reason to push this (and the similar code in
unix_stream_connect() added in patch 13) into the previous patch.

> +	if (opts->force_unlink_before_bind)
> +		unlink(path);
>  
>  	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
>  		goto fail;
> +	bind_successful = 1;

And this one needs to mark a flag explicitly, because we have no other
visible way of knowing we need to do the unlink. Makes sense.

> -	if (listen(fd, 5) < 0)
> +	if (opts->listen_backlog_size > 0)
> +		backlog = opts->listen_backlog_size;
> +	else
> +		backlog = 5;
> +	if (listen(fd, backlog) < 0)

The default-to-5 is a bit funny here. We already set the default to 5 in
UNIX_STREAM_LISTEN_OPTS_INIT. Should it be "0" there, so callers can
treat that as "use the default", which we fill in here? It probably
doesn't matter much in practice, but it seems cleaner to have only one
spot with the magic number.

> @@ -114,7 +125,10 @@ int unix_stream_listen(const char *path)
>  fail:
>  	saved_errno = errno;
>  	unix_sockaddr_cleanup(&ctx);
> -	close(fd);
> +	if (fd != -1)
> +		close(fd);
> +	if (bind_successful)
> +		unlink(path);
>  	errno = saved_errno;
>  	return -1;
>  }

Should we unlink before closing? I usually try to undo actions in the
reverse order that they were done. I thought at first it might even
matter here, such that we'd atomically relinquish the name without
having a moment where it still points to a closed socket (which might be
less confusing to somebody else trying to connect). But I guess there
will always be such a moment, because it's not like we would ever
accept() or service a request.

-Peff
