From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] fast-import: add options to enable/disable case folding
Date: Fri, 17 Apr 2015 20:52:06 +0900
Message-ID: <1429271526-31234-1-git-send-email-mh@glandium.org>
References: <xmqqoarclgnr.fsf@gitster.dls.corp.google.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 13:52:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj4ow-0001Kt-G2
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 13:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbbDQLwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 07:52:22 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:35288 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbbDQLwV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 07:52:21 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Yj4oY-00088R-4m; Fri, 17 Apr 2015 20:52:06 +0900
X-Mailer: git-send-email 2.3.5.1.g2355df5
In-Reply-To: <xmqqoarclgnr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267352>

Currently, fast-import does case folding depending on `core.ignorecase`.
`core.ignorecase` depends on the file system where the working tree is.
However, different kind of imports require different kinds of semantics,
and they usually aren't tied with the file system, but with the data being
imported.

Add command line options to enable or disable case folding. Also expose
them as features in the fast-import stream. Features instead of options,
because a stream that needs case folding enabled or disabled won't work
as expected if fast-import doesn't support the case folding options.
---
 Documentation/git-fast-import.txt | 11 ++++++
 fast-import.c                     | 19 ++++++++--
 t/t9300-fast-import.sh            | 79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 690fed3..22eba87 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -50,6 +50,13 @@ OPTIONS
 	memory used by fast-import during this run.  Showing this output
 	is currently the default, but can be disabled with \--quiet.
 
+--[no-]fold-case::
+	When files/directories with the same name but a different case
+	are detected, they are treated as the same (--fold-case) or as
+	being different (--no-fold-case). The default is --fold-case
+	when `core.ignorecase` is set to `true`, and --no-fold-case when
+	it is `false`.
+
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -1027,6 +1034,8 @@ date-format::
 export-marks::
 relative-marks::
 no-relative-marks::
+fold-case::
+no-fold-case::
 force::
 	Act as though the corresponding command-line option with
 	a leading '--' was passed on the command line
@@ -1091,6 +1100,8 @@ not be passed as option:
 * import-marks
 * export-marks
 * cat-blob-fd
+* fold-case
+* no-fold-case
 * force
 
 `done`
diff --git a/fast-import.c b/fast-import.c
index 6378726..958f3da 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -371,10 +371,18 @@ static volatile sig_atomic_t checkpoint_requested;
 /* Where to write output of cat-blob commands */
 static int cat_blob_fd = STDOUT_FILENO;
 
+/* Whether to enable case folding */
+static int fold_case;
+
 static void parse_argv(void);
 static void parse_cat_blob(const char *p);
 static void parse_ls(const char *p, struct branch *b);
 
+static int strncmp_foldcase(const char *a, const char *b, size_t count)
+{
+	return fold_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
+}
+
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
 	fprintf(rpt, "%s:\n", b->name);
@@ -1507,7 +1515,7 @@ static int tree_content_set(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp_foldcase(p, e->name->str_dat, n)) {
 			if (!*slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
@@ -1597,7 +1605,7 @@ static int tree_content_remove(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp_foldcase(p, e->name->str_dat, n)) {
 			if (*slash1 && !S_ISDIR(e->versions[1].mode))
 				/*
 				 * If p names a file in some subdirectory, and a
@@ -1664,7 +1672,7 @@ static int tree_content_get(
 	t = root->tree;
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp_foldcase(p, e->name->str_dat, n)) {
 			if (!*slash1)
 				goto found_entry;
 			if (!S_ISDIR(e->versions[1].mode))
@@ -3246,6 +3254,10 @@ static int parse_one_feature(const char *feature, int from_stream)
 		relative_marks_paths = 1;
 	} else if (!strcmp(feature, "no-relative-marks")) {
 		relative_marks_paths = 0;
+	} else if (!strcmp(feature, "fold-case")) {
+		fold_case = 1;
+	} else if (!strcmp(feature, "no-fold-case")) {
+		fold_case = 0;
 	} else if (!strcmp(feature, "done")) {
 		require_explicit_termination = 1;
 	} else if (!strcmp(feature, "force")) {
@@ -3372,6 +3384,7 @@ int main(int argc, char **argv)
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
 	marks = pool_calloc(1, sizeof(struct mark_set));
 
+	fold_case = ignore_case;
 	global_argc = argc;
 	global_argv = argv;
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index aac126f..7057c26 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3088,4 +3088,83 @@ test_expect_success 'U: validate root delete result' '
 	compare_diff_raw expect actual
 '
 
+cat >input <<INPUT_END
+blob
+mark :1
+data 2
+a
+
+commit refs/heads/V
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 0
+
+M 644 :1 a
+
+commit refs/heads/V
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 0
+
+R a A
+INPUT_END
+
+test_expect_success 'V: default case folding with ignorecase=true' '
+	git config core.ignorecase true &&
+	git fast-import <input &&
+	git ls-tree refs/heads/V >actual &&
+	git update-ref -d refs/heads/V &&
+	cat >expected <<\EOF &&
+100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	a
+EOF
+	test_cmp expected actual'
+
+test_expect_success 'V: default case folding with ignorecase=false' '
+	git config core.ignorecase false &&
+	git fast-import <input &&
+	git ls-tree refs/heads/V >actual &&
+	git update-ref -d refs/heads/V &&
+	cat >expected <<\EOF &&
+100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	A
+EOF
+	test_cmp expected actual'
+
+test_expect_success 'V: forced case folding with ignorecase=true' '
+	git config core.ignorecase true &&
+	git fast-import --fold-case <input &&
+	git ls-tree refs/heads/V >actual &&
+	git update-ref -d refs/heads/V &&
+	cat >expected <<\EOF &&
+100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	a
+EOF
+	test_cmp expected actual'
+
+test_expect_success 'V: forced case folding with ignorecase=false' '
+	git config core.ignorecase false &&
+	git fast-import --fold-case <input &&
+	git ls-tree refs/heads/V >actual &&
+	git update-ref -d refs/heads/V &&
+	cat >expected <<\EOF &&
+100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	a
+EOF
+	test_cmp expected actual'
+
+test_expect_success 'V: forced no case folding with ignorecase=true' '
+	git config core.ignorecase true &&
+	git fast-import --no-fold-case <input &&
+	git ls-tree refs/heads/V >actual &&
+	git update-ref -d refs/heads/V &&
+	cat >expected <<\EOF &&
+100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	A
+EOF
+	test_cmp expected actual'
+
+test_expect_success 'V: forced no case folding with ignorecase=false' '
+	git config core.ignorecase false &&
+	git fast-import --no-fold-case <input &&
+	git ls-tree refs/heads/V >actual &&
+	git update-ref -d refs/heads/V &&
+	cat >expected <<\EOF &&
+100644 blob 78981922613b2afb6025042ff6bd878ac1994e85	A
+EOF
+	test_cmp expected actual'
+
 test_done
-- 
2.3.5.1.g2355df5
