From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 7/7] Avoid duplicating memory, and use xmemdupz instead of xstrdup.
Date: Fri, 21 Sep 2007 00:05:06 +0200
Message-ID: <20070920220506.GC17514@artemis.corp>
References: <1190241736-30449-1-git-send-email-madcoder@debian.org> <1190241736-30449-2-git-send-email-madcoder@debian.org> <1190241736-30449-3-git-send-email-madcoder@debian.org> <1190241736-30449-4-git-send-email-madcoder@debian.org> <1190241736-30449-5-git-send-email-madcoder@debian.org> <1190241736-30449-6-git-send-email-madcoder@debian.org> <1190241736-30449-7-git-send-email-madcoder@debian.org> <1190241736-30449-8-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="uXxzq0nDebZQVNAZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 21 00:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYU96-0002dR-8R
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 00:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbXITWFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 18:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbXITWFK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 18:05:10 -0400
Received: from pan.madism.org ([88.191.52.104]:57183 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbXITWFI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 18:05:08 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2AEB120F23;
	Fri, 21 Sep 2007 00:05:07 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AEEB02E456D; Fri, 21 Sep 2007 00:05:06 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1190241736-30449-8-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58814>


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mer, sep 19, 2007 at 10:42:16 +0000, Pierre Habouzit wrote:
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  walker.c |   23 +++++++++--------------
>  1 files changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/walker.c b/walker.c
> index 397b80d..0abdd64 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -213,24 +213,19 @@ int walker_targets_stdin(char ***target, const char=
 ***write_ref)
>  	struct strbuf buf;
>  	*target =3D NULL; *write_ref =3D NULL;
>  	strbuf_init(&buf, 0);
> -	while (1) {
> -		char *rf_one =3D NULL;
> -		char *tg_one;
> -
> -		if (strbuf_getline(&buf, stdin, '\n') =3D=3D EOF)
> -			break;
> -		tg_one =3D buf.buf;
> -		rf_one =3D strchr(tg_one, '\t');
> -		if (rf_one)
> -			*rf_one++ =3D 0;
> +	while (strbuf_getline(&buf, stdin, '\n') !=3D EOF) {
> +		char *rf_one =3D memchr(buf.buf, '\t', buf.len);
> =20
>  		if (targets >=3D targets_alloc) {
> -			targets_alloc =3D targets_alloc ? targets_alloc * 2 : 64;
> -			*target =3D xrealloc(*target, targets_alloc * sizeof(**target));
> +			ALLOC_GROW(target, targets, targets_alloc);
>  			*write_ref =3D xrealloc(*write_ref, targets_alloc * sizeof(**write_re=
f));
>  		}
> -		(*target)[targets] =3D xstrdup(tg_one);
> -		(*write_ref)[targets] =3D rf_one ? xstrdup(rf_one) : NULL;
> +		if (rf_one) {
> +			(*write_ref)[targets] =3D xmemdupz(rf_one, buf.len - (rf_one - buf.bu=
f));
> +		} else {

  As someone pointed to me off-list the above should be:
  +		if (rf_one) {
  +			(*write_ref)[targets] =3D xmemdupz(rf_one + 1, buf.len - (rf_one + 1 =
- buf.buf));
  +		} else {

  Or better:
  +		if (rf_one) {
  +			rf_one++; /* skip \t */
  +			(*write_ref)[targets] =3D xmemdupz(rf_one, buf.buf + buf.len - rf_one=
);
  +		} else {

  Which is definitely more readable.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8u6SvGr7W6HudhwRAnaNAJ41oHHXGLbCsbtE6p1rhSbjIpJhYACeOhDi
VZwqdJMB4NcTYzq5wSat5dw=
=MSMS
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
