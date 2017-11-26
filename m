Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2DB620A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdKZTPN (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:15:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:40544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751427AbdKZTPM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:15:12 -0500
Received: (qmail 32262 invoked by uid 109); 26 Nov 2017 19:15:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 26 Nov 2017 19:15:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29413 invoked by uid 111); 26 Nov 2017 19:15:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 26 Nov 2017 14:15:30 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Nov 2017 14:15:10 -0500
Date:   Sun, 26 Nov 2017 14:15:10 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
Message-ID: <20171126191510.GA1501@sigill>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
 <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 12:58:17AM +0100, Christian Couder wrote:

> > Can you say more about where this comes up?
> 
> The original discussion is:
> 
> https://public-inbox.org/git/b6b12040-100f-5965-6dfd-344c84dddf96@teddy.ch/
> 
> and here are discussions related to version 1 of this patch:
> 
> https://public-inbox.org/git/20171115125200.17006-1-chriscool@tuxfamily.org/
> 
> As Peff mentions in the original discussion, at the Bloomberg Git
> sprint, we saw someone struggling to compile Git, because of these
> msgfmt and Tcl/Tk issues.

Actually, I think we had the _opposite_ problem there.

The main problem your patch fixes is that we may silently build a
version of gitk/git-gui that do not work. The "make" process completes,
but they refer to a non-existent "wish" tool, and running them will
fail.

That's potentially annoying if you wanted those tools. But if you didn't
care about them in the first place, it's fine.

The opposite problem is when you don't care about those tools, and they
_do_ break the build. And then just to get the rest of Git built, you
have to know about and set NO_TCLTK.

AFAIK that only happens if you don't have msgfmt installed. Because then
the gitk and git-gui Makefiles try to auto-fallback to implementing
msgfmt in tcl _during the build_, and there a lack of "tclsh" will break
the build.

I think your patch does say "consider setting NO_TCLTK" in that case,
which is an improvement. But it might be nicer still if it Just Worked
(either because we don't do tcl/tk by default, or because we respect
NO_GETTEXT in the gitk/git-gui Makefiles, or because our msgfmt can
fallback further to not even using tclsh).

So I'm not really against this patch, but IMHO it doesn't make the
interesting case (you don't care about tcl and are just trying to build
git for the first time) all that much better. I do also wonder if we
want to start putting these kind of run-time checks into the Makefile
itself. That's kind of what autoconf is for. As much as I hate autoconf,
is it the right advice for somebody who doesn't want to look at the
Makefile knobs to do:

  autoconf
  ./configure
  make

?

If there are deficiencies in configure.in (and I can well believe that
there are), should we be fixing it there?

-Peff
