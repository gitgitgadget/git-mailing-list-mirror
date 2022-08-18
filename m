Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA970C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 05:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbiHRFjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 01:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiHRFjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 01:39:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C72DAB2
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 22:38:57 -0700 (PDT)
Received: (qmail 11906 invoked by uid 109); 18 Aug 2022 05:38:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Aug 2022 05:38:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23225 invoked by uid 111); 18 Aug 2022 05:38:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Aug 2022 01:38:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Aug 2022 01:38:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 5/6] pipe_command(): handle ENOSPC when writing to a
 pipe
Message-ID: <Yv3QcK4PPP9yJkKR@coredump.intra.peff.net>
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
 <YvyGJiz+CFPcgpML@coredump.intra.peff.net>
 <xmqqo7wivgua.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo7wivgua.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 11:57:01AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When write() to a non-blocking pipe fails because the buffer is full,
> > POSIX says we should see EAGAIN. But our mingw_write() compat layer on
> > Windows actually returns ENOSPC for this case. This is probably
> > something we want to correct, but given that we don't plan to use
> > non-blocking descriptors in a lot of places, we can work around it by
> > just catching ENOSPC alongside EAGAIN. If we ever do fix mingw_write(),
> > then this patch can be reverted.
> >
> > We don't actually use a non-blocking pipe yet, so this is still just
> > preparation.
> >
> > Helped-by: René Scharfe <l.s.r@web.de>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Ironically, this ENOSPC bug means that switching away from xwrite() in
> > the previous patch wasn't necessary (because it's not clever enough to
> > know that ENOSPC on a pipe means EAGAIN!). But I think handling both
> > shows the intent, and sets us up better for fixing mingw_write().
> 
> Yeah, I am impressed by the attention of small details by you two
> shown here to split the steps 4/6 and 5/6.  If we consider that this
> step is a band-aid we'd be happier if we can remove, perhaps in-code
> comment to explain why we deal with ENOSPC here, instead of burying
> it only in the log message, would help remind people of the issue
> (but of course the patch is good with or without such a tweak, which
> is only relevant in the longer term).

Yeah, you may be right. I had originally written a quite long comment
here (before I split things up so much), but found in the splitting that
it made more sense to put most of the details into the commit message.

But maybe it's worth squashing this in?

diff --git a/run-command.c b/run-command.c
index 5fbaa8b5ac..065883672b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1372,6 +1372,10 @@ static int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
 			 *
 			 * Note that we lose xwrite()'s handling of MAX_IO_SIZE
 			 * and EINTR, so we have to implement those ourselves.
+			 *
+			 * We also check for ENOSPC to handle a quirk of
+			 * mingw_write(), which uses that for a full pipe
+			 * instead of EAGAIN.
 			 */
 			len = write(io->fd, io->u.out.buf,
 				    io->u.out.len <= MAX_IO_SIZE ?

-Peff
