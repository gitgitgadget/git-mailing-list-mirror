From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
Date: Wed, 22 Aug 2012 19:44:10 +0200
Message-ID: <003501cd808d$bd21b7a0$376526e0$@schmitz-digital.de>
References: <002101cd8078$eb2eb4f0$c18c1ed0$@schmitz-digital.de> <7vd32ialzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Erik Faye-Lund'" <kusmabite@gmail.com>,
	"'Johannes Sixt'" <j6t@kdbg.org>,
	"'Marius Storm-Olsen'" <mstormo@gmail.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:44:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Eyk-0002j8-7T
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab2HVRoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:44:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:60369 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab2HVRoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:44:20 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lkism-1TcTrg1m7Q-00axRD; Wed, 22 Aug 2012 19:44:17 +0200
In-Reply-To: <7vd32ialzo.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQD/eQtdRAcjQut3cNsfzSYRhS9vOQEpqCMymPjV2GA=
Content-Language: de
X-Provags-ID: V02:K0:RHMqZV/nsMDyKxZQ6XKe6ns0ERlIduXeRHaXuw6VKwd
 FBivvCJwMqGZKmE1lgTvXTIp4RwIwH4PDzmaVhAcXq0BZVuBQB
 Z2diLRH0/6ygD2ElSUx01FVW4oJpzSdPm8/jUXt/6OeAYvcPhP
 OCZ5NzceBzb39GHFQDlLAL08Fn/63I0EB8sP9SDxC8lQBiJten
 LylSewpgT8U9bmXOBq4pV3tHewIHEeqFrpufLWHTk3ytMoWwRb
 FYoGbfcoFuhbVP5fyOoFFAXncw8Q3qpzHRhzP/uBBeiPzpir3g
 nbh64BvTA5RvxXuxDFmFEUEZrHllGoNEjq6Ldb/UJtR0u+DpVM
 zjuTSbPgsxk/weihBonSnsSd0Dw7MGmBmucf3Lnnphg6qjMijR
 G96tEpofgX2sQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204046>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 7:13 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; Erik Faye-Lund; Johannes Sixt; Marius Storm-Olsen
> Subject: Re: [PATCH] Support non-WIN32 system lacking poll() while keeping
> the WIN32 part intact
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > ---
> >  Makefile            | 18 ++++++++++++++----
> >  compat/win32/poll.c |  8 ++++++--
> >  2 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 6b0c961..2af4db3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -152,6 +152,11 @@ all::
> >  #
> >  # Define NO_MMAP if you want to avoid mmap.
> >  #
> > +# Define NO_SYS_POLL_H if you don't have sys/poll.h.
> > +#
> > +# Define NO_POLL if you do not have or do not want to use poll.
> > +# This also implies NO_SYS_POLL_H.
> 
> Do you really need to have both?  I suspect "If you do not have a usable
> sys/poll.h, set NO_SYS_POLL_H" may be a simpler alternative, but there
must

Hmm, Not having <sys/poll.h> and not having poll() are different thinks,
aren't they?

Using NO_SYS_POL_H so far only affects BASIC_CFLAGS:
ifdef NO_SYS_POLL_H
        BASIC_CFLAGS += -DNO_SYS_POLL_H
endif

It does not add compat/win32/poll.c to COMPAT_OBJS, NO_POLL does that.

> be a reason why you had to add a new one instead of going that route.  It
would
> be a good idea to describe that reason in the log message above, in the
space
> before your Sign-off.
> 
> > @@ -1257,7 +1262,7 @@ ifeq ($(uname_S),Windows)
> >         BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild
> > -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H
> > -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
> >         COMPAT_OBJS = compat/msvc.o compat/winansi.o \
> >                 compat/win32/pthread.o compat/win32/syslog.o \
> > -               compat/win32/poll.o compat/win32/dirent.o
> > +               compat/win32/dirent.o
> >         COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -
> DHAVE_STRING_H
> > ...
> > @@ -1347,7 +1352,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> >         COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
> >         COMPAT_OBJS += compat/mingw.o compat/winansi.o \
> >                 compat/win32/pthread.o compat/win32/syslog.o \
> > -               compat/win32/poll.o compat/win32/dirent.o
> > +               compat/win32/dirent.o
> >         EXTLIBS += -lws2_32
> > ...
> > @@ -1601,6 +1606,11 @@ ifdef NO_GETTEXT ...
> > +ifdef NO_POLL
> > +       NO_SYS_POLL_H = YesPlease
> > +       COMPAT_CFLAGS += -DNO_POLL -Icompat/win32 # so it find poll.h
> > +       COMPAT_OBJS += compat/win32/poll.c endif
> 
> In general, I think this is a good direction to go.  If the existing
emulation in
> win32/poll.c turns out to be usable across platforms and not windows
specific,
> sharing it would be a good idea.
> 
> But if the emulation is no longer windows specific, shouldn't you also
move it
> outside compat/win32/ and somewhere more generic?

Should be possible. Esp. as with the current setup make issues a warning:

Makefile:2329: target `compat/win32/poll.c' doesn't match the target pattern

Haven't yet been able to spot where that comes from.

> > diff --git a/compat/win32/poll.c b/compat/win32/poll.c index
> > 403eaa7..49541f1 100644
> > --- a/compat/win32/poll.c
> > +++ b/compat/win32/poll.c
> > @@ -24,7 +24,9 @@
> >  # pragma GCC diagnostic ignored "-Wtype-limits"
> >  #endif
> >
> > -#include <malloc.h>
> > +#if defined(WIN32)
> > +# include <malloc.h>
> > +#endif
> 
> Hrm, are the Windows folks OK with this?  MINGW and MSVC are affected;
> Cygwin should be OK, I think.

I stole that define from another place in git (compat/nedmalloc/nedmalloc.c"
line 36), there too it was used to hide <malloc.h>, so I assumed it to be
the proper method?
 
> >  #include <sys/types.h>
> >
> > @@ -48,7 +50,9 @@
> >  #else
> >  # include <sys/time.h>
> >  # include <sys/socket.h>
> > -# include <sys/select.h>
> > +# ifndef NO_SYS_SELECT_H
> > +#  include <sys/select.h>
> > +# endif
> >  # include <unistd.h>
> >  #endif
