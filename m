From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 3/3] fetch: treat --tags like refs/tags/*:refs/tags/*
 when pruning
Date: Fri, 07 Oct 2011 18:40:01 +0200
Message-ID: <1318005601.4579.7.camel@centaur.lab.cmartin.tk>
References: <20111006205103.GA1271@erythro.kitwarein.com>
	 <1317936107-1230-1-git-send-email-cmn@elego.de>
	 <1317936107-1230-4-git-send-email-cmn@elego.de>
	 <20111007163319.GC4399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Qj4GfGI0DI5cThUPJGHg"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 18:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCDTD-0005bQ-1r
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 18:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965504Ab1JGQkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 12:40:18 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:58004 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965510Ab1JGQkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 12:40:03 -0400
Received: from [192.168.1.17] (brln-4dbc5717.pool.mediaWays.net [77.188.87.23])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id BF15E46103;
	Fri,  7 Oct 2011 18:39:37 +0200 (CEST)
In-Reply-To: <20111007163319.GC4399@sigill.intra.peff.net>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183088>


--=-Qj4GfGI0DI5cThUPJGHg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-10-07 at 12:33 -0400, Jeff King wrote:
> On Thu, Oct 06, 2011 at 11:21:47PM +0200, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index b937d71..94b2bd3 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -699,8 +699,17 @@ static int do_fetch(struct transport *transport,
> >  		free_refs(ref_map);
> >  		return 1;
> >  	}
> > -	if (prune)
> > +	if (prune) {
> > +		/* If --tags was specified, we need to tell prune_refs
> > +		 * that we're filtering the refs from the remote */
> > +		if (tags =3D=3D TAGS_SET) {
> > +			const char * tags_refspec =3D "refs/tags/*:refs/tags/*";
> > +			refs =3D xrealloc(refs, (ref_count + 1) * sizeof(struct refspec));
> > +			refs[ref_count] =3D *parse_fetch_refspec(1, &tags_refspec);
> > +			ref_count++;
> > +		}
> >  		prune_refs(transport, refs, ref_count, ref_map);
> > +	}
>=20
> I don't think we can realloc refs here. It's passed into do_fetch. When
> we realloc it, the old pointer value will be invalid. But when we return
> from do_fetch, the caller (fetch_one) will still have that old value,
> and will call free() on it.

Yes, you're right. I guess it's been working by luck and generous amount
of memory.

>=20
> Instead, you have to make a whole new list, copy the old values in, add
> your new one, and then free the result.

Will do.

   cmn


--=-Qj4GfGI0DI5cThUPJGHg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOjythAAoJEHKRP1jG7ZzTr/EH/2pZIOzP+Q58GhQ3MkzqRAtG
uN2DNoianZjMVSR8Fu/DmI40wjWxwuGnvHnJRpWXfW55JOBlLBxsceGY++eqJI+J
WRX2WGGPwT4MisU7JCAwu+Ryr3lK39JiURObJzyMZLQlYCZWhuQ1FcZmGNjcCE1V
QGYcfvABrwJK4HNgJICgeYLbPmGyu68zSv7bAXZF7Kq6LhtIO9eqvrzJm96M9i7F
j/Ifyz7a9uFfetPGmaCyUADd1fo8ZflBwOhFF/H4bzW5Iz0cOmjtKyMjwLoZjMG5
K2nkfQpIcu7leV/QRfKDqtGSXqxvUskM8AEzdYRrDz8ylAYIHP5MMHilio+ypO0=
=Q8Em
-----END PGP SIGNATURE-----

--=-Qj4GfGI0DI5cThUPJGHg--
