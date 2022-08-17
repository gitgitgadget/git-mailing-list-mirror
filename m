Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45BDC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiHQGEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiHQGEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:04:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30353ED67
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:04:07 -0700 (PDT)
Received: (qmail 6564 invoked by uid 109); 17 Aug 2022 06:04:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 06:04:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13663 invoked by uid 111); 17 Aug 2022 06:04:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 02:04:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 02:04:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/6] fix pipe_command() deadlock
Message-ID: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
References: <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
 <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
 <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
 <YvVIYyA8Js0WDAMc@coredump.intra.peff.net>
 <c7c6524c-4f02-10f6-1a58-738cef5aecf2@web.de>
 <Yvx/FNlTx+DCiCOj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yvx/FNlTx+DCiCOj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 01:39:32AM -0400, Jeff King wrote:

> I wouldn't be opposed to that, in the sense that it's supposed to be a
> black box to the caller, and it's relatively small in size. But I think
> we're pretty close to having something usable without that, so I'd like
> to pursue a smaller fix in the interim.

So here's what I came up with. Most of the changes are done as
preparatory steps, so I believe the final commit should just work out of
the box for you, as well as on Windows CI (which I just kicked off).

Here's a breakdown of the patches:

  [1/6]: compat: add function to enable nonblocking pipes
  [2/6]: nonblock: support Windows

This is my compat wrapper from v1 pulled into a separate function, and
then your Windows implementation on top.

  [3/6]: git-compat-util: make MAX_IO_SIZE define globally available
  [4/6]: pipe_command(): avoid xwrite() for writing to pipe

This fixes the "loop forever" problem of using xwrite(), under the
assumption that fixing our Windows poll() emulation is too hard. If we
did fix it, then we could revert these (though keeping them can be
thought of as a defensive measure against future bugs; busy-looping is
less bad than deadlocking).

I _think_ the amount of busy-looping on Windows will be OK here. Any
case that wouldn't deadlock currently is unaffected, and the cases that
are will probably not be too wasteful. More discussion in the commit
message.

  [5/6]: pipe_command(): handle ENOSPC when writing to a pipe

A hack around the ENOSPC problem you found. We could replace this with
your mingw_write() patch, but it looked like that needed some corner
cases to be smoothed a bit.

  [6/6]: pipe_command(): mark stdin descriptor as non-blocking

The actual fix, largely as before.

I don't love patches 3-5, but it seems like a practical path forward.
I'd prefer to go with a minimal fix that removes the existing deadlock,
and then we can do more cleanups on top. Thanks so much for all of your
investigation and testing so far!

 Makefile                   |  1 +
 compat/nonblock.c          | 50 ++++++++++++++++++++++++++++++++++++++
 compat/nonblock.h          |  9 +++++++
 git-compat-util.h          | 22 +++++++++++++++++
 run-command.c              | 33 +++++++++++++++++++++----
 t/t3701-add-interactive.sh | 13 ++++++++++
 wrapper.c                  | 22 -----------------
 7 files changed, 123 insertions(+), 27 deletions(-)
 create mode 100644 compat/nonblock.c
 create mode 100644 compat/nonblock.h

-Peff
