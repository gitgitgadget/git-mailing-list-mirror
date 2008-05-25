From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 3/3] Make old sha1 optional with git update-ref -d
Date: Sun, 25 May 2008 18:14:41 +0200
Message-ID: <20080525161440.25087.83011.stgit@yoghurt>
References: <20080525161125.25087.18083.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 18:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0IwH-00021X-0M
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 18:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbYEYQSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 12:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbYEYQSZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 12:18:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1643 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbYEYQSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 12:18:24 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K0Iro-0001Dr-00; Sun, 25 May 2008 17:14:40 +0100
In-Reply-To: <20080525161125.25087.18083.stgit@yoghurt>
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82869>

Giving the old sha1 is already optional when changing a ref, and it's
quite handy when running update-ref manually. So make it optional for
deleting a ref too.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/git-update-ref.txt |    2 +-
 builtin-update-ref.c             |    8 ++++----
 t/t1400-update-ref.sh            |    8 ++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)


diff --git a/Documentation/git-update-ref.txt b/Documentation/git-updat=
e-ref.txt
index 4dc4759..80b94c3 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -7,7 +7,7 @@ git-update-ref - Update the object name stored in a ref=
 safely
=20
 SYNOPSIS
 --------
-'git-update-ref' [-m <reason>] (-d <ref> <oldvalue> | [--no-deref] <re=
f> <newvalue> [<oldvalue>])
+'git-update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <=
ref> <newvalue> [<oldvalue>])
=20
 DESCRIPTION
 -----------
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 0d3eb8e..054e64d 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
=20
 static const char * const git_update_ref_usage[] =3D {
-	"git-update-ref [options] -d <refname> <oldval>",
+	"git-update-ref [options] -d <refname> [<oldval>]",
 	"git-update-ref [options]    <refname> <newval> [<oldval>]",
 	NULL
 };
@@ -28,11 +28,11 @@ int cmd_update_ref(int argc, const char **argv, con=
st char *prefix)
 		die("Refusing to perform update with empty message.");
=20
 	if (delete) {
-		if (argc !=3D 2)
+		if (argc < 1 || argc > 2)
 			usage_with_options(git_update_ref_usage, options);
 		refname =3D argv[0];
 		value =3D NULL;
-		oldval =3D argv[1];
+		oldval =3D argc > 1 ? argv[1] : NULL;
 	} else {
 		if (argc < 2 || argc > 3)
 			usage_with_options(git_update_ref_usage, options);
@@ -48,7 +48,7 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 		die("%s: not a valid old SHA1", oldval);
=20
 	if (delete)
-		return delete_ref(refname, oldsha1);
+		return delete_ref(refname, oldval ? oldsha1 : NULL);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
 				  no_deref ? REF_NODEREF : 0, DIE_ON_ERR);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b88e767..da82645 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -42,6 +42,14 @@ test_expect_success "delete $m" "
 "
 rm -f .git/$m
=20
+test_expect_success "delete $m without oldvalue verification" "
+	git update-ref $m $A &&
+	test $A =3D \$(cat .git/$m) &&
+	git update-ref -d $m &&
+	! test -f .git/$m
+"
+rm -f .git/$m
+
 test_expect_success \
 	"fail to create $n" \
 	"touch .git/$n_dir
