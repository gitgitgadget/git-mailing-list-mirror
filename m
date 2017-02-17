Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA8B201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 20:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934963AbdBQUyq (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 15:54:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:57425 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934780AbdBQUyp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 15:54:45 -0500
Received: (qmail 20847 invoked by uid 109); 17 Feb 2017 20:54:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 20:54:45 +0000
Received: (qmail 5965 invoked by uid 111); 17 Feb 2017 20:54:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 15:54:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 15:54:43 -0500
Date:   Fri, 17 Feb 2017 15:54:42 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
Message-ID: <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
References: <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
 <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
 <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
 <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
 <87tw7uv439.fsf@linux-m68k.org>
 <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
 <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
 <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
 <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
 <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 11:42:25AM +0100, Michael Haggerty wrote:

> On 02/17/2017 09:07 AM, Jeff King wrote:
> > [...]
> > That's similar to what I wrote earlier, but if we don't mind overwriting
> > errno unconditionally, I think just:
> > 
> >   errno = EIO; /* covers ferror(), overwritten by failing fclose() */
> >   err |= ferror(fp);
> >   err |= fclose(fp);
> > 
> > does the same thing.
> 
> True; I'd forgotten the convention that non-failing functions are
> allowed to change errno. Your solution is obviously simpler and faster.

I guess we are simultaneously assuming that it is OK to munge errno on
success in our function, but that fclose() will not do so. Which seems a
bit hypocritical. Maybe the "if" dance is better.

-Peff
