From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-opt: bring PARSE_OPT_HIDDEN to git-rev-parse --parseopt
Date: Sun, 02 Mar 2008 09:21:38 +0100
Message-ID: <20080302082138.GB5407@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Fba/0zbH8Xs+Fj9o";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 09:22:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVjSc-0000gA-A8
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 09:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbYCBIVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 03:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYCBIVk
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 03:21:40 -0500
Received: from pan.madism.org ([88.191.52.104]:46762 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbYCBIVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 03:21:39 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 155F83108A;
	Sun,  2 Mar 2008 09:21:39 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 834752BD548; Sun,  2 Mar 2008 09:21:38 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75748>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-rev-parse.txt |   15 ++++++++++-----
 builtin-rev-parse.c             |   25 ++++++++++++++-----------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index f02f6bb..e961c20 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -325,7 +325,7 @@ The lines after the separator describe the options.
 Each line of options has this format:
=20
 ------------
-<opt_spec><arg_spec>? SP+ help LF
+<opt_spec><flags>? SP+ help LF
 ------------
=20
 `<opt_spec>`::
@@ -334,10 +334,15 @@ Each line of options has this format:
 	is necessary. `h,help`, `dry-run` and `f` are all three correct
 	`<opt_spec>`.
=20
-`<arg_spec>`::
-	an `<arg_spec>` tells the option parser if the option has an argument
-	(`=3D`), an optional one (`?` though its use is discouraged) or none
-	(no `<arg_spec>` in that case).
+`<flags>`::
+	`<flags>` are any suite of `*`, `=3D` or `?`.
+	* Use `=3D` if the option take an argument.
+
+	* Use `?` to mean that the option is optional (though its use is discoura=
ged).
+
+	* Use `*` to mean that this option should not be listed in the usage
+	  generated for the `-h` argument. It's shown for `--help-all` as
+	  documented in linkgit:gitcli[5].
=20
 The remainder of the line, after stripping the spaces, is used
 as the help associated to the option.
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 90dbb9d..d1ea73a 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -322,18 +322,21 @@ static int cmd_parseopt(int argc, const char **argv, =
const char *prefix)
 		o->type =3D OPTION_CALLBACK;
 		o->help =3D xstrdup(skipspaces(s));
 		o->value =3D &parsed;
+		o->flags =3D PARSE_OPT_NOARG;
 		o->callback =3D &parseopt_dump;
-		switch (s[-1]) {
-		case '=3D':
-			s--;
-			break;
-		case '?':
-			o->flags =3D PARSE_OPT_OPTARG;
-			s--;
-			break;
-		default:
-			o->flags =3D PARSE_OPT_NOARG;
-			break;
+		while (s > sb.buf && strchr("*=3D?", s[-1])) {
+			switch (*--s) {
+			case '=3D':
+				o->flags &=3D ~PARSE_OPT_NOARG;
+				break;
+			case '?':
+				o->flags &=3D ~PARSE_OPT_NOARG;
+				o->flags |=3D PARSE_OPT_OPTARG;
+				break;
+			case '*':
+				o->flags |=3D PARSE_OPT_HIDDEN;
+				break;
+			}
 		}
=20
 		if (s - sb.buf =3D=3D 1) /* short option only */
--=20
1.5.4.3.343.g6846

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHymOSvGr7W6HudhwRAq0lAJ9Cyzsxh2i/jrBuWFdAacEPDHNGaQCgn9oI
r9DThVlg3ap0ZQsMBrn6Cmw=
=LChF
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
