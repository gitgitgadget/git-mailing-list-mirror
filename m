From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] add interface for /dev/tty interaction
Date: Mon, 6 Aug 2012 15:56:16 -0400
Message-ID: <20120806195616.GC10039@sigill.intra.peff.net>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-1-git-send-email-rctay89@gmail.com>
 <1344192340-19415-2-git-send-email-rctay89@gmail.com>
 <7vsjc12j5o.fsf@alter.siamese.dyndns.org>
 <20120806194511.GB10039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 21:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyTPd-0001cB-1K
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 21:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547Ab2HFT4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 15:56:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53617 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932500Ab2HFT4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 15:56:19 -0400
Received: (qmail 18247 invoked by uid 107); 6 Aug 2012 19:56:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 15:56:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 15:56:16 -0400
Content-Disposition: inline
In-Reply-To: <20120806194511.GB10039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202979>

On Mon, Aug 06, 2012 at 03:45:11PM -0400, Jeff King wrote:

> > This is not your fault but seeing term_t made me go "eek, yuck".
> 
> Agreed.
> 
> > As far as I can see, use of "FILE *" in existing compat/terminal.c
> > is not buying us anything useful.  The stdio calls made on FILE *fh
> > are only fopen(), fputs(), fflush() and fclose(), and everything
> > else goes through fileno(fh).
> > 
> > So perhaps it is a saner approach to fix that function first before
> > this patch so that it works on file descriptors.
> 
> Yeah, I think that is a good path. I think my original use of stdio
> was mostly because I started by paring down glibc's implementation of
> getpass.  Since we have niceties like write_in_full, I don't think
> there's any reason not to just skip stdio.

I forgot to mention: even if we changed the HAVE_DEV_TTY code path to
use an integer descriptor (which I think is a sane thing to do
regardless), that may not be sufficient to solve this problem.

Erik has looked into doing a Windows alternative in compat/terminal.c,
and I think an integer would be insufficient there. In particular, I
think Windows needs two descriptors to accomplish the same thing (one
for CONIN$ and one for CONOUT$).  So you'd need to turn term_t into a
struct (and you'd probably not want to return it by value then).

Maybe it would be better to keep the abstraction as non-leaky as
possible, and just provide "terminal_can_prompt()" or similar?

Returning the open descriptor (as Tay's patch does) avoids a race
condition where /dev/tty can be opened when terminal_can_prompt runs,
but not when we try to actually read from it. But we can either:

  1. Not care. Even if the tty is opened, if a user has closed the
     terminal we are going to get a read error anyway. So you can never
     avoid that race condition in some form.

  2. Open the terminal descriptor when either function is called, and
     never close it. I don't think there is any reason we can't just
     leak the descriptor.

-Peff
