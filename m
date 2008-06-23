From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 00:36:08 +0200
Message-ID: <20080623223608.GN13395@artemis.madism.org>
References: <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org> <7v3an3hke8.fsf@gitster.siamese.dyndns.org> <20080623222404.GM13395@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="U3s59FfKcByyGl+j";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git
X-From: git-owner@vger.kernel.org Tue Jun 24 00:37:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuer-0000BA-7j
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbYFWWgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYFWWgN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:36:13 -0400
Received: from pan.madism.org ([88.191.52.104]:33325 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbYFWWgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 18:36:12 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B226D37E5B;
	Tue, 24 Jun 2008 00:36:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 882291D67E; Tue, 24 Jun 2008 00:36:08 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080623222404.GM13395@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85947>


--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 10:24:05PM +0000, Pierre Habouzit wrote:
> Yeah actually one can use it this way, what I wrote can be used to do
> the very same thing as your _KEEP_UNKNOWN flag, but also more.
> =20
> Though I didn't fixed the fact that parse_options clobbers argv[0],
> which can be easily fixed. The issue with that is that _some_ callers
> use the fact that the filtered argv is NULL terminated. I'm unsure if
> posix says that argv[argc] is readable and NULL at all, if it isn't,
> then changing that would break git for some commands on some OSes other
> than Linux and BSD where AFAICT argv[argc] =3D=3D NULL holds.

Actually one can do it this way without breaking "backward
compatibility" here:

----8<---
=46rom 8955adf557fded857eacc6c03c885a3d6334580f Mon Sep 17 00:00:00 2001
=46rom: Pierre Habouzit <madcoder@debian.org>
Date: Tue, 24 Jun 2008 00:31:31 +0200
Subject: [PATCH] parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.

This way, argv[0] isn't clobbered, to the cost of maybe not having a
resulting NULL terminated argv array.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |    8 +++++---
 parse-options.h |    2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 1ade2ac..c1c5a94 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -246,7 +246,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->argc =3D argc - 1;
 	ctx->argv =3D argv + 1;
-	ctx->out  =3D argv;
+	ctx->out  =3D argv + ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
 	ctx->flags =3D flags;
 	strbuf_init(&ctx->buf, 0);
 }
@@ -329,10 +329,12 @@ unknown_fixup:
=20
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
+	int res =3D ctx->cpidx + ctx->argc;
 	memmove(ctx->out + ctx->cpidx, ctx->argv, ctx->argc * sizeof(*ctx->out));
-	ctx->out[ctx->cpidx + ctx->argc] =3D NULL;
+	if (ctx->out + res < ctx->argv + ctx->argc)
+		ctx->out[res] =3D NULL;
 	strbuf_release(&ctx->buf);
-	return ctx->cpidx + ctx->argc;
+	return res;
 }
=20
 int parse_options(int argc, const char **argv, const struct option *option=
s,
diff --git a/parse-options.h b/parse-options.h
index 14447d5..6745c7d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -22,6 +22,8 @@ enum parse_opt_type {
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH =3D 1,
 	PARSE_OPT_STOP_AT_NON_OPTION =3D 2,
+	/* using that option, the filtered argv may not be NULL terminated */
+	PARSE_OPT_KEEP_ARGV0 =3D 4,
 };
=20
 enum parse_opt_option_flags {
--=20
1.5.6.117.g4959d.dirty
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgJVgACgkQvGr7W6HudhzumgCfanGJoAeFYxtm+ucWODIPNSZi
PmIAn3s8PGiSCyTx06tSoIxZE3bZ0bhP
=i2xF
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--
