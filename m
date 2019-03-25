Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3427B20248
	for <e@80x24.org>; Mon, 25 Mar 2019 15:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCYPGg (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 11:06:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:35084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726185AbfCYPGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 11:06:35 -0400
Received: (qmail 520 invoked by uid 109); 25 Mar 2019 15:06:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Mar 2019 15:06:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8432 invoked by uid 111); 25 Mar 2019 15:06:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Mar 2019 11:06:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2019 11:06:33 -0400
Date:   Mon, 25 Mar 2019 11:06:33 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190325150633.GC19929@sigill.intra.peff.net>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190324162131.GL4047@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 12:21:31PM -0400, Todd Zullinger wrote:

> > I ran into that, too. Using ASCIIDOC_DOCBOOK=docbook5 worked. The output
> > looked OK to me, but I only eyeballed it briefly. It's possible there
> > are subtle problems.
> 
> Interesting.  I did that last night as well, but it only led
> to more errors.  I'm curious why manpage builds work for you
> and not for me.

I think it's because I'm an idiot. I must have only been using 2.0.0
when I was looking at the XML output manually (for the refmiscinfo
lines), and never actually rendered it to roff. I get the same problem
when I try a full build.

> On my fedora 29 test system, ASCIIDOC_DOCBOOK=docbook5 leads
> to a validation failure from xmlto, since docbook5 doesn't
> use a DTD¹.  I added XMLTO_EXTRA = --skip-validation to the
> USE_ASCIIDOCTOR block, which can build many of the man
> pages, but fails when it gets to git-blame due to use of
> literal < > characters in the xml:
> 
>     git-blame.xml:423: parser error : StartTag: invalid element name
>     <literallayout class="monospaced"><40-byte hex sha1> <sourceline> <resultline> <
>                                        ^

That seems like a bug in asciidoctor, which ought to be quoting the "<".
We certainly can't quote it ourselves (we don't even know that our
backend output is going to a format that needs angle brackets quoted).

-Peff
