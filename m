From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
	whitespace.
Date: Tue, 13 May 2008 05:11:43 -0400
Message-ID: <20080513091143.GA26248@sigill.intra.peff.net>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com> <20080428094119.GA20499@sigill.intra.peff.net> <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 11:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvqYm-00084r-Sf
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 11:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257AbYEMJLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 05:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbYEMJLq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 05:11:46 -0400
Received: from peff.net ([208.65.91.99]:4055 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757247AbYEMJLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 05:11:45 -0400
Received: (qmail 21627 invoked by uid 111); 13 May 2008 09:11:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 May 2008 05:11:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 May 2008 05:11:43 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82007>

On Mon, Apr 28, 2008 at 10:56:05AM +0100, Mike Ralphson wrote:

> > If a failing test, then I wonder if we could get a few people to set up
> > automated tests on alternate platforms. IIRC, Junio makes sure that
> > master always passes test on his Linux box and KO (Debian and Redhat, I
> > think?). Other platforms could "git pull && make test" daily. I could
> > probably do Solaris (once I get the tests to complete pass at all!) and
> > FreeBSD 6.
> 
> I could run automated build / test [/ bisect?] cycles on AIX if of any
> interest.

I think that would be helpful. We seem to have most Linux variants
pretty well covered. I now have a daily pull/build/test running on a
FreeBSD 6.1 box. I am going to try to get a Solaris one going, too, but
I have to first actually get the test scripts to pass _once_. :)

AIX would be nice, since it seems easy to break. ;) OS X would be nice,
too, though I suspect there are a few developers (Shawn?) who end up
running the test scripts occasionally anyway.

I am just calling the script below through cron, and it dumps a bunch of
output if any test fails (at which point I go investigate manually). The
only argument is the path to a git repo.

-- >8 --
#!/bin/sh

dir=$1; shift
log="$dir/.autotest.out"

try() {
  "$@" >"$log" 2>&1
  case "$?" in
    0) ;;
    *) echo >&2 "autotest failed: $*"
       cat >&2 "$log"
       exit 1
       ;;
  esac
}

try cd "$dir"
try git pull
try gmake
PATH=/usr/local/bin:/usr/bin:/bin; export PATH
try gmake test
