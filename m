From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 12:22:36 +0200
Message-ID: <20070906102236.GE8451@artemis.corp>
References: <20070905085720.GD31750@artemis.corp> <11890199232110-git-send-email-madcoder@debian.org> <7vtzq89kky.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="y2zxS2PfCDLh6JVG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 12:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITEVa-000121-1z
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 12:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXIFKWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 06:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXIFKWj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 06:22:39 -0400
Received: from pan.madism.org ([88.191.52.104]:40243 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbXIFKWi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 06:22:38 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 814601E3E3;
	Thu,  6 Sep 2007 12:22:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DEFDC1A3C5; Thu,  6 Sep 2007 12:22:36 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vtzq89kky.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57859>


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 10:03:57AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > diff --git a/strbuf.c b/strbuf.c
> > ...
> > +void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
> > +{
> > +	size_t len;
> > +	va_list ap2;
> > +
> > +	va_copy(ap2, ap);
> > +
> > +	len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
> > +	if (len < 0) {
> > +		len =3D 0;
> > +	}
> > +	if (len >=3D sb->alloc - sb->len) {
> > +		strbuf_grow(sb, len);
> > +		len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap2);
> > +		if (len >=3D sb->alloc - sb->len) {
> > +			len =3D sb->alloc - sb->len - 1;
> > +		}
> > +	}
> > +	sb->len =3D sb->len + len;
> > +	sb->buf[sb->len] =3D '\0';
> >  }
>=20
> Hmmmmm...  Didn't we recently had a patch that used va_copy()
> which was not available somewhere and was shot down?
>=20
> Instead of that nice inline strbuf_addf(), you may have to do
> something like:
>=20
> 	strbuf_addf(..., fmt, ...) {
>                 va_list ap;
>=20
>                 va_start(ap, fmt);
>                 len =3D vsnprintf(...);
>                 va_end(ap);
>                 if (len >=3D sb_avail(sb)) {
>                         strbuf_grow(sb, len);
>                         va_start(ap, fmt);
>                         len =3D vsnprintf(...);
>                         va_end(ap);
>                         if (len >=3D sb_avail(sb))
>                                 gaah();
>                 }
> 		sb->len +=3D len;
>                 sb->buf[sb->len] =3D '\0';
> 	}

  I'll do that.

> > +ssize_t strbuf_read(struct strbuf *sb, int fd)
> > +{
> > +	size_t oldlen =3D sb->len;
> > +
> > +	for (;;) {
> > +		ssize_t cnt;
> > +
> > +		strbuf_grow(sb, 8192);
> > +		cnt =3D xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
> > +		if (cnt < 0) {
> > +			sb->buf[sb->len =3D oldlen] =3D '\0';
>=20
> Assignment inside array subscript is very hard to read.
> Besides, what's the error semantics?  On error, this behaves as
> if no bytes are read (i.e. partial read results in the initial
> round is lost forever)?

  Yes that is the semantics, because it's how it was used everywhere in
git: either we were able to load all the data from the file descriptor,
or weren't able to and the next thing we do is to die().

  Maybe I should call the function strbuf_xread() instead ?
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG39TsvGr7W6HudhwRAnkaAJ9V/KAsrF6owo0plU0X/BUGO+MOCgCgptrl
UZw57bC1RZ08x9pkYUhcfdk=
=C5Wm
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
