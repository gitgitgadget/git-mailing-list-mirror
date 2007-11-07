From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations  when not needed
Date: Wed, 07 Nov 2007 01:11:12 +0100
Message-ID: <20071107001112.GD4382@artemis.corp>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site> <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org> <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org> <4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OROCMA9jn6tkzFBc";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Nov 07 01:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpYW2-0000UC-Bd
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 01:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbXKGALQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 19:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbXKGALQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 19:11:16 -0500
Received: from pan.madism.org ([88.191.52.104]:56983 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbXKGALP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 19:11:15 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A97C628D11;
	Wed,  7 Nov 2007 01:11:13 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4541235566B; Wed,  7 Nov 2007 01:11:12 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4730F5FA.3030705@lsrfire.ath.cx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63757>


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 11:17:14PM +0000, Ren=C3=A9 Scharfe wrote:
> I haven't seen any comments on strbuf_expand.  Is it too far out?
> Here it is again, adjusted for current master and with the changes
> to strbuf.[ch] coming first:

  I have one.

>  strbuf.c |   22 +++++
>  strbuf.h |    3=20
>  pretty.c |  276 ++++++++++++++++++++++++++++++++++----------------------=
-------
>  3 files changed, 178 insertions(+), 123 deletions(-)
>=20
> diff --git a/strbuf.c b/strbuf.c
> index f4201e1..b71da99 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -129,6 +129,28 @@ void strbuf_addf(struct strbuf *sb, const char *fmt,=
 ...)
>  	strbuf_setlen(sb, sb->len + len);
>  }
> =20
> +void strbuf_expand(struct strbuf *sb, const char *fmt,
> +                   const char **placeholders, expand_fn_t fn, void *cont=
ext)
> +{
> +	char c;
> +	const char **p;
> +
> +	while ((c =3D *fmt++)) {
> +		if (c !=3D '%') {
> +			strbuf_addch(sb, c);
> +			continue;
> +		}

strbuf_addch is pretty inneficient as it puts NULs each time. rather
do that (sketchy) :

{
    for (;;) {
        const char *percent =3D strchr(fmt, '%');
        if (!percent)
            break;
        strbuf_add(sb, fmt, percent - fmt);
        fmt =3D percent + 1;

        /* do your stuff */
    }
    strbuf_addstr(sb, fmt);
}

Of course it's a detail as formats will probably be short. But it's a good
example to show to people wanting to write new strbuf functions.

This nitpicking apart, the timings are impressive.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMQKgvGr7W6HudhwRAnt2AJ9a9IDY2YTbNqKZ45ki+gieB+wZHgCfURre
zokyn008uNjX+X/OwCaRBIE=
=N1tT
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
