From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Tue, 04 Sep 2007 13:53:17 +0200
Message-ID: <20070904115317.GA3381@artemis.corp>
References: <buobqcjrycl.fsf@dhapc248.dev.necel.com> <11888956802504-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709041209280.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1yeeQ81UyVL57Vl7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:53:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISWyC-0000az-Jt
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 13:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbXIDLxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 07:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbXIDLxU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 07:53:20 -0400
Received: from pan.madism.org ([88.191.52.104]:47050 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbXIDLxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 07:53:19 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2E2031DDEF;
	Tue,  4 Sep 2007 13:53:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 30D252D426C; Tue,  4 Sep 2007 13:53:17 +0200 (CEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709041209280.28586@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57555>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2007 at 11:11:45AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 4 Sep 2007, Pierre Habouzit wrote:
>=20
> >   A strbuf can be used to store byte arrays, or as an extended string=
=20
> > library. The `buf' member can be passed to any C legacy string function=
,=20
> > because strbuf operations always ensure there is a terminating \0 at th=
e=20
> > end of the buffer, not accounted in the `len' field of the structure.
> >=20
> >   A strbuf can be used to generate a string/buffer whose final size is=
=20
> > not really known, and then "strbuf_detach" can be used to get the built=
=20
> > buffer, and keep the wrapping "strbuf" structure usable for further wor=
k=20
> > again.
> >=20
> >   Other interesting feature: buffer_ensure(sb, size) ensure that there=
=20
> > is enough allocated space in `sb' to put `size' new octets of data in=
=20
> > the buffer. It helps avoiding reallocating data for nothing when the=20
> > problem the strbuf helps to solve has a known typical size.
>=20
> I like the general idea of this!
>=20
> However, some comments are due:
>=20
> - IMHO strbuf_grow() would be more descriptive than buffer_ensure(),

  Yeah, strbuf_ensure (and not buffer_ensure sorry :P) isn't a clever
name. strbuf_grow looks better indeed.

> - IMHO the same goes for strbuf_free() instead of strbuf_wipe(), and

  Well, I don't like strbuf_free, because it's opposed to
strbuf_alloc/new whatever, that would be functions that create and
release a struct strbuf * (meaning allocating the struct shell as well).
Here you only free the internal buffer, not the shell, so _free() would
be a very bad name.

  In my own coding rules, I have _new/_delete and _init/_wipe functions,
the former acts on pointers, the latter on the structs. Hence the
naming. Though, looking at git's code, it seems that the usual name for
this operation is _release. So would you go for strbuf_release ?


> - it would be nice to split this patch into
>=20
> 	- the API change (with _minimal_ changes to anything outside of=20
> 	  strbuf.[ch]), and
>=20
> 	- the cleanups in the rest of the code.

  I'll try to do that, but it's quite hard to achieve knowing that in
many places of the current state of master, there are embeded NUL's
(accounted in ->len). I'll try to see what I can split, but it's
unlikely I'll be able to have an intermediate _working_ state (I mean
that would pass the testsuite) with the new API/semantics _and_ without
touching a lot less of the rest of the code.

  But I really understand that it helps seeing what the new API
improves, whereas right now it may not be that obvious because of the
(not so) many new lines in strbuf.[hc].


  I'll try to roll a new patchset ASAP.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3UctvGr7W6HudhwRAgZMAJ9k0K3BW3Vn22vfuTDgMNPFpBIwsACbBlNm
6e2l98EE1YdceBOluVXJIYw=
=+cx3
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
