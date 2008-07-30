From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 18:56:35 -0400
Message-ID: <20080730225635.GM10399@yugib.highrise.ca>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com> <20080730204339.GJ10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301522140.13032@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 00:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOKc1-0002gi-Sn
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 00:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYG3W4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 18:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbYG3W4j
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 18:56:39 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:42454 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbYG3W4i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 18:56:38 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id F283F111E39;
	Wed, 30 Jul 2008 18:56:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0807301522140.13032@xenau.zenez.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90869>


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Boyd Lynn Gerber <gerberb@zenez.com> [080730 17:28]:
 
> How about doing a fresh 
> 
> working directory.  And just for the fun of it try...

Unfortunately, I can't use configure, apparently that SCO box does'nt
have a new enough toolc change for M4/autoconf/etc...

But I've never had to use configure before, I've always just built with
make (gmake on boxes with borked make)

> tech0 > CC=cc CXX=CC CFLAGS="-Kalloca -Kthread" CPPFLAGS="-Kalloca 
> -Kthread" ./configure
> tech0 > gmake

So, with gmake, that "generally" works.  I still need to add:
	SNPRINTF_RETURNS_BOGUS=1 NO_MKDTEMP=1

> tech0 > CC=cc CXX=CC ./configure 
> tech0 > gmake

And here, until I rid CFLAGS of -Wall, it fails.
  
> > Unfortunately, I have access to only that one SCO box, so I have no idea
> > of mkdtemp and sprintf problems are on all SCO, or just R=5 ones.
> > 
> > That allows me to build with NO_POSIX_ONLY_PROGRAMS=1, because for some reason, the
> > linker complains on linking git-shell:
> > 	Undefined                       first referenced
> > 	symbol                              in file
> > 	hexval_table                        abspath.o
> > 	null_sha1                           abspath.o
> > 	trust_executable_bit                abspath.o
> > 	has_symlinks                        abspath.o
> > 	UX:ld: ERROR: Symbol referencing errors. No output written to git-shell
> > 
> > These are all extern varualbes declared in cache.h, but no defined in
> > any of the objects git-shell links, normally not a problem, but this is SCO.
> 
> I do not see the problem on my systems.

	aidan@jpradley:~/git$ touch abspath.c
	aidan@jpradley:~/git$ gmake V=1 git-shell
	cc -o abspath.o -c -Kalloca  -Kthread -I/usr/local/include -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>' -DSNPRINTF_RETURNS_BOGUS -DNO_STRCASESTR -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM abspath.c
	cc -g -Kalloca  -Kthread -I/usr/local/include -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>' -DSNPRINTF_RETURNS_BOGUS -DNO_STRCASESTR -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM -o git-shell   -L/usr/local/lib abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o compat/lib.a
	Undefined                       first referenced
	symbol                              in file
	hexval_table                        abspath.o
	null_sha1                           abspath.o
	trust_executable_bit                abspath.o
	has_symlinks                        abspath.o
	UX:ld: ERROR: Symbol referencing errors. No output written to git-shell
	gmake: *** [git-shell] Error 1
	aidan@jpradley:~/git$ cat config.mak
	NO_OENSSL=1
	NO_MKDTEMP=1
	SHELL=/bin/bash
	SNPRINTF_RETURNS_BOGUS=1
	CFLAGS=-Kalloca
	CPPFLAGS=-Kalloca

I've found that if I set CFLAGS to -O2, it links properly:
	aidan@jpradley:~/git$ touch abspath.c
	aidan@jpradley:~/git$ gmake V=1 git-shell
	cc -o abspath.o -c -Kalloca -O2  -Kthread -I/usr/local/include -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>' -DSNPRINTF_RETURNS_BOGUS -DNO_STRCASESTR -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM abspath.c
	cc -Kalloca -O2  -Kthread -I/usr/local/include -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>' -DSNPRINTF_RETURNS_BOGUS -DNO_STRCASESTR -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM -o git-shell   -L/usr/local/lib abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o compat/lib.a

So I think it's "not inlining" stuff like:
	static inline unsigned int hexval(unsigned char c)
	{
		return hexval_table[c];
	}
 
So, finally, it pretty much works on SCO out of the box - here's my
settings, which which the test suite passed (well, is passing, I'm at
t5400, but I expect it to all pass again with these settings):

	aidan@jpradley:~/git$ cat config.mak
	NO_TCLTK=1
	NO_MKDTEMP=1
	SHELL=/bin/bash
	SNPRINTF_RETURNS_BOGUS=1
	CFLAGS=-O2

-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIkPGjuVxNPsxNPScRAonyAKCLBfQsJys2zD9G+uJVdtBBHo0tegCeP77h
WSrARRQreL7T0bvqqMZvZhQ=
=dcy/
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--
