From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: poll() emulation in git
Date: Thu, 6 Sep 2012 16:44:39 +0200
Message-ID: <010a01cd8c3e$25609500$7021bf00$@schmitz-digital.de>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org> <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de> <50476EFD.2000500@gnu.org> <010301cd8c38$4256bb90$c70432b0$@schmitz-digital.de> <5048B3D0.2070809@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>,
	"'Erik Faye-Lund'" <kusmabite@gmail.com>, <bug-gnulib@gnu.org>,
	<rsbecker@nexbridge.com>
To: "'Paolo Bonzini'" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9dKC-0000vy-P6
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336Ab2IFOou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:44:50 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:62180 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905Ab2IFOos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 10:44:48 -0400
Received: from DualCore (dsdf-4d0a10f7.pool.mediaWays.net [77.10.16.247])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Maxwc-1SqSXd0U3O-00KR2R; Thu, 06 Sep 2012 16:44:47 +0200
In-Reply-To: <5048B3D0.2070809@gnu.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIgUOmy4ZEsU7RI7VRx80YFphUkTAI89tULAgLpIAgCxd+aWgIK9t7YAl1Rw+2WfGdLkA==
Content-Language: de
X-Provags-ID: V02:K0:MfOMvjPOyAp0kH9gouUDcpV5ZSw9ZPyrjLv0SpTC8S1
 TvnszAGr5MDhldRtMysoCmavp1i7Ha3ZghQhjIlVDXgJBMH+1d
 Ju66H+fYx58fXkqTY1/dTXI32f4baKpLD5LqQLTc/1I8yfdpkl
 6J3dx6Gfvh6ChhJEF8NgkabSeeO1siaZAWEEYzD0X6IILkXX02
 1mTdCXFTBa3p8u1BWGzX7nLRjpQ48p/pnprzeRMLionSuE8sW6
 F0MAzXHbPkMBbZx/vvSlUrDZAki2wNPJYUb7728x2I6BbJnbSS
 7DXEjUz+jSe0T+kGWuM3TPsw4d/OinuP1I9YSpYnHcZqvyHDXc
 kjg8C6XqCk5W3iP5+kDQ/9edrlEAyN33x3IrYwydiN69i6ADMq
 CRu9M/HpuF5pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204892>

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> Sent: Thursday, September 06, 2012 4:32 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; 'Junio C Hamano'; 'Erik Faye-Lund'; bug-gnulib@gnu.org; rsbecker@nexbridge.com
> Subject: Re: poll() emulation in git
> 
> Il 06/09/2012 16:02, Joachim Schmitz ha scritto:
> >
> > But is there something that could be done to make git work even without poll()?
> > It is used in 5 places:
> >
> > $ grep -n poll\( *.c */*.c
> > credential-cache--daemon.c:175: if (poll(&pfd, 1, 1000 * wakeup) < 0) {
> > daemon.c:1018:          if (poll(pfd, socklist->nr, -1) < 0) {
> > help.c:361:                     poll(NULL, 0, autocorrect * 100);
> > upload-pack.c:232:              if (poll(pfd, pollsize, -1) < 0) {
> > builtin/upload-archive.c:125:           if (poll(pfd, 2, -1) < 0) {
> >
> > Don't quite understand why in help.c it has that NULL, which should always result in an EFAULT and other than that basically is
a
> > NOP (at least in the poll() emulation)? Seems a usleep(autocorrect * 100) is meant to happen here instead?
> > So I think here a poll() isn't needed at all. But also the 'broken' one shouldn't harm too much.
> 
> Yes, it's an usleep(autocorrect * 100000) basically (poll takes
> milliseconds, not micro).

OK, it is _supposed_ to do this usleep(), but is does not, as poll() returns early with EFAULT in this case:
  /* EFAULT is not necessary to implement, but let's do it in the
     simplest case. */
  if (!pfd)
    {
      errno = EFAULT;
      return -1;
    }

poll() is doing this before calling select(), so won't sleep.
So there's a bug in {gnulib|git}'s poll(), right?

> > ...
> > # else
> >       char data[64];
> >       r = recv (fd, data, sizeof (data), MSG_PEEK);
> >       socket_errno = (r < 0) ? errno : 0;
> > # endif
> >       if (r == 0)
> >         happened |= POLLHUP;
> >
> >       /* If the event happened on an unconnected server socket,
> >          that's fine. */
> >       else if (r > 0 || ( /* (r == -1) && */ socket_errno == ENOTCONN))
> >         happened |= (POLLIN | POLLRDNORM) & sought;
> >
> >       /* Distinguish hung-up sockets from other errors.  */
> >       else if (socket_errno == ESHUTDOWN || socket_errno == ECONNRESET
> >                || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
> >         happened |= POLLHUP;
> >
> > #ifdef __TANDEM /* as we can't recv(...,MSG_PEEK) on a non-socket */
> >       else if (socket_errno == ENOTSOCK)
> >         happened |= (POLLIN | POLLRDNORM) & sought;
> > #endif
> >       else
> >         happened |= POLLERR;
> >     }
> > ...
> >
> > We won't detect POLLHUP that way I think. However it seems to work, we've been able to clone, push, pull, branch that way with
> > NonStop being the (ssh-)server, something that didn't work at all without that hack (and yes, I believe it is just that).
> > Someone in for a cleaner way of managing this?
> 
> I suppose it works to always handle ENOTSOCK that way, even on
> non-__TANDEM systems.

So you think this is a clean way of dealing with it?

Bye, Jojo
