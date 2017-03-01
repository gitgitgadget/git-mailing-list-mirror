Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80DB2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbdCAVfW (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:35:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:36695 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753279AbdCAVeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:34:46 -0500
Received: (qmail 11121 invoked by uid 109); 1 Mar 2017 20:34:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 20:34:29 +0000
Received: (qmail 9286 invoked by uid 111); 1 Mar 2017 20:34:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 15:34:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 15:34:27 -0500
Date:   Wed, 1 Mar 2017 15:34:27 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Dan Shumow <danshu@microsoft.com>,
        Marc Stevens <marc.stevens@cwi.nl>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
 <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 12:14:34PM -0800, Linus Torvalds wrote:

> > My biggest concern is the index-pack operation. Try this:
> 
> I'm mobile right now, so I can't test, but I'd this perhaps at least partly
> due to the full checksum over the pack-file?
>
> We have two very different uses of SHA1: the actual object name hash, but
> also the sha1file checksums that we do on the index file and the pack files.
>
> And the checksum code really doesn't need the collision checking at all.

I don't think that helps. The sha1 over the pack-file takes about 1.3s
with openssl, and 5s with sha1dc. So we already know the increase there
is only a few seconds, not a few minutes.

And it makes sense if you think about the index-pack operation. It has
to inflate each object, resolving deltas, and checksum the result. And
the number of inflated bytes is _much_ larger than the on-disk bytes.
You can see the difference with:

  git cat-file --batch-all-objects \
    --batch-check='%(objectsize:disk) %(objectsize)' |
  perl -alne '
    $disk += $F[0]; $raw += $F[1];
    END { print "$disk $raw" }
  '

On linux.git that yields:

  1210521959 63279680406

That's over a 50x increase in the bytes we have to sha1 for objects
versus pack-checksums.

-Peff
