Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90B91F404
	for <e@80x24.org>; Mon, 26 Feb 2018 20:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeBZUqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 15:46:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:37712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752065AbeBZUqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 15:46:37 -0500
Received: (qmail 29543 invoked by uid 109); 26 Feb 2018 20:46:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Feb 2018 20:46:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16248 invoked by uid 111); 26 Feb 2018 20:47:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Feb 2018 15:47:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Feb 2018 15:46:35 -0500
Date:   Mon, 26 Feb 2018 15:46:35 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180226204635.GB12598@sigill.intra.peff.net>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
 <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
 <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
 <20180216165815.GA4681@tor.lan>
 <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
 <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
 <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net>
 <20180226173533.GA7877@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226173533.GA7877@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 06:35:33PM +0100, Torsten Bögershausen wrote:

> > diff --git a/userdiff.c b/userdiff.c
> > index dbfb4e13cd..48fa7e8bdd 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -161,6 +161,7 @@ IPATTERN("css",
> >  	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
> >  	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
> >  ),
> > +{ "utf16", NULL, -1, { NULL, 0 }, NULL, "iconv:utf16" },
> >  { "default", NULL, -1, { NULL, 0 } },
> >  };
> >  #undef PATTERNS
> 
> The patch looks like a possible step into the right direction -
> some minor notes: "utf8" is better written as "UTF-8", when talking
> to iconv.h, same for utf16.
> 
> But, how do I activate the diff ?
> I have in .gitattributes
> XXXenglish.txt diff=UTF-16
> 
> and in .git/config
> [diff "UTF-16"]
>       command = iconv:UTF-16
> 
> 
> What am I doing wrong ?

After applying the patch, if I do:

  git init
  echo hello | iconv -f utf8 -t utf16 >file
  git add file
  git commit -m one
  echo goodbye | iconv -f utf8 -t utf16 >file
  git add file
  git commit -m two

then:

  git log -p

shows "binary files differ" but:

  echo "file diff=utf16" >.gitattributes
  git log -p

shows text diffs. I assume you tweaked the patch before switching to
the UTF-16 spelling in your example. Did you use a plumbing command to
show the diff? textconv isn't enabled for plumbing, because the
resulting patches cannot actually be applied (in that sense an encoding
switch is potentially special, since in theory one could convert to the
canonical text format, apply the patch, and then convert back).

-Peff
