Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9EE202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 21:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934204AbdKPV5a (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 16:57:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:60266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752051AbdKPV52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 16:57:28 -0500
Received: (qmail 20675 invoked by uid 109); 16 Nov 2017 21:57:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Nov 2017 21:57:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20529 invoked by uid 111); 16 Nov 2017 21:57:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 16 Nov 2017 16:57:41 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Nov 2017 16:57:26 -0500
Date:   Thu, 16 Nov 2017 16:57:26 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 4/6] list-objects: filter objects in
 traverse_commit_list
Message-ID: <20171116215725.k44e3alk2lq6bbwu@sigill.intra.peff.net>
References: <20171116180743.61353-1-git@jeffhostetler.com>
 <20171116180743.61353-5-git@jeffhostetler.com>
 <20171116122133.4cc718414579c1a5a682174b@google.com>
 <bdf75d90-570d-8cf0-886a-2c5c9cdba1c1@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdf75d90-570d-8cf0-886a-2c5c9cdba1c1@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 16, 2017 at 04:49:08PM -0500, Jeff Hostetler wrote:

> > First of all, about the injection problem, replying to your previous e-mail
> > [1]:
> > 
> > https://public-inbox.org/git/61855872-221b-0e97-abaa-24a011ad899e@jeffhostetler.com/
> > 
> > > I couldn't use quote.[ch] because it is more concerned with
> > > quoting pathnames because of LF and CR characters within
> > > them -- rather than semicolons and quotes and the like which
> > > I was concerned about.
> > 
> > sq_quote_buf() (or one of the other similarly-named functions) should
> > solve this problem, right? The single quotes around the argument takes
> > care of LF, CR, and semicolons, and things like backslashes and quotes
> > are taken care of as documented.
> > 
> > I don't think we need to invent another encoding to solve this.
> 
> I'll take another look, sq_quote_buf() looks like it might work.
> I was looking at quote_c_style() and that didn't seem right for
> my needs.  Thanks.

I admit I haven't been following this thread closely, but I couldn't
seem to find any indication of exactly which interfaces need quoting, or
who is expected to unquote (here or in the previous iterations).

It sounds like you're worried about shell injection, but shouldn't we
worry about that the actual shell boundary? Likewise, if these values
are being passed over the git protocol, shouldn't that part of the
protocol be designed to encode arbitrary bytes?

Those encodings don't necessarily need to be the same, because they're
about transport. Inside each process we'd have the raw bytes, and encode
them as appropriate to whatever sub-program we're going to pass to (or
not at all if we skip the shell for sub-processes, which is usually a
good idea).

I have the feeling I'm missing something.

-Peff
