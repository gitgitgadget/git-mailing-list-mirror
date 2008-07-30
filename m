From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 15:28:35 -0600
Message-ID: <alpine.LNX.1.10.0807301522140.13032@xenau.zenez.com>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com> <20080730204339.GJ10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:29:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJEo-0005H0-EB
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbYG3V2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbYG3V2h
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:28:37 -0400
Received: from zenez.com ([166.70.62.2]:7803 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbYG3V2g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 17:28:36 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 4C0803F973; Wed, 30 Jul 2008 15:28:35 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 382243F972;
	Wed, 30 Jul 2008 15:28:35 -0600 (MDT)
In-Reply-To: <20080730204339.GJ10399@yugib.highrise.ca>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90858>

On Wed, 30 Jul 2008, Aidan Van Dyk wrote:
> * Boyd Lynn Gerber <gerberb@zenez.com> [080730 16:09]:
> > I have just tried this on 4 OpenServer 6.0 machines fresh installed and I 
> > do not need this added.  I am trying to figure out what is different on 
> > his.  It appears he is using the exact same version of the compiler as 
> > well.
> > 
> > My uname -a gives me this...
> > 
> > SCO_SV tech0 5 6.0.0 i386
> > 
> > and the gcc -V gives me the exact same compiler.  So I do not know why he 
> > has to have the additional __OPENSERVER__.  This does break my OpenServer 
> > 5.0.7 fresh install as well.  So I would not use it.  What I do not 
> > understand is why the !defined(__USLC__) does not catch it.  It should.
> 
> Sorry, a bit premature on my end...
> 
> I tried a "default" gmake, and hit an error right away:
> 	UX:cc: ERROR: Invalid subargument: -Wall
> And immediately pulled my changes from last january into the fix it.  My
> changes included a local config.mak CFLAGS override which was the real
> fix.
> 
> To build with no source changes, I need:
> NO_MKDTEMP=1 SNPRINTF_RETURNS_BOGUS=1 CFLAGS=-g NO_POSIX_ONLY_PROGRAMS=1

How about doing a fresh 

working directory.  And just for the fun of it try...

This

tech0 > CC=cc CXX=CC CFLAGS="-Kalloca -Kthread" CPPFLAGS="-Kalloca 
-Kthread" ./configure
tech0 > gmake

and

tech0 > CC=cc CXX=CC ./configure 
tech0 > gmake

worked without any issues for me.
 
> How about something like this:
> 	diff --git a/Makefile b/Makefile
> 	index 798a2f2..c42040f 100644
> 	--- a/Makefile
> 	+++ b/Makefile
> 	@@ -602,6 +602,7 @@ ifeq ($(uname_S),SCO_SV)
> 		endif
> 		ifeq ($(uname_R),5)
> 			CC = cc
> 	+               CFLAGS = -g
> 			BASIC_CFLAGS += -Kthread
> 		endif
> 		NEEDS_SOCKET = YesPlease
> 	@@ -615,6 +616,8 @@ ifeq ($(uname_S),SCO_SV)
> 		BASIC_LDFLAGS += -L/usr/local/lib
> 		NO_STRCASESTR = YesPlease
> 		NO_MEMMEM = YesPlease
> 	+       NO_MKDTEMP = YesPlease
> 	+       SNPRINTF_RETURNS_BOGUS = YesPlease
> 		INSTALL = ginstall
> 		TAR = gtar
> 	 endif

The above does work on OpenServer 6, UnixWare 7.1.4 and OpenServer 5.0.7
 
> Unfortunately, I have access to only that one SCO box, so I have no idea
> of mkdtemp and sprintf problems are on all SCO, or just R=5 ones.
> 
> That allows me to build with NO_POSIX_ONLY_PROGRAMS=1, because for some reason, the
> linker complains on linking git-shell:
> 	Undefined                       first referenced
> 	symbol                              in file
> 	hexval_table                        abspath.o
> 	null_sha1                           abspath.o
> 	trust_executable_bit                abspath.o
> 	has_symlinks                        abspath.o
> 	UX:ld: ERROR: Symbol referencing errors. No output written to git-shell
> 
> These are all extern varualbes declared in cache.h, but no defined in
> any of the objects git-shell links, normally not a problem, but this is SCO.

I do not see the problem on my systems.


--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
