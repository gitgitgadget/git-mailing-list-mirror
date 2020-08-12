Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED4AC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831272080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLPGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:06:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:56432 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgHLPGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 11:06:12 -0400
Received: (qmail 9549 invoked by uid 109); 12 Aug 2020 15:06:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 15:06:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32165 invoked by uid 111); 12 Aug 2020 15:06:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 11:06:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 11:06:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/11] renaming argv_array
Message-ID: <20200812150611.GA33189@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 06:08:22PM +0200, René Scharfe wrote:

> > This has bugged me for a while, so I decided to finally fix it. It
> > wasn't _too_ painful, though I'm sure there will be a little fallout
> > with topics in flight.
> 
> Just as this landed in master now, https://lobste.rs/ decided to link to
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2493.pdf, which is a
> paper about reserved identifiers in C.  It contains a nice overview.
> 
> Anyway, 7.31 of C11 says: "All external names described below are
> reserved no matter what headers are included by the program."  And
> 7.31.13 goes on: "Function names that begin with str, mem, or wcs and a
> lowercase letter may be added to the declarations in the <string.h>
> header."  So the names of the strvec functions are reserved.

It was the same in C99. I think this is one of those cases where we need
to worry less about what the standard says and more about what the real
world does. As long as we're ready for C25 or whatever to add "strvec"
and we accept that we'll need to change the name then, I'm not
particularly concerned. A compiler that starts warning about "str"
functions in the meantime would be impractical I think (forget strbuf,
stuff like strip_extension() would be illegal).

> Also how about using Coccinelle and patience to reduce the impact of
> such a change next time?  I.e. adding the new thing, providing a
> semantic patch for converting old code, waiting a reasonable amount of
> time after the last conversion was necessary and then removing the
> old thing.

So I almost sent a rant about Coccinelle along with this series. :)

Debian unstable now ships coccinelle 1.0.8, and it's unbelievably slow
compared to 1.0.4. Running "make coccicheck" is currently at 80 minutes
of CPU time running each script in parallel, with none of them down.
They're also all consuming 6GB of RAM each, so I'm killing them all.

I got somewhere similar when I was working on this series, got fed up,
and then just did the whole thing with grep, which was easier. I'm open
to the idea that a slower transition might have helped topics in flight
catch up, but it also would have prolonged the pain. So I dunno.

-Peff
