Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A516207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 20:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbcJIU7A (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 16:59:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:54729 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbcJIU67 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 16:58:59 -0400
Received: (qmail 27538 invoked by uid 109); 9 Oct 2016 20:58:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Oct 2016 20:58:56 +0000
Received: (qmail 24893 invoked by uid 111); 9 Oct 2016 20:59:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Oct 2016 16:59:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Oct 2016 16:58:54 -0400
Date:   Sun, 9 Oct 2016 16:58:54 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Message-ID: <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
 <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610081034430.35196@virtualbox>
 <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
 <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 09, 2016 at 06:32:38PM +0700, Duy Nguyen wrote:

> > If you mean ambiguity between the old "alias.X" and the new "alias.X.*",
> > then yes, I think that's an unavoidable part of the transition.  IMHO,
> > the new should take precedence over the old, and people will gradually
> > move from one to the other.
> 
> Do we really need to treat this differently than
> 
> [alias]
>     d2u = !dos2unix
>     d2u = C:/cygwin/bin/dos3unix.exe
> 
> ?
> 
> Another similar case is one d2u (could be either old syntax or new) is
> defined in ~/.gitconfig and the other d2u in $GIT_DIR/config. In
> either case, the "latest" d2u definition wins.

Yeah, that's reasonable, too. So:

  [alias]
    d2u = "!dos2unix"

acts exactly as if:

  [alias "d2u"]
    command = dos2unix
    type = shell

was specified at that point, which is easy to understand.

> > If you mean the ambiguity between alias.X.shell and alias.X.exec in your
> > example, the problem is that you have keys with overlapping meanings.
> > One solution is "don't do that" (so have a key like "cmd", and another
> > to select "shell or git-cmd", etc). Another is to define some rule, like
> > "last one wins" (so "exec" overrides "shell" in your example).
> [...]
> 
> Any suggestion? I suppose we can have _one_ key for the command. How
> to execute that command (exec, shell, nocd...) are boolean options.
> People can still write conflicting things. We have been nice so far,
> always dying when the user specify conflicting command line options.
> We could do the same here, I guess.

Having separate exec/shell boolean options just punts the overlap from
the command key to those keys. If you have two mutually exclusive
options, I think the best thing is a single option, like:

  type = <shell | exec | whatever>

and then it is obvious that a second appearance of "type" overrides an
earlier one, by our usual "last one wins" convention. As opposed to:

  shell = true
  exec = true

where you have to understand the meaning of each option to know that
"exec" overrides "shell".

-Peff
