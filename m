From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Revert removal of multi-match discard heuristic in 27af01
Date: Sun, 25 Sep 2011 19:53:35 +0200
Message-ID: <4E7F6A9F.6050501@lsrfire.ath.cx>
References: <4E7B5F28.2020204@lsrfire.ath.cx> <1316957948-1908-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 19:53:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7stl-0003Ji-Il
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 19:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab1IYRxt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 13:53:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:54827 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1IYRxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 13:53:48 -0400
Received: from [192.168.2.104] (p579BEB9F.dip.t-dialin.net [87.155.235.159])
	by india601.server4you.de (Postfix) with ESMTPSA id C89DC2F8040;
	Sun, 25 Sep 2011 19:53:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <1316957948-1908-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182079>

Am 25.09.2011 15:39, schrieb Tay Ray Chuan:
> From: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
>=20
> 27af01d (xdiff/xprepare: improve O(n*m) performance in
> xdl_cleanup_records(), 2011-08-17) was supposed to be a performance
> boost only. However, it unexpectedly changed the behaviour of diff.
>=20
> Revert a part of 27af01d that removes logic that mark lines as
> "multi-match" (ie. dis[i] =3D=3D 2). This was preventing the multi-ma=
tch
> discard heuristic (performed in xdl_cleanup_records() and
> xdl_clean_mmatch()) from executing.
>=20
> Reported-by: Alexander Pepper <pepper@inf.fu-berlin.de>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
>=20
> ---
>=20
> Junio, this replaces the patch the one in the
> 'rs/diff-cleanup-records-fix' topic in 'pu'. The only difference is i=
n
> the patch message.
>=20
> Ren=C3=A9, will need your SOB on this. Thanks for working to produce =
the
> patch. Please disregard my earlier message [1], further reading has
> shown my previous understanding to be wrong.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

>=20
> [1] <CALUzUxprUFGMR-WVEMOOvYiwkev1cfxHOyBmZq9bKJcHq5E2VA@mail.gmail.c=
om>
> ---
>  xdiff/xprepare.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 05a8f01..4c447ca 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -398,7 +398,7 @@ static int xdl_clean_mmatch(char const *dis, long=
 i, long s, long e) {
>   * might be potentially discarded if they happear in a run of discar=
dable.
>   */
>  static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, =
xdfile_t *xdf2) {
> -	long i, nm, nreff;
> +	long i, nm, nreff, mlim;
>  	xrecord_t **recs;
>  	xdlclass_t *rcrec;
>  	char *dis, *dis1, *dis2;
> @@ -411,16 +411,20 @@ static int xdl_cleanup_records(xdlclassifier_t =
*cf, xdfile_t *xdf1, xdfile_t *xd
>  	dis1 =3D dis;
>  	dis2 =3D dis1 + xdf1->nrec + 1;
> =20
> +	if ((mlim =3D xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
> +		mlim =3D XDL_MAX_EQLIMIT;
>  	for (i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->dstart]; i <=3D=
 xdf1->dend; i++, recs++) {
>  		rcrec =3D cf->rcrecs[(*recs)->ha];
>  		nm =3D rcrec ? rcrec->len2 : 0;
> -		dis1[i] =3D (nm =3D=3D 0) ? 0: 1;
> +		dis1[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D mlim) ? 2: 1;
>  	}
> =20
> +	if ((mlim =3D xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
> +		mlim =3D XDL_MAX_EQLIMIT;
>  	for (i =3D xdf2->dstart, recs =3D &xdf2->recs[xdf2->dstart]; i <=3D=
 xdf2->dend; i++, recs++) {
>  		rcrec =3D cf->rcrecs[(*recs)->ha];
>  		nm =3D rcrec ? rcrec->len1 : 0;
> -		dis2[i] =3D (nm =3D=3D 0) ? 0: 1;
> +		dis2[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D mlim) ? 2: 1;
>  	}
> =20
>  	for (nreff =3D 0, i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->ds=
tart];
