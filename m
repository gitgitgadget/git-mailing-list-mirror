Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710E51FD09
	for <e@80x24.org>; Sun, 28 May 2017 19:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdE1T0f (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 15:26:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:59086 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbdE1T0e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 15:26:34 -0400
Received: (qmail 17663 invoked by uid 109); 28 May 2017 19:26:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 28 May 2017 19:26:34 +0000
Received: (qmail 10978 invoked by uid 111); 28 May 2017 19:27:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 28 May 2017 15:27:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 May 2017 15:26:32 -0400
Date:   Sun, 28 May 2017 15:26:32 -0400
From:   Jeff King <peff@peff.net>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
Message-ID: <20170528192632.3iei3hxfggqkfrfh@sigill.intra.peff.net>
References: <20170528165642.14699-1-joel@teichroeb.net>
 <20170528165642.14699-5-joel@teichroeb.net>
 <CACBZZX5cxkV4C42OwJ077b1XMHCk+uTCbdHV9Ez5EVStR4DWxg@mail.gmail.com>
 <CA+CzEk8Xx4nh=Bh533DR=Xo_BjQsxAoYNbx3=O=rtWr8+v4xsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+CzEk8Xx4nh=Bh533DR=Xo_BjQsxAoYNbx3=O=rtWr8+v4xsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 11:31:48AM -0700, Joel Teichroeb wrote:

> >> +       /* TODO: Improve this logic */
> >> +       strbuf_addf(&symbolic, "%s", REV);
> >> +       str = strstr(symbolic.buf, "@");
> >
> > Could you elaborate on how this should be improved?
> 
> I just figured there would be a builtin function that could help here,
> but hadn't had the chance to look into it. It's something easy to do
> in bash, but more complicated in C.

There's no strbuf function for "truncate at this character". But:

  - you can use strchr for a single-character match, which is more
    efficient; i.e.:

      str = strchr(symbolic.buf, '@');

  - instead of inserting a '\0' into the strbuf, use strbuf_setlen(),
    which also updates the symbolic.len; i.e.:

      strbuf_setlen(&symbolic, str - symbolic.buf);

  - it looks like you copy into the strbuf just to truncate, so you
    could actually get the final size before inserting into the strbuf
    using strchrnul. Like:

      end_of_rev = strchrnul(REV, '@');
      strbuf_add(&symbolic, REV, end_of_rev - REV);

-Peff
