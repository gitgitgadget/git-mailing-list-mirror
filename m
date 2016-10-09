Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94FF51F4F8
	for <e@80x24.org>; Sun,  9 Oct 2016 06:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754623AbcJIGId (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 02:08:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:54565 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbcJIGId (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 02:08:33 -0400
Received: (qmail 7143 invoked by uid 109); 9 Oct 2016 06:01:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Oct 2016 06:01:52 +0000
Received: (qmail 20097 invoked by uid 111); 9 Oct 2016 06:02:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Oct 2016 02:02:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Oct 2016 02:01:49 -0400
Date:   Sun, 9 Oct 2016 02:01:49 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Message-ID: <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
 <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610081034430.35196@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610081034430.35196@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 08, 2016 at 10:36:13AM +0200, Johannes Schindelin wrote:

> > > Maybe it's time to aim for
> > > 
> > >   git config alias.d2u.shell \
> > >        'f() { git ls-files "$@" | xargs dos2unix; }; f'
> > >   git config alias.d2u.cdup false
> > >   git d2u *.c   # yada!
> > 
> > That would be nice. It would also allow "alias.foo_bar.shell"; right now
> > "alias.foo_bar" is forbidden because of the config syntax, which does
> > not allow underscores outside of the "subsection" name.
> 
> So what about this?
> 
> 	[alias]
> 		d2u = !dos2unix
> 	[alias "d2u"]
> 		shell = 'f() { git ls-files "$@" | xargs dos2unix; }; f'
> 		exec = C:/cygwin64/bin/dos2unix.exe
> 
> You introduce all kinds of ambiguities here that did not exist before...

If you mean ambiguity between the old "alias.X" and the new "alias.X.*",
then yes, I think that's an unavoidable part of the transition.  IMHO,
the new should take precedence over the old, and people will gradually
move from one to the other.

If you mean the ambiguity between alias.X.shell and alias.X.exec in your
example, the problem is that you have keys with overlapping meanings.
One solution is "don't do that" (so have a key like "cmd", and another
to select "shell or git-cmd", etc). Another is to define some rule, like
"last one wins" (so "exec" overrides "shell" in your example).

I'd prefer the "don't do that" path. The config you showed is
nonsensical, and it doesn't really matter that much how we behave. But
it is better still if we have a config scheme that makes it hard to
write nonsensical things in the first place.

-Peff
