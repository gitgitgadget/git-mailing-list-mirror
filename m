From: Pierre Habouzit <madcoder@debian.org>
Subject: [REPLACEMENT PATCH] parse-opt: fake short strings for callers to believe in.
Date: Tue, 24 Jun 2008 22:58:01 +0200
Message-ID: <20080624205801.GG9189@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org> <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="L+ofChggJdETEG3Y";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 22:59:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBFbS-0007QW-Dk
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbYFXU6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbYFXU6F
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:58:05 -0400
Received: from pan.madism.org ([88.191.52.104]:46083 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbYFXU6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:58:05 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7E08C3831D;
	Tue, 24 Jun 2008 22:58:02 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2C59446DEEB; Tue, 24 Jun 2008 22:58:01 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Content-Disposition: inline
In-Reply-To: <1214298732-6247-6-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86146>


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If we begin to parse -abc and that the parser knew about -a and -b, it
will fake a -c switch for the caller to deal with.

Of course in the case of -acb (supposing -c is not taking an argument) the
caller will have to be especially clever to do the same thing. We could
think about exposing an API to do so if it's really needed, but oh well...

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  On top of my leaky() mini series, one can on purpose leak some memory
  here, and avoid the strbuf and limitations at once. It means that in my
  current git-blame proof of concept one can drop the strdup(), which
  makes it slightly less disgusting.

 parse-options.c |    9 +++++++++
 parse-options.h |    5 +++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 90935f3..60a11e8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
+#include "cache.h"
=20
 #define OPT_SHORT 1
 #define OPT_UNSET 2
@@ -257,6 +258,9 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
                        const struct option *options,
                        const char * const usagestr[])
 {
+	/* we must reset ->opt, unknown short option leave it dangling */
+	ctx->opt =3D NULL;
+
 	for (; ctx->argc; ctx->argc--, ctx->argv++) {
 		const char *arg =3D ctx->argv[0];
=20
@@ -286,6 +290,11 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 				case -1:
 					return parse_options_usage(usagestr, options);
 				case -2:
+					/* fake a short option thing to hide the fact that we may have
+					 * started to parse aggregated stuff
+					 */
+					ctx->argv[0] =3D leaky(xstrdup(ctx->opt - 1));
+					*(char *)ctx->argv[0] =3D '-';
 					return PARSE_OPT_UNKNOWN;
 				}
 			}
diff --git a/parse-options.h b/parse-options.h
index 9da5e8c..b391bb6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -119,6 +119,11 @@ enum {
 	PARSE_OPT_UNKNOWN,
 };
=20
+/*
+ * It's okay for the caller to consume argv/argc in the usual way.
+ * Other fields of that structure are private to parse-options and should =
not
+ * be modified in any way.
+ */
 struct parse_opt_ctx_t {
 	const char **argv;
 	const char **out;
--=20
1.5.6.120.g3adb8.dirty


--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhhX9kACgkQvGr7W6HudhxzHQCggUpxMVZ1yLeSLzW3Nty+46kA
HbEAnR7ma6FL0DF7X1WnnRxjfCUb0EdD
=m6bX
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
