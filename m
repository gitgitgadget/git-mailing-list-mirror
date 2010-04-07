From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 07 Apr 2010 14:37:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004071431000.7232@xanadu.home>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
 <20100407031655.GA7156@spearce.org>
 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
 <20100407144555.GA23911@fredrik-laptop>
 <alpine.LFD.2.00.1004071103341.7232@xanadu.home>
 <v2t4c8ef71004070913r2de3c8car31f39a2ab7aa6d15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_eIp9iR9AKjFumYPwxll2IQ)"
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:37:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nza7t-0004bI-Cr
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986Ab0DGShP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 14:37:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25373 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab0DGShO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 14:37:14 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0I00B28RQ1OXF0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 14:37:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <v2t4c8ef71004070913r2de3c8car31f39a2ab7aa6d15@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144264>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_eIp9iR9AKjFumYPwxll2IQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 7 Apr 2010, Fredrik Kuivinen wrote:

> On Wed, Apr 7, 2010 at 17:08, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Wed, 7 Apr 2010, Fredrik Kuivinen wrote:
> >> diff --git a/thread-utils.c b/thread-utils.c
> >> index 4f9c829..3c8d817 100644
> >> --- a/thread-utils.c
> >> +++ b/thread-utils.c
> >> @@ -1,4 +1,5 @@
> >>  #include "cache.h"
> >> +#include <pthread.h>
> >
> > This will fail compilation on Windows surely?
> 
> I think it will work. We use "#include <pthread.h>" in builtin/grep.c,
> builtin/pack-objects.c, and preload-index.c already.

True indeed.

> >>  #if defined(hpux) || defined(__hpux) || defined(_hpux)
> >>  #  include <sys/pstat.h>
> >> @@ -43,3 +44,24 @@ int online_cpus(void)
> >>
> >>       return 1;
> >>  }
> >> +
> >> +int init_recursive_mutex(pthread_mutex_t *m)
> >> +{
> >> +#ifdef _WIN32
> >> +     /* The mutexes in the WIN32 pthreads emulation layer are
> >> +      * recursive, so we don't have to do anything extra here. */
> >> +     return pthread_mutex_init(m, NULL);
> >> +#else
> >> +     pthread_mutexattr_t a;
> >> +     int ret;
> >> +     if (pthread_mutexattr_init(&a))
> >> +             die("pthread_mutexattr_init failed: %s", strerror(errno));
> >> +
> >> +     if (pthread_mutexattr_settype(&a, PTHREAD_MUTEX_RECURSIVE))
> >> +             die("pthread_mutexattr_settype failed: %s", strerror(errno));
> >> +
> >> +     ret = pthread_mutex_init(m, &a);
> >> +     pthread_mutexattr_destroy(&a);
> >> +     return ret;
> >
> > Are you sure the pthread_mutexattr_t object can be destroyed even if the
> > mutex is still in use?  Is the attribute object "attached" to the mutex
> > or merely used as a template?
> 
> It is safe. See
> http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutexattr_init.html

OK.  ACK to your patch then.


Nicolas

--Boundary_(ID_eIp9iR9AKjFumYPwxll2IQ)--
