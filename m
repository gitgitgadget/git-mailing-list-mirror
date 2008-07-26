From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] rev-parse: Add support for the ^! and ^@ syntax
Date: Sat, 26 Jul 2008 18:37:56 +0200
Message-ID: <20080726163756.GA25103@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 18:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMmnN-0006Sb-LM
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 18:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYGZQiB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jul 2008 12:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbYGZQiB
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 12:38:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:47574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753012AbYGZQiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 12:38:00 -0400
Received: (qmail invoked by alias); 26 Jul 2008 16:37:58 -0000
Received: from i577BB289.versanet.de (EHLO atjola.local) [87.123.178.137]
  by mail.gmx.net (mp060) with SMTP; 26 Jul 2008 18:37:58 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+0rIknfay0vFUGFID+Vy6Y+Y+VxLHmPmoUEmAfo5
	22Byt+55cUzcxq
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90254>

Those shorthands are explained in the rev-parse documentation but were =
not
actually supported by rev-parse itself.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 builtin-rev-parse.c          |   32 ++++++++++++++++++++++++++++++++
 t/t6101-rev-parse-parents.sh |    2 ++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index aa71f4a..9aa049e 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -241,6 +241,36 @@ static int try_difference(const char *arg)
 	return 0;
 }
=20
+static int try_parent_shorthands(const char *arg)
+{
+	char *dotdot;
+	unsigned char sha1[20];
+	struct commit *commit;
+	struct commit_list *parents;
+	int parents_only;
+
+	if ((dotdot =3D strstr(arg, "^!")))
+		parents_only =3D 0;
+	else if ((dotdot =3D strstr(arg, "^@")))
+		parents_only =3D 1;
+
+	if (!dotdot || dotdot[2])
+		return 0;
+
+	*dotdot =3D 0;
+	if (get_sha1(arg, sha1))
+		return 0;
+
+	if (!parents_only)
+		show_rev(NORMAL, sha1, arg);
+	commit =3D lookup_commit_reference(sha1);
+	for (parents =3D commit->parents; parents; parents =3D parents->next)
+		show_rev(parents_only ? NORMAL : REVERSED,
+				parents->item->object.sha1, arg);
+
+	return 1;
+}
+
 static int parseopt_dump(const struct option *o, const char *arg, int =
unset)
 {
 	struct strbuf *parsed =3D o->value;
@@ -573,6 +603,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 		/* Not a flag argument */
 		if (try_difference(arg))
 			continue;
+		if (try_parent_shorthands(arg))
+			continue;
 		name =3D arg;
 		type =3D NORMAL;
 		if (*arg =3D=3D '^') {
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.s=
h
index efc8313..919552a 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -28,6 +28,8 @@ test_expect_success 'final^1^2 !=3D final^1^1' "test =
$(git rev-parse final^1^2) !=3D
 test_expect_success 'final^1^3 not valid' "if git rev-parse --verify f=
inal^1^3; then false; else :; fi"
 test_expect_success '--verify start2^1' 'test_must_fail git rev-parse =
--verify start2^1'
 test_expect_success '--verify start2^0' 'git rev-parse --verify start2=
^0'
+test_expect_success 'final^1^@ =3D final^1^1 final^1^2' "test \"$(git =
rev-parse final^1^@)\" =3D \"$(git rev-parse final^1^1 final^1^2)\""
+test_expect_success 'final^1^! =3D final^1 ^final^1^1 ^final^1^2' "tes=
t \"$(git rev-parse final^1^\!)\" =3D \"$(git rev-parse final^1 ^final^=
1^1 ^final^1^2)\""
=20
 test_expect_success 'repack for next test' 'git repack -a -d'
 test_expect_success 'short SHA-1 works' '
--=20
1.6.0.rc0.79.gb0320.dirty
