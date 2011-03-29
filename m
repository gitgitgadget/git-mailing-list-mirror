From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Minor cosmetic defect in git-pack-objects output
Date: Tue, 29 Mar 2011 22:48:34 +0200
Message-ID: <20110329224834.62393f3c.ospite@studenti.unina.it>
References: <20110329121040.de22bd56.ospite@studenti.unina.it>
	<4D923D59.3070301@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__29_Mar_2011_22_48_35_+0200_aRUamgh98cf4Gmwu"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:49:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fqU-0007tl-JI
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab1C2Usp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:48:45 -0400
Received: from smtp204.alice.it ([82.57.200.100]:46202 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486Ab1C2Uso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:48:44 -0400
Received: from jcn (87.6.149.121) by smtp204.alice.it (8.5.124.08) (authenticated as fospite@alice.it)
        id 4D7E0F640152C6F2; Tue, 29 Mar 2011 22:48:41 +0200
In-Reply-To: <4D923D59.3070301@lsrfire.ath.cx>
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.24.3; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170319>

--Signature=_Tue__29_Mar_2011_22_48_35_+0200_aRUamgh98cf4Gmwu
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Mar 2011 22:13:13 +0200
Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

> Am 29.03.2011 12:10, schrieb Antonio Ospite:
> > Hi,
> >=20
> > in some cases, on git-pack-objects failure, there is a small defect in
> > the output, see:
> >=20
> > # git gc --aggressive
> > Counting objects: 1954118, done.
> > Delta compression using up to 2 threads.
> > warning: suboptimal pack - out of memory02)
> > Compressing objects: 100% (1936802/1936802), done.
> > Writing objects: 100% (1954118/1954118), done.
> > Total 1954118 (delta 1618716), reused 0 (delta 0)
> >=20
> > The defect is here:
> > warning: suboptimal pack - out of memory02)
> >                                          ^^^
> > the trailing chars are from the replaced line which was ending in
> > 1936802)
> >=20
> > AFAICS this is basically what is happening:
> > #include "git-compat-util.h"
> > fprintf(stderr, "Compressing objects:  15% (296661/1936802)\r");
> >                   warning("suboptimal pack - out of memory");
> >=20
> > I can think to a dumb workaround for this particular path but maybe
> > there are other places when this can happen as well.
>=20
> The following patch should avoid it by clearing the the rest of the
> line after warnings, error messages, usage notes etc. if stderr is a
> terminal.
>

Cool, this is working indeed on the terminal, I don't know if
introducing a CLEARLINE macro would look prettier.

Thanks Ren=E9.

Regards,
   Antonio

> Ren=E9
>=20
> ---
>  usage.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/usage.c b/usage.c
> index b5e67e3..36f1968 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -9,7 +9,7 @@ void vreportf(const char *prefix, const char *err, va_lis=
t params)
>  {
>  	char msg[4096];
>  	vsnprintf(msg, sizeof(msg), err, params);
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +	fprintf(stderr, "%s%s%s\n", prefix, msg, isatty(2) ? "\033[K" : "");
>  }
> =20
>  static NORETURN void usage_builtin(const char *err, va_list params)
>=20
>=20


--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__29_Mar_2011_22_48_35_+0200_aRUamgh98cf4Gmwu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2SRaMACgkQ5xr2akVTsAEiFgCgr3wxCjO1fVxdp5cWRRO1P2Gw
4XYAoIys136hymK0RDfG/U5kvy7zdeqB
=L0QY
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Mar_2011_22_48_35_+0200_aRUamgh98cf4Gmwu--
