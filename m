From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 21:24:20 +0200
Message-ID: <20080623192419.GA13395@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="IS0zKkzwUGydFO0o";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 21:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KArfT-00035O-QO
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 21:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbYFWTYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 15:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbYFWTYb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 15:24:31 -0400
Received: from pan.madism.org ([88.191.52.104]:50526 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433AbYFWTYa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 15:24:30 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4305537ED6;
	Mon, 23 Jun 2008 21:24:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 20FD129FE; Mon, 23 Jun 2008 21:24:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85907>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 04:25:10PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Mon, 23 Jun 2008, Johannes Schindelin wrote:
> >=20
> > Thinking about the recursive approach again, I came up with this POC:
>=20
> "recursive" is pointless.
>=20
> The problem with the current "parse_options()" is not that it's recursive=
=20
> (although that has been claimed multiple times!.
>=20
> The problem with parse_options() is that it's currently impossible to=20
> write something that handles _partial_ cases.
>=20
> Let me explain.
>=20
> Look at cmd_apply() in builtin-apply.c. Notice how it currently absolutel=
y=20
> CANNOT sanely be turned into using "parse_options()", not because it need=
s=20
> any "recursive" handling, but simply because it wants to do *incremental*=
=20
> handling.
>=20
> It should be perfectly possible to change that argument loop from
>=20
> 	for (i =3D 1; i < argc; i++) {
> 		const char *arg =3D argv[i];
> 		if (strcmp(arg, "-")) {
> 			.. handle <stdin> ..
> 			continue;
> 		}
> 		...
>=20
> to doing something like this:
>=20
> 	for (;;) {
> 		const char *arg;
> 		argc =3D parse_options(argc, argv,
> 			options, usage, PARSE_OPT_STOP_AT_UNKNOWN);
> 		if (!argc)
> 			break;
> 		arg =3D argv[1];
> 		argv++;
> 		argc--;
> 		if (strcmp(arg, "-")) {
> 			.. handle <stdin> ..
> 			continue;
> 		}
> 		...=09
>=20
> or whatever. See?

  Indeed, I read the thread many times, and I like the incremental
approach very much, it really makes sense, and we can easily migrate
code this way indeed. In fact that should have been the way
parse_options was designed from the beginning.

  There is a bit of work to do from this "handwaved" solution, because
people care about the filtered argv, so one should rememeber some kind
of "writing" position. SOmething like:


  parse_opt_ctx_t ctx;

  /* will basically copy argc/argv */
  parse_options_start(&ctx, argc, argv);

  for (;;) {
      const char *arg;
      int res =3D parse_options_step(&ctx, options, usage, 0));

      if (res =3D=3D PARSE_OPT_HELP) {
          /* generate help and exit */
      }
      if (res =3D=3D PARSE_OPT_DONE)
          break;

      arg =3D ctx->argv[ctx->pos++];
      if (strcmp(arg, "-")) {
          ... handle <stdin>....
          continue;
      }
  }

  argc =3D parse_options_end(&ctx);

  /* at this point (argc,argv) is almost what parse_options would have
     left us */


  THis way, parse_options can be written:

      parse_opt_ctx_t ctx;
      parse_options_start(&ctx, argc, argv);
      switch (parse_options_step(&ctx, options, usage, 0)) {
	  case PARSE_OPT_HELP: exit....
	  case PARSE_OPT_DONE: break;
	  default: exit(error("unknown option ....");
      }
      return parse_options_end(&ctx);

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhf+GMACgkQvGr7W6HudhzvSwCdH2JQW53hX9WbInzthV/tBuDx
we0Ani6LLchnGUwt2j/zevykmxrgIlBm
=AdlZ
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
