Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F80920954
	for <e@80x24.org>; Wed,  6 Dec 2017 08:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbdLFIsg (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 03:48:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:49688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753998AbdLFIsg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 03:48:36 -0500
Received: (qmail 9037 invoked by uid 109); 6 Dec 2017 08:48:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Dec 2017 08:48:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9804 invoked by uid 111); 6 Dec 2017 08:48:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 06 Dec 2017 03:48:56 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Dec 2017 03:48:33 -0500
Date:   Wed, 6 Dec 2017 03:48:33 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: Documentation Breakage at 2.5.6
Message-ID: <20171206084833.GA9501@sigill.intra.peff.net>
References: <008d01d36e48$747cc130$5d764390$@nexbridge.com>
 <877eu0uvb2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eu0uvb2.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 06, 2017 at 09:14:57AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I'm trying to upgrade the NonStop port from 2.3.7 upward eventually to
> > 2.15.1 and hit a snag on documentation. The xmlto component is a bit new to
> > me and I hit the following error:

Did it work before in v2.3.7? If so, can you bisect to the breakage?

> >     XMLTO git-remote-testgit.1
> > xmlto: /home/git/git/Documentation/git-remote-testgit.xml does not validate
> > (status 3)
> > xmlto: Fix document syntax or use --skip-validation option
> > I/O error : Attempt to load network entity
> > http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
> > /home/git/git/Documentation/git-remote-testgit.xml:2: warning: failed to
> > load external entity
> > "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> > D DocBook XML V4.5//EN"
> > "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> >
> > ^
> > I/O error : Attempt to load network entity
> > http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
> > warning: failed to load external entity
> > "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> > validity error : Could not load the external subset
> > http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd

Those URLs are the "official" names of the docbook DTDs. But normally
you'd have a local copy, along with a mapping from the official name to
your local copy. The XML term for that mapping is a "catalog", and it
looks something like this:

  $ grep oasis-open /etc/xml/catalog
  <delegateSystem systemIdStartString="http://www.oasis-open.org/docbook/xml/" catalog="file:///etc/xml/docbook-xml.xml"/>

That just points to another local catalog, which has:

  $ grep 4.5/docbookx.dtd /etc/xml/docbook-xml.xml
  <delegateSystem systemIdStartString="http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" catalog="file:///usr/share/xml/docbook/schema/dtd/4.5/catalog.xml"/>
  <delegateSystem systemIdStartString="http://docbook.org/xml/4.5/docbookx.dtd" catalog="file:///usr/share/xml/docbook/schema/dtd/4.5/catalog.xml"/>

So my guess is that your problem is one of:

  1. You don't have docbook 4.5 installed on your system.

or

  2. You don't have a correctly built catalog file, or xmlto isn't
     pointing to it for some reason (on Debian, this is normally built
     by the post-install script of packages that contain xml).

And xmlto (actually, probably xsltproc that it's calling) is unwilling
or unable to hit the network to pull down those entities.

Those are all somewhat vague guesses based on past troubles I've had
with broken xml setups. I'm far from an expert on xml processing (and
I'd just as soon keep it that way).

> I don't know if this helps, but here with xmlto 0.0.28 on Debian if I
> apply this the docs still build:
> 
>     diff --git a/Documentation/texi.xsl b/Documentation/texi.xsl
>     index 0f8ff07eca..332a65558d 100644
>     --- a/Documentation/texi.xsl
>     +++ b/Documentation/texi.xsl
>     @@ -7,7 +7,7 @@
>      <xsl:output method="xml"
>                 encoding="UTF-8"
>                 doctype-public="-//OASIS//DTD DocBook XML V4.5//EN"
>     -           doctype-system="http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" />
>     +           doctype-system="http://example.org/docbook/xml/4.5/docbookx.dtd" />
> 
> So whatever's needing to remote fetch those resources doesn't seem to
> cause the same error for me.

I think that would come into play only if you try to build
"gitman.info", which isn't one of the default targets.

The string that Randall is seeing is in git-remote-testgit.xml, so it's
probably be generated by the "docbook" backend of asciidoc.

One alternative is to try to avoid docbook entirely. The only way to get
manpages with asciidoc is to generate docbook and then process it, but:

 - you can generate HTML directly (and "make -C Documentation html" does
   this). Perhaps not as nice, but you still at least have some
   documentation.

 - asciidoctor can generate manpages directly. I don't think our
   Makefile supports that now, but it might not be too hard to hack in
   (we already have some basic asciidoctor support). I'm not sure how
   hard it would be to get Ruby running on NonStop

And of course one final option is to generate the manpages elsewhere and
copy them in, since they're platform-independent. In fact, that's what
quick-install-man should do (you just have to clone Junio's git-manpages
repository -- see the INSTALL file).

-Peff
