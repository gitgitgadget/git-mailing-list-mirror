Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE06120248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfDESLe (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:11:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESLe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:11:34 -0400
Received: (qmail 11259 invoked by uid 109); 5 Apr 2019 18:11:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:11:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28292 invoked by uid 111); 5 Apr 2019 18:12:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:12:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:11:32 -0400
Date:   Fri, 5 Apr 2019 14:11:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/12] http: simplify parsing of remote objects/info/packs
Message-ID: <20190405181132.GA32401@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232704.GE21839@sigill.intra.peff.net>
 <83129937-dcd0-f16e-c8aa-97eceec9769a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83129937-dcd0-f16e-c8aa-97eceec9769a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 12:41:27PM +0200, René Scharfe wrote:

> Am 05.04.2019 um 01:27 schrieb Jeff King:
> > We can use skip_prefix() and parse_oid_hex() to continuously increment
> > our pointer, rather than dealing with magic numbers. This also fixes a
> > few small shortcomings:
> >
> >   - if we see a 'P' line that does not match our expectations, we'll
> >     leave our "i" counter in the middle of the line. So we'll parse:
> >     "P P P pack-1234.pack" as if there was just one "P" which was not
> >     intentional (though probably not that harmful).
> 
> How so?  The default case, which we'd fall through to, skips the rest
> of such a line, doesn't it?

Oh, you're right. I didn't notice the fall-through, which is quite
subtle (I'm actually surprised -Wimplicit-fallthrough doesn't complain
about this).

I'll fix up the commit message (the cleanup is still very much worth it
for the garbage-oid issue, IMHO).

> > +	while (*data) {
> > +		if (skip_prefix(data, "P pack-", &data) &&
> > +		    !parse_oid_hex(data, &oid, &data) &&
> > +		    skip_prefix(data, ".pack", &data) &&
> > +		    (*data == '\n' || *data == '\0')) {
> > +			fetch_and_setup_pack_index(packs_head, oid.hash, base_url);
> > +		} else {
> > +			data = strchrnul(data, '\n');
> >  		}
> > -		i++;
> > +		if (*data)
> > +			data++; /* skip past newline */
> 
> So much simpler, *and* converted to object_id -- I like it!
> 
> Parsing "P" and "pack-" together crosses logical token boundaries,
> but that I don't mind it here.

Yeah, I was tempted to write:

  if (skip_prefix(data, "P ", &data) &&
      skip_prefix(data, "pack-", &data) &&
      ...

but that felt a little silly. I dunno. I guess it is probably not any
less efficient, because we'd expect skip_prefix() and its loop to get
inlined here anyway.

-Peff
