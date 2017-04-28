Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BBD207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998138AbdD1NpM (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:45:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:41727 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998128AbdD1NpF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:45:05 -0400
Received: (qmail 22344 invoked by uid 109); 28 Apr 2017 13:45:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 13:45:02 +0000
Received: (qmail 20526 invoked by uid 111); 28 Apr 2017 13:45:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 09:45:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 09:45:00 -0400
Date:   Fri, 28 Apr 2017 09:45:00 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
Message-ID: <20170428134500.dzww4qea75elww2m@sigill.intra.peff.net>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
 <6cc5670f-2de3-33f2-3c85-5a6d99fcca12@kdbg.org>
 <alpine.DEB.2.20.1704281206500.3480@virtualbox>
 <20170428112002.tjkcjjdfqenl2aie@sigill.intra.peff.net>
 <alpine.DEB.2.20.1704281346480.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704281346480.3480@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 03:33:41PM +0200, Johannes Schindelin wrote:

> As usual, EOF is defined as -1 in Git for Windows' context, meaning that
> we look at the last entry of the sane_ctype array, which returns 0 for any
> sane_istest(x,mask) test for x >= 0x80:
> 
>         /* Nothing in the 128.. range */
> 
> So it would appear that it happens to work, but I doubt that it was
> intentional.

Yeah, that was the same analysis I came to. Even though it works, it is
a potential portability problem if a platform defines EOF in a weird
way. The "right" thing in such a case is probably checking explicitly
for EOF, but I'd hate to add an extra conditional to sane_istest(). It's
a fairly hot code path. So I'm fine with punting on that until we see
evidence of such a system.

> Having said that, it is really curious why Coverity should get confused by
> the code and not realize that casting a negative number to (unsigned char)
> will make it valid as an index for the sane_ctype array.

Yeah, that is the part that confuses me, too. It seems like an easy
case to get right.

Oh well. If you are tweaking it to handle EOF separately for other
reasons, then the Coverity question goes away entirely.

-Peff
