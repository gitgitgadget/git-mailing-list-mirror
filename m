Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107E21F42D
	for <e@80x24.org>; Wed,  9 May 2018 08:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933898AbeEIIDt (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 04:03:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933715AbeEIIDo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 04:03:44 -0400
Received: (qmail 18111 invoked by uid 109); 9 May 2018 08:03:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 May 2018 08:03:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12234 invoked by uid 111); 9 May 2018 08:03:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 09 May 2018 04:03:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 May 2018 04:03:41 -0400
Date:   Wed, 9 May 2018 04:03:41 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Message-ID: <20180509080341.GB3327@sigill.intra.peff.net>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net>
 <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
 <20180417001212.GC14631@genre.crustytoothpaste.net>
 <20180507094459.GA3412@sigill.intra.peff.net>
 <20180507230650.GH953644@genre.crustytoothpaste.net>
 <20180508132814.GA24975@sigill.intra.peff.net>
 <20180508230922.GB275488@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508230922.GB275488@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 08, 2018 at 11:09:22PM +0000, brian m. carlson wrote:

> On Tue, May 08, 2018 at 09:28:14AM -0400, Jeff King wrote:
> > OK, so my question then is: what does just-gpgsm support look like?
> > 
> > Do we literally add gpgsm.program? My thought was that taking us the
> > first step towards a more generic config scheme would prevent us having
> > to backtrack later.
> 
> I think the signingtool prefix is fine, or something similar.  My "just
> gpgsm" proposal is literally just "check for PGP header" and "check for
> CMS header" in parse_signature and dispatch appropriately.

Hmm. I suppose that would work. I just didn't want to go the route of
adding more hard-coded magic that the user couldn't override (or
anything that is more complex than what the user could specify for their
own tool if they wanted to).  But I suppose there's probably not a big
need to override the GPG or CMS matching in practice.

> > There are also more CMS signers than gpgsm (and I know Ben is working on
> > a tool). So it feels a little ugly to make it "gpgsm.program", since it
> > really is a more generic format.
> 
> Okay, so signingtool.cms.program?  signingtool.smime.program?
> 
> I suppose Ben still intends to use the same command-line interface as
> for gpgsm.

AFAIK, yes.

> > Or would you be happy if we just turned the matcher into a whole-line
> > substring or regex match?
> 
> A first line regex would probably be fine, if you want to go that way.
> That, I think, is generic enough that we can make use of it down the
> line, since it distinguishes all known formats, TTBOMK.

That seems like a happy medium to me. I worried at first that a regex
might be noticeably expensive, but probably not. During "git log" we
only feed "gpgsig" headers from each commit to the signature parsing
code (so it's few lines, and no cost when you aren't using signatures).
For tags we have to scan the whole tag body, but per-tag performance is
much less important there, because you're not typically traversing
hundreds of thousands of them.

> It would be nice if we could still continue to use gpg without having to
> add specific configuration for it, at least for compatibility reasons.

Definitely. Maintaining compatibility with the existing out-of-the-box
behavior and with the existing config options is non-negotiable (and is
already the case with the existing patch under discussion).

-Peff
