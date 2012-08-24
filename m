From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [RFC] Support for HP NonStop
Date: Fri, 24 Aug 2012 21:22:04 +0200
Message-ID: <005501cd822d$bf844bb0$3e8ce310$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 21:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4zSb-0005Zk-87
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 21:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760051Ab2HXTWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 15:22:20 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:58786 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758130Ab2HXTWR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 15:22:17 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LiWYm-1Tf9gp2STc-00dEi9; Fri, 24 Aug 2012 21:22:15 +0200
References: 
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B5aqsx7X29Ba9QAajUvjl8QL5ZAAR8GwA
Content-Language: de
X-Provags-ID: V02:K0:Y2LS5mtRIcI56Ews1TEcCALwVf/4iDpF6aEChfwa/XX
 y8ZbGM03mJ5/LsDTsAA6MJKxZ3oI3ttgzmF056JvpTmRtZkB3d
 xZ3Y/cwQyQKdmfo1zFxzMZ13QqIBX3zbNJ16k29qjGuvVBDzoa
 Nylf+ZJakYD2RGDc0A1cAKrrZ4mRUOqeCJ/7pOwuGtUgOZQ2XD
 U9FZbUSeyKH+CA6Wfvv7MfyFQYvdavQlyKL9S8V2+8jjSmRgdL
 wNoOROUxrvHGSzDiHuCfXmxT06TKxZUlkBRKFq4s43XXGK2r0N
 Z7U/LIGjDJmb493GKvWoxGFT78+nNKS6bk/henPHQYXvBlCy3w
 1LZI8HHH10WkypnUC48xLvBrvvhAXlxfL/ULKpl/mRFgLNoEgQ
 0Rab/Q4ziB4wQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204228>

Hi folks

On top of the patches I=92ve submitted so far, which were needed for HP=
 NonStop,=20
but possibly useful for other platforms too, here is one that is at lea=
st in parts NonStop specific

diff --git a/git-compat-util.h b/git-compat-util.h
index a047221..d6a142a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -74,7 +74,8 @@
# define _XOPEN_SOURCE 500
# endif
#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__=
) && \
-=A0=A0=A0=A0=A0 !defined(_M_UNIX) && !defined(__sgi) && !defined(__Dra=
gonFly__)
+=A0=A0=A0=A0=A0 !defined(_M_UNIX) && !defined(__sgi) && !defined(__Dra=
gonFly__) && \
+=A0=A0=A0=A0=A0 !defined(__TANDEM)
#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD need=
s 600 fo
#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
#endif
+#ifdef __TANDEM /* or HAVE_STRINGS_H ? */
+#include <strings.h> /* for strcasecmp() */
+#endif
#include <errno.h>
#include <limits.h>
#include <sys/param.h>
@@ -141,6 +145,10 @@
#else
#include <stdint.h>
#endif
+#ifdef __TANDEM /* or NO_INTPTR_T resp. NO_UINTPTR_T? */
+typedef int intptr_t;
+typedef unsigned int uintptr_t;
+#endif
#if defined(__CYGWIN__)
#undef _XOPEN_SOURCE
#include <grp.h>

The 1st hunk avoids a =91is already defined with a different value warn=
ing, and I
believe this is the only and right way to fix this, but on the 2nd and =
3rd hunk=20
I=92d need advice on how to properly add those. The #ifdef __TANDEM=85#=
endif=20
works fine for me, but doesn=92t seem 100% clean to me.
In the comment I mention alternatives.

strcasecamp() is declared in <strings.h> as per C99/POSIX, and in C99 m=
ode a prototype has=20
to be seen by the compiler.

intptr_t and uintprt_t seem to be optional in C99 and are not provided =
for NonStop

What do you think?

Bye, Jojo
