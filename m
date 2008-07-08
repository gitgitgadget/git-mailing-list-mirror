From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What should "git branch --merged master" do?
Date: Tue, 08 Jul 2008 12:14:52 +0200
Message-ID: <20080708101452.GB19202@artemis.madism.org>
References: <7v8wwcx446.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="TakKZr9L6Hm6aLOc";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 12:16:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGAFU-0002OU-9r
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 12:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYGHKOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 06:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbYGHKOz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 06:14:55 -0400
Received: from pan.madism.org ([88.191.52.104]:42621 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbYGHKOy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 06:14:54 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 846E3281B9;
	Tue,  8 Jul 2008 12:14:53 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 421A12FBC12; Tue,  8 Jul 2008 12:14:52 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
Content-Disposition: inline
In-Reply-To: <7v8wwcx446.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87741>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2008 at 06:49:13AM +0000, Junio C Hamano wrote:
> e8b404c (git-branch: add support for --merged and --no-merged, 2008-04-17)
> introduced "git branch --merged" to show the branches that are contained
> within the current HEAD.  I.e. the ones that you can say "git branch -d"
> and do not have to say "-D" to delete.
>=20
> Currently "git branch --merged master" fails with a message:
>=20
> 	fatal: A branch named 'master' already exists.
>=20
> but --merged and its opposite --no-merged are in spirit very similar to
> another option --contains in that it is meant to be used as a way to
> influence which branches are _reported_, and not about creating a new
> branch.
>=20
> Perhaps we should change them to default to HEAD (to retain the current
> behaviour) but take a commit, and show branches that are merged to the
> commit or not yet fully merged to the commit, respectively?
>=20
> Incidentally, "git branch --with" fails without the mandatory commit
> argument, and if we are going to do the above, we probably should default
> the argument to HEAD as well.
>=20
> Here is an attempt to update --with but I am not happy with it.
>=20
> The patch makes
>=20
> 	$ git branch --contains
>=20
> work as expected, but breaks
>=20
> 	$ git branch --contains master
>=20
> You need to spell "git branch --contains=3Dmaster" instead.  Which means =
it
> is a regression and cannot be applied.  I suspect I am not using
> parse_options() in an optimal way, but I did not find a way for my
> callback to tell "I consumed the next parameter and it was mine" or "The
> next one is not my optional parameter" back to the parse_options(), so
> probably parse_options() need to be fixed to update this without
> regression, I suspect.

  I actually see three ways.

  (1) quick and dirty: if we see at argv[argc - 1]
      --contains/--merge/--no-merge/... we do:

      argv[argc] =3D "HEAD" and use parse-options with a mandatory
      argument for --merge/--contains/... Okay this leaves the issue of
      the fact that we must NULL-terminate argv, but that's trivial
      (even if quite despisable).

  (2) big update of parse-options: we refactor callbacks so that they
      can decide if they take their argument or not. This removes the
      need for --long-opt=3Dfoo for options with optional arguments, but
      the refactor will be heavy. That's more or less what you suggest
      in your last =C2=A7 but I don't like it for many reasons so I wont
      enter the details.

  (3) inspired from (1) and (2), have a flag for options that says "I do
      take an argument, but if I'm the last option on the command line,
      please fake this argument for me.

  I really like (3) more FWIW as it doesn't generate ambiguous parsers
like (2) would, and it's not horrible like (1). And cherry on top it's
pretty trivial to implement I think.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhzPhwACgkQvGr7W6HudhwSigCglqevnUrZT0m5QN3IIZKKSLMK
VuQAn0NOGmZWAglYWLG1SCUCST4HTf3Z
=f8h0
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
