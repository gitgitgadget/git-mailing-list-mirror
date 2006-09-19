From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] Build on Debian GNU/Hurd
Date: Tue, 19 Sep 2006 17:03:35 +0000
Message-ID: <20060919170335.28054.qmail@14e0e1fe2bc371.315fe32.mid.smarden.org>
References: <20060915125846.10469.qmail@ccc765dd61a02d.315fe32.mid.smarden.org> <7vr6yce5ky.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 19 19:03:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPj0H-0006jn-0J
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 19:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWISRDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWISRDT
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 13:03:19 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:35819 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1030316AbWISRDS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 13:03:18 -0400
Received: (qmail 28055 invoked by uid 1000); 19 Sep 2006 17:03:35 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6yce5ky.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27278>

On Fri, Sep 15, 2006 at 10:35:57PM -0700, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > Patch from Cyril Brulebois to make the build process detect and support the
> > Debian GNU/Hurd architecture, see
> >  http://bugs.debian.org/379841
> >
> > Signed-off-by: Gerrit Pape <pape@smarden.org>
> >
> > +ifeq ($(uname_S),GNU)
> > +       # GNU stands for GNU/Hurd
> > +       NO_STRLCPY = YesPlease
> > +       ALL_CFLAGS += -DPATH_MAX=4096
> > +endif
> 
> Two questions come to mind. (1) Does GNU stand for GNU/Hurd and
> nobody else? (2) Does everybody else have PATH_MAX?

I'm not that familiar with the Hurd, but (1) seems to be so according
to http://www.gnu.org/software/hurd/hurd.html; it looks like either GNU
or GNU/Hurd is used.  (2) For IRIX64 PATH_MAX also is defined explicitly

 git$ grep -B7 -A3 PATH_MAX Makefile 
 ifeq ($(uname_S),IRIX64)
         NO_IPV6=YesPlease
         NO_SETENV=YesPlease
         NO_STRCASESTR=YesPlease
         NO_STRLCPY = YesPlease
         NO_SOCKADDR_STORAGE=YesPlease
         SHELL_PATH=/usr/gnu/bin/bash
         ALL_CFLAGS += -DPATH_MAX=1024
         # for now, build 32-bit version
         ALL_LDFLAGS += -L/usr/lib32
 endif

that's where I got it from.

> Adding NO_STRLCPY I do not have much problems with, but
> something like the attached may be cleaner to deal with PATH_MAX;
> of course now there is an issue of what the appropriate value
> for that symbol should be.

It's been so before it seems, I'm not sure why it changed.
http://www.debian.org/ports/hurd/hurd-devel-debian says one cannot
expect PATH_MAX to be defined on a POSIX system, so defining it
conditionally IMHO is the right thing.

 git$ PAGER=cat git log -p 579d1fb..8e76483
 commit 8e76483ce0ce256b01345abc4ca97b1f94aed354
 Author: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
 Date:   Sun Jul 30 17:00:40 2006 +0100
 
     Fix header breakage due to redefining PATH_MAX.
     
     The header builtin.h was, incorrectly, redefining PATH_MAX which
     causes a header order dependency in builtin-write-tree.c.  The fix
     is to simply include <limits.h> directly to obtain the correct
     definition of PATH_MAX.
     
     Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
     Signed-off-by: Junio C Hamano <junkio@cox.net>
 
 diff --git a/builtin.h b/builtin.h
 index 1c8637a..88c4d84 100644
 --- a/builtin.h
 +++ b/builtin.h
 @@ -2,10 +2,7 @@ #ifndef BUILTIN_H
  #define BUILTIN_H
  
  #include <stdio.h>
 -
 -#ifndef PATH_MAX
 -# define PATH_MAX 4096
 -#endif
 +#include <limits.h>
  
  extern const char git_version_string[];
  

HTH, Gerrit.
