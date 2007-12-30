From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sun, 30 Dec 2007 14:58:20 +0100
Message-ID: <20071230135820.GB25917@artemis.madism.org>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com> <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de> <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com> <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de> <e5bfff550712300502p543680b9jbeb9469a5a970f0@mail.gmail.com> <20071230135557.GA25917@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="IrhDeMKUP4DT/M7F";
	protocol="application/pgp-signature"; micalg=SHA1
To: Marco Costalba <mcostalba@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 14:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8ygi-0003yw-Ox
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 14:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbXL3N6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 08:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbXL3N6W
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 08:58:22 -0500
Received: from pan.madism.org ([88.191.52.104]:44032 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbXL3N6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 08:58:22 -0500
Received: from madism.org (unknown [82.236.23.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1868A2C1E8;
	Sun, 30 Dec 2007 14:58:21 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8BE8BC471; Sun, 30 Dec 2007 14:58:20 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071230135557.GA25917@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69363>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 30, 2007 at 01:55:57PM +0000, Pierre Habouzit wrote:
> On Sun, Dec 30, 2007 at 01:02:28PM +0000, Marco Costalba wrote:
> > Subject: [PATCH] Certain codepaths (notably "git log --pretty=3Dformat.=
=2E.") use
> >=20
> > prefixcmp() extensively, with very short prefixes.  In those cases,
> > calling strlen() is a wasteful operation, so avoid it.
> >=20
> > Initial patch by Johannes Schindelin.
> >=20
> > Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> > ---
> >  git-compat-util.h |   11 ++++++++++-
> >  1 files changed, 10 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 79eb10e..843a8f5 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -398,7 +398,16 @@ static inline int sane_case(int x, int high)
> >=20
> >  static inline int prefixcmp(const char *str, const char *prefix)
> >  {
> > -	return strncmp(str, prefix, strlen(prefix));
> > +	do {
> > +		if (*str !=3D *prefix)
> > +			return *(unsigned const char *)prefix - *(unsigned const char *)str;
> > +
> > +		if (!*(++prefix))
> > +			return 0;
> > +
> > +		str++;
> > +
> > +	} while (1);
>=20
>   This code doesn't work if prefix is "". You want something like:
>=20
>     for (; *prefix; prefix++, str++) {
>         if (*str !=3D *prefix)
>             return *(unsigned const char *)prefix - *(unsigned const char=
 *)str;
>     }
>     return 0;

  Which happens to be basically the same than what Dscho wrote, though I
suppose the compiler can compile that more efficiently than his code.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHd6P8vGr7W6HudhwRAnmzAJ0UAlf5sdzRyiJoPJSYUFNvfKOe4QCgiOhZ
cRDCw9VC+D2kPT5OvPoZpJ4=
=9v1Y
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
