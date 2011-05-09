From: Jeff King <peff@peff.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 04:12:19 -0400
Message-ID: <20110509081219.GB6205@sigill.intra.peff.net>
References: <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
 <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
 <20110506065601.GB13351@elie>
 <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
 <20110506172334.GB16576@sigill.intra.peff.net>
 <BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
 <20110509073535.GA5657@sigill.intra.peff.net>
 <BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 10:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLZt-0008I1-N7
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 10:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab1EIIMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 04:12:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45287
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab1EIIMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 04:12:22 -0400
Received: (qmail 6099 invoked by uid 107); 9 May 2011 08:14:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 04:14:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 04:12:19 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173206>

On Mon, May 09, 2011 at 05:49:27PM +1000, Jon Seymour wrote:

> Yep, that was part of the motivation for the suggestion - something
> that works consistently, assuming only a working git installation.
> 
> Per one of my other notes, my initial inclination is to provide a
> patch that implements support for
> 
>      git --system-extensions-dir
> 
> which would:
>    - provide the caller with location that extensions could be
> installed in (assuming the caller can acquire write privileges)
>    - provide a guarantee that $(git --system-extensions-dir)/bin will
> be on the path set up by the git wrapper and $(git
> --system-extensions-dir)/man will be in the MANPATH searched by git
> help
> 
> Extensions could then use this information, together with git
> --html-path to install themselves into these places using whatever
> mechanism seems appropriate (either a POSIX shell script or a
> make/install script).

But is the system extension dir always the right place to do so? If I'm
not root, then that probably won't be writable (or even if I am, I may
want to install the extension only for the root user).

If your proposal is for the user to decide on one of:

  unzip -d "$(git --system-extension-dir)" git-foo.zip

or

  unzip -d "$HOME/.gitplugins" git-foo.zip

then they can make that decision. But if you're proposing that the
extension-writer distribute a script, then it's more complicated. They
would probably need to provide a "--user" versus "--system" option.

It would also be tempting to write something like:

  install_dir() {
    if test "`id -u`" = "0"; then
      git --system-extension-dir
    else
      echo $HOME/.gitplugins
    fi
  }

but that is:

  1. Not portable.

  2. Does not allow for user-only installation by root.

But all of this is a packaging best-practices issue, not an issue of
what git needs to do to support it (you _could_ address the portability
issue by having "git --preferred-extension-path" that did the
appropriate platform-specific UID check, but that still doesn't address
the second point).

-Peff
