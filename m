Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45C1C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C849820857
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgDVT6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:58:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:36410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726380AbgDVT6l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 15:58:41 -0400
Received: (qmail 10247 invoked by uid 109); 22 Apr 2020 19:58:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 19:58:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1431 invoked by uid 111); 22 Apr 2020 20:09:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 16:09:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 15:58:39 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Casey <drafnel@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jessica Clarke <jrtc27@jrtc27.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for
 GNU/Hurd
Message-ID: <20200422195839.GE558336@coredump.intra.peff.net>
References: <20200422153347.40018-1-jrtc27@jrtc27.com>
 <20200422164150.GA140314@google.com>
 <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
 <CA+sFfMf=NZOV41-4oJTLF34rvELr7EvfEHOr90X_h8pSFC3AJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sFfMf=NZOV41-4oJTLF34rvELr7EvfEHOr90X_h8pSFC3AJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 12:13:50PM -0700, Brandon Casey wrote:

> On Wed, Apr 22, 2020 at 11:48 AM Brandon Casey <drafnel@gmail.com> wrote:
> >
> > I just looked in config.mak.uname, and I'm surprised to see
> > FREAD_READS_DIRECTORIES set for so many platforms. And it's set for
> > Linux and Darwin?!?!? Junio added it for Darwin
> > (8e178ec4d072da4cd8f4449e17aef3aff5b57f6a) and Nguyễn Thái Ngọc Duy
> > added it for Linux (e2d90fd1c33ae57e4a6da5729ae53876107b3463), but
> > also seemed to mistake the intention of FREAD_FREADS_DIRECTORIES as
> > being about the fopen(..., "r") of a directory rather than about an
> > fread() of a directory.
> >
> > I just wrote a test program and tested on Linux, Darwin, and Windows.
> > Linux and Darwin both succeed to fopen() a directory and fail to
> > fread() it, as expected. Windows fails to fopen() a directory.
> >
> > I notice this earlier commit mentions a failure of t1308
> > (4e3ecbd43958b1400d6cb85fe5529beda1630e3a). I wonder if this is the
> > reason FREAD_READS_DIRECTORIES was added to so many platforms?
> 
> Whoops, I got the order of e2d90fd1c33ae57e4a6da5729ae53876107b3463
> and 4e3ecbd43958b1400d6cb85fe5529beda1630e3a wrong. Looks like the
> misunderstanding of FREAD_READS_DIRECTORIES in e2d90fd could have been
> the cause of all of this. That commit introduced the test t1308 and
> added FREAD_READS... to Linux, kFreeBSD, and FreeBSD, and the other
> additions followed shortly after.

I think the code is actually doing the right thing (or at least
something useful), and the "FREAD" in the name is the confusing part.
Because there's now code doing:

  fh = fopen(fn, "r");
  if (!fh) {
    if (errno == ENOENT || errno == EISDIR) {
       /* not actually a file; treat as a gentle noop */
       return 0;
    } else {
       die_errno("omg, a real open error");
    }
  }
  if (!fread(..., fh))
       die_errno("omg, a real read error");

which is exactly what the failing test in t1308 is doing.

I know that wasn't the original intent of the flag, but I think it was a
conscious decision to build on around the time of e2d90fd1c, when we
started actually checking fopen() return values (as opposed to just
segfaulting).

And in practice, do we really care about cases that can fopen a
directory but refuse to read from it? It's simpler and more efficient to
catch this case up front.

So I think the knob has de facto become "do we need to use our compat
wrapper to make opening a directory fail with EISDIR". And any attempt
to change that will mean adapting all of the callers to handle that case
themselves. I think what we have now is the useful knob we want; it's
just misnamed (and obviously I don't blame your original patch; it was
adapted over time).

-Peff
