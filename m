Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4239C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C2460ED6
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhH3UrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:47:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:34246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhH3UrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:47:15 -0400
Received: (qmail 1454 invoked by uid 109); 30 Aug 2021 20:46:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 20:46:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10208 invoked by uid 111); 30 Aug 2021 20:46:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 16:46:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 16:46:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stef Bon <stefbon@gmail.com>, Git Users <git@vger.kernel.org>
Subject: Re: Exec upload-pack on remote with what parameters to get
 direntries.
Message-ID: <YS1DnGTDo5ZG8Iw4@coredump.intra.peff.net>
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
 <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
 <xmqq35qq4t1x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35qq4t1x.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 12:43:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There is no operation to list the tree contents, for example, nor really
> > even a good way to fetch a single object. The protocol is geared around
> > efficiently transferring slices of history, so it is looking at sets of
> > reachable objects (what the client is asking for, and what it claims to
> > have).
> >
> > You might be able to cobble something together with shallow and partial
> > fetches. E.g., something like:
> >
> >   git clone --depth 1 --filter=blob:none --single-branch -b $branch
> 
> I was hoping that our support for fetching a single object (not
> necessarily a commit) at the protocol level was good enough, so that
> Stef's fuse/nfs daemon can fetch the tree object it is interested
> in.

I don't think there's a clean way to ask for a single object. But
thinking on it more, I suspect you could do something _really_ hacky
using the new object-type filters:

  git fetch --filter=object:type=commit --filter=object:type=blob

Because we AND the filters together, no object can satisfy both. But
because we also send any objects which were _explicitly_ requested by
the client, you can now fetch whatever single objects you want.

And as long as you tell the other side you don't have any objects, it
won't send any deltas.

> There also is an effort, slowly moving to add verbs like object-info
> to the protocol to help the vfs usecase, but primitives at too low a
> level would be killed by latency, so it is somewhat unknown how
> effective it would be.

Yes. At GitHub we actually have a custom endpoint which hooks up
"cat-file --batch" with a format of the client's choosing. That's what
(indirectly) feeds things like raw.github.com.

I've been tempted to send it upstream, but it's pretty ugly, and does
give the client a lot of power (for now, the placeholders you can use
with cat-file are not that powerful, but if we start to unify with
ref-filter, etc, then we run into situations like we had with
%(describe) recently). Likewise, the v2 object-info endpoint _could_
accept arbitrary format strings (it's the same idea, just with
--batch-check instead of --batch).

-Peff
