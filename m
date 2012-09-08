From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v4 4/4] make poll() work on platforms that can't recv() on a non-socket
Date: Sat, 8 Sep 2012 15:53:43 +0200
Message-ID: <001b01cd8dc9$5c6ca7a0$1545f6e0$@schmitz-digital.de>
References: <004201cd8d0f$8e9ad4f0$abd07ed0$@schmitz-digital.de> <CABPQNSY1+3X3LE19mSm2398Kr9EvOxbmsoRLzo4fFTytiA3B+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 15:54:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TALUq-0000fE-EX
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 15:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2IHNx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 09:53:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60311 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2IHNx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 09:53:58 -0400
Received: from DualCore (dsdf-4db5dae6.pool.mediaWays.net [77.181.218.230])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Mcj5x-1SsOxN3luD-00HfUr; Sat, 08 Sep 2012 15:53:53 +0200
In-Reply-To: <CABPQNSY1+3X3LE19mSm2398Kr9EvOxbmsoRLzo4fFTytiA3B+Q@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQI8QGZpVede+XkNimQF45X+XqteXQF35RFGlpcrj6A=
Content-Language: de
X-Provags-ID: V02:K0:7Smkx1tAwbEWGcEPhQX3fYGWD8PjxUNCQwNFjh4O8xf
 UY90anmDphxntgDpanMo25EdEyqf+7JUZuPupNMatlDRaXmaQ5
 p7CydcFQtZ1inwgfG75pLR4fiWWjHYId2ps1TbLSbgszo124Tz
 bMlbWkG0CCnsn4bi30N09CLPbmySa7yhnvnMN5jzRzAZ/0KBX4
 8mgOuiol0Ig2/BTxFxbBd3GTI7zQN3grN2Bx3HYcylpEazEf0e
 5dtOHa0svijDj6wneRRmOXb9aeZOcWjm3ZKINsoXNugsU0t3s8
 d28aFOuR+jnL8hWWN8LYS0GSwH7DVVYqZgRT3593k3EbKpWxAy
 4xAng4+UCn1uRDUGtzGb6NfoFClfrXswCPgPljoaTftY0FMHzv
 TzU+L5aCUo7ig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205012>

> From: Erik Faye-Lund [mailto:kusmabite@gmail.com]
> Sent: Saturday, September 08, 2012 1:32 PM
> To: Joachim Schmitz
> Cc: Junio C Hamano; git@vger.kernel.org
> Subject: Re: [PATCH v4 4/4] make poll() work on platforms that can't recv() on a non-socket
> 
> On Fri, Sep 7, 2012 at 5:43 PM, Joachim Schmitz <jojo@schmitz-digital.de> wrote:
> > This way it gets added to gnulib too.
> >
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > ---
> >  compat/poll/poll.c | 5 +++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> > index e4b8319..10a204e 100644
> > --- a/compat/poll/poll.c
> > +++ b/compat/poll/poll.c
> > @@ -306,6 +306,10 @@ compute_revents (int fd, int sought, fd_set *rfds, fd_set *wfds, fd_set *efds)
> >                || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
> >         happened |= POLLHUP;
> >
> > +      /* some systems can't use recv() on non-socket, including HP NonStop */
> > +      else if (/* (r == -1) && */ socket_errno == ENOTSOCK)
> 
> Why add commented-out code ("(r == -1) && ")?

I'm not really sure whether it may be needed, esp. for Mac OS X, where en ENOTSOCK is expected from a recv() but then dealt with by
an ioctl(), which does not resert socket_errno, but does set r to something not -1. And wouldn't need this code path?
There's some similar code a few lines up, which too has that part commented out:

      /* If the event happened on an unconnected server socket,
         that's fine. */
      else if (r > 0 || ( /* (r == -1) && */ socket_errno == ENOTCONN))
        happened |= (POLLIN | POLLRDNORM) & sought;

Bye, Jojo
