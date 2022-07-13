Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0566C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 19:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiGMTRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 15:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiGMTQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 15:16:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F5D286FC
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 12:16:56 -0700 (PDT)
Received: (qmail 15547 invoked by uid 109); 13 Jul 2022 19:16:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jul 2022 19:16:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15445 invoked by uid 111); 13 Jul 2022 19:16:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jul 2022 15:16:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jul 2022 15:16:55 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t0301-credential-cache test failure on cygwin
Message-ID: <Ys8aJ1HSLnWFT5qB@coredump.intra.peff.net>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
 <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
 <CA+kUOakjnOxs_FGojdZXaiaY4+68pvyBHsbue+AQHp7PLXqNJw@mail.gmail.com>
 <CA+kUOak29RkU-ooMgOz8yCg9-q6vb1VfdP8_VLay_V650ttwjA@mail.gmail.com>
 <51972253-c1a1-8be7-39f5-3093ac83ffb1@ramsayjones.plus.com>
 <CA+kUOam-_3qR7YguPyUmyC2dWi2M1cy6Hg4Pveak+f40qtYBvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+kUOam-_3qR7YguPyUmyC2dWi2M1cy6Hg4Pveak+f40qtYBvA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 03:42:38PM +0100, Adam Dinwoodie wrote:

> Having now spent far more time than I'd like wrangling the Cygwin build
> infrastructure, I've found the change in the Cygwin code that introduced
> the break. But I'm afraid progressing beyond this -- and in particular
> making any sort of judgement about appropriate next steps -- is beyond
> what I'm going to have time for in the foreseeable future.

Hmm. So I had assumed that the problem was unlink()ing the socket path
while the client was still trying to read(). If that's the case, then I
_think_ the minimal reproduction below should also trigger the problem.
That might give you something more useful to show to Cygwin folks.

But...

> commit ef95c03522f65d5956a8dc82d869c6bc378ef3f9 (HEAD, refs/bisect/bad)
> Author: Corinna Vinschen <corinna@vinschen.de>
> Date:   Tue Apr 6 21:35:43 2021 +0200
> 
>     Cygwin: select: Fix FD_CLOSE handling
>     
>     An FD_CLOSE event sets a socket descriptor ready for writing.
>     This is incorrect if the FD_CLOSE is a result of shutdown(SHUT_RD).
>     Only set the socket descriptor ready for writing if the FD_CLOSE
>     is indicating an connection abort or reset error condition.
>     
>     This requires to tweak fhandler_socket_wsock::evaluate_events.
>     FD_CLOSE in conjunction with FD_ACCEPT/FD_CONNECT special cases
>     a shutdown condition by setting an error code.  This is correct
>     for accept/connect, but not for select.  In this case, make sure
>     to return with an error code only if FD_CLOSE indicates a
>     connection error.

...this is about select outcomes. Which makes me think two things
(though these are really pretty blind guesses, as I'm not at all
familiar with Cygwin's socket code):

  - it may be that this situation was always ECONNABORTED (it's not on
    Linux, but perhaps due to details of the underlying socket code on
    Windows, it's different there). And this patch is just surfacing
    that state to the caller better.

  - it could be unrelated to the unlink() entirely. The socket code in
    Git dups the client descriptor and opens two FILE* handles, one for
    reading and one for writing. Could it be that it's important to
    fclose() one before the other (and the implicit closing done by
    exit() does the wrong order)? It seems like a stretch, but this
    commit message is talking about a shutdown(SHUT_RD), which is kind
    of what you get by fclose-ing one side (though again, not on Linux,
    because the "FILE*" are aware that they are read/write, but the
    underlying descriptors aren't).

Or maybe those are just totally off track. I know you said you don't
have time to dig further, and that's fine. But if you or anybody has a
chance to try the program below, it might be interesting to see the
result (it would confirm whether it's the unlink() that's the problem).

-- >8 --
#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>

#define SOCKET_PATH "mysocket"

static void diesys(const char *syscall)
{
	perror(syscall);
	exit(1);
}

static int create_server(void)
{
	int fd;
	struct sockaddr_un sa = {
		.sun_family = AF_UNIX,
		.sun_path = SOCKET_PATH,
	};

	fd = socket(AF_UNIX, SOCK_STREAM, 0);
	if (fd < 0)
		diesys("socket");
	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
		diesys("bind");
	if (listen(fd, 5) < 0)
		diesys("listen");

	return fd;
}

static void do_server(int listen_fd)
{
	int client_fd = accept(listen_fd, NULL, NULL);
	if (client_fd < 0)
		diesys("accept");
	if (unlink(SOCKET_PATH) < 0)
		diesys("unlink");
	if (close(client_fd) < 0)
		diesys("close(client)");
	close(listen_fd);
}

static void do_client(void)
{
	int fd;
	char buf[64];
	struct sockaddr_un sa = {
		.sun_family = AF_UNIX,
		.sun_path = SOCKET_PATH,
	};

	fd = socket(AF_UNIX, SOCK_STREAM, 0);
	if (fd < 0)
		diesys("socket");
	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
		diesys("connect");
	if (read(fd, buf, sizeof(buf)) < 0)
		diesys("read");
	close(fd);
}

int main(void)
{
	int fd = create_server();

	if (fork()) {
		do_server(fd);
	} else {
		close(fd);
		do_client();
	}
	return 0;
}
