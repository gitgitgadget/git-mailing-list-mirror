From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Use of strbuf.buf when strbuf.len == 0
Date: Sat, 29 Sep 2007 09:48:13 +0200
Message-ID: <20070929074813.GA3366@artemis.corp>
References: <7vir5wy6fv.fsf@gitster.siamese.dyndns.org> <20070927101300.GD10289@artemis.corp> <alpine.LFD.0.999.0709281746500.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="PEIAKu/WMn1b1Hv9";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 09:48:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbX3o-00081k-7E
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 09:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbXI2HsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 03:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754145AbXI2HsR
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 03:48:17 -0400
Received: from pan.madism.org ([88.191.52.104]:44405 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbXI2HsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 03:48:16 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C40A022509;
	Sat, 29 Sep 2007 09:48:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BD53F34A45A; Sat, 29 Sep 2007 09:48:13 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0709281746500.3579@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59446>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2007 at 12:51:36AM +0000, Linus Torvalds wrote:
>=20
>=20
> On Thu, 27 Sep 2007, Pierre Habouzit wrote:
> >=20
> >   I can see a way, that would need special proof-reading of the strbuf
> > module, but should not harm its users, that would be to change
> > STRBUF_INIT to work this way:
> >=20
> >   { .buf =3D "", .len =3D 0, .alloc =3D 0 }
>=20
> I'd like to pipe up a bit here..
>=20
> I think the above is a good fix for the current problem of wanting to=20
> always be able to use "sb->buf", but I thinkit actually has the potential=
=20
> to fix another issue entirely.
>=20
> Namely strbuf's that are initialized from various static strings and/or=
=20
> strings not directly allocated with malloc().
>=20
> That's not necessarily something really unusual. Wanting to initialize a=
=20
> string with a fixed constant value is a common problem.
>=20
> And wouldn't it be nice if you could actually do that, with
>=20
> 	{ .buf =3D "static initializer", .len =3D 18, .alloc =3D 0 }
>=20
> and have all the strbuf routines that modify the initializer (including=
=20
> making it shorter!) notice that the allocation is too short, and create a=
=20
> new allocation?

  We could probably do that. The places to change to make this work are
seldom:
  * strbuf_grow to emulate a realloc (and copy the buffer into the new
    malloc()ed one),
  * strbuf_release assumes that ->alloc =3D=3D 0 means _init isn't
    necessary, it would be now,
  * strbuf_setlen should not have the assert anymore (though I'm not
    sure this assert still makes sense with the new initializer).
and that's it.

  But we cannot initialize a strbuf with an immediate string because all
the strbuf APIs suppose that the strbuf buffer are writeable (and IMHO
it's pointless to use a strbuf for reading purposes). Other point, I've
made many readings of the code searching for specific patterns of code,
to replace with strbuf's, and I've never seen places (I do not say those
don't exists though) that would directly benefit from that.

> Hmm?

  So I'd say I'll keep the idea in mind, because it's tasteful and could
help, though I'd prefer Junio to review that patch, and then later add
this new semantics if the need arises.

  The sole thing that may be worth investigating would look like:

      char internal_buf[PATH_MAX]; /* should be damn long enough */
      struct strbuf buf;

      strbuf_init_static(&buf, internal_buf, sizeof(internal_buf);

      /* hack with the strbuf API */

      strbuf_release(&buf); /* do release memory, in case we went over
                               PATH_MAX octets */

because it could save some allocations _and_ be safe at the same time.
But I don't really like it, when allocation is critical in git, it's
rarely in functions where there is an obvious size limit for the
problem, and avoiding allocations can be done using static strbufs
(fast-import.c does that in many places).


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/gM9vGr7W6HudhwRAjONAKCqe8gvyDwOBJSU0+v+4piPEdePvQCfdWDA
AF/zN0cGBlOnXuHtj1203+I=
=/cGo
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
