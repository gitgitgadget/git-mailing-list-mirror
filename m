From: Jeff King <peff@peff.net>
Subject: Re: git_getpass regression?
Date: Fri, 29 Jun 2012 13:39:55 -0400
Message-ID: <20120629173954.GA3804@sigill.intra.peff.net>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 19:40:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkfAv-0004PP-4m
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 19:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab2F2RkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 13:40:03 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:49500
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755819Ab2F2RkC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 13:40:02 -0400
Received: (qmail 14201 invoked by uid 107); 29 Jun 2012 17:40:06 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Jun 2012 13:40:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jun 2012 13:39:55 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200818>

On Fri, Jun 29, 2012 at 12:06:31PM +0200, Erik Faye-Lund wrote:

> Since 9b4b894 ("Makefile: linux has /dev/tty", 2011-12-10) we're
> reading input from the terminal using strbuf_getline instead of
> getpass. But at least on my linux-box, getpass treats the
> backspace-key ('\b') as an actual deletion. strbuf_getline obviously
> shouldn't do this, as it's a utility function. But I think as a
> user-interface feature, it would be much more pleasant to be allowed
> to edit the entered text ;)
> 
> I can't find anything in POSIX that standardize this behavior, but for
> most text-input use-cases it's probably what the user intended.

Backspace shouldn't be making it to git at all; it should be handled at
the terminal input layer, because we are not putting the terminal into
raw mode. It works just fine for me here, both on the linux console and
in an xterm. What terminal are you using? Are you ssh-ing to a remote
linux box? If that is the case, I wonder if your 'stty erase' settings
do not match what your terminal emulator is sending.

If you run "stty erase ^H" and then run git, does it work?

> I think we have multiple possible solutions:
>  1) Read a character at the time, and special-case '\r' to erase the
> previously entered character.
>  2) Post-process the strbuf to explicitly perform the erasing.
>  3) Do nothing.

I assume you meant '\b' in (1).  I think (3) is the only sane thing,
though. Even if we handled \b, that is not what all terminals generate.
In particular, most linux terminal emulators these days will generate
DEL (aka ^? or 0x7f) on backspace. This problem needs to be solved at
the terminal layer, and I suspect is just a configuration issue in your
setup.

-Peff
