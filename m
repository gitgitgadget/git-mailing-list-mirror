Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63248C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201AB64FE9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 09:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCEJZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:25:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:53300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCEJZX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 04:25:23 -0500
Received: (qmail 32560 invoked by uid 109); 5 Mar 2021 09:25:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Mar 2021 09:25:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18558 invoked by uid 111); 5 Mar 2021 09:25:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Mar 2021 04:25:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Mar 2021 04:25:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating
 unix domain sockets
Message-ID: <YEH5AUxgFxWTxb6u@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
 <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
 <YED1DmLWd+ciySNa@coredump.intra.peff.net>
 <xmqqa6riejyp.fsf@gitster.c.googlers.com>
 <xmqqtupqbij4.fsf@gitster.c.googlers.com>
 <YEHzmIOYgRtI1Ak1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEHzmIOYgRtI1Ak1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 04:02:16AM -0500, Jeff King wrote:

> I don't know offhand if this trick actually works. I can imagine it
> does, but it hinges on the subtlety between an integer descriptor and
> the underlying "file description" (the term used in POSIX). Does binding
> a socket operate on the former (like close() does not close the parent's
> descriptor) or the latter (like lseek() impacts other descriptors).
> 
> I'd guess the latter, but I wasn't sure if you were suggesting this from
> experience or if you just invented the technique. ;)

I was curious, but this does indeed work:

-- >8 --
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>

int main(void)
{
	int listen_fd, client_fd;
	struct addrinfo *ai;
	pid_t pid;

	getaddrinfo("127.0.0.1", "1234", NULL, &ai);
	listen_fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
	pid = fork();
	if (!pid) {
		bind(listen_fd, ai->ai_addr, ai->ai_addrlen);
		return 0;
	}
	waitpid(pid, NULL, 0);

	listen(listen_fd, 5);
	client_fd = accept(listen_fd, NULL, NULL);
	write(client_fd, "foo\n", 4);
	return 0;
}
-- >8 --

-Peff
