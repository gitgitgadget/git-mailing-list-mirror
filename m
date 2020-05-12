Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8409BCA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D43C206A5
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgELT1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 15:27:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:44578 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725554AbgELT1H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 15:27:07 -0400
Received: (qmail 30944 invoked by uid 109); 12 May 2020 19:27:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 May 2020 19:27:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10352 invoked by uid 111); 12 May 2020 19:27:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2020 15:27:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 May 2020 15:27:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
Message-ID: <20200512192706.GD54565@coredump.intra.peff.net>
References: <20200512191610.GB54565@coredump.intra.peff.net>
 <20200512192300.203201-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200512192300.203201-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 12, 2020 at 12:23:00PM -0700, Jonathan Tan wrote:

> > PS I sometimes find the normal trace a bit verbose, but I do still want
> >    to see data. Do others feel the same? Particularly I find the "SSL"
> >    lines totally worthless (I guess maybe you could be debugging ssl
> >    stuff, but that would be the exception, I'd think). Ditto the split
> >    of data into two lines: one with the size and one with the actual
> >    data.
> > 
> >    I dunno. I haven't been debugging any git-over-http stuff lately, so
> >    it hasn't been bothering me. But I definitely have written perl
> >    scripts to extract the data to a more readable format. Maybe it would
> >    be easier if it had a few more knobs.
> 
> Data can be turned on using GIT_TRACE_CURL=1 and refraining from setting
> GIT_TRACE_CURL_NO_DATA. What knobs were you thinking of?

I still want to see data, but less cruft. I.e., something like
"GIT_TRACE_CURL_SSL" (which I'd default to "off"), and probably just
reducing:

  15:24:01.169101 [pid=55191] http.c:702            <= Recv data, 0000000004 bytes (0x00000004)
  15:24:01.169104 [pid=55191] http.c:717            <= Recv data: 3e..

to just the second line. Actually, we might not need a knob at all for
SSL data. I was thinking that people might actually be debugging SSL
problems with it, but since all of the non-printable characters are
munged to "." anyway, it's basically useless (you can often pick out a
few strings from the cert during handshake, but you'd be much better off
to just connect with "openssl s_client" and ask it to dump the cert).

-Peff
