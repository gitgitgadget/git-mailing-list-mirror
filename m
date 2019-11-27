Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C389C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B9220665
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK0RBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:01:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:34124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726593AbfK0RBD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:01:03 -0500
Received: (qmail 12664 invoked by uid 109); 27 Nov 2019 17:01:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 17:01:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11576 invoked by uid 111); 27 Nov 2019 17:05:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 12:05:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 12:01:02 -0500
From:   Jeff King <peff@peff.net>
To:     Ed Maste <emaste@freebsd.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4210: skip i18n tests that don't work on FreeBSD
Message-ID: <20191127170102.GA1123@sigill.intra.peff.net>
References: <20191127151708.50531-1-emaste@freefall.freebsd.org>
 <20191127162416.GB30581@sigill.intra.peff.net>
 <CAPyFy2AyQGhFxzd2AEGhtU5u6OHZD-mJy4duXCs5-YYVbvkYFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPyFy2AyQGhFxzd2AEGhtU5u6OHZD-mJy4duXCs5-YYVbvkYFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 08:07:30AM -0500, Ed Maste wrote:

> On Wed, 27 Nov 2019 at 11:24, Jeff King <peff@peff.net> wrote:
> >
> > > Extend test-lib.sh to add a FREEBSD prereq (akin to MINGW) and add !FREEBSD
> > > to these tests.
> >
> > Before we start growing more system-specific prereqs here, can we add a
> > layer of indirection? Convert this test to use a REGEX_ALLOW_ILLSEQ
> > prereq (or maybe there's a better name), and then set it for both mingw
> > and freebsd?
> 
> Thanks, and that makes sense, but should we make the sense the
> opposite way - set REGEX_ALLOW_ILLSEQ only for glibc (including
> Cygwin, I guess)?

Possibly. There's a long tail of platforms we support, and we don't
really know how they behave (are they OK, or is it that nobody has
bothered to check yet?). I'd be inclined to blacklist platforms where we
know it doesn't work, in order to let the test run on as many as
possible.

I guess we'd need to invert the prereq then to systems that actually
report ILLSEQ (maybe REGEX_ILLSEQ, and set it for FreeBSD?).

> This also applies only to two cases ("latin1 + locale" and "latin1 +
> locale + invalid needle"). There are other !MINGW tests in
> t4210-log-i18n.sh which do not use invalid UTF-8 and work fine on
> FreeBSD.

Hmm, yeah. It's not clear to me if !MINGW is there because of the ILLSEQ
issue, or just because it doesn't handle these tests at all. So maybe it
would make sense to just set it for FreeBSD for now, and mingw folks can
clean it up further if they want to dig into it.

-Peff
