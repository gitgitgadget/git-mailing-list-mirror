Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D62C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiHBPkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHBPkA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:40:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71821276B
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:39:59 -0700 (PDT)
Received: (qmail 3936 invoked by uid 109); 2 Aug 2022 15:39:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Aug 2022 15:39:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32686 invoked by uid 111); 2 Aug 2022 15:39:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Aug 2022 11:39:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Aug 2022 11:39:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] pipe_command(): mark stdin descriptor as non-blocking
Message-ID: <YulFTSTbVaTwuQtt@coredump.intra.peff.net>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 02, 2022 at 12:13:07AM -0400, Jeff King wrote:

>   - more importantly, I'm not sure of the portability implications of
>     the fix. This is our first use of O_NONBLOCK outside of the
>     compat/simple-ipc unix-socket code. Do we need to abstract this
>     behind a compat/ layer for Windows?

So I think the answer is pretty clearly "yes", from the Windows CI
results:

  run-command.c:1429:18: 'O_NONBLOCK' undeclared (first use in this function)
         flags |= O_NONBLOCK;
                  ^~~~~~~~~~

It looks like we'd have the option of either adding F_GETFL/F_SETFL
support to compat/mingw.c's fake fcntl() function, or adding a
compat/nonblock.c that abstracts the whole thing. I'd prefer the latter,
as it makes the interface a bit narrower.

But I'm not sure what should go on the Windows side of that #ifdef.
Unlike some other spots, I don't think we can just make it a noop, or
Windows will be subject to the same deadlock (unless for some reason its
write() does behave differently?).

-Peff
