From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 10:06:04 +0100
Message-ID: <20071213090604.GA12398@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="X1bOJ3K7DJ5YkBrT";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 10:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2k1r-0005ra-F7
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 10:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbXLMJGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 04:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbXLMJGL
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 04:06:11 -0500
Received: from pan.madism.org ([88.191.52.104]:34272 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbXLMJGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 04:06:08 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 969182FB58;
	Thu, 13 Dec 2007 10:06:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 062CA56D; Thu, 13 Dec 2007 10:06:04 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071213055226.GA3636@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68133>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2007 at 05:52:26AM +0000, Jeff King wrote:
> Pierre,
>=20
> I am converting shortlog to use parse_options, but I have hit a behavior
> I can't seem to represent.
>=20
> The "-w" option has an optional argument, and we used to accept only
> "-w" or "-wX,Y,Z". However, parse_options allows "-w X,Y,Z".
>=20
> This means that "-w HEAD" used to mean "turn on wrapping
> with default parameters, look at HEAD" and now translates to
> "-w with parameter HEAD".
>=20
> Is there a way to do this currently, or can we add an option flag?

No we can't. And I believe that such a thing is definitely bad practice
:/ So if you really need to, we will have to add some PARSE_OPT_STICKARG
or sth alike that would check that the argument was "sticked" to the
option either with `-wA,B,C` or `--long-opt=3DA,B,C` depending on the fact
that an option is short or long.

Though: `git shortlog -w -- HEAD` will work properly because option
arguments don't take the next token as an argument thing if it starts
with a dash.

Though note that you can't migrate things that use init_revisions and so
on to parseoptions yet, because revisions also have dashed tokens (--not
e.g.) and that the first run of parse_options will just hate it and
fail. Maybe we can do parse_options work in multiple passes though, but
that would require a quite extensive rethought of the module, the
introduction of a parseopt context to be freed after the last pass
(because we will have a lot of small allocation stuff going on). I'll
try to see what I can do in that direction.

For that we must migrate diff and revisions option parser as big macros
(I started[0] it but didn't had the time to complete it yet, and it's
quite a huge task, because there is no incremental upgrade path here,
and there are commands using both diff and revisions options so we must
migrate both at once) and use aggregated parseoptions specifiers.

  [0] http://git.madism.org/?p=3Dgit.git;a=3Dcommitdiff;h=3D059cfb6d4cfbdff=
68d81577d00c9dbce6fed443e

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYPX8vGr7W6HudhwRAr87AJ9GVM28fjgjn1NV6JkVK8nyFbmbtwCfQfN3
1COPSeyC+nvjutyVpUifgPQ=
=1odj
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
