From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] New strbuf APIs: splice and embed.
Date: Sun, 16 Sep 2007 10:10:12 +0200
Message-ID: <20070916081012.GA21810@artemis.corp>
References: <20070915141210.GA27494@artemis.corp> <20070915141335.ECB4B4C152@madism.org> <7vwsur77g7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Nq2Wo0NMKNjxTN9z";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 10:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWpCv-0001F2-NR
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 10:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXIPIKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 04:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbXIPIKR
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 04:10:17 -0400
Received: from pan.madism.org ([88.191.52.104]:60349 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbXIPIKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 04:10:14 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BE5E578B;
	Sun, 16 Sep 2007 10:10:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A97F3D6E5; Sun, 16 Sep 2007 10:10:12 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsur77g7.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58303>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 16, 2007 at 12:57:44AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > * strbuf_splice replace a portion of the buffer with another.
> > * strbuf_embed replace a strbuf buffer with the given one, that should =
be
> >   malloc'ed. Then it enforces strbuf's invariants. If alloc > len, then=
 this
> >   function has negligible cost, else it will perform a realloc, possibly
> >   with a cost.
>=20
> "embed" does not sound quite right, does it?  It is a reverse
> operation of strbuf_detach() as far as I can tell.

  Well I don't like either, and indeed strbuf_attach() seems better.

> > -void strbuf_rtrim(struct strbuf *sb)
> > -{
> > +void strbuf_rtrim(struct strbuf *sb) {
> >  	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
> >  		sb->len--;
> >  	sb->buf[sb->len] =3D '\0';
>=20
> This is changing the style in the wrong direction, isn't it?  We
> start our functions like this:
>=20
> 	type name(proto)
>         {

  Well that's what I usually do for my code, but I thought git was
putting the opening brace on the same line, my bad.

> > +void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
> > +				   const void *data, size_t dlen)
> > +{
> > +	if (pos + len < pos)
> > +		die("you want to splice outside from the buffer");
>=20
> That is a funny error message for an integer wrap-around check.

  right ;)

>=20
> > +	if (pos > sb->len)
> > +		pos =3D sb->len;
>
> Shouldn't this be flagged as a programming error?
>=20
> > +	if (pos + len > sb->len)
> > +		len =3D sb->len - pos;
>=20
> Likewise.

  I just attached the same semantics that was chose for strbuf_insert
when the insertion position is outside from the buffer. Though I can
enforce those to stay inside the buffer and just die(). I don't care
much I shall say. Maybe it hides some programmers being sloppy, hence is
a bad semantics. I'll propose a patch where the check die()s instead of
"fixing" the values.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7OTkvGr7W6HudhwRAi19AKCW08fy3Wp7MPeG9rF2YOTDBUCPbgCbBNMR
V7yoSbdBfkdXzEsJgQZNR60=
=pwM/
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
