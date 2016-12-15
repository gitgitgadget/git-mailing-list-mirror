Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79BC21FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 11:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbcLOLCn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 06:02:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:56964 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752661AbcLOLCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 06:02:41 -0500
Received: (qmail 14156 invoked by uid 109); 15 Dec 2016 11:01:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 11:01:57 +0000
Received: (qmail 902 invoked by uid 111); 15 Dec 2016 11:02:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 06:02:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 06:01:55 -0500
Date:   Thu, 15 Dec 2016 06:01:55 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] fix pushing to //server/share/dir on Windows
Message-ID: <20161215110155.it7ptkbju5etmnpn@sigill.intra.peff.net>
References: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
 <20161214173034.inbyakdykjv5j7ua@sigill.intra.peff.net>
 <787a421b-8b7a-14c5-768f-06c3dc183cf4@kdbg.org>
 <c8501e28-db8a-5b6e-717c-5bda1e63c2e7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8501e28-db8a-5b6e-717c-5bda1e63c2e7@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 08:30:52AM +0100, Torsten Bögershausen wrote:

> > > Would it be reasonable to
> > > write:
> > > 
> > >    /* Copy initial part of absolute path, converting separators on Windows */
> > >    const char *end = src + offset_1st_component(src);
> > >    while (src < end) {
> > > 	  char c = *src++;
> > > 	  if (c == '\\')
> > > 		  c = '/';
> > > 	  *dst++ = c;
> > >    }
> > Makes a lot of sense! I haven't had an opportunity, though, to test
> > on Windows.
> I'm not sure, if a conversion should be done here, in this part of code.
> To my knowledge,
> 
> C:\dir1\file
> is the same
> as
> C:/dir1/file
> and that is handled by windows.

I don't have an opinion either way on what Windows would want, but note
that the function already _does_ convert separators to slashes. With
Johannes's original patch, you'd end up with a mix, like:

  \\server\share/dir1/file

So this conversion is really just retaining the original behavior, and
making it consistent throughout the path.

Which isn't to say that the function as it currently exists isn't a
little bit buggy. :)

One of the points of normalizing, though, is that Git can then do
textual comparisons between the output. So I think there's value in
having a canonical internal representation, even if the OS could handle
more exotic ones.

-Peff
