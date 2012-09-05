From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: poll() emulation in git
Date: Wed, 5 Sep 2012 13:24:25 +0200
Message-ID: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Erik Faye-Lund'" <kusmabite@gmail.com>,
	<bug-gnulib@gnu.org>, "'Paolo Bonzini'" <bonzini@gnu.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 13:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Dj0-0008Gt-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 13:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628Ab2IELYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 07:24:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55129 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758588Ab2IELYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 07:24:38 -0400
Received: from DualCore (dsdf-4db50426.pool.mediaWays.net [77.181.4.38])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MOpRC-1TBwkL1E3i-0063x3; Wed, 05 Sep 2012 13:24:32 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2LUuyJjvLsUfp2S9ecYSmnLauuHw==
Content-Language: de
X-Provags-ID: V02:K0:s9+AosE+ApRlcAMJFkbulbCfbKaV9JrYdphzbnQGFt8
 YB5UHkO3WIZtv0ytUlkotI7P2HxKABoypJBIUPas0RVpd74623
 P/4jFUyHo7c4naHo2efwJp7jsT5h68cOCW4EVO32pMUk1cNubC
 j1w5A0PrIPOokWrnvRDN5afHUKC6beOhaWGNClB3IDeVyWUZcE
 wwGj3WsKDFxHdVAmXLbBLNQAiqLS4tZ+DPyrGlyCOto3IYayvu
 3fKCrvuO2qfkSfHZ+4lYM5wx3US2PapwZ65VksuNoHAoDrT2ju
 aX5eKBqyusy9RBnF8MygdSFPDgtdmhm+OBRPbQNL38tKyDhYkH
 CE0J0IjhF+qGZHCbNRuPeNFKqzHUpLe39W7cvOt2GgkqVa67kD
 /7Z5ZVA9A2XmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204814>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Tuesday, September 04, 2012 1:49 PM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'; 'Erik Faye-Lund'
> Subject: RE: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
> 
> > From: Junio C Hamano [mailto:gitster@pobox.com]
> > Sent: Friday, August 24, 2012 9:47 PM
> > To: Joachim Schmitz
> > Cc: git@vger.kernel.org; 'Erik Faye-Lund'
> > Subject: Re: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
> >
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> > > Different, but related question: would poll.[ch] be allowed to #include "git-compat-util.h"?
> >
> > Seeing other existing generic wrappers directly under compat/,
> > e.g. fopen.c, mkdtemp.c, doing so, I would say why not.
> >
> > Windows folks (I see Erik is already CC'ed, which is good ;-),
> > please work with Joachim to make sure such a move won't break your
> > builds.  I believe that it should just be the matter of updating a
> > couple of paths in the top-level Makefile.
> 
> Haven't heard anything from the Windows folks yet.
> 
> I'd prefer to move compat/win32/poll.[ch] into compat/poll.
> Then adjust a few paths in Makefile and that would be the 1st patch
> 
> A 2nd patch would be my already proposed ones that make this usable for others (me in this case ;-)), namely wrapping 2 #inludes.
> 
> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> index 403eaa7..49541f1 100644
> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -24,7 +24,9 @@
>  # pragma GCC diagnostic ignored "-Wtype-limits"
>  #endif
> 
> -#include <malloc.h>
> +#if defined(WIN32)
> +# include <malloc.h>
> +#endif
> 
>  #include <sys/types.h>
> 
> @@ -48,7 +50,9 @@
>  #else
>  # include <sys/time.h>
>  # include <sys/socket.h>
> -# include <sys/select.h>
> +# ifndef NO_SYS_SELECT_H
> +#  include <sys/select.h>
> +# endif
>  # include <unistd.h>
>  #endif
> 
> --
> 1.7.12

However: this poll implementation, while compiling OK, doesn't work properly.
Because it uses recv(...,MSG_PEEK), it works on sockets only (returns ENOTSOCK on anything else), while the real poll() works on all
kind if file descriptors, at least that is my understanding.

Here on HP NonStop, when being connected via an non-interactive SSH, we get a set of pipes (stdin, stdout, stderr) instead of a
socket to talk to, so the poll() just hangs/loops.

As git's implementation is based on ('stolen' from?) gnulib's and still pretty similar, CC to the gnulib list and Paolo

Any idea how this could get solved? I.e. how to implement a poll() that works on non-sockets too?
There is some code that pertains to a seemingly similar problem in Mac OS X, but my problem is not identical, as that fix doesn't
help.

Bye, Jojo
