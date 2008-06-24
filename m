From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 21:30:28 +0200
Message-ID: <20080624193028.GC9189@artemis.madism.org>
References: <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <7vzlpbeksn.fsf@gitster.siamese.dyndns.org> <20080624082447.GB24357@artemis.madism.org> <alpine.LFD.1.10.0806241001140.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="5QAgd0e35j3NYeGe";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEEg-0002Bt-Pg
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYFXTab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYFXTab
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:30:31 -0400
Received: from pan.madism.org ([88.191.52.104]:34447 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbYFXTaa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:30:30 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B78A8382E9;
	Tue, 24 Jun 2008 21:30:29 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 72C141D67E; Tue, 24 Jun 2008 21:30:28 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806241001140.2926@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86122>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 05:05:50PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Tue, 24 Jun 2008, Pierre Habouzit wrote:
> >=20
> >   Actually this doesn't work because it may point into the strbuf that
> > will be invalidated later. Our sole option here is to leak some memory I
> > fear.
>=20
> I think leaking memory is ok (it's obviously going to be bounded by the=
=20
> size of the arguments you pass into a program), but I also think you can=
=20
> just change the option strings in place.
>=20
> Yeah, I know - it's impolite, and we even marked things "const char", but=
=20
> "const" in C is just a politeness thing, we can just choose to have a=20
> function with a big comment that changes the string anyway. We'll have to=
=20
> make sure that the few places that actually create argument strings by=20
> hand (ie not from the ones supplied by a real "execve()") not do them so=
=20
> that they need splitting (but no current ones would need to, obviously,=
=20
> since splitting the argumens isn't even supported yet).
>=20
> Or, if people hate that, just leak a few malloc'ed areas. That's arguably=
=20
> the more straightforward way.

  The problem is that we sometimes feed the option parser with hand
crafted const char *[] where strings are indeed in rodata, and well,
changing things is not only impolite, it tends to SIG{BUS,SEGV} ;)

  But I think too that leaking is an option. git rev-parse --parseopt
already leaks in the same ways e.g.

  Though for the win32 port where fork is replaced with threads, well,
it may cause some issues, so I was reluctant wrt them. Of course it's
unlikely that it will cause problems, but one never knows ;)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhhS1QACgkQvGr7W6HudhxtCACfT94h2wZnLFISCUVik3Uk1Yox
fSgAnjI9DgGpmKcdrb59arjiB0f0R/zW
=WFLM
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
