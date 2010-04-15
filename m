From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] combined diff: correctly handle truncated file
Date: Thu, 15 Apr 2010 14:59:37 +0200
Message-ID: <884b9b68a4478aceda580299c059a9a67417cb1c.1271336073.git.trast@student.ethz.ch>
References: <4BC6EECE.6060408@gestiweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <desarrollo@gestiweb.com>,
	<deavidsedice@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:59:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Ofi-0006FF-JH
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab0DOM7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 08:59:49 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:4058 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab0DOM7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 08:59:48 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 15 Apr
 2010 14:59:46 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 15 Apr
 2010 14:59:37 +0200
X-Mailer: git-send-email 1.7.1.rc1.265.g77471
In-Reply-To: <4BC6EECE.6060408@gestiweb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144982>

Consider an evil merge of two commits A and B, both of which have a
file 'foo', but the merge result does not have that file.

The combined-diff code learned in 4462731 (combine-diff: do not punt
on removed or added files., 2006-02-06) to concisely show only the
removal, since that is the evil part and the previous contents are
presumably uninteresting.

However, to diagnose an empty merge result, it overloaded the variable
that holds the file's length.  This means that the check also triggers
for truncated files.  Consequently, such files were not shown in the
diff at all despite the merge being clearly evil.

=46ix this by adding a new variable that distinguishes whether the file
was deleted (which is the case 4462731 handled) or truncated.  In the
truncated case, we show the full combined diff again, which is rather
spammy but at least does not hide the evilness.

Reported-by: David Mart=C3=ADnez Mart=C3=AD <desarrollo@gestiweb.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 combine-diff.c           |   14 ++++++++------
 t/t4038-diff-combined.sh |    8 ++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 6162691..3480dae 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -204,7 +204,7 @@ static void consume_line(void *state_, char *line, =
unsigned long len)
 static void combine_diff(const unsigned char *parent, unsigned int mod=
e,
 			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
-			 int num_parent)
+			 int num_parent, int result_deleted)
 {
 	unsigned int p_lno, lno;
 	unsigned long nmask =3D (1UL << n);
@@ -215,7 +215,7 @@ static void combine_diff(const unsigned char *paren=
t, unsigned int mode,
 	struct combine_diff_state state;
 	unsigned long sz;
=20
-	if (!cnt)
+	if (result_deleted)
 		return; /* result deleted */
=20
 	parent_file.ptr =3D grab_blob(parent, mode, &sz);
@@ -517,7 +517,7 @@ static void show_line_to_eol(const char *line, int =
len, const char *reset)
 }
=20
 static void dump_sline(struct sline *sline, unsigned long cnt, int num=
_parent,
-		       int use_color)
+		       int use_color, int result_deleted)
 {
 	unsigned long mark =3D (1UL<<num_parent);
 	unsigned long no_pre_delete =3D (2UL<<num_parent);
@@ -530,7 +530,7 @@ static void dump_sline(struct sline *sline, unsigne=
d long cnt, int num_parent,
 	const char *c_plain =3D diff_get_color(use_color, DIFF_PLAIN);
 	const char *c_reset =3D diff_get_color(use_color, DIFF_RESET);
=20
-	if (!cnt)
+	if (result_deleted)
 		return; /* result deleted */
=20
 	while (1) {
@@ -687,6 +687,7 @@ static void show_patch_diff(struct combine_diff_pat=
h *elem, int num_parent,
 {
 	struct diff_options *opt =3D &rev->diffopt;
 	unsigned long result_size, cnt, lno;
+	int result_deleted =3D 0;
 	char *result, *cp;
 	struct sline *sline; /* survived lines */
 	int mode_differs =3D 0;
@@ -767,6 +768,7 @@ static void show_patch_diff(struct combine_diff_pat=
h *elem, int num_parent,
 		}
 		else {
 		deleted_file:
+			result_deleted =3D 1;
 			result_size =3D 0;
 			elem->mode =3D 0;
 			result =3D xcalloc(1, 1);
@@ -823,7 +825,7 @@ static void show_patch_diff(struct combine_diff_pat=
h *elem, int num_parent,
 			combine_diff(elem->parent[i].sha1,
 				     elem->parent[i].mode,
 				     &result_file, sline,
-				     cnt, i, num_parent);
+				     cnt, i, num_parent, result_deleted);
 		if (elem->parent[i].mode !=3D elem->mode)
 			mode_differs =3D 1;
 	}
@@ -889,7 +891,7 @@ static void show_patch_diff(struct combine_diff_pat=
h *elem, int num_parent,
 			dump_quoted_path("+++ ", b_prefix, elem->path,
 					 c_meta, c_reset);
 		dump_sline(sline, cnt, num_parent,
-			   DIFF_OPT_TST(opt, COLOR_DIFF));
+			   DIFF_OPT_TST(opt, COLOR_DIFF), result_deleted);
 	}
 	free(result);
=20
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 7584efa..09e8c8a 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -81,4 +81,12 @@ test_expect_success 'check combined output (2)' '
 	verify_helper sidesansone
 '
=20
+test_expect_success 'diagnose truncated file' '
+	: > file &&
+	git add file &&
+	git commit --amend -C HEAD &&
+	git show > out &&
+	grep "diff --cc file" out
+'
+
 test_done
--=20
1.7.1.rc1.265.g77471
