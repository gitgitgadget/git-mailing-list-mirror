From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 6/7] parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
Date: Tue, 24 Jun 2008 22:55:46 +0200
Message-ID: <20080624205546.GF9189@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org> <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org> <1214298732-6247-7-git-send-email-madcoder@debian.org> <alpine.LFD.1.10.0806241015390.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rWhLK7VZz0iBluhq";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBFZF-0006ie-Uj
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbYFXUzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbYFXUzu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:55:50 -0400
Received: from pan.madism.org ([88.191.52.104]:46073 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbYFXUzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:55:49 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AF4D13831D;
	Tue, 24 Jun 2008 22:55:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2BABF46DEE2; Tue, 24 Jun 2008 22:55:46 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806241015390.2926@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86144>


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 05:18:56PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Tue, 24 Jun 2008, Pierre Habouzit wrote:
> >
> > This way, argv[0] isn't clobbered, to the cost of maybe not having a
> > resulting NULL terminated argv array.
>=20
> Umm. I think it's much easier to do by always having
>=20
> 	ctx->out  =3D argv;
>=20
> and then just initializing cpix to 0 or 1:
>=20
> 	ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
>=20
> because now parse_options_end() doesn't need to play games any more. It=
=20
> doesn't need to care about PARSE_OPT_KEEP_ARGV0, it can just do exactly=
=20
> what it always used to do, because "ctx->cpidx + ctx->argc" automatically=
=20
> does the right thing (it is both the return value _and_ the index that yo=
u=20
> should fill with NULL.

It indeed is now a trivial patch:

-----8<-----

Subject: [PATCH] parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.

This way, argv[0] isn't clobbered.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |    1 +
 parse-options.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 60a11e8..51a44e3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -248,6 +248,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->argc =3D argc - 1;
 	ctx->argv =3D argv + 1;
 	ctx->out  =3D argv;
+	ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
 	ctx->flags =3D flags;
 }
=20
diff --git a/parse-options.h b/parse-options.h
index b391bb6..6299632 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -20,6 +20,7 @@ enum parse_opt_type {
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH =3D 1,
 	PARSE_OPT_STOP_AT_NON_OPTION =3D 2,
+	PARSE_OPT_KEEP_ARGV0 =3D 4,
 };
=20
 enum parse_opt_option_flags {
--=20
1.5.6.120.g3adb8.dirty


--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhhX1IACgkQvGr7W6HudhwHlACffaGRC3j0Xdld1ZxrbmyKEyBi
5sUAnioV0Q8+KaBxNZcohItjNwIFP2tv
=P9mm
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
