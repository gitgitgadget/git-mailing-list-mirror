From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/6] revisions: split the pure option parsing out from  parse_revisions.
Date: Tue, 08 Jul 2008 13:25:32 +0200
Message-ID: <20080708112532.GG19202@artemis.madism.org>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org> <1215510964-16664-2-git-send-email-madcoder@debian.org> <1215510964-16664-3-git-send-email-madcoder@debian.org> <487346A1.4040006@viscovery.net> <20080708110022.GE19202@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="9Iq5ULCa7nGtWwZS";
	protocol="application/pgp-signature"; micalg=SHA1
To: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Tue Jul 08 13:26:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGBL7-0008Fw-JF
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 13:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbYGHLZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 07:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbYGHLZf
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 07:25:35 -0400
Received: from pan.madism.org ([88.191.52.104]:53933 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731AbYGHLZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 07:25:35 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 48749281B9;
	Tue,  8 Jul 2008 13:25:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 426EC2D00DA; Tue,  8 Jul 2008 13:25:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net
Content-Disposition: inline
In-Reply-To: <20080708110022.GE19202@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87750>


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2008 at 11:00:22AM +0000, Pierre Habouzit wrote:
> On Tue, Jul 08, 2008 at 10:51:13AM +0000, Johannes Sixt wrote:
> > Pierre Habouzit schrieb:
> > > +int handle_revision_opt(struct rev_info *revs, int argc, const char =
**argv,
> > > +			int *unkc, const char **unkv)
> > > +{
> > > +	const char *arg =3D argv[0];
> > > +
> > > +	/* pseudo revision arguments */
> > > +	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
> > > +	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
> > > +	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
> > > +	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
> > > +	{
> > > +		unkv[*unkc++] =3D arg;
> >=20
> > +		unkv[(*unkc)++] =3D arg;
>=20
>   Huh right. Good catch, I wonder why the testsuite failed to see that.

  Okay, I know why, there is another bug that was hiding this one,
parse_revisions whas doing argv[left++] =3D arg itself too, which was
fixing this mistake. I've pushed it again, and here is the fixed patch
3/6 for reviewing.

-----------8<-----------
=46rom d0a062617526128c4ec0245614eb9916b7996c38 Mon Sep 17 00:00:00 2001
=46rom: Pierre Habouzit <madcoder@debian.org>
Date: Tue, 8 Jul 2008 11:00:02 +0200
Subject: [PATCH] revisions: split handle_revision_args from parse_revisions.

This new function is meant to only parse non option revision arguments in
a row. IOW it's meant to parse what remains from a parse-opt filtering of
the argument list, with the knowledge of the "--" position (0 means none).

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 revision.c |   97 +++++++++++++++++++++++++++++++++++---------------------=
---
 revision.h |    1 +
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/revision.c b/revision.c
index 99b3cc9..6958725 100644
--- a/revision.c
+++ b/revision.c
@@ -1241,39 +1241,15 @@ int handle_revision_opt(struct rev_info *revs, int =
argc, const char **argv,
 	return 1;
 }
=20
-/*
- * Parse revision information, filling in the "rev_info" structure,
- * and removing the used arguments from the argument list.
- *
- * Returns the number of arguments left that weren't recognized
- * (which are also moved to the head of the argument list)
- */
-int parse_revisions(int argc, const char **argv, struct rev_info *revs)
+int handle_revision_args(struct rev_info *revs,
+			 int argc, const char **argv, int dashdash_pos)
 {
-	int i, flags, seen_dashdash;
-	const char **unrecognized =3D argv + 1;
-	int left =3D 1;
+	int i, left, flags =3D 0;
=20
-	/* First, search for "--" */
-	seen_dashdash =3D 0;
-	for (i =3D 1; i < argc; i++) {
+	for (left =3D i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
-		if (strcmp(arg, "--"))
-			continue;
-		argv[i] =3D NULL;
-		argc =3D i;
-		if (argv[i + 1])
-			revs->prune_data =3D get_pathspec(revs->prefix, argv + i + 1);
-		seen_dashdash =3D 1;
-		break;
-	}
=20
-	flags =3D 0;
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
 		if (*arg =3D=3D '-') {
-			int opts;
-
 			if (!strcmp(arg, "--all")) {
 				handle_refs(revs, flags, for_each_ref);
 				continue;
@@ -1306,23 +1282,22 @@ int parse_revisions(int argc, const char **argv, st=
ruct rev_info *revs)
 				revs->no_walk =3D 0;
 				continue;
 			}
-
-			opts =3D handle_revision_opt(revs, argc - i, argv + i, NULL, NULL);
-			if (opts > 0) {
-				i +=3D opts - 1;
-				continue;
+			if (i =3D=3D dashdash_pos) {
+				argv[i] =3D NULL;
+				argc =3D i;
+				if (argv[i + 1])
+					revs->prune_data =3D get_pathspec(revs->prefix, argv + i + 1);
+				break;
 			}
-			if (opts < 0)
-				exit(128);
-			*unrecognized++ =3D arg;
-			left++;
+
+			argv[left++] =3D arg;
 			continue;
 		}
=20
-		if (handle_revision_arg(arg, revs, flags, seen_dashdash)) {
+		if (handle_revision_arg(arg, revs, flags, dashdash_pos)) {
 			int j;
-			if (seen_dashdash || *arg =3D=3D '^')
-				die("bad revision '%s'", arg);
+			if (dashdash_pos || *arg =3D=3D '^')
+				return error("bad revision '%s'", arg);
=20
 			/* If we didn't have a "--":
 			 * (1) all filenames must exist;
@@ -1338,9 +1313,51 @@ int parse_revisions(int argc, const char **argv, str=
uct rev_info *revs)
 			break;
 		}
 	}
+
 	return left;
 }
=20
+/*
+ * Parse revision information, filling in the "rev_info" structure,
+ * and removing the used arguments from the argument list.
+ *
+ * Returns the number of arguments left that weren't recognized
+ * (which are also moved to the head of the argument list)
+ */
+int parse_revisions(int argc, const char **argv, struct rev_info *revs)
+{
+	int i, left, dashdash_pos =3D 0;
+
+	/* First, filter out revision options and look for "--" */
+	for (left =3D i =3D 1; i < argc; i++) {
+		const char *arg =3D argv[i];
+		int opts;
+
+		if (arg[0] !=3D '-') {
+			argv[left++] =3D arg;
+			continue;
+		}
+
+		if (!strcmp(arg, "--")) {
+			dashdash_pos =3D left;
+			memcpy(argv + left, argv + i, sizeof(*argv) * (argc - i));
+			left +=3D argc - i;
+			break;
+		}
+
+		opts =3D handle_revision_opt(revs, argc - i, argv + i, &left, argv);
+		if (opts > 0) {
+			i +=3D opts - 1;
+			continue;
+		}
+		if (opts < 0)
+			exit(128);
+	}
+	argv[left] =3D NULL;
+
+	return handle_revision_args(revs, left, argv, dashdash_pos);
+}
+
 void setup_revisions(struct rev_info *revs, const char *def)
 {
 	if (revs->def =3D=3D NULL)
diff --git a/revision.h b/revision.h
index 46ab713..c0f5df0 100644
--- a/revision.h
+++ b/revision.h
@@ -125,6 +125,7 @@ extern int parse_revisions(int argc, const char **argv,=
 struct rev_info *revs);
 extern void setup_revisions(struct rev_info *revs, const char *def);
 extern int handle_revision_opt(struct rev_info *revs, int argc, const char=
 **argv,
 			       int *unkc, const char **unkv);
+extern int handle_revision_args(struct rev_info *revs, int argc, const cha=
r **argv, int dashdash_pos);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int =
flags,int cant_be_filename);
=20
 extern int prepare_revision_walk(struct rev_info *revs);
--=20
1.5.6.2.399.g15e15


--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhzTqwACgkQvGr7W6HudhxqUACdF5dG1PSB2PRHl/WF6a3yrdCC
j6QAnRuhs7kbvhlsDAgaKdX36KZXsuGV
=MASy
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
