From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 17:16:49 -0400
Message-ID: <20110401211649.GA16787@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104012142.22065.j6t@kdbg.org>
 <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
 <201104012218.07872.j6t@kdbg.org>
 <AANLkTi=ec9azPovJoDVO6kyXEik4uFQu3dZNxAJyvDY=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 23:17:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5liG-0008Ky-T0
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 23:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab1DAVQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 17:16:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56733
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298Ab1DAVQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 17:16:53 -0400
Received: (qmail 16272 invoked by uid 107); 1 Apr 2011 21:17:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 17:17:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 17:16:49 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=ec9azPovJoDVO6kyXEik4uFQu3dZNxAJyvDY=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170623>

On Fri, Apr 01, 2011 at 10:31:42PM +0200, Erik Faye-Lund wrote:

> On Fri, Apr 1, 2011 at 10:18 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > On Freitag, 1. April 2011, Erik Faye-Lund wrote:
> >> On Fri, Apr 1, 2011 at 9:42 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> >> > But this does not help the case at hand in any way. How would you
> >> > interrupt a thread that is blocked in ReadFile()? The point of
> >> > pthread_cancel() is that it interrupts blocked system calls
> >>
> >> There is no mention of such a guarantee in POSIX (section 2.9.5 Thread
> >> Cancellation), so relying on that is undefined behavior.
> >
> > In the paragraph before the bulleted list at the end of "Cancellation Points":
> >
> > "...If a thread has cancelability enabled and a cancellation request is made
> > with the thread as a target while the thread is suspended at a cancellation
> > point, the thread shall be awakened and the cancellation request shall be
> > acted upon..."
> >
> 
> A blocking thread and a suspended are two different matters. A
> suspended thread is a thread that has been explicitly suspended by
> wait, waitpid, sleep, pause etc. These functions explicitly say that
> they suspend the thread ("shall suspend the calling thread until"),
> while read etc does not ("shall block the calling thread until").
> 
> Similarly, making a blocking read/write fail (or terminate mid-way) is
> not the same thing as awakening the thread.
> 
> I see how some people can read something like this into this section,
> but I think it's pretty clear - this is not what it's talking about.
> In fact, the more I read the relevant texts, the more convinced I get
> that implementations that does terminate read/write strictly speaking
> is in violation of the standard.

What about the text right before the bit that Johannes quoted:

  The side effects of acting upon a cancellation request while suspended
  during a call of a function are the same as the side effects that may
  be seen in a single-threaded program when a call to a function is
  interrupted by a signal and the given function returns [EINTR]. Any
  such side effects occur before any cancellation cleanup handlers are
  called.

I agree it would be nicer if it explicitly said "when you are in a
function which is a cancellation point, pending cancellation requests
which are delivered are acuted upon immediately".

But it is implied to me by the surrounding text, and it's the only
sensible behavior IMHO. Plus it seems to be what at least glibc pthreads
does on Linux, so I'm going to assume that people smarter than me
thought about it and came up with the same interpretation.

My test program was:

-- >8 --
#include <pthread.h>
#include <unistd.h>
#include <stdio.h>

void *child(void *data)
{
  char buf[32];
  int r;

  fprintf(stderr, "child reading from stdin...\n");
  r = read(0, buf, sizeof(buf));
  fprintf(stderr, "child read returned %d\n", r);
  return NULL;
}

int main(void)
{
  pthread_t t;
  void *r;

  pthread_create(&t, NULL, child, NULL);
  sleep(3);
  pthread_cancel(t);

  pthread_join(t, &r);
  if (r == PTHREAD_CANCELED)
    fprintf(stderr, "thread was canceled\n");
  else
    fprintf(stderr, "thread returned %p\n", r);

  return 0;
}
-- >8 --

If you input something before 3 seconds is up, the thread prints its
message and returns NULL. But if you let it go, the cancel interrupts
the read().

-Peff
