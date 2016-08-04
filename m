Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D84D20193
	for <e@80x24.org>; Thu,  4 Aug 2016 21:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966417AbcHDVWt (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 17:22:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:55015 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753041AbcHDVWs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 17:22:48 -0400
Received: (qmail 15943 invoked by uid 102); 4 Aug 2016 21:22:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 17:22:48 -0400
Received: (qmail 16718 invoked by uid 107); 4 Aug 2016 21:23:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 17:23:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 17:22:44 -0400
Date:	Thu, 4 Aug 2016 17:22:44 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 6/7] trace: disable key after write error
Message-ID: <20160804212244.cilov7i2uelg7lnh@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
 <20160803230103.daexq233ufrttnmn@sigill.intra.peff.net>
 <xmqq8twc1cx4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8twc1cx4.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 01:45:11PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If we get a write error writing to a trace descriptor, the
> > error isn't likely to go away if we keep writing. Instead,
> > you'll just get the same error over and over. E.g., try:
> >
> >   GIT_TRACE_PACKET=42 git ls-remote >/dev/null
> >
> > You don't really need to see:
> >
> >   warning: unable to write trace for GIT_TRACE_PACKET: Bad file descriptor
> >
> > hundreds of times. We could fallback to tracing to stderr,
> > as we do in the error code-path for open(), but there's not
> > much point. If the user fed us a bogus descriptor, they're
> > probably better off fixing their invocation. And if they
> > didn't, and we saw a transient error (e.g., ENOSPC writing
> > to a file), it probably doesn't help anybody to have half of
> > the trace in a file, and half on stderr.
> 
> Yes, I think I like this better than "we cannot open the named file,
> so let's trace into standard error stream" that is done in the code
> in the context of [3/7].  We should do the same over there.

Yeah, I was tempted to strip that out, too. I'll look into preparing a
patch on top.

-Peff
