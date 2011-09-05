From: Jeff King <peff@peff.net>
Subject: Re: git 'new' alias
Date: Mon, 5 Sep 2011 16:41:18 -0400
Message-ID: <20110905204118.GA4221@sigill.intra.peff.net>
References: <CACnwZYfo2E0SFfFrYzUktAZYwqgyX_J4KgFQD5kqXToGmip3Lg@mail.gmail.com>
 <vpqei00m4pf.fsf@bauges.imag.fr>
 <20110901211747.GA16308@sigill.intra.peff.net>
 <vpqipp77xpb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 05 22:41:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0fz0-0008Pe-3X
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 22:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab1IEUlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 16:41:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38768
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab1IEUlW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 16:41:22 -0400
Received: (qmail 20569 invoked by uid 107); 5 Sep 2011 20:42:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Sep 2011 16:42:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2011 16:41:18 -0400
Content-Disposition: inline
In-Reply-To: <vpqipp77xpb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180759>

On Mon, Sep 05, 2011 at 06:36:48PM +0200, Matthieu Moy wrote:

> >   $ git config alias.one
> >   !f() { r=$1; shift; echo $r@{1}..$r@{0} "$@"; }; f
> 
> (which, I've just discovered, should be written as
> 
> [alias]
>         one = "!f() { r=$1; shift; echo $r@{1}..$r@{0} "$@"; }; f"
> 
> otherwise "git config" messes up with the ; in the line)

Yes, it definitely needs quotes. However, you also need to
backslash-escape the quotes inside, or you get:

  $ git config alias.one
  !f() { r=$1; shift; echo $r@{1}..$r@{0} $@; }; f

which will accidentally split any arguments with whitespace.

> I now have this, which is really ugly in a config file, but does the
> DWIMery I want:
> 
> 	new = "!f () { if echo \"$1\" | grep -q -e '^-' -e '^$'; then r=; else r=$1; shift; fi; git log $r@{1}..$r@{0} \"$@\"; } && f"

Instead of piping into grep, I would do:

  case "$1" in
    ""|-*) ;;
    *) r=$1; shift ;;
  esac

which saves a process (and is IMHO a little more obvious).

As far as getting ugly for a config file, I would note that:

  1. You can always drop a git-new script in your PATH. :)

  2. You can backslash-escape literal newlines in config entries. It's
     not amazingly pretty, but it can help:

      [alias]
        new = "! \
          f() { \
            case \"$1\" in \
              ''|-*) ;; \
              *) r=$1; shift ;; \
            esac; \
            git log $r@{1}..$r@{0} \"$@\"; \
          }; \
          f"

-Peff

PS I use a similar alias, and I have found that defaulting to "--oneline
--graph --boundary $r@{0}...@r{1}" is quite nice for seeing how you
differ from upstream.
