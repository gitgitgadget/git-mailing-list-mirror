Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5D3201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 19:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdBYT07 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 14:26:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:34113 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbdBYT07 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 14:26:59 -0500
Received: (qmail 32509 invoked by uid 109); 25 Feb 2017 19:26:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 19:26:58 +0000
Received: (qmail 16146 invoked by uid 111); 25 Feb 2017 19:27:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 14:27:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 14:26:56 -0500
Date:   Sat, 25 Feb 2017 14:26:56 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170225192655.l5dbzq42cvk5surl@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170225185050.t6e5txrppofgelsf@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170225185050.t6e5txrppofgelsf@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 06:50:50PM +0000, brian m. carlson wrote:

> > As long as the reader can tell from the format of object names
> > stored in the "new object format" object from what era is being
> > referred to in some way [*1*], we can name new objects with only new
> > hash, I would think.  "new refers only to new" that stratifies
> > objects into older and newer may make things simpler, but I am not
> > convinced yet that it would give our users a smooth enough
> > transition path (but I am open to be educated and pursuaded the
> > other way).
> 
> I would simply use multihash[0] for this purpose.  New-style objects
> serialize data in multihash format, so it's immediately obvious what
> hash we're referring to.  That makes future transitions less
> problematic.
> 
> [0] https://github.com/multiformats/multihash

I looked at that earlier, because I think it's a reasonable idea for
future-proofing. The first byte is a "varint", but I couldn't find where
they defined that format.

The closest I could find is:

  https://github.com/multiformats/unsigned-varint

whose README says:

  This unsigned varint (VARiable INTeger) format is for the use in all
  the multiformats.

    - We have not yet decided on a format yet. When we do, this readme
      will be updated.

    - We have time. All multiformats are far from requiring this varint.

which is not exactly confidence inspiring. They also put the length at
the front of the hash. That's probably convenient if you're parsing an
unknown set of hashes, but I'm not sure it's helpful inside Git objects.
And there's an incentive to minimize header data at the front of a hash,
because every byte is one more byte that every single hash will collide
over, and people will have to type when passing hashes to "git show",
etc.

I'd almost rather use something _really_ verbose like

  sha256:1234abcd...

in all of the objects. And then when we get an unadorned hash from the
user, we guess it's sha256 (or whatever), and fallback to treating it as
a sha1.

Using a syntactically-obvious name like that also solves one other
problem: there are sha1 hashes whose first bytes will encode as a "this
is sha256" multihash, creating some ambiguity.

-Peff
