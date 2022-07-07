Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BC2C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiGGSMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiGGSMf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:12:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0741EAF8
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:12:33 -0700 (PDT)
Received: (qmail 6360 invoked by uid 109); 7 Jul 2022 18:12:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 18:12:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3209 invoked by uid 111); 7 Jul 2022 18:12:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 14:12:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 14:12:31 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t0301-credential-cache test failure on cygwin
Message-ID: <YsciDznU2TqzCXP4@coredump.intra.peff.net>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 07, 2022 at 02:50:21AM +0100, Ramsay Jones wrote:

> Having deleted the above patch, I now had a look at the server side. Tracing
> out the server execution showed no surprises - everything progressed as one
> would expect and it 'exit(0)'-ed correctly! The relevant part of the code to
> process a client request (in the serve_one_client() function, lines 132-142
> in builtin/credential-cache--daemon.c) looks like:
> 
> 	else if (!strcmp(action.buf, "exit")) {
> 		/*
> 		 * It's important that we clean up our socket first, and then
> 		 * signal the client only once we have finished the cleanup.
> 		 * Calling exit() directly does this, because we clean up in
> 		 * our atexit() handler, and then signal the client when our
> 		 * process actually ends, which closes the socket and gives
> 		 * them EOF.
> 		 */
> 		exit(0);
> 	}
> 
> Now, the comment doesn't make clear to me why "it's important that we clean
> up our socket first" and, indeed, whether 'socket' refers to the socket
> descriptor or the socket file. In the past, all of my unix-stream-socket
> servers have closed the socket descriptor and then unlink()-ed the socket
> file before exit(), with no 'atexit' calls in sight (lightly cribbed from a
> 30+ years old Unix Network programming book by Stevens - or was it the Comer
> book - or maybe the Comer and Stevens book - I forget!).

That comment refers to the socket file. If we close the handle to the
client before we clean up the socket file, then the client may finish
while the socket file is still there. So anybody expecting that:

  git credential-cache exit

is a sequencing operation will be fooled. One obvious thing is:

  git credential-cache exit
  git credential-cache store <some-cred

which is now racy; the second command may try to contact the socket for
the exiting daemon. It might actually handle that gracefully (because
the server wouldn't actually accept()) but I didn't check. But another
example, and the one that motivated that comment is:

  git credential-cache exit
  test_path_is_missing $HOME/.git-credential-cache/socket

which is exactly what our tests do. ;) See the discussion around here:

  https://lore.kernel.org/git/20160318061201.GA28102@sigill.intra.peff.net/

A few messages up we even discuss adding an fclose(). :)

> The C standard (see C11 7.22.4.4) says that the 'exit' function first calls
> all functions registered by 'atexit', then all open streams with unwritten
> buffered data are flushed, all open streams are closed, and all files created
> by the 'tmpfile' function are removed.

Right. That's exactly the order we're relying on: our atexit cleans up
the socket and _then_ the descriptor to the client is closed.

I think we could actually just call delete_tempfile() explicitly. Back
when the code was originally written, that would require making sure our
atexit() handler didn't do a double-cleanup, but these days it uses the
tempfile code, which I believe does the right thing.

I think that still wouldn't solve your cygwin problem, though; from the
client perspective the behavior would be the same.

> Anyway, I started playing around with flushing/closing of 'FILE *' streams
> before the 'exit' call, to change the order, relative to the socket-file
> deletion in the 'atexit' function (or the closing of the listen-socket
> descriptor, come to that). In particular, I found that if I were to close
> the 'in'put stream, then the client would receive an EOF and exit normally
> (ie no error return from read_in_full() above).

Right, but now you've introduced the race discussed above.

> Having noticed that the 'timeout' test was not failing, I decided to try
> making the 'action=exit' code-path behave more like the timeout code, as
> far as exiting the server is concerned.

I think this introduces a similar race.

> Indeed, you might ask why the timeout code doesn't just 'exit(0)' as well ...

It doesn't matter there, because there's no client expecting us to exit.
So the sequence of cleaning up our socket vs hanging up on the client
doesn't matter. And indeed, it's unlikely to even _have_ a client here,
as they'd have to connect and do their business right as our final
credential was hitting its expiration.

> So, we now have three patches which 'fix' the issue. What does this tell us?
> Well, not an awful lot! ;-)

Of the three, I actually like the client-side one to check errno the
best. The client is mostly "best effort". If it can't talk to the daemon
for whatever reason, then it becomes a noop (there is nothing it can
retrieve from the cache, and if it's trying to write, then oh well, the
cached value was immediately expired!).

So one could argue that _every_ read error should be silently ignored.
Calling die_errno() is mostly a nicety for debugging a broken setup, but
in normal use, the outcome is the same either way (and Git will
certainly ignore the exit code credential-cache anyway). I prefer the
"ignore known harmless errors" approach, possibly because I am often the
one debugging. ;) If ECONNABORTED is a harmless error we see in
practice, I don't mind adding it to the list (under the same rationale
as the current ECONNRESET that is there).

-Peff
