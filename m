From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] combine-diff: respect textconv attributes
Date: Mon, 23 May 2011 16:31:05 -0400
Message-ID: <20110523203105.GE6298@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:31:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QObmT-0006re-J7
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933534Ab1EWUbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 16:31:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58975
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307Ab1EWUbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:31:07 -0400
Received: (qmail 23142 invoked by uid 107); 23 May 2011 20:33:11 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 16:33:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 16:31:05 -0400
Content-Disposition: inline
In-Reply-To: <20110523201529.GA6281@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174271>

When doing a combined diff, we did not respect textconv
attributes at all. This generally lead to us printing
"Binary files differ" when we could show a combined diff of
the converted text.

This patch converts file contents according to textconv
attributes. The implementation is slightly ugly; because the
textconv code is tightly linked with the diff_filespec code,
we temporarily create a diff_filespec during conversion. In
practice, though, this should not create a performance
problem.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c                  |   41 +++++++++++++----
 t/t4048-diff-combined-binary.sh |   99 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 94a207f..fbed374 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -93,7 +93,8 @@ struct sline {
 	unsigned long *p_lno;
 };
 
-static char *grab_blob(const unsigned char *sha1, unsigned int mode, unsigned long *size)
+static char *grab_blob(const unsigned char *sha1, unsigned int mode,
+		       unsigned long *size, struct userdiff_driver *textconv)
 {
 	char *blob;
 	enum object_type type;
@@ -106,6 +107,13 @@ static char *grab_blob(const unsigned char *sha1, unsigned int mode, unsigned lo
 		/* deleted blob */
 		*size = 0;
 		return xcalloc(1, 1);
+	} else if (textconv) {
+		/* yuck, the textconv code is linked heavily with
+		 * filespecs */
+		struct diff_filespec *df = alloc_filespec("");
+		fill_filespec(df, sha1, mode);
+		*size = fill_textconv(textconv, df, &blob);
+		free_filespec(df);
 	} else {
 		blob = read_sha1_file(sha1, &type, size);
 		if (type != OBJ_BLOB)
@@ -205,7 +213,8 @@ static void consume_line(void *state_, char *line, unsigned long len)
 static void combine_diff(const unsigned char *parent, unsigned int mode,
 			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
-			 int num_parent, int result_deleted)
+			 int num_parent, int result_deleted,
+			 struct userdiff_driver *textconv)
 {
 	unsigned int p_lno, lno;
 	unsigned long nmask = (1UL << n);
@@ -218,7 +227,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	if (result_deleted)
 		return; /* result deleted */
 
-	parent_file.ptr = grab_blob(parent, mode, &sz);
+	parent_file.ptr = grab_blob(parent, mode, &sz, textconv);
 	parent_file.size = sz;
 	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = 0;
@@ -771,16 +780,20 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	int working_tree_file = is_null_sha1(elem->sha1);
 	mmfile_t result_file;
 	struct userdiff_driver *userdiff;
+	struct userdiff_driver *textconv = NULL;
 	int is_binary;
 
 	context = opt->context;
 	userdiff = userdiff_find_by_path(elem->path);
 	if (!userdiff)
 		userdiff = userdiff_find_by_name("default");
+	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV))
+		textconv = userdiff_get_textconv(userdiff);
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
-		result = grab_blob(elem->sha1, elem->mode, &result_size);
+		result = grab_blob(elem->sha1, elem->mode, &result_size,
+				   textconv);
 	else {
 		/* Used by diff-tree to read from the working tree */
 		struct stat st;
@@ -803,9 +816,16 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		} else if (S_ISDIR(st.st_mode)) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(elem->path, "HEAD", sha1) < 0)
-				result = grab_blob(elem->sha1, elem->mode, &result_size);
+				result = grab_blob(elem->sha1, elem->mode,
+						   &result_size, NULL);
 			else
-				result = grab_blob(sha1, elem->mode, &result_size);
+				result = grab_blob(sha1, elem->mode,
+						   &result_size, NULL);
+		} else if (textconv) {
+			struct diff_filespec *df = alloc_filespec(elem->path);
+			fill_filespec(df, null_sha1, st.st_mode);
+			result_size = fill_textconv(textconv, df, &result);
+			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
 			ssize_t done;
@@ -862,7 +882,9 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		}
 	}
 
-	if (userdiff->binary != -1)
+	if (textconv)
+		is_binary = 0;
+	else if (userdiff->binary != -1)
 		is_binary = userdiff->binary;
 	else {
 		is_binary = buffer_is_binary(result, result_size);
@@ -871,7 +893,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			unsigned long size;
 			buf = grab_blob(elem->parent[i].sha1,
 					elem->parent[i].mode,
-					&size);
+					&size, NULL);
 			if (buffer_is_binary(buf, size))
 				is_binary = 1;
 			free(buf);
@@ -932,7 +954,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			combine_diff(elem->parent[i].sha1,
 				     elem->parent[i].mode,
 				     &result_file, sline,
-				     cnt, i, num_parent, result_deleted);
+				     cnt, i, num_parent, result_deleted,
+				     textconv);
 	}
 
 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
index a943994..87a8949 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -110,4 +110,103 @@ test_expect_success 'diff --cc respects binary attribute' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup textconv attribute' '
+	echo "text diff=upcase" >.gitattributes &&
+	git config diff.upcase.textconv "tr a-z A-Z <"
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --git a/text b/text
+index 2bdf67a..2ab19ae 100644
+--- a/text
++++ b/text
+@@ -1 +1 @@
+-THREE
++RESOLVED
+resolved
+
+diff --git a/text b/text
+index f719efd..2ab19ae 100644
+--- a/text
++++ b/text
+@@ -1 +1 @@
+-TWO
++RESOLVED
+EOF
+test_expect_success 'diff -m respects textconv attribute' '
+	git show --format=%s -m >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --combined text
+index 2bdf67a,f719efd..2ab19ae
+--- a/text
++++ b/text
+@@@ -1,1 -1,1 +1,1 @@@
+- THREE
+ -TWO
+++RESOLVED
+EOF
+test_expect_success 'diff -c respects textconv attribute' '
+	git show --format=%s -c >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+resolved
+
+diff --cc text
+index 2bdf67a,f719efd..2ab19ae
+--- a/text
++++ b/text
+@@@ -1,1 -1,1 +1,1 @@@
+- THREE
+ -TWO
+++RESOLVED
+EOF
+test_expect_success 'diff --cc respects textconv attribute' '
+	git show --format=%s --cc >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+diff --combined text
+index 2bdf67a,f719efd..2ab19ae
+--- a/text
++++ b/text
+@@@ -1,1 -1,1 +1,1 @@@
+- three
+ -two
+++resolved
+EOF
+test_expect_success 'diff-tree plumbing does not respect textconv' '
+	git diff-tree HEAD -c -p >full &&
+	tail -n +2 full >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+diff --cc text
+index 2bdf67a,f719efd..0000000
+--- a/text
++++ b/text
+@@@ -1,1 -1,1 +1,5 @@@
+++<<<<<<< HEAD
+ +THREE
+++=======
++ TWO
+++>>>>>>> MASTER
+EOF
+test_expect_success 'diff --cc respects textconv on worktree file' '
+	git reset --hard HEAD^ &&
+	test_must_fail git merge master &&
+	git diff >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.5.2.4.g43415
