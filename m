From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] run-command: allow aborting async code prematurely
Date: Fri, 1 Apr 2011 09:59:11 -0400
Message-ID: <20110401135910.GA1650@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <20110331184421.GC16906@sigill.intra.peff.net>
 <AANLkTinAQiuYjs+pxBVKM2-aQNSDd_-CC_fMahasTB=V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 15:59:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5esi-0008K9-Qd
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 15:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab1DAN7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 09:59:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58688
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340Ab1DAN7N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 09:59:13 -0400
Received: (qmail 9026 invoked by uid 107); 1 Apr 2011 13:59:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 09:59:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 09:59:11 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinAQiuYjs+pxBVKM2-aQNSDd_-CC_fMahasTB=V@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170584>

On Fri, Apr 01, 2011 at 11:36:53AM +0200, Erik Faye-Lund wrote:

> > diff --git a/run-command.c b/run-command.c
> > index 258c880..f179d2a 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -439,6 +439,16 @@ int finish_async(struct async *async)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> > =C2=A0}
> >
> > +void abort_async(struct async *async)
> > +{
> > +#ifndef WIN32
> > + =C2=A0 =C2=A0 =C2=A0 kill(async->pid, 15);
>=20
> This doesn't compile unless NO_PTHREADS is set, no?

Read the cover letter again. This goes on top of an old version,
pre-pthreads. Patch 5/4 modernizes it.

> This should probably be
>=20
> void abort_async(struct async *async)
> {
> #ifdef NO_PTHREADS
> 	kill(async->pid, 15);
> #else
> 	pthread_cancel(async->tid)
> #endif
> 	finish_async(async);
> }

Yes, eventually it becomes that, in 5/4.

> ... and then us Windows-guys must implement something like pthread_ca=
ncel().
>=20
> Or maybe not. Can pthread reliably cancel a thread while making sure
> that thread isn't holding a mutex (like some thread-safe malloc
> implementations do)? If not, I'm not entirely sure we can even reach
> this goal.

Yes, as you figured out in a later email, there are cancellation points=
=2E
However, I'm not sure it matters for this. Run-command's async code is =
a
very abstract primitive that can even be implemented in a separate
process. So async code must not use mutexes or assume it shares memory
with the parent. Real threaded code should use pthreads directly (and
must be optional, or we alienate non-threaded platforms).

-Peff
