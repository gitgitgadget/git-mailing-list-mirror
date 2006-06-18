From: Florian Forster <octo@verplant.org>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Sun, 18 Jun 2006 10:21:04 +0200
Message-ID: <20060618082103.GA1331@verplant.org>
References: <1150609831500-git-send-email-octo@verplant.org> <20060618110749.e6fb9030.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 10:21:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrsWr-0006Tz-Rr
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWFRIVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWFRIVG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:21:06 -0400
Received: from verplant.org ([213.95.21.52]:40683 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S932160AbWFRIVF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 04:21:05 -0400
Received: from octo by huhu.verplant.org with local (Exim 4.50)
	id 1FrsWm-0002UR-5t; Sun, 18 Jun 2006 10:21:04 +0200
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060618110749.e6fb9030.tihirvon@gmail.com>
X-Pgp-Fingerprint: E7F2 3FEC B693 9F6F 9B77  ACF6 8EF9 1EF5 9152 3C3D
X-Pgp-Public-Key: http://verplant.org/pubkey.txt
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22057>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 18, 2006 at 11:07:49AM +0300, Timo Hirvonen wrote:
> Many of the void-pointer arithmetic warnings could be fixed by
> changing the variable types to char * instead of casting them in many
> places.

true. Casting to a void-pointer can be done implicitely (even according
to the standard), so changing a function's argument from `void *' to
`char *' might break code somewhere else.

> > -			struct {
> > -				struct combine_diff_path p;
> > -				struct combine_diff_parent filler[5];
> > -			} combine;
>=20
> Yes this is somewhat ugly but avoids a malloc.

No, malloc is still needed to allocate `combine.p.path'. My change does
allocate all memory in one pass, so the number of calls to malloc
doesn't differ.

> Leave the code as it is now unless it causes real problems.

`struct combine_diff_path' has a flexible array member (FAM) and is
therefore an incomplete type. This means you may not instanciate it.

GCC ignores the FAM in this case and allocates `sizeof (struct
combine_diff_path)' bytes. However, this is not correct according to
ANSI and prevents building using other compilers (e.g. Sun cc).

To be honest, I don't get the point of FAMs anyways. Why don't we just
use a pointer to `struct combine_diff_parent' there in the first place?

> 'A'...'Z' is more readable.  Does some compiler fail to compile it?

It's not in ANSI, therefore GCC with `-ansi' failes, so does the Sun cc.

> >  static inline int needs_quote(int ch)
>=20
> Hmm.. same function in http-fetch.c.  Lots of common code could be
> moved to http.h.

Right, I wanted to keep the changes as minimal as possible, though.

As you can probably tell my goal is building a Solaris version of git
using the Sun cc. I'm not quite there yet and don't have time to look
into the remaining issue(s) today nor tomorrow, but I might have some
time at the end of the week.

Regards,
-octo
--=20
Florian octo Forster
Hacker in training
GnuPG: 0x91523C3D
http://verplant.org/

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFElQzvjvke9ZFSPD0RAgBoAJ98w4SYbxzsOL6+jI32zz6+65hUagCdHA0r
aQpNy+8WjwKhdJXUvpFZHV8=
=1/Ft
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
