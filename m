From: Pierre Habouzit <madcoder@debian.org>
Subject: [FIXED PATCH] git-describe: Add a --match option to limit considered tags.
Date: Fri, 21 Dec 2007 22:49:54 +0100
Message-ID: <20071221214954.GA16481@artemis.madism.org>
References: <1198253900-31502-1-git-send-email-madcoder@debian.org> <7v7ij87x5u.fsf@gitster.siamese.dyndns.org> <20071221212212.GB10318@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="RnlQjJ0d97Da+TV1";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 22:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5pl7-00079u-92
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 22:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbXLUVt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbXLUVt4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 16:49:56 -0500
Received: from pan.madism.org ([88.191.52.104]:43663 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354AbXLUVt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 16:49:56 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1EC3B24933;
	Fri, 21 Dec 2007 22:49:55 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 78F484E50; Fri, 21 Dec 2007 22:49:54 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071221212212.GB10318@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69098>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    On Fri, Dec 21, 2007 at 09:22:12PM +0000, Pierre Habouzit wrote:
    > On Fri, Dec 21, 2007 at 05:52:29PM +0000, Junio C Hamano wrote:
    > > Does it work with "describe --contains" as well?

    Okay, you're right =E2=80=A6 Here is an updated patch.

 Documentation/git-describe.txt |    4 ++++
 builtin-describe.c             |   21 ++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index ac23e28..cb869e9 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -51,6 +51,10 @@ OPTIONS
 	being employed to standard error.  The tag name will still
 	be printed to standard out.
=20
+--match <pattern>::
+        Only consider tags matching the given pattern (can be used to avoid
+        leaking private tags made from the repository).
+
 EXAMPLES
 --------
=20
diff --git a/builtin-describe.c b/builtin-describe.c
index 7a148a2..dd44df9 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -19,6 +19,7 @@ static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
+const char *pattern =3D NULL;
=20
 struct commit_name {
 	int prio; /* annotated tag =3D 2, tag =3D 1, head =3D 0 */
@@ -57,9 +58,11 @@ static int get_name(const char *path, const unsigned cha=
r *sha1, int flag, void
 	 * Otherwise only annotated tags are used.
 	 */
 	if (!prefixcmp(path, "refs/tags/")) {
-		if (object->type =3D=3D OBJ_TAG)
+		if (object->type =3D=3D OBJ_TAG) {
 			prio =3D 2;
-		else
+			if (pattern && fnmatch(pattern, path + 10, 0))
+				prio =3D 0;
+		} else
 			prio =3D 1;
 	}
 	else
@@ -253,7 +256,9 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BOOLEAN(0, "tags",       &tags, "use any tag in .git/refs/tags"),
 		OPT__ABBREV(&abbrev),
 		OPT_INTEGER(0, "candidates", &max_candidates,
-					"consider <n> most recent tags (default: 10)"),
+		            "consider <n> most recent tags (default: 10)"),
+		OPT_STRING(0, "match",       &pattern, "pattern",
+		           "only consider tags matching <pattern>"),
 		OPT_END(),
 	};
=20
@@ -266,12 +271,18 @@ int cmd_describe(int argc, const char **argv, const c=
har *prefix)
 	save_commit_buffer =3D 0;
=20
 	if (contains) {
-		const char **args =3D xmalloc((4 + argc) * sizeof(char*));
+		const char **args =3D xmalloc((5 + argc) * sizeof(char*));
 		int i =3D 0;
 		args[i++] =3D "name-rev";
 		args[i++] =3D "--name-only";
-		if (!all)
+		if (!all) {
 			args[i++] =3D "--tags";
+			if (pattern) {
+				char *s =3D xmalloc(strlen("--refs=3Drefs/tags/") + strlen(pattern) + =
1);
+				sprintf(s, "--refs=3Drefs/tags/%s", pattern);
+				args[i++] =3D s;
+			}
+		}
 		memcpy(args + i, argv, argc * sizeof(char*));
 		args[i + argc] =3D NULL;
 		return cmd_name_rev(i + argc, args, prefix);
--=20
1.5.4.rc1.1097.gd122b-dirty


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHbDUCvGr7W6HudhwRAoKrAKCblnOK2OKIML1HVJdZsb5R8w6MDwCdGn8B
W5XEJjrs5pwU//JyLjIjPcM=
=xTrJ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
