Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91200C11D07
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED96207FD
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 11:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgBTLTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:19:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:49104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727495AbgBTLTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 06:19:02 -0500
Received: (qmail 3239 invoked by uid 109); 20 Feb 2020 11:19:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Feb 2020 11:19:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3451 invoked by uid 111); 20 Feb 2020 11:28:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Feb 2020 06:28:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Feb 2020 06:19:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Reftable support git-core
Message-ID: <20200220111901.GA1252160@coredump.intra.peff.net>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <xmqqy2szip35.fsf@gitster-ct.c.googlers.com>
 <CAOw_e7abpAwTkb6qKZjbxxw7XrAWdhcANbjAWvRxi1_fT5vSDA@mail.gmail.com>
 <xmqq36b6h5o2.fsf@gitster-ct.c.googlers.com>
 <CAOw_e7ZztSCzpmaCYg2c1iaZLWSsYz4dYegT0V0dHVaDy8A_uQ@mail.gmail.com>
 <xmqq8skyfnxm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8skyfnxm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 10:10:29AM -0800, Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwenn@gmail.com> writes:
> 
> > On Wed, Feb 19, 2020 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> > your checker is tripping over code imported from zlib. I added a /*
> >> > clang-format off */ comment to avoid reformatting this code. What do
> >> > you suggest?
> >>
> >> Use zlib from the system instead?
> >
> > uncompress2 is a 2016 addition to zlib. It doesn't pass on
> > gitgitgadget's CI, because it is using an older version of zlib.
> 
> Ahh.
> 
> It is OK (and indeed you're right that you cannot avoid it) to ship
> a reasonably new snapshot as a fallback in such a case, but it still
> is far more preferrable to avoid linking with the fallback snapshot
> copy when a working one is available on the system, especially for a
> widely used and established library like zlib, because we have one
> less thing to keep up-to-date with the security patches made to the
> upstream.

If this were substantial code, I'd agree. But this is really just a thin
wrapper around the usual loop zlib inflate() loop that we already do in
a dozen places in our code (e.g., unpack_loose_rest(), which even does
the "did we consume all the bytes" check that uncompress2 allows).

I'm not sure it is worth the mental energy of adding a Makefile knob to
use the zlib version if we can just open-code it ourselves (or provide
our own custom helper that we always use).

And if it _is_ worth taking the zlib version because we're concerned
that it may contain or gain bugfixes[1], then possibly we should
be using it in lots more places (though probably not everywhere, as we
do sometimes need the streaming behavior of the loop).

[1] I'll admit we've hit some subtleties with that loop in the past,
    especially around corrupted or bogus inputs, but I think we've
    shaken them all out these days.

-Peff
