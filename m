Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4171F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeCUHuq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 03:50:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:37166 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751670AbeCUHun (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 03:50:43 -0400
Received: (qmail 2213 invoked by uid 109); 21 Mar 2018 07:50:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 07:50:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7995 invoked by uid 111); 21 Mar 2018 07:51:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 03:51:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 03:50:41 -0400
Date:   Wed, 21 Mar 2018 03:50:41 -0400
From:   Jeff King <peff@peff.net>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation
 bug)
Message-ID: <20180321075041.GA24701@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net>
 <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net>
 <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
 <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
 <20180321065212.GC16784@sigill.intra.peff.net>
 <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 03:36:09AM -0400, Dakota Hawkins wrote:

> > I think that ignoring all of /ignore-most/ is much more efficient, since
> > we don't have to enumerate the paths inside it at all (which is why the
> > current behavior works as it does).
> 
> That's definitely true, but I wonder what the impact would be for most
> cases (even for most cases with large repos and larges sets of ignore
> files).

Probably not that much CPU, but it used to be quite annoying to fault in
the dcache for an infrequently used hierarchy. These days I generally
have an SSD and lots of memory for disk caching, so I don't know if it
would still be.

On systems where readdir/stat are slower than Linux it might be
noticeable for a big hierarchy.

> At any rate, would it at least be a good idea to make the "trailing
> slash halts recursion, won't consider nested .gitignore files"
> explicit in the `.gitignore` doc? Unless I'm missing it, I don't think
> that behavior is called out (or at least not called out concisely/in
> one place). It looks like this is all there is:

Yeah, it's definitely come up multiple times over the years. I don't
know what all is in gitignore(5), but if it's not mentioned it probably
should be.

>     "If the pattern ends with a slash, it is removed for the purpose
> of the following description, but it would only find a match with a
> directory. In other words, foo/ will match a directory foo and paths
> underneath it, but will not match a regular file or a symbolic link
> foo (this is consistent with the way how pathspec works in general in
> Git)."
> 
> Also, I'm not sure what the "following description" is in "it is
> removed for the purpose of the following description". Is that trying
> to imply "excluded from the rest of the doc"?

I think it means "for the rest of the description of how the patterns
work". I.e., "foo/" matches as "foo" when the rest of the matching rules
are applied. I agree it's a bit awkward. Patches welcome. :)

-Peff
