Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EC1C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3C5615E2
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhKPPrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:47:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:60102 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238327AbhKPPrb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 10:47:31 -0500
Received: (qmail 20418 invoked by uid 109); 16 Nov 2021 15:44:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 15:44:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30112 invoked by uid 111); 16 Nov 2021 15:44:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 10:44:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 10:44:33 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Generate temporary files using a CSPRNG
Message-ID: <YZPR4Ya1ocWvKbAf@coredump.intra.peff.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 03:35:40AM +0000, brian m. carlson wrote:

> For those who are interested, I computed the probability of spurious
> failure for the self-test mode like so:
> 
>   256 * (255/256)^65536
> 
> This Ruby one-liner estimates the probability at approximately 10^-108:
> 
>   ruby -e 'a = 255 ** 65536; b = 256 ** 65536; puts b.to_s.length - a.to_s.length - 3'
> 
> If I have made an error in the calculation, please do feel free to point
> it out.

Yes, I think your math is correct there.

A more interesting question is whether generating 64k of PRNG bytes per
test run is going to a problem for system entropy pools. For that
matter, I guess the use of it for tempfiles will produce a similar
burden, since we run so many commands. My understanding is that modern
systems will just produce infinite output for /dev/urandom, etc, but I
wonder if there are any systems left where that is not true (because
they have a misguided notion that they need to stir in more "real"
entropy bits).

-Peff
