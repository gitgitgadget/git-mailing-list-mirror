From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
Date: Tue, 4 Sep 2012 13:49:16 +0200
Message-ID: <002701cd8a93$50773e30$f165ba90$@schmitz-digital.de>
References: <004001cd81f9$21e68e10$65b3aa30$@schmitz-digital.de> <7vsjbc1dg1.fsf@alter.siamese.dyndns.org> <005401cd822a$67687a30$36396e90$@schmitz-digital.de> <7vboi0yswz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Erik Faye-Lund'" <kusmabite@gmail.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:49:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8rdS-0004f3-0q
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 13:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861Ab2IDLt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 07:49:28 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:63896 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773Ab2IDLt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 07:49:26 -0400
Received: from DualCore (dsdf-4d0a1636.pool.mediaWays.net [77.10.22.54])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0Lx0hB-1TfM651yXJ-016iKG; Tue, 04 Sep 2012 13:49:20 +0200
In-Reply-To: <7vboi0yswz.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQD+UJbyfpuh0NvtD/0Nf09ZKJpnFgHbe408Ab1TybwB2sw8/Zjs19TA
Content-Language: de
X-Provags-ID: V02:K0:RNivVwURXgslBXX0y0cxkM1iKOzZO7MkOX2i8QxhXR0
 qxFHYV5TQpeQTTYbBbWPjc2eb8+NSccMYeXkbfNelFItaKpGs5
 y0L97LBMhwaVda4HhmQFmOfxQltIvMdYTl61r0UXYnnb9EKQaJ
 NWiMxeH1Yt8ylUzGQmU9lPJNfpu9P2e1t5EqnleyiGMA43/SxR
 pK+DMB1+m0/eOpPOqBEGDmW7GZ0cegd9lcVVG0TkxxoAlViXOQ
 t5Ppm05syq7YRQ87ef811rulTCWwOqpsQbabrt59Arhy/YItE4
 ReWLN7F4SBmVclSAUxUrfSIC7DC4XFfUXZs2sjTlckmwpc5GNy
 qZa4OPCDBi/wjXjODIDT4FPVelVGf5FRKnOPqBfY7cMWph7Ti6
 oSgRWqnRx/FEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204738>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, August 24, 2012 9:47 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; 'Erik Faye-Lund'
> Subject: Re: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Different, but related question: would poll.[ch] be allowed to #include "git-compat-util.h"?
> 
> Seeing other existing generic wrappers directly under compat/,
> e.g. fopen.c, mkdtemp.c, doing so, I would say why not.
> 
> Windows folks (I see Erik is already CC'ed, which is good ;-),
> please work with Joachim to make sure such a move won't break your
> builds.  I believe that it should just be the matter of updating a
> couple of paths in the top-level Makefile.

Haven't heard anything from the Windows folks yet.

I'd prefer to move compat/win32/poll.[ch] into compat/poll.
Then adjust a few paths in Makefile and that would be the 1st patch

A 2nd patch would be my already proposed ones that make this usable for others (me in this case ;-)), namely wrapping 2 #inludes.

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 403eaa7..49541f1 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -24,7 +24,9 @@
 # pragma GCC diagnostic ignored "-Wtype-limits"
 #endif

-#include <malloc.h>
+#if defined(WIN32)
+# include <malloc.h>
+#endif

 #include <sys/types.h>

@@ -48,7 +50,9 @@
 #else
 # include <sys/time.h>
 # include <sys/socket.h>
-# include <sys/select.h>
+# ifndef NO_SYS_SELECT_H
+#  include <sys/select.h>
+# endif
 # include <unistd.h>
 #endif

--
1.7.12
