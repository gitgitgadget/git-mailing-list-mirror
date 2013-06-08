From: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Subject: [PATCH 1/2] rm: better error message on failure for multiple files
Date: Sat,  8 Jun 2013 10:33:53 +0200
Message-ID: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Mathieu=20Li=C3=A9nard--Mayor?= 
	<Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 10:34:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlEbm-0006Mv-6b
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 10:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab3FHIej convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 04:34:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35202 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab3FHIeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 04:34:37 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r588YLlW023181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 10:34:21 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r588YLsL008936;
	Sat, 8 Jun 2013 10:34:21 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r588YLwm003526;
	Sat, 8 Jun 2013 10:34:21 +0200
Received: (from lienardm@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r588YLeG003525;
	Sat, 8 Jun 2013 10:34:21 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 08 Jun 2013 10:34:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r588YLlW023181
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: mathieu.lienard--mayor@ensimag.imag.fr
MailScanner-NULL-Check: 1371285267.08488@n6S/mDzQW6hqlCpBLK+97Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226788>

=46rom: Mathieu Li=C3=A9nard--Mayor <Mathieu.Lienard--Mayor@ensimag.ima=
g.fr>

When 'git rm' fails, it now displays a single message
with the list of files involved, instead of displaying
a list of messages with one file each.

As an example, the old message:
	error: 'foo.txt' has changes staged in the index
	(use --cached to keep the file, or -f to force removal)
	error: 'bar.txt' has changes staged in the index
	(use --cached to keep the file, or -f to force removal)

would now be displayed as:
	error: the following files have changes staged in the index:
		foo.txt
		bar.txt
	(use --cached to keep the file, or -f to force removal)

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.i=
mag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.garcia-Garcia@ensim=
ag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 builtin/rm.c  |   54 ++++++++++++++++++++++++++++++++++++++-----------=
-----
 t/t3600-rm.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 7b91d52..5b2abd2 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -82,6 +82,11 @@ static int check_local_mod(unsigned char *head, int =
index_only)
 	int i, no_head;
 	int errs =3D 0;
=20
+	struct strbuf files_staged =3D STRBUF_INIT;
+	struct strbuf files_cached =3D STRBUF_INIT;
+	struct strbuf files_submodule =3D STRBUF_INIT;
+	struct strbuf files_local =3D STRBUF_INIT;
+
 	no_head =3D is_null_sha1(head);
 	for (i =3D 0; i < list.nr; i++) {
 		struct stat st;
@@ -170,30 +175,47 @@ static int check_local_mod(unsigned char *head, i=
nt index_only)
 		 * "intent to add" entry.
 		 */
 		if (local_changes && staged_changes) {
-			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
-				errs =3D error(_("'%s' has staged content different "
-					     "from both the file and the HEAD\n"
-					     "(use -f to force removal)"), name);
+			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD)) {
+				strbuf_addstr(&files_staged, "\n	");
+				strbuf_addstr(&files_staged, name);
+			}
 		}
 		else if (!index_only) {
-			if (staged_changes)
-				errs =3D error(_("'%s' has changes staged in the index\n"
-					     "(use --cached to keep the file, "
-					     "or -f to force removal)"), name);
+			if (staged_changes) {
+				strbuf_addstr(&files_cached, "\n	");
+				strbuf_addstr(&files_cached, name);
+			}
 			if (local_changes) {
 				if (S_ISGITLINK(ce->ce_mode) &&
 				    !submodule_uses_gitfile(name)) {
-					errs =3D error(_("submodule '%s' (or one of its nested "
-						     "submodules) uses a .git directory\n"
-						     "(use 'rm -rf' if you really want to remove "
-						     "it including all of its history)"), name);
-				} else
-					errs =3D error(_("'%s' has local modifications\n"
-						     "(use --cached to keep the file, "
-						     "or -f to force removal)"), name);
+					strbuf_addstr(&files_submodule, "\n	");
+					strbuf_addstr(&files_submodule, name);
+				} else {
+					strbuf_addstr(&files_local, "\n	");
+					strbuf_addstr(&files_local, name);
+				}
 			}
 		}
 	}
+
+	if (files_staged.len)
+		errs =3D error(_("the following files have staged content "
+			       "different from both the\nfileand the HEAD:%s\n"
+			       "(use -f to force removal)"), files_staged.buf);
+	if (files_cached.len)
+		errs =3D error(_("the following files have changes staged "
+			       "in the index:%s\n(use --cached to keep the file, "
+			       "or -f to force removal)"), files_cached.buf);
+	if (files_submodule.len)
+		errs =3D error(_("the following submodules (or one of its nested "
+			       "submodule) use a .git directory:%s\n"
+			       "(use 'rm -rf' if you really want to remove "
+			       "it including all of its history)"), files_submodule.buf);
+	if (files_local.len)
+		errs =3D error(_("the following files have local modifications:"
+			       "%s\n(use --cached to keep the file, or -f to "
+			       "force removal)"), files_local.buf);
+
 	return errs;
 }
=20
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0c44e9f..e0f3166 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -687,4 +687,49 @@ test_expect_failure SYMLINKS 'rm across a symlinke=
d leading path (w/ index)' '
 	test_path_is_file e/f
 '
=20
+test_expect_success 'setup for testing rm messages' '
+	>bar.txt &&
+	>foo.txt &&
+	git add bar.txt foo.txt
+'
+
+test_expect_success 'rm files with different staged content' '
+	cat >expect << EOF &&
+error: the following files have staged content different from both the
+file and the HEAD:
+	bar.txt
+	foo.txt
+(use -f to force removal)
+EOF
+	echo content1 >foo.txt &&
+	echo content1 >bar.txt &&
+	test_must_fail git rm foo.txt bar.txt 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm file with local modification' '
+	cat >expect << EOF &&
+error: the following files have local modifications:
+	foo.txt
+(use --cached to keep the file, or -f to force removal)
+EOF
+	git commit -m "testing rm 3" &&
+	echo content3 >foo.txt &&
+	test_must_fail git rm foo.txt 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm file with changes in the index' '
+	cat >expect << EOF &&
+error: the following files have changes staged in the index:
+	foo.txt
+(use --cached to keep the file, or -f to force removal)
+EOF
+	git reset --hard &&
+	echo content5 >foo.txt &&
+	git add foo.txt &&
+	test_must_fail git rm foo.txt 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.8
