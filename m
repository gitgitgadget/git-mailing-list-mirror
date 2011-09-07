From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] for-each-ref: add split message parts to %(contents:*).
Date: Wed, 7 Sep 2011 13:46:08 -0400
Message-ID: <20110907174608.GE11355@sigill.intra.peff.net>
References: <20110902175323.GA29761@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:46:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1MCX-00037v-NM
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab1IGRqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 13:46:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37347
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698Ab1IGRqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:46:10 -0400
Received: (qmail 4044 invoked by uid 107); 7 Sep 2011 17:46:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 13:46:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 13:46:08 -0400
Content-Disposition: inline
In-Reply-To: <20110902175323.GA29761@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180889>

=46rom: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>

The %(body) placeholder returns the whole body of a tag or
commit, including the signature. However, callers may want
to get just the body without signature, or just the
signature.

Rather than change the meaning of %(body), which might break
some scripts, this patch introduces a new set of
placeholders which break down the %(contents) placeholder
into its constituent parts.

[jk: initial patch by mg, rebased on top of my refactoring
and with tests by me]

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-for-each-ref.txt |    7 ++--
 builtin/for-each-ref.c             |   32 +++++++++++++++---
 t/lib-gpg.sh                       |    8 +++++
 t/t6300-for-each-ref.sh            |   60 ++++++++++++++++++++++++++++=
++++++-
 4 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index 152e695..c872b88 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -101,9 +101,10 @@ Fields that have name-email-date tuple as its valu=
e (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
=20
-The first line of the message in a commit and tag object is
-`subject`, the remaining lines are `body`.  The whole message
-is `contents`.
+The complete message in a commit and tag object is `contents`.
+Its first line is `contents:subject`, the remaining lines
+are `contents:body` and the optional GPG signature
+is `contents:signature`.
=20
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index ea2112b..50fba65 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -69,6 +69,9 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
+	{ "contents:subject" },
+	{ "contents:body" },
+	{ "contents:signature" },
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
@@ -472,7 +475,9 @@ static void grab_person(const char *who, struct ato=
m_value *val, int deref, stru
=20
 static void find_subpos(const char *buf, unsigned long sz,
 			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen)
+			const char **body, unsigned long *bodylen,
+			unsigned long *nonsiglen,
+			const char **sig, unsigned long *siglen)
 {
 	const char *eol;
 	/* skip past header until we hit empty line */
@@ -486,10 +491,14 @@ static void find_subpos(const char *buf, unsigned=
 long sz,
 	while (*buf =3D=3D '\n')
 		buf++;
=20
+	/* parse signature first; we might not even have a subject line */
+	*sig =3D buf + parse_signature(buf, strlen(buf));
+	*siglen =3D strlen(*sig);
+
 	/* subject is first non-empty line */
 	*sub =3D buf;
 	/* subject goes to first empty line */
-	while (*buf && *buf !=3D '\n') {
+	while (buf < *sig && *buf && *buf !=3D '\n') {
 		eol =3D strchrnul(buf, '\n');
 		if (*eol)
 			eol++;
@@ -505,14 +514,15 @@ static void find_subpos(const char *buf, unsigned=
 long sz,
 		buf++;
 	*body =3D buf;
 	*bodylen =3D strlen(buf);
+	*nonsiglen =3D *sig - buf;
 }
=20
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, =
struct object *obj, void *buf, unsigned long sz)
 {
 	int i;
-	const char *subpos =3D NULL, *bodypos;
-	unsigned long sublen, bodylen;
+	const char *subpos =3D NULL, *bodypos, *sigpos;
+	unsigned long sublen, bodylen, nonsiglen, siglen;
=20
 	for (i =3D 0; i < used_atom_cnt; i++) {
 		const char *name =3D used_atom[i];
@@ -523,17 +533,27 @@ static void grab_sub_body_contents(struct atom_va=
lue *val, int deref, struct obj
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    strcmp(name, "contents"))
+		    strcmp(name, "contents") &&
+		    strcmp(name, "contents:subject") &&
+		    strcmp(name, "contents:body") &&
+		    strcmp(name, "contents:signature"))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
 				    &subpos, &sublen,
-				    &bodypos, &bodylen);
+				    &bodypos, &bodylen, &nonsiglen,
+				    &sigpos, &siglen);
=20
 		if (!strcmp(name, "subject"))
 			v->s =3D copy_subject(subpos, sublen);
+		else if (!strcmp(name, "contents:subject"))
+			v->s =3D copy_subject(subpos, sublen);
 		else if (!strcmp(name, "body"))
 			v->s =3D xmemdupz(bodypos, bodylen);
+		else if (!strcmp(name, "contents:body"))
+			v->s =3D xmemdupz(bodypos, nonsiglen);
+		else if (!strcmp(name, "contents:signature"))
+			v->s =3D xmemdupz(sigpos, siglen);
 		else if (!strcmp(name, "contents"))
 			v->s =3D xstrdup(subpos);
 	}
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 28463fb..05824fa 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -24,3 +24,11 @@ else
 		;;
 	esac
 fi
+
+sanitize_pgp() {
+	perl -ne '
+		/^-----END PGP/ and $in_pgp =3D 0;
+		print unless $in_pgp;
+		/^-----BEGIN PGP/ and $in_pgp =3D 1;
+	'
+}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0c9ff96..1721784 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -6,6 +6,7 @@
 test_description=3D'for-each-ref test'
=20
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
=20
 # Mon Jul 3 15:18:43 2006 +0000
 datestamp=3D1151939923
@@ -40,9 +41,10 @@ test_atom() {
 		   *) ref=3D$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
-	test_expect_${4:-success} "basic atom: $1 $2" "
+	test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
 		git for-each-ref --format=3D'%($2)' $ref >actual &&
-		test_cmp expected actual
+		sanitize_pgp <actual >actual.clean &&
+		test_cmp expected actual.clean
 	"
 }
=20
@@ -72,7 +74,10 @@ test_atom head taggerdate ''
 test_atom head creator 'C O Mitter <committer@example.com> 1151939923 =
+0200'
 test_atom head creatordate 'Mon Jul 3 17:18:43 2006 +0200'
 test_atom head subject 'Initial'
+test_atom head contents:subject 'Initial'
 test_atom head body ''
+test_atom head contents:body ''
+test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
=20
@@ -102,7 +107,10 @@ test_atom tag taggerdate 'Mon Jul 3 17:18:45 2006 =
+0200'
 test_atom tag creator 'C O Mitter <committer@example.com> 1151939925 +=
0200'
 test_atom tag creatordate 'Mon Jul 3 17:18:45 2006 +0200'
 test_atom tag subject 'Tagging at 1151939927'
+test_atom tag contents:subject 'Tagging at 1151939927'
 test_atom tag body ''
+test_atom tag contents:body ''
+test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151939927
 '
=20
@@ -390,9 +398,14 @@ test_expect_success 'create tag with multiline sub=
ject' '
 	git tag -F msg multiline
 '
 test_atom refs/tags/multiline subject 'first subject line second subje=
ct line'
+test_atom refs/tags/multiline contents:subject 'first subject line sec=
ond subject line'
 test_atom refs/tags/multiline body 'first body line
 second body line
 '
+test_atom refs/tags/multiline contents:body 'first body line
+second body line
+'
+test_atom refs/tags/multiline contents:signature ''
 test_atom refs/tags/multiline contents 'first subject line
 second subject line
=20
@@ -400,4 +413,47 @@ first body line
 second body line
 '
=20
+test_expect_success GPG 'create signed tags' '
+	git tag -s -m "" signed-empty &&
+	git tag -s -m "subject line" signed-short &&
+	cat >msg <<-\EOF &&
+	subject line
+
+	body contents
+	EOF
+	git tag -s -F msg signed-long
+'
+
+sig=3D'-----BEGIN PGP SIGNATURE-----
+-----END PGP SIGNATURE-----
+'
+
+PREREQ=3DGPG
+test_atom refs/tags/signed-empty subject ''
+test_atom refs/tags/signed-empty contents:subject ''
+test_atom refs/tags/signed-empty body "$sig"
+test_atom refs/tags/signed-empty contents:body ''
+test_atom refs/tags/signed-empty contents:signature "$sig"
+test_atom refs/tags/signed-empty contents "$sig"
+
+test_atom refs/tags/signed-short subject 'subject line'
+test_atom refs/tags/signed-short contents:subject 'subject line'
+test_atom refs/tags/signed-short body "$sig"
+test_atom refs/tags/signed-short contents:body ''
+test_atom refs/tags/signed-short contents:signature "$sig"
+test_atom refs/tags/signed-short contents "subject line
+$sig"
+
+test_atom refs/tags/signed-long subject 'subject line'
+test_atom refs/tags/signed-long contents:subject 'subject line'
+test_atom refs/tags/signed-long body "body contents
+$sig"
+test_atom refs/tags/signed-long contents:body 'body contents
+'
+test_atom refs/tags/signed-long contents:signature "$sig"
+test_atom refs/tags/signed-long contents "subject line
+
+body contents
+$sig"
+
 test_done
--=20
1.7.6.10.g62f04
