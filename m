From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: RE: [PATCH] Build on Debian GNU/Hurd
Date: Thu, 21 Sep 2006 18:37:56 +0100
Message-ID: <000001c6dda4$ad0b1ec0$c47eedc1@ramsay1.demon.co.uk>
References: <20060919170335.28054.qmail@14e0e1fe2bc371.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 21 19:41:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQSVC-0008LJ-Fe
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 19:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWIURiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 13:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWIURiS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 13:38:18 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:18707 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751385AbWIURiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 13:38:17 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-34.mail.demon.net with smtp (Exim 4.42)
	id 1GQSV4-0007cd-Et; Thu, 21 Sep 2006 17:38:16 +0000
To: "Gerrit Pape" <pape@smarden.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
In-Reply-To: <20060919170335.28054.qmail@14e0e1fe2bc371.315fe32.mid.smarden.org>
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27499>


On Tues Sept 19, 2006 at 18:04, Gerrit Pape wrote:
> On Fri, Sep 15, 2006 at 10:35:57PM -0700, Junio C Hamano wrote:
> > Gerrit Pape <pape@smarden.org> writes:
> > > Patch from Cyril Brulebois to make the build process detect 
> and support the
> > > Debian GNU/Hurd architecture, see
> > >  http://bugs.debian.org/379841
> > >
> > > Signed-off-by: Gerrit Pape <pape@smarden.org>
> > >
> > > +ifeq ($(uname_S),GNU)
> > > +       # GNU stands for GNU/Hurd
> > > +       NO_STRLCPY = YesPlease
> > > +       ALL_CFLAGS += -DPATH_MAX=4096
> > > +endif
> > 
> > Two questions come to mind. (1) Does GNU stand for GNU/Hurd and
> > nobody else? (2) Does everybody else have PATH_MAX?
> 
> I'm not that familiar with the Hurd, but (1) seems to be so according
> to http://www.gnu.org/software/hurd/hurd.html; it looks like either GNU
> or GNU/Hurd is used.  (2) For IRIX64 PATH_MAX also is defined explicitly
> 
>  git$ grep -B7 -A3 PATH_MAX Makefile 
>  ifeq ($(uname_S),IRIX64)
>          NO_IPV6=YesPlease
>          NO_SETENV=YesPlease
>          NO_STRCASESTR=YesPlease
>          NO_STRLCPY = YesPlease
>          NO_SOCKADDR_STORAGE=YesPlease
>          SHELL_PATH=/usr/gnu/bin/bash
>          ALL_CFLAGS += -DPATH_MAX=1024
>          # for now, build 32-bit version
>          ALL_LDFLAGS += -L/usr/lib32
>  endif
> 
> that's where I got it from.
> 
> > Adding NO_STRLCPY I do not have much problems with, but
> > something like the attached may be cleaner to deal with PATH_MAX;
> > of course now there is an issue of what the appropriate value
> > for that symbol should be.
> 
> It's been so before it seems, I'm not sure why it changed.

Because without the change (below), git would not compile for me ;-)

Indeed it would not compile for any system that:
    1) defines PATH_MAX in limits.h
AND 2) conditionally defines PATH_MAX to a different value.
(Actually, it does not have to be a different value, just a different
token sequence, including the presence/absence of whitespace/comments)

Note that other systems use a different "PATH_MAX value", (a value of
1024 is common), and in particular, earlier version of linux use a
value of 4095.

> http://www.debian.org/ports/hurd/hurd-devel-debian says one cannot
> expect PATH_MAX to be defined on a POSIX system,

Correct. Although PATH_MAX is a POSIX symbol, it is not required to be
defined; it *may* be defined in limits.h and, if so, must have a value
of at least 256.

The symbol _PC_PATH_MAX *may* also be defined and, if so, may be used
in a call to pathconf() to *maybe* determine a "PATH_MAX value" at
runtime; it can return a value, indicate no limit, or an "indeterminate"
limit.

... so defining it
> conditionally IMHO is the right thing.

IMHO, setting the value in the Makefile, for systems that don't define
PATH_MAX, is a much better solution. In fact, that is what I thought was
already being done.

All the best,

Ramsay


> 
>  git$ PAGER=cat git log -p 579d1fb..8e76483
>  commit 8e76483ce0ce256b01345abc4ca97b1f94aed354
>  Author: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
>  Date:   Sun Jul 30 17:00:40 2006 +0100
>  
>      Fix header breakage due to redefining PATH_MAX.
>      
>      The header builtin.h was, incorrectly, redefining PATH_MAX which
>      causes a header order dependency in builtin-write-tree.c.  The fix
>      is to simply include <limits.h> directly to obtain the correct
>      definition of PATH_MAX.
>      
>      Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
>      Signed-off-by: Junio C Hamano <junkio@cox.net>
>  
>  diff --git a/builtin.h b/builtin.h
>  index 1c8637a..88c4d84 100644
>  --- a/builtin.h
>  +++ b/builtin.h
>  @@ -2,10 +2,7 @@ #ifndef BUILTIN_H
>   #define BUILTIN_H
>   
>   #include <stdio.h>
>  -
>  -#ifndef PATH_MAX
>  -# define PATH_MAX 4096
>  -#endif
>  +#include <limits.h>
>   
>   extern const char git_version_string[];
>   
