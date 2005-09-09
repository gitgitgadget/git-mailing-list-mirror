From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: patches
Date: Fri, 09 Sep 2005 15:25:22 -0700
Message-ID: <25968.1126304722@lotus.CS.Berkeley.EDU>
References: <1125962642.15293.20.camel@divert>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 00:25:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDrJO-0003Fm-Vf
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 00:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVIIWZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 18:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVIIWZc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 18:25:32 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:53968 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932586AbVIIWZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2005 18:25:31 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id j89MPN6d025991;
	Fri, 9 Sep 2005 15:25:23 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id j89MPNH4025990;
	Fri, 9 Sep 2005 15:25:23 -0700 (PDT)
To: Patrick Mauritz <oxygene@studentenbude.ath.cx>
In-reply-to: <1125962642.15293.20.camel@divert> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8251>

And Patrick Mauritz writes:
 - 
 - --- git-core-0.99.5.orig/convert-cache.c	Wed Aug 17 09:55:00 2005
 - +++ git-core-0.99.5/convert-cache.c	Wed Aug 17 09:58:48 2005
 - @@ -1,4 +1,5 @@
 -  #define _XOPEN_SOURCE /* glibc2 needs this */
 - +#define __EXTENSIONS__ /* solaris needs this */

To be honest, the right place to handle both these 
#defines is the Makefile.  AIX needs its own set of 
-Ds to turn on various standards.  ugh.  I'm sure 
HP-UX needs even more magic, IRIX needs (is?) a dead 
chicken, etc.

 - +#ifndef __sun
[...]
 -  		getdomainname(real_email+len, sizeof(real_email)-len);
[...]
 - +#endif

getdomainname isn't declared, but it is in libnsl
(on Solaris 8, Sparc) and works just fine.  Sun 
documents sysinfo (2) as its replacement, but that 
call is different on different platforms.  I'd be
shocked if getdomainname disappeared from libnsl,
especially since the C++ include files declare it.
Whoops.

 - +ifeq ($(shell uname -s),SunOS)
 - +  LIBS += -lsocket
 - +endif

Traditionally, it's -lsocket -lnsl to cover all the
bases.  Old SunOS4 -> SunOS5 porting annoyance.  That 
also lets getdomainname work.

The Makefile is generally insufficient for any platform
other than Linux with system-supplied support libraries.
Fixing that will take a good deal of work and probably
will involve putting a bunch of variable-defining makefile
fragments somewhere and including the "right" one.  With
the right variable definitions, a user can over-ride any
of them from the make command...

In the meantime, my personal coping method is just to copy
the Makefile to Makefile.platform, edit it, and use make -f 
Makefile.platform.  I could be really cool and just use a 
different git branch per platform, but I'm lazy.

Jason
