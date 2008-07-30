From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 16:43:39 -0400
Message-ID: <20080730204339.GJ10399@yugib.highrise.ca>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:44:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOIXM-0005OV-CH
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbYG3Unl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbYG3Unk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:43:40 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:40947 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYG3Unk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:43:40 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 499B4111E39;
	Wed, 30 Jul 2008 16:43:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90850>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Boyd Lynn Gerber <gerberb@zenez.com> [080730 16:09]:

> I have just tried this on 4 OpenServer 6.0 machines fresh installed and I 
> do not need this added.  I am trying to figure out what is different on 
> his.  It appears he is using the exact same version of the compiler as 
> well.
> 
> My uname -a gives me this...
> 
> SCO_SV tech0 5 6.0.0 i386
> 
> and the gcc -V gives me the exact same compiler.  So I do not know why he 
> has to have the additional __OPENSERVER__.  This does break my OpenServer 
> 5.0.7 fresh install as well.  So I would not use it.  What I do not 
> understand is why the !defined(__USLC__) does not catch it.  It should.

Sorry, a bit premature on my end...

I tried a "default" gmake, and hit an error right away:
	UX:cc: ERROR: Invalid subargument: -Wall
And immediately pulled my changes from last january into the fix it.  My
changes included a local config.mak CFLAGS override which was the real
fix.

To build with no source changes, I need:
NO_MKDTEMP=1 SNPRINTF_RETURNS_BOGUS=1 CFLAGS=-g NO_POSIX_ONLY_PROGRAMS=1

How about something like this:
	diff --git a/Makefile b/Makefile
	index 798a2f2..c42040f 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -602,6 +602,7 @@ ifeq ($(uname_S),SCO_SV)
		endif
		ifeq ($(uname_R),5)
			CC = cc
	+               CFLAGS = -g
			BASIC_CFLAGS += -Kthread
		endif
		NEEDS_SOCKET = YesPlease
	@@ -615,6 +616,8 @@ ifeq ($(uname_S),SCO_SV)
		BASIC_LDFLAGS += -L/usr/local/lib
		NO_STRCASESTR = YesPlease
		NO_MEMMEM = YesPlease
	+       NO_MKDTEMP = YesPlease
	+       SNPRINTF_RETURNS_BOGUS = YesPlease
		INSTALL = ginstall
		TAR = gtar
	 endif

Unfortunately, I have access to only that one SCO box, so I have no idea
of mkdtemp and sprintf problems are on all SCO, or just R=5 ones.

That allows me to build with NO_POSIX_ONLY_PROGRAMS=1, because for some reason, the
linker complains on linking git-shell:
	Undefined                       first referenced
	symbol                              in file
	hexval_table                        abspath.o
	null_sha1                           abspath.o
	trust_executable_bit                abspath.o
	has_symlinks                        abspath.o
	UX:ld: ERROR: Symbol referencing errors. No output written to git-shell

These are all extern varualbes declared in cache.h, but no defined in
any of the objects git-shell links, normally not a problem, but this is SCO.

-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIkNJ7uVxNPsxNPScRAiqwAKCntO5HZc5gJA3qkLgaQAtTeq1Q1wCfZ37m
tVZs53b5LBNevS3jbc35GQo=
=V0RI
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
