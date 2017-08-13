Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66DF208B8
	for <e@80x24.org>; Sun, 13 Aug 2017 05:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbdHMF64 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 01:58:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:37322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750922AbdHMF64 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 01:58:56 -0400
Received: (qmail 14324 invoked by uid 109); 13 Aug 2017 05:58:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Aug 2017 05:58:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28729 invoked by uid 111); 13 Aug 2017 05:59:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Aug 2017 01:59:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Aug 2017 01:58:53 -0400
Date:   Sun, 13 Aug 2017 01:58:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Simon Ruderich <simon@ruderich.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
Message-ID: <20170813055853.vrrfot3ijrpjk2rv@sigill.intra.peff.net>
References: <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
 <20170811075059.nn6lru7uy6s6vpza@ruderich.org>
 <e8e7f028-6e23-368c-484f-9f069bae5dc8@web.de>
 <20170812100252.bhbgg5jjlom7dfl2@ruderich.org>
 <510f566b-3aee-98fd-9663-d97c3dcfeb96@web.de>
 <20170813043237.ndcm77i43ivepo7b@sigill.intra.peff.net>
 <4bf18555-f8ea-a3f6-5204-b02bfd8f1ff9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bf18555-f8ea-a3f6-5204-b02bfd8f1ff9@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 13, 2017 at 07:51:34AM +0200, René Scharfe wrote:

> Am 13.08.2017 um 06:32 schrieb Jeff King:
> > On Sat, Aug 12, 2017 at 01:57:06PM +0200, René Scharfe wrote:
> > 
> >> But we probably want to check for other errors.  They look unlikely
> >> enough that we may get away with something like this:
> >>
> >> 	-	if (errno == ENOMEM)
> >> 	-		die("Out of memory, getdelim failed");
> >> 	+	if (errno || ferror(fp))
> >> 	+		die_errno(_("getdelim failed"));
> >>
> >> NB: The other errors are EINVAL (input pointers are NULL or the
> >> stream is invalid) and EOVERFLOW (read more than fits into ssize_t)
> >> according to POSIX and the Linux manpage.
> > 
> > Can't we also get any of the errors that fgetc() would return. I.e., any
> > normal read errors? We should return EOF on those, not die (and the
> > caller can check ferror()).
> 
> Yes, we can get those as well, and leaving error checking to the caller
> is a flexible way to handle them.  
> 
> Many of the existing callers don't seem to be bother, though.

Yes, but keep in mind that we need to match the non-getdelim()
implementation here (which itself tries to behave like more or less like
a dynamic fgets, including the eof/error handling). Because the callers
don't know which one they're getting.

-Peff
