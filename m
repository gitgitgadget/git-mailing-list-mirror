From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-options: add PARSE_OPT_FAKELASTARG flag.
Date: Tue, 08 Jul 2008 12:34:08 +0200
Message-ID: <20080708103408.GC19202@artemis.madism.org>
References: <7v8wwcx446.fsf@gitster.siamese.dyndns.org> <20080708101452.GB19202@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="raC6veAxrt5nqIoY";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 12:35:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGAXU-0000pG-Q6
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 12:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbYGHKeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 06:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbYGHKeM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 06:34:12 -0400
Received: from pan.madism.org ([88.191.52.104]:56433 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754453AbYGHKeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 06:34:11 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B761F343A8;
	Tue,  8 Jul 2008 12:34:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B63A02CB85E; Tue,  8 Jul 2008 12:34:08 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
Content-Disposition: inline
In-Reply-To: <20080708101452.GB19202@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87742>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If you set this for a given flag, and the flag appears without a value on
the command line, then the `defval' is used to fake a new argument.

Note that this flag is meaningless in presence of OPTARG or NOARG flags.
(in the current implementation it will be ignored, but don't rely on it).

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    >   (3) inspired from (1) and (2), have a flag for options that says
    >       "I do take an argument, but if I'm the last option on the
    >       command line, please fake this argument for me.
    >
    > I really like (3) more FWIW as it doesn't generate ambiguous
    > parsers like (2) would, and it's not horrible like (1). And cherry
    > on top it's pretty trivial to implement I think.

  And here it is, untested though (in the sense that I didn't test the
  new feature, but git is not broken with the patch).


 parse-options.c |   55 +++++++++++++++++++++++++++------------------------=
----
 parse-options.h |    1 +
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index a90b336..a63485c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -5,17 +5,6 @@
 #define OPT_SHORT 1
 #define OPT_UNSET 2
=20
-static inline const char *get_arg(struct parse_opt_ctx_t *p)
-{
-	if (p->opt) {
-		const char *res =3D p->opt;
-		p->opt =3D NULL;
-		return res;
-	}
-	p->argc--;
-	return *++p->argv;
-}
-
 static int opterror(const struct option *opt, const char *reason, int flag=
s)
 {
 	if (flags & OPT_SHORT)
@@ -25,8 +14,24 @@ static int opterror(const struct option *opt, const char=
 *reason, int flags)
 	return error("option `%s' %s", opt->long_name, reason);
 }
=20
+static inline int get_arg(struct parse_opt_ctx_t *p, const struct option *=
opt,
+			  int flags, const char **arg)
+{
+	if (p->opt) {
+		*arg =3D p->opt;
+		p->opt =3D NULL;
+	} else if (p->argc) {
+		p->argc--;
+		*arg =3D *++p->argv;
+	} else if (opt->flags & PARSE_OPT_FAKELASTARG) {
+		*arg =3D (const char *)opt->defval;
+	} else
+		return opterror(opt, "requires a value", flags);
+	return 0;
+}
+
 static int get_value(struct parse_opt_ctx_t *p,
-                     const struct option *opt, int flags)
+		     const struct option *opt, int flags)
 {
 	const char *s, *arg;
 	const int unset =3D flags & OPT_UNSET;
@@ -52,7 +57,6 @@ static int get_value(struct parse_opt_ctx_t *p,
 		}
 	}
=20
-	arg =3D p->opt ? p->opt : (p->argc > 1 ? p->argv[1] : NULL);
 	switch (opt->type) {
 	case OPTION_BIT:
 		if (unset)
@@ -74,17 +78,12 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
=20
 	case OPTION_STRING:
-		if (unset) {
+		if (unset)
 			*(const char **)opt->value =3D NULL;
-			return 0;
-		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
 			*(const char **)opt->value =3D (const char *)opt->defval;
-			return 0;
-		}
-		if (!arg)
-			return opterror(opt, "requires a value", flags);
-		*(const char **)opt->value =3D get_arg(p);
+		else
+			return get_arg(p, opt, flags, (const char **)opt->value);
 		return 0;
=20
 	case OPTION_CALLBACK:
@@ -94,9 +93,9 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
 		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
 			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
-		if (!arg)
-			return opterror(opt, "requires a value", flags);
-		return (*opt->callback)(opt, get_arg(p), 0) ? (-1) : 0;
+		if (get_arg(p, opt, flags, &arg))
+			return -1;
+		return (*opt->callback)(opt, arg, 0) ? (-1) : 0;
=20
 	case OPTION_INTEGER:
 		if (unset) {
@@ -107,9 +106,9 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value =3D opt->defval;
 			return 0;
 		}
-		if (!arg)
-			return opterror(opt, "requires a value", flags);
-		*(int *)opt->value =3D strtol(get_arg(p), (char **)&s, 10);
+		if (get_arg(p, opt, flags, &arg))
+			return -1;
+		*(int *)opt->value =3D strtol(arg, (char **)&s, 10);
 		if (*s)
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
diff --git a/parse-options.h b/parse-options.h
index c5f0b4b..6e9edd1 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -28,6 +28,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NOARG   =3D 2,
 	PARSE_OPT_NONEG   =3D 4,
 	PARSE_OPT_HIDDEN  =3D 8,
+	PARSE_OPT_FAKELASTARG =3D 16,
 };
=20
 struct option;
--=20
1.5.6.2.398.g3c3f1.dirty

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhzQqAACgkQvGr7W6HudhzPhACeKz1TR8SFQVgwMQ+tdnfdZNv1
50oAoIODlLa0//lCHc/HnzQho7/9Mdgl
=vpNv
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
