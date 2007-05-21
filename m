From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] config: Add --quoted option to produce machine-parsable output
Date: Mon, 21 May 2007 21:54:23 +0200
Message-ID: <20070521195423.GC5082@efreet.light.src>
References: <20070520225953.GK4085@planck.djpig.de> <11797696193384-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon May 21 21:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqDyC-0000J5-Vi
	for gcvg-git@gmane.org; Mon, 21 May 2007 21:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935378AbXEUTyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 15:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765066AbXEUTyl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 15:54:41 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1882 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933980AbXEUTyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 15:54:39 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.483475;
	Mon, 21 May 2007 21:54:23 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HqDxX-0001gb-4R; Mon, 21 May 2007 21:54:23 +0200
Content-Disposition: inline
In-Reply-To: <11797696193384-git-send-email-frank@lichtenheld.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48043>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2007 at 19:46:59 +0200, Frank Lichtenheld wrote:
> This option will enclose key names in quotes (") if they
> contain a subsection and then escape " and \. It will also
> escape line breaks in values. Together this should produce
> an easily parsable output.

That will lead to either eval (which runs perl parser and probably won't win
anything) or regexps (which is not big win over parsing the .ini directly
with them) on the perl side. IMHO only thing that would actually be faster =
is
NUL-separated entries.

Either:
    KEY <NUL> VALUE <NUL>

or:
    KEY <TAB> VALUE <NUL>

I am not sure whether there can be multi-valued entries. If so, than there
are three options:

1. Simply repeated key/value pairs:
   KEY <NUL> VALUE1 <NUL> KEY <NUL> VALUE2 <NUL>.
   KEY <TAB> VALUE1 <NUL> KEY <TAB> VALUE2 <NUL> resp.

2. Key/count/values:
   KEY <NUL> 1 <NUL> VALUE <NUL>
   KEY <NUL> 2 <NUL> VALUE1 <NUL> VALUE2 <NUL>
   (there's probably no benefit for the tab-nul format, because the first
   value must be terminated with NUL)

3. Empty-entry terminated:
   KEY <NUL> VALUE <NUL> <NUL>
   KEY <NUL> VALUE1 <NUL> VALUE2 <NUL> <NUL>
   (again no point in terminating the KEY with tab)

The advantage of such format is, that it can be parsed with:
    local $/ =3D "\0";
    while(<INPUT>) {
	$hash{$_} =3D <INPUT>;
    }
and slight variations for the other variants. It should be similarly easy
=66rom python and C. Shell won't like it, though.

Note: In both bash and zsh, read -d '' line reads NUL-terminated "lines".
However, dash does not have -d option to read :-(.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUfjvRel1vVwhjGURAvKTAJ9JA1r+IxMSmsFeDkfBafzQjFDZRACeOa0S
c8Jo8SZr9H6xI3Nz0ESSJs4=
=nWM7
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
