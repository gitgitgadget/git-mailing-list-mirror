Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9501F463
	for <e@80x24.org>; Tue, 10 Sep 2019 18:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfIJSoY (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 14:44:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:45736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726449AbfIJSoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 14:44:24 -0400
Received: (qmail 1917 invoked by uid 109); 10 Sep 2019 18:44:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Sep 2019 18:44:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18450 invoked by uid 111); 10 Sep 2019 18:46:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2019 14:46:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Sep 2019 14:44:22 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
Message-ID: <20190910184422.GA17446@sigill.intra.peff.net>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907170746.273984-1-sandals@crustytoothpaste.net>
 <20190908104833.GE15641@sigill.intra.peff.net>
 <20190908171807.GL11334@genre.crustytoothpaste.net>
 <20190908212122.GA8514@sigill.intra.peff.net>
 <20190908222423.GN11334@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190908222423.GN11334@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 08, 2019 at 10:24:24PM +0000, brian m. carlson wrote:

> Trying again, I'm able to reproduce this.  I found the cause, which is
> in the stylesheets.  XSLT stylesheets have the ability to specify
> elements from which whitespace should be stripped (using the
> xsl:strip-space directive).  In the DocBook stylesheets, listitem is
> specified as such an element, so the whitespace there should be
> stripped.
> 
> However, in DocBook 5, our elements are in a namespace.  Therefore, the
> unnamespaced stylesheets specify only "listitem", not "d:listitem", like
> the namespaced stylesheets do.  Because this happens right after the
> tree has been constructed "but before it is otherwise processed by XSLT"
> and isn't affected by the EXSLT extension that allows re-parsing the
> modified tree, then we end up with the whitespace that we don't want.

First off, thank you again for your explanations. I dread digging into
how anything related to docbook or xml works, so having you serve it up
on a silver platter is a delight. :)

> 2. We can force xmlto to use a custom stylesheet with "-x" that merely
> imports the DocBook 5 stylesheets using a URL.  If the user has the
> DocBook 5 stylesheets installed and XML catalogs configured (the default
> on Linux distributions), then everything will just work and the system
> will resolve it to the local copy.  If, however, things are not properly
> configured, this will result in multiple network downloads for each
> manual page.

Isn't this already the case just with the docbook DTDs? I.e., if you
don't have a catalog entry, it is up to the tool (xmlto in this case) to
either fail or try to fetch it. That seems like the best we can do. And
as you note, this typically just works out of the box on modern
installs. Of course people may want to build on non-modern ones, but
IMHO we should probably be more aggressive about dropping legacy support
in the documentation and pointing people to the pre-formatted pages.

> My personal preference is #2; I think that seems like the best choice
> forward.  XML catalogs are well understood and well configured on Linux
> distributions.  Homebrew supports them adequately, but you have to add
> an environment variable to your shell configuration to enable them.  Of
> course, if you're doing _anything_ with XML, you'll have them enabled.

Yeah, agreed.

-Peff
