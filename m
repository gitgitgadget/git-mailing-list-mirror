From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git-clean fails to remove a file whose name contains \\, ", or  \n, TAB, etc.
Date: Wed, 9 May 2007 01:11:15 +0200
Message-ID: <20070508231115.GA14900@efreet.light.src>
References: <87ps5bhx8t.fsf@rho.meyering.net> <86k5vj9gzu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed May 09 01:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlYrH-0004xd-AU
	for gcvg-git@gmane.org; Wed, 09 May 2007 01:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032644AbXEHXLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 19:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032641AbXEHXLf
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 19:11:35 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4023 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1032597AbXEHXLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 19:11:34 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.85401;
	Wed, 09 May 2007 01:11:16 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HlYpv-0005nW-R9; Wed, 09 May 2007 01:11:15 +0200
Content-Disposition: inline
In-Reply-To: <86k5vj9gzu.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46633>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2007 at 13:51:01 -0700, Randal L. Schwartz wrote:
> >>>>> "Jim" =3D=3D Jim Meyering <jim@meyering.net> writes:
>=20
> Jim> Not that it matters (or maybe this is a feature :-), because people
> Jim> who create such files in their working directory deserve what they
> Jim> get, Eh? :-)
>=20
> The problem is the newline in the string, since
>=20
>   git-ls-files --others --directory $excl ${excl_info:+"$excl_info"} -- "=
$@" |
>   while read -r file; do
>=20
> is using newline as a delimiter.  Any file with a newline would mess this=
 up.
>=20
> Not being a shell programming expert, is there a way we could use -z and =
xargs
> -0 here instead?

Unfortunately read does not have zero-delimited mode (at all). Unfortunately
the backquote expansion does not preserve whitespace correctly, so it's not
possible to use something like head.

Unfortunately there does not seem to be a way to feed newline to read
(without -r flag), because the rules say that '\<NL>' =3D> '' and
'\<something>' =3D> '<something>'.

Than I can't think of anything other than xargs -0. Unfortunately that is an
external command, which only handles simple commands. So the question becom=
es
how to give it a simple command. Well, there would be two ways:

 - A simple command might be:
	sh -c 'arbitrarily complex command' dummy arguments...
   (the "dummy" will become $0),
   so you can simply put the whole loop in single quotes, use for file; do
   instead of while read -r file; do and be done.

 - Reinvoke the program with special argument meaning it should run the inn=
er
   loop. Ie. add an option --inner-loop option, that would run the
   inner loop and terminate and use xargs -0 "$0" --inner-loop

Both solutions require exporting all the necessary variables.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQQOTRel1vVwhjGURAoGDAJ45VuznzJSssFEWIg6Oorwkv5fqhwCgp2EI
0h6tOBTYg3EgxSs523mj0U4=
=f/kO
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
