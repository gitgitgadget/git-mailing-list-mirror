Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B451FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933451AbdBPVbo (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:31:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:56691 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933087AbdBPVbn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:31:43 -0500
Received: (qmail 25818 invoked by uid 109); 16 Feb 2017 21:31:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 21:31:42 +0000
Received: (qmail 27651 invoked by uid 111); 16 Feb 2017 21:31:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 16:31:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 16:31:40 -0500
Date:   Thu, 16 Feb 2017 16:31:40 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH] tempfile: avoid "ferror | fclose" trick
Message-ID: <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
 <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
 <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
 <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
 <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
 <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
 <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
 <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
 <87tw7uv439.fsf@linux-m68k.org>
 <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 11:43:59AM -0500, Jeff King wrote:

> On Thu, Feb 16, 2017 at 11:10:18AM +0100, Andreas Schwab wrote:
> 
> > >> 	int xfclose(FILE *fp)
> > >> 	{
> > >> 		return ferror(fp) | fclose(fp);
> > >> 	}
> > >
> > > Yes, that's exactly what I had in mind (might be worth calling out the
> > > bitwise-OR, though, just to make it clear it's not a typo).
> > 
> > Since the order of evaluation is unspecified, it would be better to
> > force sequencing ferror before fclose.
> 
> Good point. Arguably the call in tempfile.c is buggy.

Here's a fix.

I think close_tempfile() suffers from the same errno problem discussed
earlier in this thread (i.e., that after calling it, you may get an
error return with a random, unrelated errno value if ferror() failed but
fclose() did not).

-- >8 --
Subject: [PATCH] tempfile: avoid "ferror | fclose" trick

The current code wants to record an error condition from
either ferror() or fclose(), but makes sure that we always
call both functions. So it can't use logical-OR "||", which
would short-circuit when ferror() is true. Instead, it uses
bitwise-OR "|" to evaluate both functions and set one or
more bits in the "err" flag if they reported a failure.

Unlike logical-OR, though, bitwise-OR does not introduce a
sequence point, and the order of evaluation for its operands
is unspecified. So a compiler would be free to generate code
which calls fclose() first, and then ferror() on the
now-freed filehandle.

There's no indication that this has happened in practice,
but let's write it out in a way that follows the standard.

Noticed-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 2990c9242..ffcc27237 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -247,12 +247,8 @@ int close_tempfile(struct tempfile *tempfile)
 	tempfile->fd = -1;
 	if (fp) {
 		tempfile->fp = NULL;
-
-		/*
-		 * Note: no short-circuiting here; we want to fclose()
-		 * in any case!
-		 */
-		err = ferror(fp) | fclose(fp);
+		err = ferror(fp);
+		err |= fclose(fp);
 	} else {
 		err = close(fd);
 	}
-- 
2.12.0.rc1.559.gd292418bf

