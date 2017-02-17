Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B957201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 21:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934994AbdBQVHx (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 16:07:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:57436 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934894AbdBQVHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 16:07:52 -0500
Received: (qmail 21780 invoked by uid 109); 17 Feb 2017 21:07:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 21:07:51 +0000
Received: (qmail 6062 invoked by uid 111); 17 Feb 2017 21:07:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 16:07:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 16:07:49 -0500
Date:   Fri, 17 Feb 2017 16:07:49 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
Message-ID: <20170217210749.6dqmaotleefid76y@sigill.intra.peff.net>
References: <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
 <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
 <20170215231832.bzg3ygz4ualcvqlc@sigill.intra.peff.net>
 <87tw7uv439.fsf@linux-m68k.org>
 <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
 <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
 <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
 <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
 <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
 <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 03:54:42PM -0500, Jeff King wrote:

> I guess we are simultaneously assuming that it is OK to munge errno on
> success in our function, but that fclose() will not do so. Which seems a
> bit hypocritical. Maybe the "if" dance is better.

So here's that patch with a justification.

At this point, this snippet of code would be appropriate to pull into
xfclose() if we wanted. But possibly that is the wrong direction, as it
encourages callers to do:

  if (xfclose(fp))
	err = error_errno("failure writing to ...");

when they could do:

  if (ferror(fp))
	err = error("failure writing to ...");
  if (fclose(fp))
        err = error_errno("failure writing to ...");

While longer, it's arguably better for them to distinguish the two
cases. It's only worth doing the errno magic when the close is deep
inside a callstack, and passing out the two cases is awkward.

-- >8 --
Subject: tempfile: set errno to a known value before calling ferror()

In close_tempfile(), we return an error if ferror()
indicated a previous failure, or if fclose() failed. In the
latter case, errno is set and it is useful for callers to
report it.

However, if _only_ ferror() triggers, then the value of
errno is based on whatever syscall happened to last fail,
which may not be related to our filehandle at all. A caller
cannot tell the difference between the two cases, and may
use "die_errno()" or similar to report a nonsense errno value.

One solution would be to actually pass back separate return
values for the two cases, so a caller can write a more
appropriate message for each case. But that makes the
interface clunky.

Instead, let's just set errno to the generic EIO in this case.
That's not as descriptive as we'd like, but at least it's
predictable. So it's better than the status quo in all cases
but one: when the last syscall really did involve a failure
on our filehandle, we'll be wiping that out. But that's a
fragile thing for us to rely on.

In any case, we'll let the errno result from fclose() take
precedence over our value, as we know that's recent and
accurate (and many I/O errors will persist through the
fclose anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index ffcc27237..684371067 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -247,8 +247,13 @@ int close_tempfile(struct tempfile *tempfile)
 	tempfile->fd = -1;
 	if (fp) {
 		tempfile->fp = NULL;
-		err = ferror(fp);
-		err |= fclose(fp);
+		if (ferror(fp)) {
+			err = -1;
+			if (!fclose(fp))
+				errno = EIO;
+		} else {
+			err = fclose(fp);
+		}
 	} else {
 		err = close(fd);
 	}
-- 
2.12.0.rc1.612.ga5f664feb

