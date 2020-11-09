Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F564C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868A6206CB
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKIVkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:40:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:51892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgKIVkM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 16:40:12 -0500
Received: (qmail 4026 invoked by uid 109); 9 Nov 2020 21:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Nov 2020 21:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27336 invoked by uid 111); 9 Nov 2020 21:40:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 16:40:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 16:40:11 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [PATCH 4/4] Doc: push with --base
Message-ID: <20201109214011.GA668551@coredump.intra.peff.net>
References: <xmqqft5qs5qs.fsf@gitster.c.googlers.com>
 <20201109195630.2511149-1-jonathantanmy@google.com>
 <xmqq8sbab52p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sbab52p.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 01:20:14PM -0800, Junio C Hamano wrote:

> Would the earlier refactoring of the negotiation part into a
> separate negotiator module help, or did the refactor not remove the
> deep assumption that it is only about the fetch/upload-pack traffic
> and we need a design for push/receive-pack from scratch?

I haven't thought too deeply about this problem area, but there is one
challenge I'd expect with reusing the existing negotiation protocol and
code: the stateless side is flipped for http.

In the fetch protocol, the client is stateful and makes a series of
requests to a stateless server, each time saying "I want X, we agreed
previously on Y, and here are some more options Z; let me know if that's
enough to generate a pack". If we were to flip that around, the client
must remain the stateful party, but it's no longer the receiver of the
pack. For the receiver (i.e., the stateless server) to iterate through
its history looking for a shard point, I think the message would have to
be more like "last time you told me about X, and gave me cut-points Y to
resume your traversal; tell me more about Y so that I can decide if
we're ready to send a pack".

-Peff
