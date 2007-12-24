From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [FIXED PATCH] git-describe: Add a --match option to limit considered tags.
Date: Mon, 24 Dec 2007 12:18:22 +0100
Message-ID: <20071224111822.GA10356@artemis.madism.org>
References: <1198253900-31502-1-git-send-email-madcoder@debian.org> <7v7ij87x5u.fsf@gitster.siamese.dyndns.org> <20071221212212.GB10318@artemis.madism.org> <20071221214954.GA16481@artemis.madism.org> <20071222180244.GD23262@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="HlL+5n6rz5pIUxbD";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 24 12:19:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6lKq-0007mn-0O
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 12:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbXLXLSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 06:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbXLXLSc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 06:18:32 -0500
Received: from pan.madism.org ([88.191.52.104]:44271 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbXLXLSa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 06:18:30 -0500
Received: from madism.org (unknown [62.147.220.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 32CAE2B3FF
	for <git@vger.kernel.org>; Mon, 24 Dec 2007 12:18:28 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 39A9EFF9E; Mon, 24 Dec 2007 12:18:22 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071222180244.GD23262@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69212>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rework get_rev_name to return NULL rather than "undefined" when a reference
is undefined. If --undefined is passed (default) git-name-rev prints
"undefined" for the name, else it die()s.

Make git-describe use --no-undefined when calling git-name-rev so that
--contains behavior matches the standard git-describe one.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    On sam, d=C3=A9c 22, 2007 at 06:02:44 +0000, Pierre Habouzit wrote:
    >   Like I said on IRC, I saw that git describe --contains has a bad
    > behaviour:
    >=20
    >     $ git describe --match=3D'asd*' HEAD; echo $?
    >     fatal: cannot describe 'e272415ab7da3bde51af2ce95c88d7be3abfba28'
    >     128
    >     $ git describe --contains HEAD; echo $?
    >     undefined
    >     0

    Okay here is a patch to have git-name-rev have a strict mode where
    it rejects undefined's.  With this patch:

    $ git describe --contains HEAD
    fatal: cannot describe 'e26a806b93f2f2f2354831ce0f943347a8ba7c3e'

    This patch is minimal and looks safe for master to me. A better patch
    would probably to have shared some logic between name-rev and
    describe, but this would have been a quite larger patch, and I was
    uncomfortable with it.


 builtin-describe.c |    3 ++-
 builtin-name-rev.c |   34 ++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 18eab47..3428483 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -271,10 +271,11 @@ int cmd_describe(int argc, const char **argv, const c=
har *prefix)
 	save_commit_buffer =3D 0;
=20
 	if (contains) {
-		const char **args =3D xmalloc((5 + argc) * sizeof(char*));
+		const char **args =3D xmalloc((6 + argc) * sizeof(char*));
 		int i =3D 0;
 		args[i++] =3D "name-rev";
 		args[i++] =3D "--name-only";
+		args[i++] =3D "--no-undefined";
 		if (!all) {
 			args[i++] =3D "--tags";
 			if (pattern) {
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index a0c89a8..f22c8b5 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -125,18 +125,18 @@ static int name_ref(const char *path, const unsigned =
char *sha1, int flags, void
 }
=20
 /* returns a static buffer */
-static const char* get_rev_name(struct object *o)
+static const char *get_rev_name(struct object *o)
 {
 	static char buffer[1024];
 	struct rev_name *n;
 	struct commit *c;
=20
 	if (o->type !=3D OBJ_COMMIT)
-		return "undefined";
+		return NULL;
 	c =3D (struct commit *) o;
 	n =3D c->util;
 	if (!n)
-		return "undefined";
+		return NULL;
=20
 	if (!n->generation)
 		return n->tip_name;
@@ -159,7 +159,7 @@ static char const * const name_rev_usage[] =3D {
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs =3D { 0, 0, NULL };
-	int all =3D 0, transform_stdin =3D 0;
+	int all =3D 0, transform_stdin =3D 0, allow_undefined =3D 1;
 	struct name_ref_data data =3D { 0, 0, NULL };
 	struct option opts[] =3D {
 		OPT_BOOLEAN(0, "name-only", &data.name_only, "print only names (no SHA-1=
)"),
@@ -169,6 +169,7 @@ int cmd_name_rev(int argc, const char **argv, const cha=
r *prefix)
 		OPT_GROUP(""),
 		OPT_BOOLEAN(0, "all", &all, "list all commits reachable from all refs"),
 		OPT_BOOLEAN(0, "stdin", &transform_stdin, "read from stdin"),
+		OPT_BOOLEAN(0, "undefined", &allow_undefined, "allow to print `undefined=
` names"),
 		OPT_END(),
 	};
=20
@@ -226,7 +227,7 @@ int cmd_name_rev(int argc, const char **argv, const cha=
r *prefix)
 				else if (++forty =3D=3D 40 &&
 						!ishex(*(p+1))) {
 					unsigned char sha1[40];
-					const char *name =3D "undefined";
+					const char *name =3D NULL;
 					char c =3D *(p+1);
=20
 					forty =3D 0;
@@ -240,11 +241,10 @@ int cmd_name_rev(int argc, const char **argv, const c=
har *prefix)
 					}
 					*(p+1) =3D c;
=20
-					if (!strcmp(name, "undefined"))
+					if (!name)
 						continue;
=20
-					fwrite(p_start, p - p_start + 1, 1,
-					       stdout);
+					fwrite(p_start, p - p_start + 1, 1, stdout);
 					printf(" (%s)", name);
 					p_start =3D p + 1;
 				}
@@ -260,18 +260,32 @@ int cmd_name_rev(int argc, const char **argv, const c=
har *prefix)
 		max =3D get_max_object_index();
 		for (i =3D 0; i < max; i++) {
 			struct object * obj =3D get_indexed_object(i);
+			const char *name;
 			if (!obj)
 				continue;
 			if (!data.name_only)
 				printf("%s ", sha1_to_hex(obj->sha1));
-			printf("%s\n", get_rev_name(obj));
+			name =3D get_rev_name(obj);
+			if (name)
+				printf("%s\n", name);
+			else if (allow_undefined)
+				printf("undefined\n");
+			else
+				die("cannot describe '%s'", sha1_to_hex(obj->sha1));
 		}
 	} else {
 		int i;
 		for (i =3D 0; i < revs.nr; i++) {
+			const char *name;
 			if (!data.name_only)
 				printf("%s ", revs.objects[i].name);
-			printf("%s\n", get_rev_name(revs.objects[i].item));
+			name =3D get_rev_name(revs.objects[i].item);
+			if (name)
+				printf("%s\n", name);
+			else if (allow_undefined)
+				printf("undefined\n");
+			else
+				die("cannot describe '%s'", sha1_to_hex(revs.objects[i].item->sha1));
 		}
 	}
=20
--=20
1.5.4.rc1.1123.ge26a8

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHb5V+vGr7W6HudhwRAu9jAJ92ha8DwkK1RfVpLtL71ii6+auHJwCfZ7Ck
TkK/uBldY+2pol7ONCwYhFI=
=2PPa
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
