Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E4A20986
	for <e@80x24.org>; Sun, 23 Oct 2016 01:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756203AbcJWBiu (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 21:38:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:33048 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756170AbcJWBiu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 21:38:50 -0400
Received: (qmail 16142 invoked by uid 109); 23 Oct 2016 01:38:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 01:38:49 +0000
Received: (qmail 14762 invoked by uid 111); 23 Oct 2016 01:39:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Oct 2016 21:39:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2016 21:38:47 -0400
Date:   Sat, 22 Oct 2016 21:38:47 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Lukas Fleischer <lfleischer@lfos.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
Message-ID: <20161023013846.ct3olfabw2yhzio2@sigill.intra.peff.net>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
 <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net>
 <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
 <147712794056.12237.1478296296628149440@typhoon.fritz.box>
 <CACsJy8Bz-DhE+CkJH+3zsrZJUQfGYDN072MKawJ6dx5begfnMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Bz-DhE+CkJH+3zsrZJUQfGYDN072MKawJ6dx5begfnMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 08:23:01AM +0700, Duy Nguyen wrote:

> I hit the same problem sometimes, but in my case sometimes I
> accidentally do "git add" after "git add -p" and a configuration in
> "git commit -a" won't help me. I'd prefer we could undo changes in
> index instead. Something like reflog but for index.

An index write always writes the whole file from scratch, so you really
just need to save a copy of the old file. Perhaps something like:

  rm -f $GIT_DIR/index.old
  ln $GIT_DIR/index.old $GIT_DIR/index
  ... and then open $GIT_DIR/index.tmp ...
  ... and then rename(index.tmp, index) ...

could do it cheaply. It's a little more complicated if you want to save
a sequence of versions, and eventually would take a lot of space, but
presumably a handful of saved indexes would be sufficient.

Another option would be an index format that journals, and you could
potentially walk back the journal to a point. That seems like a much
bigger change (and has weird layering, because deciding when to fold in
the journal is usually a performance thing, but obviously this would
have user-visible impact about how far back you could undo).

-Peff
