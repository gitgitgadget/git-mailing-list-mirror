From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations  when not needed
Date: Wed, 07 Nov 2007 01:14:58 +0100
Message-ID: <20071107001458.GE4382@artemis.corp>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site> <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org> <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org> <4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx> <20071107001112.GD4382@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="d8Lz2Tf5e5STOWUP";
	protocol="application/pgp-signature"; micalg=SHA1
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 01:15:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpYZg-0001SH-NZ
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 01:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbXKGAPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 19:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754196AbXKGAPA
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 19:15:00 -0500
Received: from pan.madism.org ([88.191.52.104]:56994 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbXKGAO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 19:14:59 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C286E28D35;
	Wed,  7 Nov 2007 01:14:58 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6DF15352263; Wed,  7 Nov 2007 01:14:58 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071107001112.GD4382@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63758>


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2007 at 12:11:12AM +0000, Pierre Habouzit wrote:
> On Tue, Nov 06, 2007 at 11:17:14PM +0000, Ren=C3=A9 Scharfe wrote:
> > I haven't seen any comments on strbuf_expand.  Is it too far out?
> > Here it is again, adjusted for current master and with the changes
> > to strbuf.[ch] coming first:
>=20
>   I have one.
>=20
> >  strbuf.c |   22 +++++
> >  strbuf.h |    3=20
> >  pretty.c |  276 ++++++++++++++++++++++++++++++++++--------------------=
---------
> >  3 files changed, 178 insertions(+), 123 deletions(-)
> >=20
> > diff --git a/strbuf.c b/strbuf.c
> > index f4201e1..b71da99 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -129,6 +129,28 @@ void strbuf_addf(struct strbuf *sb, const char *fm=
t, ...)
> >  	strbuf_setlen(sb, sb->len + len);
> >  }
> > =20
> > +void strbuf_expand(struct strbuf *sb, const char *fmt,
> > +                   const char **placeholders, expand_fn_t fn, void *co=
ntext)
> > +{
> > +	char c;
> > +	const char **p;
> > +
> > +	while ((c =3D *fmt++)) {
> > +		if (c !=3D '%') {
> > +			strbuf_addch(sb, c);
> > +			continue;
> > +		}
>=20
> strbuf_addch is pretty inneficient as it puts NULs each time. rather
> do that (sketchy) :
>=20
> {
>     for (;;) {
>         const char *percent =3D strchr(fmt, '%');
>         if (!percent)
>             break;
>         strbuf_add(sb, fmt, percent - fmt);
>         fmt =3D percent + 1;
>=20
>         /* do your stuff */
>     }
>     strbuf_addstr(sb, fmt);
> }


Or if we are at this level of micro-optimization:

{
    const char *percent =3D strchrnul(fmt, '%');
    while (*percent) {
        strbuf_add(sb, fmt, percent - fmt);
        fmt =3D percent + 1;

        /* do your stuff */

        percent =3D strchrnul(fmt, '%');
    }
    strbuf_add(sb, fmt, percent - fmt);
}


Which would require strchrnul, but it's trivial compat/ material for sure.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMQOCvGr7W6HudhwRAtc4AJ95JFmBLIOokUe8XvPajkYaTrnBUACdGSIQ
SWkESm+carb1MKbNbWA5NiI=
=yhJI
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
