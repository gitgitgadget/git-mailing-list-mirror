From: Pierre Habouzit <madcoder@debian.org>
Subject: [RESEND PATCH] git-checkout: fix argument parsing to detect ambiguous arguments.
Date: Wed, 23 Jul 2008 03:27:51 +0200
Message-ID: <20080723012751.GI11831@artemis.madism.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oxV4ZoPwBLqAyY+a";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 03:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLTAC-0006ob-M3
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbYGWB1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbYGWB1z
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:27:55 -0400
Received: from pan.madism.org ([88.191.52.104]:54261 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbYGWB1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:27:54 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2815B3A4C9;
	Wed, 23 Jul 2008 03:27:53 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 067BE142488; Wed, 23 Jul 2008 03:27:52 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1216774940-4955-1-git-send-email-madcoder@debian.org>
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89593>


--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Note that it also fix a bug, git checkout -- <path> would be badly
understood as git checkout <branch> if <path> is ambiguous with a branch.

Testcases included.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  This is a resend with proper patches that made me realize that my
previous patch had silly mistakes and wasn't testing thigns properly.

 builtin-checkout.c            |   23 +++++++++++++++++------
 t/t2010-checkout-ambiguous.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 6 deletions(-)
 create mode 100755 t/t2010-checkout-ambiguous.sh

diff --git a/builtin-checkout.c b/builtin-checkout.c
index fbd5105..97321e6 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -438,12 +438,17 @@ int cmd_checkout(int argc, const char **argv, const c=
har *prefix)
=20
 	opts.track =3D git_branch_track;
=20
-	argc =3D parse_options(argc, argv, options, checkout_usage, 0);
-	if (argc) {
+	argc =3D parse_options(argc, argv, options, checkout_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc && strcmp(argv[0], "--")) {
+		int may_be_ambiguous =3D argc =3D=3D 1 || strcmp(argv[1], "--");
+
 		arg =3D argv[0];
-		if (get_sha1(arg, rev))
-			;
-		else if ((new.commit =3D lookup_commit_reference_gently(rev, 1))) {
+		if (get_sha1(arg, rev)) {
+			if (may_be_ambiguous)
+				verify_filename(NULL, arg);
+		} else if ((new.commit =3D lookup_commit_reference_gently(rev, 1))) {
 			new.name =3D arg;
 			setup_branch_path(&new);
 			if (resolve_ref(new.path, rev, 1, NULL))
@@ -454,10 +459,16 @@ int cmd_checkout(int argc, const char **argv, const c=
har *prefix)
 			source_tree =3D new.commit->tree;
 			argv++;
 			argc--;
+			if (may_be_ambiguous)
+				verify_non_filename(NULL, arg);
 		} else if ((source_tree =3D parse_tree_indirect(rev))) {
 			argv++;
 			argc--;
-		}
+			if (may_be_ambiguous)
+				verify_non_filename(NULL, arg);
+		} else
+			if (may_be_ambiguous)
+				verify_filename(NULL, arg);
 	}
=20
 	if (argc && !strcmp(argv[0], "--")) {
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
new file mode 100755
index 0000000..389ba8c
--- /dev/null
+++ b/t/t2010-checkout-ambiguous.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description=3D'checkout and pathspecs/refspecs ambiguities'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	echo hello >all &&
+	git add all world &&
+	git commit -m initial &&
+	git branch world
+'
+
+test_expect_success 'branch switching' '
+	test "refs/heads/master" =3D "$(git symbolic-ref HEAD)" &&
+	git checkout world -- &&
+	test "refs/heads/world" =3D "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success 'checkout world from the index' '
+	echo bye > world &&
+	git checkout -- world &&
+	git diff --exit-code --quiet
+'
+
+test_expect_success 'non ambiguous call' '
+	git checkout all
+'
+
+test_expect_success 'ambiguous call' '
+	test_must_fail git checkout world
+'
+
+test_done
--=20
1.6.0.rc0.154.ge2a39.dirty


--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGiRcACgkQvGr7W6HudhygewCeLv9Kdt3XbbwU1VxCyrs0+Jgm
MywAn0Q728oBJi90Url8gyQw3b00TIJi
=F+Ox
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--
