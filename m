Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA8EC32771
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 05:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiHQFjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 01:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHQFjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 01:39:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486BB4DF3E
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 22:39:34 -0700 (PDT)
Received: (qmail 6273 invoked by uid 109); 17 Aug 2022 05:39:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 05:39:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13501 invoked by uid 111); 17 Aug 2022 05:39:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 01:39:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 01:39:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: handle writes to non-blocking pipe
Message-ID: <Yvx/FNlTx+DCiCOj@coredump.intra.peff.net>
References: <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de>
 <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
 <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
 <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
 <YvVIYyA8Js0WDAMc@coredump.intra.peff.net>
 <c7c6524c-4f02-10f6-1a58-738cef5aecf2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7c6524c-4f02-10f6-1a58-738cef5aecf2@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2022 at 05:37:08PM +0200, René Scharfe wrote:

> Turns out that's not the case on Windows: 94f4d01932 (mingw: workaround
> for hangs when sending STDIN, 2020-02-17) changed the compatibility
> implementation to 'Make `poll()` always reply "writable" for write end
> of the pipe.'.

Ah, good find. That kind of explains everything, then, I think. ;)

> > I'm not sure what "small enough" we can rely on, though. Really it is
> > the interplay between poll() and write() that we care about here. We
> > would like to know at what point poll() will tell us it's OK to write().
> > But we don't know what the OS thinks of that.
> 
> Based on the output above I think Linux' poll() won't consider a pipe
> writable that has less than PIPE_BUF (4096) available bytes.

Right, that makes sense. It would have to in order to meet the atomicity
requirement for write(), but still always make forward progress for each
write().

> Perhaps we should take the advice about PIPE_NOWAIT in the docs serious
> and use overlapping (asynchronous) writes on Windows instead.  This
> would mean reimplementing the whole pipe_command() with Windows API
> commands, I imagine.

I wouldn't be opposed to that, in the sense that it's supposed to be a
black box to the caller, and it's relatively small in size. But I think
we're pretty close to having something usable without that, so I'd like
to pursue a smaller fix in the interim.

> Avoiding xwrite() in pump_io_round() on top lets the test suite
> finish successfully.

That makes sense. We end up busy-looping between poll() and write()
while we wait for our read descriptor to become available. But if poll()
doesn't block, that's the best we can do.

-Peff
