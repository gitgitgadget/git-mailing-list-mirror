From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: poll() emulation in git
Date: Thu, 6 Sep 2012 16:02:30 +0200
Message-ID: <010301cd8c38$4256bb90$c70432b0$@schmitz-digital.de>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org> <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de> <50476EFD.2000500@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Erik Faye-Lund'" <kusmabite@gmail.com>, <bug-gnulib@gnu.org>,
	<rsbecker@nexbridge.com>
To: <git@vger.kernel.org>, "'Paolo Bonzini'" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:03:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9cfu-0006Ob-1z
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901Ab2IFODK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:03:10 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52465 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab2IFODI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 10:03:08 -0400
Received: from DualCore (dsdf-4d0a10f7.pool.mediaWays.net [77.10.16.247])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MVYtf-1T4zOk2Sbf-00Ymcy; Thu, 06 Sep 2012 16:02:39 +0200
In-Reply-To: <50476EFD.2000500@gnu.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIgUOmy4ZEsU7RI7VRx80YFphUkTAI89tULAgLpIAgCxd+aWpafPklg
Content-Language: de
X-Provags-ID: V02:K0:WgHMBCJSRbCFZ5UAAOb4vI9yvSDUh9G8TjWeuzsKu+p
 ZM6blDaPFMgv8Hn1IpkiqZSB1CISVr50TqUwAaCxxa6lUj1kgP
 zITw3qR668zS8C2JvViqreAwL5do9uqFEvLdPuGsFkxWgIxJiC
 1x7/jKgGkf+fSAFJf4pGMGGKkdAmeIHdUlgBht6MK13Dqw5T1s
 V4zaa1gxBVD8lBX/wuCRkBmqnoqNq9P3R6xmk6g4wX+ljlJx2t
 SPOF8SpppSzM6kaUXLs3A5Mdw8Kc3liP8n5MoOMd4wY8nYaIK3
 c6DXivKo1UgAqxAYvpS1TdUKYhF4BobyRfUxu7dToMoD71TZ3S
 2rBSWizVgZJPdnadEdfy7+88YnQzPRjpl7bNLa76PVMAJMTN+E
 3FeIvkbsR1l2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204884>

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> Sent: Wednesday, September 05, 2012 5:26 PM
> To: Joachim Schmitz
> Cc: 'Junio C Hamano'; git@vger.kernel.org; 'Erik Faye-Lund'; bug-gnulib@gnu.org
> Subject: Re: poll() emulation in git
> 
> Il 05/09/2012 15:36, Joachim Schmitz ha scritto:
> >>> > > Does your system have a working FIONREAD ioctl for pipes?
> >> >
> >> > It does have FIONREAD ioctl. Whether it works properly is to be determined...
> >> > I'll test if you could show me how?
> > Oh, now I see what you aimed at, but no, that Mac OS X method doesn't work for me, I tried (at least I think I did).
> >
> > And <sys/ioctl.h> has
> > /*
> >  * Normal IOCTL's supported by the socket interface
> >  */
> > #define FIONREAD        _IOR(0, 8, _ioctl_int)       /* Num of bytes to read */
> > #define FIONBIO         _IOW(0, 9, _ioctl_int)       /* Non-blocking I/O     */
> >
> > So these seem to be supported on sockets only, I guess.
> > And indeed the man pages for ioctl confirms:
> >
> >           Valid values for the request parameter for AF_INET or
> >           AF_INET6 sockets are:
> >
> >
> >           FIONREAD  Gets the number of bytes available for reading and
> >                     stores it at the int pointed at by arg.
> >
> >
> > So not even AF_UNIX sockets, not to mention pipes...
> 
> So there's no way you can support POLLHUP.  Your system is quite
> crippled. :(

Unfortunatly.

But is there something that could be done to make git work even without poll()?
It is used in 5 places:

$ grep -n poll\( *.c */*.c
credential-cache--daemon.c:175: if (poll(&pfd, 1, 1000 * wakeup) < 0) {
daemon.c:1018:          if (poll(pfd, socklist->nr, -1) < 0) {
help.c:361:                     poll(NULL, 0, autocorrect * 100);
upload-pack.c:232:              if (poll(pfd, pollsize, -1) < 0) {
builtin/upload-archive.c:125:           if (poll(pfd, 2, -1) < 0) {

Don't quite understand why in help.c it has that NULL, which should always result in an EFAULT and other than that basically is a
NOP (at least in the poll() emulation)? Seems a usleep(autocorrect * 100) is meant to happen here instead?
So I think here a poll() isn't needed at all. But also the 'broken' one shouldn't harm too much.

In daemon.c it seems to be all sockets it polls on, so it should work on NonStop.
Same in credential-cache--daemon.c

Remains upload-pack.c and builtin/upload-archive.c
In both start_command() gathers the FDs to poll() on and that indeed works on pipes -> problem on NonStop!

Seeing that in those cases xread() takes care of EAGAIN, I've now used 'brute force' in poll.c:

...
# else
      char data[64];
      r = recv (fd, data, sizeof (data), MSG_PEEK);
      socket_errno = (r < 0) ? errno : 0;
# endif
      if (r == 0)
        happened |= POLLHUP;

      /* If the event happened on an unconnected server socket,
         that's fine. */
      else if (r > 0 || ( /* (r == -1) && */ socket_errno == ENOTCONN))
        happened |= (POLLIN | POLLRDNORM) & sought;

      /* Distinguish hung-up sockets from other errors.  */
      else if (socket_errno == ESHUTDOWN || socket_errno == ECONNRESET
               || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
        happened |= POLLHUP;

#ifdef __TANDEM /* as we can't recv(...,MSG_PEEK) on a non-socket */
      else if (socket_errno == ENOTSOCK)
        happened |= (POLLIN | POLLRDNORM) & sought;
#endif
      else
        happened |= POLLERR;
    }
...

We won't detect POLLHUP that way I think. However it seems to work, we've been able to clone, push, pull, branch that way with
NonStop being the (ssh-)server, something that didn't work at all without that hack (and yes, I believe it is just that).
Someone in for a cleaner way of managing this?

Bye, Jojo
