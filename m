Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3356AC05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 08:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjAZI7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 03:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjAZI7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 03:59:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966D442DF
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 00:58:59 -0800 (PST)
Received: (qmail 18975 invoked by uid 109); 26 Jan 2023 08:58:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 08:58:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21401 invoked by uid 111); 26 Jan 2023 08:58:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 03:58:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 03:58:57 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 04/12] test-http-server: add stub HTTP server test
 helper
Message-ID: <Y9JA0UCRh7qUqKQI@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <17c890ee1080abc81267e44a1eaff4609ee41690.1674252531.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17c890ee1080abc81267e44a1eaff4609ee41690.1674252531.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 10:08:42PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> Introduce a mini HTTP server helper that in the future will be enhanced
> to provide a frontend for the git-http-backend, with support for
> arbitrary authentication schemes.
> 
> Right now, test-http-server is a pared-down copy of the git-daemon that
> always returns a 501 Not Implemented response to all callers.

This may be a dumb question, but I didn't see it raised or answered in
the cover letter or earlier in the thread: what does this custom server
give us that our current use of apache in the tests does not?

I'd imagine the answer is along the lines of: configuring apache to
respond to auth in the way we'd like is hard and/or impossible. And if
so, and if it's just "hard", I'd ask "how hard?".

Because I see a few downsides to introducing a custom server here:

  1. It may or may not behave like real-world servers, which makes the
     test slightly less good. Not that apache can claim to cover all
     real-world behavior, but it's probably closer to reality (and that
     has flushed out interesting bugs and behaviors before).

  2. It's a non-trivial amount of code, doing tricky things like
     daemonizing, socket setup and I/O, pidfiles, and so on.  For
     example, it handles multiple listen addresses, and ipv6. Do we
     really need that? And we take shortcuts around things like CGI
     output buffering. I do see that you tried to reuse some existing
     code, but...

  3. You're reusing parts of git-daemon, which I personally consider to
     be one of the absolute low-points of code quality inside git.git. I
     know that's a subjective statement, but my experience running it
     within GitHub was that there were a lot of rough edges, and we
     ended up rewriting several parts of it. In particular, the
     child-handling is inefficient (I seem to recall that it's quadratic
     in several places) and has odd behaviors (its kill_some_child() is
     basically nonsense, and can starve requests). Probably none of that
     matters for your use case in tests, which is likely doing one
     request at a time.

     But then I'd wonder: do we really need those bits at all, then? In
     fact, would it be sufficient to write the server to handle one
     request at a time, without spawning a worker child at all?

I dunno. I know I am showing up to review quite late in the life of this
patch series, and that probably makes me a bad person to start the
review with "and could you re-do the whole test infrastructure". So if
you want to tell me to get lost, I'd understand. But I had hoped that
one day we could just delete all of daemon.c, and this moves in the
opposite direction.

I think my order of preference (if you care ;) ) is:

  1. Can we do it with apache?

  2. If not, could we do it with a trivial application of some existing
     http server framework? I know that may mean extra dependencies, but
     there's a lot of perl in the test suite already, and it doesn't
     seem too terrible to me to require it for these tests.

  3. If not, can we make the http-server code even more minimal?

>  Makefile                            |   1 +
>  contrib/buildsystems/CMakeLists.txt |  11 +-
>  t/helper/.gitignore                 |   1 +
>  t/helper/test-http-server.c         | 381 ++++++++++++++++++++++++++++
>  4 files changed, 392 insertions(+), 2 deletions(-)
>  create mode 100644 t/helper/test-http-server.c

If we do use this code, here are a few small bits I noticed:

> +static void child_handler(int signo)
> +{
> +	/*
> +	 * Otherwise empty handler because systemcalls will get interrupted
> +	 * upon signal receipt
> +	 * SysV needs the handler to be rearmed
> +	 */
> +	signal(SIGCHLD, child_handler);
> +}

daemon.c has this, too. If we're going to share its child-handling code,
should it maybe just handle this part, too?

> +static int service_loop(struct socketlist *socklist)
> +{
> +	struct pollfd *pfd;
> +	int i;
> +
> +	CALLOC_ARRAY(pfd, socklist->nr);

(Actually, Coverity noticed this, not me).

This pfd is never freed. I know this is copied from daemon.c, but in
that file we never return from the function. Here you do break out of
the loop and try to clean up; you'd want to free(pfd) there.

> +	for (;;) {
> +		int i;
> +		int nr_ready;
> +		int timeout = (pid_file ? 100 : -1);
> +
> +		check_dead_children(first_child, &live_children, loginfo);
> +
> +		nr_ready = poll(pfd, socklist->nr, timeout);
> +		if (nr_ready < 0) {
> +			if (errno != EINTR) {
> +				logerror("Poll failed, resuming: %s",
> +				      strerror(errno));
> +				sleep(1);
> +			}
> +			continue;
> +		}
> +		else if (nr_ready == 0) {
> +			/*
> +			 * If we have a pid_file, then we watch it.
> +			 * If someone deletes it, we shutdown the service.
> +			 * The shell scripts in the test suite will use this.
> +			 */
> +			if (!pid_file || file_exists(pid_file))
> +				continue;
> +			goto shutdown;
> +		}

I wondered how this would work, since removal of the pid file won't
trigger poll(). But it looks like you set the timeout unconditionally in
that case, so we're effectively polling for its removal every 100ms.
It's not beautiful, but it should work reliably.

That also made me wonder about this timeout:

> +		if (skip_prefix(arg, "--timeout=", &v)) {
> +			timeout = atoi(v);
> +			continue;
> +		}

but it is not used. The "timeout" in service_loop shadows the global,
and nobody ever looks at the global (however, it looks like a later
patch adds an alarm() which uses it).

> +		if (skip_prefix(arg, "--max-connections=", &v)) {
> +			max_connections = atoi(v);
> +			if (max_connections < 0)
> +				max_connections = 0; /* unlimited */
> +			continue;
> +		}

I don't think any caller ever uses --max-connections, though. This could
be dropped, and that would simplify service_loop a bit.

> +	if (listen_port == 0)
> +		listen_port = DEFAULT_GIT_PORT;

That's a funny default. Surely "80" or even "8080" would make more
sense. But really, since our purpose is tests, isn't it a
misconfiguration if the test does not tell us which port (which is
generally dynamic based on the test number), and we should bail?

> +	/*
> +	 * If no --listen=<addr> args are given, the setup_named_sock()
> +	 * code will use receive a NULL address and set INADDR_ANY.
> +	 * This exposes both internal and external interfaces on the
> +	 * port.
> +	 *
> +	 * Disallow that and default to the internal-use-only loopback
> +	 * address.
> +	 */
> +	if (!listen_addr.nr)
> +		string_list_append(&listen_addr, "127.0.0.1");

Likewise, it seems like you could probably ditch --listen entirely, and
just always listen on 127.0.0.1, for the purposes of the tests.

-Peff
