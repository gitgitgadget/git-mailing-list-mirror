Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB891F516
	for <e@80x24.org>; Mon,  2 Jul 2018 18:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeGBSRp (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 14:17:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:56524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753130AbeGBSRo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 14:17:44 -0400
Received: (qmail 30719 invoked by uid 109); 2 Jul 2018 18:17:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 18:17:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23454 invoked by uid 111); 2 Jul 2018 18:17:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 14:17:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 14:17:42 -0400
Date:   Mon, 2 Jul 2018 14:17:42 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
Message-ID: <20180702181742.GA12208@sigill.intra.peff.net>
References: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
 <20180628024446.GD644867@genre.crustytoothpaste.net>
 <20180628143405.GA16657@sigill.intra.peff.net>
 <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
 <20180628172707.GA31766@sigill.intra.peff.net>
 <20180701175657.GC7965@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180701175657.GC7965@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 01, 2018 at 05:56:58PM +0000, brian m. carlson wrote:

> On Thu, Jun 28, 2018 at 01:27:07PM -0400, Jeff King wrote:
> > Yeah, that was along the lines that I was thinking. I wonder if anybody
> > would ever need two such auto-encodings, though. Probably not. But
> > another way to think about it would be to allow something like:
> > 
> >   working-tree-encoding=foo
> > 
> > and then in your config "foo" to map to some encoding.
> > 
> > But that may be over-engineering, I dunno. utf8 has always been enough
> > for me. :)
> 
> I had a thought the other day about why this solution might be valuable.
> Different platforms encode different values for iconv character sets.
> So, for example, one may have platforms supporting some disjoint sets of
> the following:
> 
> * LATIN-1
> * LATIN1
> * ISO8859-1
> * ISO-8859-1
> * ISO_8859-1
> * ISO_8859-1:1987
> * some lowercase variants of these
> 
> Therefore, specifying a working-tree-encoding value that works across a
> wide variety of system may be non-trivial.  This is less of a problem
> with UTF-8, but having the ability to pick an encoding and remap it to a
> supported value may be useful nevertheless.

One thing I almost did in the example I gave above was to literally call
the encoding name by a "real" one. I.e.:

  echo '*.txt working-tree-encoding=iso-8859-1' >.gitattributes
  git config encoding.iso-8859-1.replace latin1

or something. But I wondered if it was a little crazy as a practice,
since mapping "iso-8859-1" to "utf-8" is probably going to lead to
headaches.

But your example above of semantically equivalent variants with
different spellings would be a good use of that trick.

It also makes me wonder if there's another layer of indirection
somewhere in the iconv machinery we could be taking advantage of to
accomplish the same thing.  Probably not conveniently or portably, I
guess.

-Peff
