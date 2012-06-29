From: Jeff King <peff@peff.net>
Subject: Re: git_getpass regression?
Date: Fri, 29 Jun 2012 16:30:01 -0400
Message-ID: <20120629203001.GA12937@sigill.intra.peff.net>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
 <20120629173954.GA3804@sigill.intra.peff.net>
 <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 22:30:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkhpU-0004b0-7U
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 22:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947Ab2F2UaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 16:30:05 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:49587
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932796Ab2F2UaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 16:30:04 -0400
Received: (qmail 15930 invoked by uid 107); 29 Jun 2012 20:30:09 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Jun 2012 16:30:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jun 2012 16:30:01 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200830>

On Fri, Jun 29, 2012 at 10:14:35PM +0200, Erik Faye-Lund wrote:

> > Backspace shouldn't be making it to git at all; it should be handled at
> > the terminal input layer, because we are not putting the terminal into
> > raw mode.
> 
> I don't get it. How can the terminal ever interpret the backspace, when
> we've already put the character it's supposed to erase in a strbuf? Sure,
> the echo can be correctly dealt with (probably with the exception of the
> border case of erasing characters from the prompt text), but once we've put
> the characters into a buffer, the terminal cannot erase it.

Because a terminal in non-raw mode is typically line-oriented, and your
program doesn't get to see any input at all until the user hits enter.

Try this on your linux box:

  strace -e read cat

You should be able to type characters and backspace erase them, all
without seeing any activity from strace. When you hit enter, you should
see the full text you typed read as a single syscall.

If the backspacing doesn't work, then there is a configuration mismatch
between what linux's tty driver expects and what your terminal emulator
is sending (the former is probably expecting ^? as the erase character,
and the latter is sending ^H).

> > If that is the case, I wonder if your 'stty erase' settings
> > do not match what your terminal emulator is sending.
> 
> I have no idea what that even means. And having to fiddle around with
> terminal settings just makes git feel cheap.

But it's not git that is broken. It's your configuration. Fixing git is
a band-aid, and other programs will still be broken. Of course, I may be
mis-diagnosing your problem. Did you try this:

> > If you run "stty erase ^H" and then run git, does it work?

?

> >  I think (3) is the only sane thing,
> > though. Even if we handled \b, that is not what all terminals generate.
> > In particular, most linux terminal emulators these days will generate
> > DEL (aka ^? or 0x7f) on backspace. This problem needs to be solved at
> > the terminal layer, and I suspect is just a configuration issue in your
> > setup.
>
> As I already said, I don't think this is the case. Inserting 0x7f in a
> strbuf does not delete the preceding char...

Of course not. Control characters should be handled by the terminal
driver, and shouldn't make it to git at all. Backspacing works perfectly
well on correctly configured systems, and it should not be git's
responsibility to care about it at all for line-oriented input (and if
we _did_ want to handle it ourselves, we should use a real terminal
library like readline or curses).

-Peff
