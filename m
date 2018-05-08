Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2CA200B9
	for <e@80x24.org>; Tue,  8 May 2018 13:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeEHN2T (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 09:28:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:60308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932168AbeEHN2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 09:28:16 -0400
Received: (qmail 356 invoked by uid 109); 8 May 2018 13:28:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 13:28:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4316 invoked by uid 111); 8 May 2018 13:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 09:28:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 09:28:14 -0400
Date:   Tue, 8 May 2018 09:28:14 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Message-ID: <20180508132814.GA24975@sigill.intra.peff.net>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net>
 <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
 <20180417001212.GC14631@genre.crustytoothpaste.net>
 <20180507094459.GA3412@sigill.intra.peff.net>
 <20180507230650.GH953644@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180507230650.GH953644@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 07, 2018 at 11:06:50PM +0000, brian m. carlson wrote:

> I think my main objection to this series is that it is generic in a way
> that isn't necessarily useful.  We know there are essentially only two
> formats of PEM-style signatures: OpenPGP and CMS[0].  Even if there are
> more, they aren't intrinsically useful, because our codebase can only
> handle GnuPG-style tools, and those are the only formats GnuPG-style
> tools really support (although, as you point out, other tools could
> mimic the interface).
> 
> I think if we aren't going to implement some sort of interface that's
> generically useful for all signing tools, it would be better to simply
> say that we support gpg and gpgsm and have signingtool.gpg.program and
> signingtool.gpgsm.program and hard-code the logic for those two formats.
> That way we don't have a generic interface that's really only useful for
> PEM-style tools, when we know it likely won't be useful for other tools
> as well.  We can add a more generic interface when we have more varied
> tools to support and we know more about what the requirements will be.

OK, so my question then is: what does just-gpgsm support look like?

Do we literally add gpgsm.program? My thought was that taking us the
first step towards a more generic config scheme would prevent us having
to backtrack later.

There are also more CMS signers than gpgsm (and I know Ben is working on
a tool). So it feels a little ugly to make it "gpgsm.program", since it
really is a more generic format.

Or would you be happy if we just turned the matcher into a whole-line
substring or regex match?

> This doesn't address Junio's concern about whether adding CMS support is
> the right direction to go.  I personally think OpenPGP is the right
> direction for most open-source projects, but I know some companies want
> to use CMS internally and I'm not intrinsically opposed to that[1].
> That decision is ultimately up to Junio, though.

My guess is that fragmentation isn't likely to be much of a problem in
practice, because the tool choice generally falls along
culture/community boundaries. I'd expect that open source projects are
never going to choose CMS, because the centralized cert management is
awful. But it's exactly what many closed-source enterprises want, and
they will literally choose "no signing" over wrestling with PGP.

I'd be much more worried about the open source world splitting into
"signify" and "gpg" camps or similar. OTOH, I just don't see it as all
that big a deal. It's a project decision, and it may even allow for some
healthy competition between standards.

-Peff
