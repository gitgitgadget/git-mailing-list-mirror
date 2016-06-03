From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] reflog: continue walking the reflog past root commits
Date: Fri,  3 Jun 2016 22:42:35 +0200
Message-ID: <20160603204235.7994-1-szeder@ira.uka.de>
References: <f51f9df7-d6d7-3a45-736f-ca2e2c9eb2cb@textalk.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Patrik Gustafsson <pvn@textalk.se>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 22:43:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8vvn-0006wK-5X
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 22:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbcFCUmz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 16:42:55 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36124 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752272AbcFCUmy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 16:42:54 -0400
Received: from x4db1ec54.dyn.telefonica.de ([77.177.236.84] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1b8vvd-0004SX-Kb; Fri, 03 Jun 2016 22:42:51 +0200
X-Mailer: git-send-email 2.9.0.rc1.66.ge2c3978
In-Reply-To: <f51f9df7-d6d7-3a45-736f-ca2e2c9eb2cb@textalk.se>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1464986571.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296371>

If a repository contains more than one root commit, then its HEAD
reflog may contain multiple "creation events", i.e. entries whose
"from" value is the null sha1.  Listing such a reflog currently stops
prematurely at the first such entry, even when the reflog still
contains older entries.  This can scare users into thinking that their
reflog got truncated after 'git checkout --orphan'.

Continue walking the reflog past such creation evens based on the
preceeding reflog entry's "new" value.

The test 'symbolic-ref writes reflog entry' in t1401-symbolic-ref
implicitly relies on the current behavior of the reflog walker to stop
at a root commit and thus to list only the reflog entries that are
relevant for that test.  Adjust the test to explicitly specify the
number of relevant reflog entries to be listed.

Reported-by: Patrik Gustafsson <pvn@textalk.se>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 reflog-walk.c           |  6 ++++++
 t/t1401-symbolic-ref.sh |  2 +-
 t/t1410-reflog.sh       | 22 ++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 0ebd1da5ceb8..a246af27678a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -241,6 +241,12 @@ void fake_reflog_parent(struct reflog_walk_info *i=
nfo, struct commit *commit)
 		logobj =3D parse_object(reflog->osha1);
 	} while (commit_reflog->recno && (logobj && logobj->type !=3D OBJ_COM=
MIT));
=20
+	if (!logobj && commit_reflog->recno >=3D 0 && is_null_sha1(reflog->os=
ha1)) {
+		/* a root commit, but there are still more entries to show */
+		reflog =3D &commit_reflog->reflogs->items[commit_reflog->recno];
+		logobj =3D parse_object(reflog->nsha1);
+	}
+
 	if (!logobj || logobj->type !=3D OBJ_COMMIT) {
 		commit_info->commit =3D NULL;
 		commit->parents =3D NULL;
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 417eecc3af2a..ca3fa406c34f 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -110,7 +110,7 @@ test_expect_success 'symbolic-ref writes reflog ent=
ry' '
 	update
 	create
 	EOF
-	git log --format=3D%gs -g >actual &&
+	git log --format=3D%gs -g -2 >actual &&
 	test_cmp expect actual
 '
=20
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 9cf91dc6d217..dd2be049ecf6 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -348,4 +348,26 @@ test_expect_success 'reflog expire operates on sym=
ref not referrent' '
 	git reflog expire --expire=3Dall the_symref
 '
=20
+test_expect_success 'continue walking past root commits' '
+	git init orphanage &&
+	(
+		cd orphanage &&
+		cat >expect <<-\EOF &&
+		HEAD@{0} commit (initial): orphan2-1
+		HEAD@{1} commit: orphan1-2
+		HEAD@{2} commit (initial): orphan1-1
+		HEAD@{3} commit (initial): initial
+		EOF
+		test_commit initial &&
+		git reflog &&
+		git checkout --orphan orphan1 &&
+		test_commit orphan1-1 &&
+		test_commit orphan1-2 &&
+		git checkout --orphan orphan2 &&
+		test_commit orphan2-1 &&
+		git log -g --format=3D"%gd %gs" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.9.0.rc1.66.ge2c3978
