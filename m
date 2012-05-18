From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] archive: simplify refname handling
Date: Fri, 18 May 2012 18:44:43 +0200
Message-ID: <1337359483.3083.2.camel@centaur.lab.cmartin.tk>
References: <4FB5DAE5.6020307@lsrfire.ath.cx>
	 <20120518155903.GA21264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 18 18:44:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVQIN-0003Bc-AF
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 18:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911Ab2ERQor convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 12:44:47 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:33010 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529Ab2ERQop (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 12:44:45 -0400
Received: from [192.168.1.3] (brln-4d0c1fd4.pool.mediaWays.net [77.12.31.212])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 416F946057;
	Fri, 18 May 2012 18:44:40 +0200 (CEST)
In-Reply-To: <20120518155903.GA21264@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197961>

On Fri, 2012-05-18 at 11:59 -0400, Jeff King wrote:
> [+cc Carlos, as this is his code]
>=20
> On Fri, May 18, 2012 at 07:15:17AM +0200, Ren=C3=A9 Scharfe wrote:
>=20
> > There is no need to build a copy of the relevant part of the string=
 just
> > to make sure we have a NUL-terminated string.  We can simply pass t=
he
> > length of the interesting part to dwim_ref() instead.
> >=20
> > Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> > ---
> >  archive.c |   17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/archive.c b/archive.c
> > index cd083ea..ecc1ff0 100644
> > --- a/archive.c
> > +++ b/archive.c
> > @@ -254,18 +254,11 @@ static void parse_treeish_arg(const char **ar=
gv,
> >  	/* Remotes are only allowed to fetch actual refs */
> >  	if (remote) {
> >  		char *ref =3D NULL;
> > -		const char *refname, *colon =3D NULL;
> > -
> > -		colon =3D strchr(name, ':');
> > -		if (colon)
> > -			refname =3D xstrndup(name, colon - name);
> > -		else
> > -			refname =3D name;
> > -
> > -		if (!dwim_ref(refname, strlen(refname), sha1, &ref))
> > -			die("no such ref: %s", refname);
> > -		if (refname !=3D name)
> > -			free((void *)refname);
> > +		const char *colon =3D strchr(name, ':');
> > +		size_t refnamelen =3D colon ? colon - name : strlen(name);
> > +
> > +		if (!dwim_ref(name, refnamelen, sha1, &ref))
> > +			die("no such ref: %.*s", refnamelen, name);
> >  		free(ref);
>=20
> Looks obviously correct to me.

Yep, that's clearly a much better way of doing it.

   cmn
