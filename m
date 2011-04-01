From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 16:17:14 -0400
Message-ID: <20110401201714.GA16501@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104011927.03366.j6t@kdbg.org>
 <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
 <201104012142.22065.j6t@kdbg.org>
 <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
 <20110401200537.GA15778@sigill.intra.peff.net>
 <AANLkTi=ro88pwpA+Gfu5p2dB3ntn8PUcwvjHRh3iRy_H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5kmk-0004yV-W0
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 22:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab1DAURY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 16:17:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54620
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755168Ab1DAURQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 16:17:16 -0400
Received: (qmail 15498 invoked by uid 107); 1 Apr 2011 20:18:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 16:18:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 16:17:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=ro88pwpA+Gfu5p2dB3ntn8PUcwvjHRh3iRy_H@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170615>

On Fri, Apr 01, 2011 at 10:13:23PM +0200, Erik Faye-Lund wrote:

> On Fri, Apr 1, 2011 at 10:05 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, Apr 01, 2011 at 09:57:14PM +0200, Erik Faye-Lund wrote:
> >
> >> > But this does not help the case at hand in any way. How would you interrupt a
> >> > thread that is blocked in ReadFile()? The point of pthread_cancel() is that
> >> > it interrupts blocked system calls
> >>
> >> There is no mention of such a guarantee in POSIX (section 2.9.5 Thread
> >> Cancellation), so relying on that is undefined behavior.
> >
> > Eh? My pthreads(7) says that read() is required to be a cancellation
> > point acrroding to POSIX. I didn't dig up the actual reference in the
> > standard, though.
> 
> I don't understand where the implementor would get that from after
> reading through it, but if there's something I've missed we can fix it
> by replacing my pthread_cancel with this, no?

Out of curiosity, which POSIX are you reading? My page references
POSIX.1-2001, but technically pthreads were originally defined in
POSIX.1c-1995.

> static inline int pthread_cancel(pthread_t thread)
> {
> 	SetEvent(thread.cancel_event);
> 	CancelSynchronousIo(thread.handle);
> }

There are a ton of cancellation points, not just I/O (e.g., sleep).
However, interrupting a read would probably be sufficient for git's
purposes.

-Peff
