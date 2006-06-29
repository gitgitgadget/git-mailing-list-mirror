From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with
 Git.pm
Date: Thu, 29 Jun 2006 13:04:00 +0400
Message-ID: <20060629130400.c280de67.vsu@altlinux.ru>
References: <20060628183557.GA5713@fiberbit.xs4all.nl>
	<7vr719159v.fsf@assigned-by-dhcp.cox.net>
	<20060628190814.GC5713@fiberbit.xs4all.nl>
	<7vbqsdynvu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__29_Jun_2006_13_04_00_+0400_lwkAFQZKZBV139yC"
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org,
	pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Jun 29 11:04:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvsRe-0007QL-0h
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 11:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWF2JEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 05:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWF2JEH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 05:04:07 -0400
Received: from mivlgu.ru ([81.18.140.87]:59038 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1751856AbWF2JEF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 05:04:05 -0400
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with SMTP
	id D5E62804E; Thu, 29 Jun 2006 13:04:02 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqsdynvu.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22850>

--Signature=_Thu__29_Jun_2006_13_04_00_+0400_lwkAFQZKZBV139yC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jun 2006 14:24:37 -0700 Junio C Hamano wrote:

> Marco Roeland <marco.roeland@xs4all.nl> writes:
>=20
> > Even for Linux someone mentioned that probably i386 is the exception in
> > _not_ needing the -fPIC linkage. It might even be specific to the Perl
> > "xs" implementation specifics?

In general, -fPIC is required when building shared libraries.  On some
systems (e.g., Linux/i386) you can get away without -fPIC, but with a
penalty on memory use and load time: non-PIC code will need relocations,
therefore its pages will no longer be shared between different
processes, and relocations will be performed immediately after loading
the shared library.

> USE_PIC is for pleasing Perly git and nothing else right now.
>=20
> > So I should have added "Works for me (TM)"! ;-)
>=20
> That would have been more explicit way to tell me that this is a
> partial solution and I should solicit help from people on other
> platforms.
>=20
> By the way, I had an impression that compiling things with -fPIC
> when not necessary was generally a bad idea from performance
> point of view.  If that is the case we might want to compile,
> under USE_PIC, everything with -fPIC in a separate area to
> compile and link with Git.xs, without affecting the C-only core
> code.

This is exactly what libtool does (if both static and shared libraries
are compiled, each file is compiled twice - once with -fPIC -DPIC, and
once without these options).

But I suspect that even libtool won't help with Perl anyway, unless we
create a proper libgit.so and then link our Perl extension with it.

> I suspect this would largely depend on the architecture.  I ran
> git-fsck-objects compiled with and without -fPIC (after "make
> clean" to rebuild everything) on a fully packed copy of the
> linux-2.6 repository on my x86_64 box, and did not see
> meaningful differences:
>=20
> : gitster; /usr/bin/time ../git.junio/git-fsck-objects-no-pic --full
> 109.71user 5.01system 1:54.89elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
> 0inputs+0outputs (14major+1834967minor)pagefaults 0swaps
> : gitster; /usr/bin/time ../git.junio/git-fsck-objects-with-pic --full
> 109.05user 4.97system 1:54.08elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
> 0inputs+0outputs (0major+1834981minor)pagefaults 0swaps
> : gitster;

This is because most of time is spent inside SHA-1 and zlib routines,
which are the same in these cases.  Using mozilla-sha1 code might show
some difference.

And the effect of -fPIC on x86_64 is smaller than on i386, because
x86_64 has 2x more registers than i386, therefore loss of one register
is less noticeable.

--Signature=_Thu__29_Jun_2006_13_04_00_+0400_lwkAFQZKZBV139yC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEo5eCW82GfkQfsqIRAtqDAKCDxvJjFn5gnPAk0gq947vHZBSGVACeNPGi
uijZGUEFLxyVdhI2hTVAF7U=
=an94
-----END PGP SIGNATURE-----

--Signature=_Thu__29_Jun_2006_13_04_00_+0400_lwkAFQZKZBV139yC--
