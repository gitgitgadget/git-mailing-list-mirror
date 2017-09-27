Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3F520A26
	for <e@80x24.org>; Wed, 27 Sep 2017 07:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbdI0HQ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 03:16:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:51794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752149AbdI0HQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 03:16:28 -0400
Received: (qmail 28327 invoked by uid 109); 27 Sep 2017 07:16:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 07:16:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12688 invoked by uid 111); 27 Sep 2017 07:17:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 03:17:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 03:16:25 -0400
Date:   Wed, 27 Sep 2017 03:16:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] validate_headref: NUL-terminate HEAD buffer
Message-ID: <20170927071625.3dtljf5oaiaa5pjq@sigill.intra.peff.net>
References: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
 <20170927061722.7ubswfgykxiawzh3@sigill.intra.peff.net>
 <xmqqefqs4o41.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefqs4o41.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 04:06:22PM +0900, Junio C Hamano wrote:

> A few tangents I noticed:
> 
>  - the result of readlink should be checked with starts_with() in
>    the modern codebase (#leftoverbits).

Yes, though it needs to NUL-terminate, too (readlink does not do so
automatically). Again, we seem to have left room for the NUL but didn't
bother to put it there.

>  - buffer[256] would mean that we cannot have a branch whose name is
>    more than a couple of hundred bytes long; as you said, we may be
>    better off using strbuf_read to read the whole thing.

Heh, I almost talked about this in the cover letter, but didn't want to
go off on a tangent. But since you mention it...

I had the same concern, but actually truncation is not a problem here
(for a symlink or a symref). We are only seeing if the contents look
vaguely correct, so really we never parse past "refs/" in either case.

The real symref resolution happens in refs/files-backend.c these days,
and does use a strbuf.

-Peff
