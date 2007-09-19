From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 10:47:03 +0200
Message-ID: <20070919084703.GG28205@artemis.corp>
References: <20070918223947.GB4535@artemis.corp> <20070918224122.2B55D344AB3@madism.org> <7v1wcvqcsg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OFj+1YLvsEfSXdCH";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:47:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXvDG-0000ip-Gq
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbXISIrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbXISIrI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:47:08 -0400
Received: from pan.madism.org ([88.191.52.104]:35409 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbXISIrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:47:05 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6A7F320B08;
	Wed, 19 Sep 2007 10:47:04 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id F334C1A3A3; Wed, 19 Sep 2007 10:47:03 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v1wcvqcsg.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58700>


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 08:28:47AM +0000, Junio C Hamano wrote:
> At this point, you have max that is larger by 3 than what old
> code had.  That would make the next two printf() you added as
> expected.  This affects scaling of add/delete code.  Is this
> intentional?  I _think_ the change is correct (there is no
> reason that name display being cliped should affect the length
> of the bar graph), but that should have been documented as a
> separate bugfix in the commit log.

  Indeed, in fact I didn't noticed that difference, I'll document that.

>=20
> > diff --git a/quote.c b/quote.c
> > index 67c6527..a8a755a 100644
> > --- a/quote.c
> > +++ b/quote.c
> > @@ -114,83 +114,142 @@ char *sq_dequote(char *arg)
> >  	}
> >  }
> > =20
> > +/* 1 means: quote as octal
> > + * 0 means: quote as octal if (quote_path_fully)
> > + * -1 means: never quote
> > + * c: quote as "\\c"
> > + */
> > +#define X8(x)   x, x, x, x, x, x, x, x
> > +#define X16(x)  X8(x), X8(x)
> > +static signed char const sq_lookup[256] =3D {
> > +	/*           0    1    2    3    4    5    6    7 */
> > +	/* 0x00 */   1,   1,   1,   1,   1,   1, 'a',   1,
>=20
> Isn't BEL =3D=3D 0x07, not 0x06?

  indeed.

> > +	/* 0x08 */ 'b', 't', 'n', 'v', 'f', 'r',   1,   1,
> > +	/* 0x10 */ X16(1),
> > +	/* 0x20 */  -1,  -1, '"',  -1,  -1,  -1,  -1,  -1,
> > +	/* 0x28 */ X16(-1), X16(-1), X16(-1),
> > +	/* 0x58 */  -1,  -1,  -1,  -1,'\\',  -1,  -1,  -1,
> > +	/* 0x60 */ X16(-1), X16(-1),
>=20
> Shouldn't you quote DEL =3D=3D 0177 here?

  indeed again.

> >  /*
> >   * C-style name quoting.
> >   *
> > - * Does one of three things:
> > - *
> >   * (1) if outbuf and outfp are both NULL, inspect the input name and
> >   *     counts the number of bytes that are needed to hold c_style
> >   *     quoted version of name, counting the double quotes around
> >   *     it but not terminating NUL, and returns it.  However, if name
> >   *     does not need c_style quoting, it returns 0.
> >   *
>=20
> You need to update this comment; you do not have outbuf nor
> outfp anymore, you have something else.

  heh, well outfp is still here, but I'll fix the part about outbuf.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8OIHvGr7W6HudhwRAr4wAJ0Soor9wa6REfkKlY5e0K7Xv27GJgCfRmbd
c7BWgl9ae2YhXrQUP/fHcqQ=
=hprw
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
