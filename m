From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Mon, 08 Oct 2007 09:23:12 +0200
Message-ID: <20071008072312.GA22552@artemis.corp>
References: <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <20071007172425.bb691da9.tihirvon@gmail.com> <20071007143912.GB10024@artemis.corp> <87sl4nlyg0.fsf@catnip.gol.com> <857ilylxhm.fsf@lola.goethe.zz> <20071007215432.GC2765@steel.home> <EF81F7DD-73C7-4B6F-92D2-4A143CA05365@wincent.com> <20071007223140.GG2765@steel.home> <87odfapefc.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J2SCkAp4GZ/dPZZf";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	David Kastrup <dak@gnu.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 09:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iemxa-0005UD-3J
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 09:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbXJHHXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 03:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbXJHHXQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 03:23:16 -0400
Received: from pan.madism.org ([88.191.52.104]:34856 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbXJHHXP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 03:23:15 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A238623E4B;
	Mon,  8 Oct 2007 09:23:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B8BC94413; Mon,  8 Oct 2007 09:23:12 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Miles Bader <miles@gnu.org>, Alex Riesen <raa.lkml@gmail.com>,
	Wincent Colaiuta <win@wincent.com>, David Kastrup <dak@gnu.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <87odfapefc.fsf@catnip.gol.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60297>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2007 at 01:45:27AM +0000, Miles Bader wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > int strbuf_cmp2(struct strbuf *a, struct strbuf *b)
> > {
> > 	int len =3D a->len < b->len ? a->len: b->len;
> > 	int cmp =3D memcmp(a->buf, b->buf, len);
> > 	if (cmp)
> > 		return cmp;
> > 	return a->len < b->len ? -1: a->len !=3D b->len;
> > }
>=20
> BTW, why are you making such effort to return only -1, 0, or 1 in the
> last line?  memcmp/strcmp make no such guarantee; e.g. glibc says:
>=20
>      The `strcmp' function compares the string S1 against S2, returning
>      a value that has the same sign as the difference between the first
>      differing pair of characters (interpreted as `unsigned char'
>      objects, then promoted to `int').
>=20
>      If the two strings are equal, `strcmp' returns `0'.
>=20
>      A consequence of the ordering used by `strcmp' is that if S1 is an
>      initial substring of S2, then S1 is considered to be "less than"
>      S2.
>=20
> So I think the last line can just be:
>=20
>    return a->len - b->len;

  Won't work because ->len are size_t and return value is int, so on 64
bits platform, this has chances to overflow.

  FWIW I believe we are doing micro-benchs in a function that is used in
2 places in git right now.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHCdrgvGr7W6HudhwRAqVMAJ9ENWVJFfH4CMc5qoGoCTKYdNlsYQCgipMk
F7SAiCCB9jJTaZFHL2eRox8=
=HNkw
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
