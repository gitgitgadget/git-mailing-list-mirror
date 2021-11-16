Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F2BC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44683619E5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbhKPTYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:24:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:60374 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234139AbhKPTYU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 14:24:20 -0500
Received: (qmail 20940 invoked by uid 109); 16 Nov 2021 19:21:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 19:21:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 928 invoked by uid 111); 16 Nov 2021 19:21:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 14:21:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 14:21:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] wrapper: use a CSPRNG to generate random file names
Message-ID: <YZQEsjidbBUgvhfu@coredump.intra.peff.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-3-sandals@crustytoothpaste.net>
 <YZPQE+SKVXjexXMT@coredump.intra.peff.net>
 <YZP4XDtF7O7Sxh17@nand.local>
 <xmqqtugc9bdz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtugc9bdz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 10:57:28AM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> I actually wonder if we should simply die() in such a case. That's not
> >> very friendly from a libification stand-point, but we really can't
> >> progress on much without being able to generate random bytes.
> >
> > Alternatively, we could fall back to the existing code paths. This is
> > somewhat connected to my suggestion to Randall earlier in the thread.
> > But I would rather see that fallback done at compile-time for platforms
> > that don't give us an easy-to-use CSPRNG, and avoid masking legitimate
> > errors caused from trying to use a CSPRNG that should exist.
> 
> Yeah, I do not think we are doing this because the current code is
> completely broken and everybody needs to move to CSPRNG that makes
> it absoletely safe---rather this is still just making it safer than
> the current code, when system support is available.  So a fallback
> to the current code would be a good (and easy) thing to have, I
> would think.

One challenge for any fallback is that there are security implications.
In particular:

  - the fallback probably needs to be specific to the mktemp code; we
    don't have any callers yet of csprng_bytes(), but anybody using it
    for, say, actual cryptography would be very unhappy if it quietly
    fell back to insecure bytes.

    (I don't have any plans to use it and we don't do very much actual
    crypto ourselves, but one place that _could_ use it is the
    generation of the push-cert nonce seed).

  - I'm not sure if we should fallback for runtime errors or not. E.g.,
    if we try to open /dev/urandom and it isn't there, is it OK to fall
    back to the older, less-secure tempfile method? That's convenient in
    some sense; Git continues to work inside a chroot for which you
    haven't set up /dev/urandom. But it may also be surprising, and
    erring on the side of doing the less secure thing is probably a bad
    idea.

    So the mktemp code probably needs to be aware of the difference
    between "we have no CSPRNG source" and "we were compiled with
    support for a source, but it didn't work".

-Peff
