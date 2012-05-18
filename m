From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: simplify refname handling
Date: Fri, 18 May 2012 11:59:03 -0400
Message-ID: <20120518155903.GA21264@sigill.intra.peff.net>
References: <4FB5DAE5.6020307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri May 18 17:59:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVPaD-0003eG-Vb
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 17:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606Ab2ERP7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 11:59:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48426
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757616Ab2ERP7G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 11:59:06 -0400
Received: (qmail 4003 invoked by uid 107); 18 May 2012 15:59:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 11:59:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 11:59:03 -0400
Content-Disposition: inline
In-Reply-To: <4FB5DAE5.6020307@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197960>

[+cc Carlos, as this is his code]

On Fri, May 18, 2012 at 07:15:17AM +0200, Ren=C3=A9 Scharfe wrote:

> There is no need to build a copy of the relevant part of the string j=
ust
> to make sure we have a NUL-terminated string.  We can simply pass the
> length of the interesting part to dwim_ref() instead.
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  archive.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> diff --git a/archive.c b/archive.c
> index cd083ea..ecc1ff0 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -254,18 +254,11 @@ static void parse_treeish_arg(const char **argv=
,
>  	/* Remotes are only allowed to fetch actual refs */
>  	if (remote) {
>  		char *ref =3D NULL;
> -		const char *refname, *colon =3D NULL;
> -
> -		colon =3D strchr(name, ':');
> -		if (colon)
> -			refname =3D xstrndup(name, colon - name);
> -		else
> -			refname =3D name;
> -
> -		if (!dwim_ref(refname, strlen(refname), sha1, &ref))
> -			die("no such ref: %s", refname);
> -		if (refname !=3D name)
> -			free((void *)refname);
> +		const char *colon =3D strchr(name, ':');
> +		size_t refnamelen =3D colon ? colon - name : strlen(name);
> +
> +		if (!dwim_ref(name, refnamelen, sha1, &ref))
> +			die("no such ref: %.*s", refnamelen, name);
>  		free(ref);

Looks obviously correct to me.

-Peff
