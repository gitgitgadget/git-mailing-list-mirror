Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B9BC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 14:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DAD64F53
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 14:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCDO5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 09:57:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:52216 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhCDO44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 09:56:56 -0500
Received: (qmail 27141 invoked by uid 109); 4 Mar 2021 14:56:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Mar 2021 14:56:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9382 invoked by uid 111); 4 Mar 2021 14:56:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Mar 2021 09:56:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Mar 2021 09:56:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating
 unix domain sockets
Message-ID: <YED1DmLWd+ciySNa@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
 <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 03, 2021 at 02:53:23PM -0800, Junio C Hamano wrote:

> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Calls to `chdir()` are dangerous in a multi-threaded context.  If
> > `unix_stream_listen()` or `unix_stream_connect()` is given a socket
> > pathname that is too long to fit in a `sockaddr_un` structure, it will
> > `chdir()` to the parent directory of the requested socket pathname,
> > create the socket using a relative pathname, and then `chdir()` back.
> > This is not thread-safe.
> >
> > Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when this
> > flag is set.
> 
> While it is clear that this will not affect any existing callers, I
> am not sure if this is a good direction to go in the longer term.
> 
> I have to wonder if somebody actually relies on this "feature",
> though.  As long as ENAMETOOLONG is passed back to the caller so
> that it can react to it, any caller that knows it is safe to chdir()
> at the point of calling "send_request()" should be able to chdir()
> itself and come back (or fork a child that chdirs and opens a unix
> domain socket there, and then send the file descriptor back to the
> parent process).

The feature is definitely useful; I think I did 1eb10f4091 (unix-socket:
handle long socket pathnames, 2012-01-09) in response to a real problem.

Certainly callers could handle the error themselves. The reason I pushed
it down into the socket code was to avoid having to implement in
multiple callers. There are only two, but we'd have needed it in both
sides (credential-cache--daemon as the listener, and credential-cache as
the client).

Ironically, the listening side now does a permanent chdir() to the
socket directory anyway, since 6e61449051 (credential-cache--daemon:
change to the socket dir on startup, 2016-02-23). So we could just do
that first, and then feed the basename to the socket code.

The client side would still need to handle it, though. It could probably
also chdir to the socket directory without any real downside (once
started, I don't think the helper program needs to access the filesystem
at all outside of the socket).

So I dunno. I'd be OK to just rip the feature out in favor of doing
those chdir()s. But that seems like a non-zero amount of work versus
leaving, and the existing code has the benefit that if another caller
shows up, it could benefit from the feature.

-Peff
