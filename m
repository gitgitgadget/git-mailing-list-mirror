Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800F8C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B18E20674
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgERQu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:50:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:49768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726958AbgERQu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:50:57 -0400
Received: (qmail 20481 invoked by uid 109); 18 May 2020 16:50:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 16:50:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3803 invoked by uid 111); 18 May 2020 16:50:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 12:50:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 12:50:56 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] remote-curl: fix deadlocks when remote server
 disconnects
Message-ID: <20200518165056.GD42240@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 11:47:17AM -0400, Denton Liu wrote:

> Changes since v1:
> 
> * Remove fallthrough in switch in favour of just extracting the common
>   call out of the switch in patch 3
> 
> * Add more detail in function comment and use `const char linelen[4]` in
>   patch 4
> 
> * Implement most of Peff's suggestions[0] in patch 5
> 
> * Only operate on stateless_connect() in patch 5
> 
> * Add tests in patch 5
> 
> * Drop "remote-curl: ensure last packet is a flush" in favour of
>   "stateless-connect: send response end packet"

Overall this looks pretty cleanly done. I left a few minor comments
throughout, but the real question is whether we prefer the "0002" packet
in the last one, or if we instead insist that the response end in a
flush.

At first glance, the "0002" seems like it's more flexible, because we're
making fewer assumptions about what's being transferred over the
stateless-connect channel. But in reality it still has to be pktlines
(because we're checking them for incomplete or invalid packets already).
So all it really buys us is that the server response doesn't have to end
with a flush packet.

So I dunno. The "0002" solution is slightly more flexible, but I'm not
sure it helps in practice. And it does eat up one of our two remaining
special packet markers.

There is another solution, which would allow arbitrary data over
stateless-connect: adding an extra level of pktline framing between the
helper and the parent process. But that's rather ugly (inner pktlines
may be split across outer ones, so you have to do a bunch of buffer
reassembly). I think that's actually how v0 http works, IIRC.
IMHO it probably isn't worth pursuing. That extra layer wrecks the
elegance to the v2 stateless-connect approach, and we really do expect
only pktlines to go over it.

So I think either of your solutions (enforcing a final flush, or the
0002 packet) is preferable. I'm on the fence between them.

-Peff
