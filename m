Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852DEC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 14:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BA464F42
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 14:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhCDOl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 09:41:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:52178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232172AbhCDOk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 09:40:57 -0500
Received: (qmail 27072 invoked by uid 109); 4 Mar 2021 14:40:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Mar 2021 14:40:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9267 invoked by uid 111); 4 Mar 2021 14:40:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Mar 2021 09:40:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Mar 2021 09:40:16 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 03/12] pkt-line: (optionally) libify the packet readers
Message-ID: <YEDxUFJmPH4nP6Qk@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <e05467def4e158a5f1cfa3aafffdb5c77097859a.1613598529.git.gitgitgadget@gmail.com>
 <xmqqwnuohv4t.fsf@gitster.c.googlers.com>
 <6b1ce8c0-0881-77a0-deda-677e34560cc0@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b1ce8c0-0881-77a0-deda-677e34560cc0@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 04, 2021 at 09:17:41AM -0500, Jeff Hostetler wrote:

> > In the post-context of this hunk, there is this code:
> > 
> > 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
> > 	    starts_with(buffer, "ERR "))
> > 		die(_("remote error: %s"), buffer + 4);
> > 
> > 	*pktlen = len;
> > 	return PACKET_READ_NORMAL;
> > 
> > But here, there is no way to override the DIE_ON_ERR with
> > READ_NEVER_DIE.
> > 
> > The asymmetry is somewhat annoying (i.e. if "if you do not want to
> > die upon ERR, don't pass DIE_ON_ERR" could be a valid suggestion to
> > the callers, then "if you do not want to die upon an unexpected
> > hung-up, pass GENTLE_ON_EOF" would equally be valid suggestion),
> > but I'll let it pass.
> 
> I agree that there is something odd about all of these flags,
> but I don't have the context on all the various caller combinations
> to make a better suggestion at this time.  And I certainly don't
> want to stir up a bigger mess than I already have. :-)
> 
> We did document in the .h that READ_NEVER_DIE excludes ERR packets
> when READ_DIE_ON_ERR is set, so I think we're safe from unexpected
> surprises.

I think the flag is doing sensible things; it's just that the word
"never" in the name is confusing, since it is "never except this one
time".

Would PACKET_READ_GENTLE_ON_READ_ERROR be a better name, to match
GENTLE_ON_EOF? I was tempted to just call it "ON_ERROR", since it also
include parsing errors, but maybe somebody would think that includes ERR
packets (that is more of a stretch, though, I think).

Likewise, I kind of wonder if callers would really prefer suppressing
the error() calls, too. Saying "error: the remote end hung up
unexpectedly" is not that helpful if the "remote end" we are talking
about is fsmonitor, and not the server side of a fetch.

-Peff
