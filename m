Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8702013A
	for <e@80x24.org>; Fri, 17 Feb 2017 08:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754937AbdBQIID (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 03:08:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:56923 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754841AbdBQIIC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 03:08:02 -0500
Received: (qmail 3822 invoked by uid 109); 17 Feb 2017 08:08:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 08:08:01 +0000
Received: (qmail 31863 invoked by uid 111); 17 Feb 2017 08:08:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 03:08:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 03:07:59 -0500
Date:   Fri, 17 Feb 2017 03:07:59 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
Message-ID: <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
References: <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
 <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
 <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
 <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
 <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
 <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
 <87tw7uv439.fsf@linux-m68k.org>
 <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
 <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
 <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 09:00:09AM +0100, Michael Haggerty wrote:

> As you pointed out, if ferror() fails, it doesn't set errno properly. At
> least one caller tries to strerror(errno), so it would probably be good
> to store *something* in there, probably EIO.

Yeah, we discussed this up-thread a bit, and my "solution" was similar
to yours. I don't like it, because EIO is a real thing that can happen,
too, and it would certainly be surprising to a user to see. But it's
probably better than the alternative, which is getting whatever random
value happened to be in errno.

The only downside is that if the value of errno _was_ valid (because the
last thing you did really was writing to the filehandle, then we'd
overwrite it).

> To be really pedantic, there's also the question of what errno the
> caller would want if *both* ferror() and fclose() fail. Normally I would
> say "the first error that occurred", but in this case we don't know the
> correct errno from the error reported by ferror(), so maybe the fclose()
> errno is more likely to hint at the underlying reason for the failure.

Yes, I think we're better to take what fclose gives us, if we can.

> So I (reluctantly) propose
> 
> 	if (ferror(fp)) {
> 		if (!fclose(fp)) {
> 			/*
> 			 * ferror() doesn't set errno, so we have to
> 			 * set one. (By contrast, when fclose() fails
> 			 * too, we leave *its* errno in place.)
> 			 */
> 			errno = EIO;
> 		}
> 		return -1;
> 	}
> 	return fclose();

That's similar to what I wrote earlier, but if we don't mind overwriting
errno unconditionally, I think just:

  errno = EIO; /* covers ferror(), overwritten by failing fclose() */
  err |= ferror(fp);
  err |= fclose(fp);

does the same thing.

-Peff
