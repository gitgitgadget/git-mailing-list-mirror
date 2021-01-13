Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B60C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A42233F8
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 14:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbhAMOHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:07:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:54756 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbhAMOHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 09:07:06 -0500
Received: (qmail 22653 invoked by uid 109); 13 Jan 2021 14:06:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 14:06:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30197 invoked by uid 111); 13 Jan 2021 14:06:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 09:06:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 09:06:25 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 07/10] unix-socket: create gentle version of
 unix_stream_listen()
Message-ID: <X/7+YU16XrPFDYlN@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <96268351ac66371a0998d189db619f357d2b71fa.1610465493.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96268351ac66371a0998d189db619f357d2b71fa.1610465493.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:31:29PM +0000, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create a gentle version of `unix_stream_listen()`.  This version does
> not call `die()` if a socket-fd cannot be created and does not assume
> that it is safe to `unlink()` an existing socket-inode.

The existing one is meant to be gentle. Maybe it is worth fixing it
instead.

> `unix_stream_listen()` uses `unix_stream_socket()` helper function to
> create the socket-fd.  Avoid that helper because it calls `die()` on
> errors.

Yeah, I think this is just a bug. My thinking in the original was that
socket() would basically never fail. And it generally wouldn't, but
things like EMFILE do happen. There are only two callers, and both would
be one-liners to propagate the error up the stack.

> `unix_stream_listen()` always tries to `unlink()` the socket-path before
> calling `bind()`.  If there is an existing server/daemon already bound
> and listening on that socket-path, our `unlink()` would have the effect
> of disassociating the existing server's bound-socket-fd from the socket-path
> without notifying the existing server.  The existing server could continue
> to service existing connections (accepted-socket-fd's), but would not
> receive any futher new connections (since clients rendezvous via the
> socket-path).  The existing server would effectively be offline but yet
> appear to be active.

The trouble here is that one cannot tell if the existing file is active,
and you are orphaning an existing server, or if there is leftover cruft
from an exited server that did not clean up after itself (you will get
EADDRINUSE either way).

Handling those cases (and especially doing so in a non-racy way) is
probably outside the scope of unix_stream_listen(), but it makes sense
for this to be an option. And it looks like you even made it so here,
so unix_stream_listen() could just become a wrapper that sets the
option. Or since there is only one caller in the whole code-base,
perhaps it could just learn to pass the option struct. :)

Likewise for the no-chdir option added in the follow-on patch.

> Furthermore, `unix_stream_listen()` creates an opportunity for a brief
> race condition for connecting clients if they try to connect in the
> interval between the forced `unlink()` and the subsequent `bind()` (which
> recreates the socket-path that is bound to a new socket-fd in the current
> process).

I'll be curious to see how you do this atomically. From my skim of patch
10, you will connect to see if it's active, and unlink if it's not. But
then two simultaneous new processes could both see an inactive one and
race to forcefully create the new one. One of them will lose and be
orphaned with a socket that has no filesystem name.

There might be a solution using link() to have an atomic winner, but it
gets tricky around unlinking the old name out of the way. You might need
a separate dot-lock to make sure only one process does the
unlink-and-create process at a time.

-Peff
