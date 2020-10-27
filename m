Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E2C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226ED20725
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441005AbgJ0UmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:42:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:39360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436598AbgJ0UmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 16:42:07 -0400
Received: (qmail 19163 invoked by uid 109); 27 Oct 2020 20:42:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 20:42:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22218 invoked by uid 111); 27 Oct 2020 20:42:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 16:42:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 16:42:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sideband: diagnose more incoming packet anomalies
Message-ID: <20201027204205.GA643357@coredump.intra.peff.net>
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
 <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
 <20201027065250.GB3005508@coredump.intra.peff.net>
 <20201027071222.GC3005508@coredump.intra.peff.net>
 <xmqqblgncxap.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblgncxap.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 11:56:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Oct 27, 2020 at 02:52:50AM -0400, Jeff King wrote:
> >
> >>   - we'll report an eof with a more detailed "protocol error: eof while
> >>     reading sideband packet", rather than the generic "the remote end
> >>     hung up unexpectedly"
> >
> > I wasn't sure if "eof" was too jargon-y. This is probably a message
> > normal users are likely to see if the network drops out on them.
> 
> We were expecting to see something, and instead of seeing that
> specific thing we were waiting, we saw the end-of-file?
> 
> That sounds like "the other side hung up unexpectedly" to me.  Does
> it bother you for being "too generic" because it does not say what
> we were expecting to see?  "unexpected disconnect while waiting for
> a sideband packet"?

Yes, saying what we were expecting is what seems like an improvement to
me. I tried coming up with something that said "hung up" but the wording
ended up awkward. Your "unexpected disconnect while waiting for a
sideband packet" is exactly what I was trying for. :)

Does this patch seem otherwise worth doing?

An alternate patch would be to keep the behavior the same and just
clarify the code a bit. Something like:

-- >8 --
Subject: [PATCH] demultiplex_sideband(): clarify corner cases

The size checks in demultiplex_sideband() are a bit subtle and
confusing:

  - we consider a zero-length packet ("0004") to be a flush packet, even
    though it's not really one. This is perhaps wrong, but it should
    never happen in our protocol, and we err on the side of history and
    leniency. We'll leave a comment indicating that we expect this case.

  - likewise we consider any flush-like packet (e.g., "0001" delim) to
    be a flush. I didn't confirm whether this is necessary for normal
    protocol usage. It may be for the everything-over-sideband mode
    introduced by 0bbc0bc574 ({fetch,upload}-pack: sideband v2 fetch
    response, 2019-01-16). Likewise let's leave a comment.

  - we check for "len < 1" to see if there's no sideband designator.
    That's confusing, because we already covered the "len == 0" case.
    What is interesting is the "len < 0" case. But that's not a missing
    sideband designator, but rather an error or EOF from the pkt-line
    code. This should never happen, though, because our callers instruct
    pkt-line to die() on EOF anyway. So let's make it more obvious
    that we're looking for a negative value here, and consider it a
    BUG() in the caller to pass us garbage.

Signed-off-by: Jeff King <peff@peff.net>
---
 sideband.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sideband.c b/sideband.c
index 0a60662fa6..6ba1925614 100644
--- a/sideband.c
+++ b/sideband.c
@@ -130,17 +130,18 @@ int demultiplex_sideband(const char *me, char *buf, int len,
 			suffix = DUMB_SUFFIX;
 	}
 
+	if (len < 0)
+		BUG("error/eof packet passed to demultiplex_sideband");
+
 	if (len == 0) {
+		/*
+		 * we treat all flush-like packets (flush, delim, etc) and even
+		 * empty data packets as a flush
+		 */
 		*sideband_type = SIDEBAND_FLUSH;
 		goto cleanup;
 	}
-	if (len < 1) {
-		strbuf_addf(scratch,
-			    "%s%s: protocol error: no band designator",
-			    scratch->len ? "\n" : "", me);
-		*sideband_type = SIDEBAND_PROTOCOL_ERROR;
-		goto cleanup;
-	}
+
 	band = buf[0] & 0xff;
 	buf[len] = '\0';
 	len--;
-- 
2.29.1.641.gb6287e56d2

