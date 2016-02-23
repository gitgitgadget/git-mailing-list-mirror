From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/5] diff: activate diff.renames by default
Date: Tue, 23 Feb 2016 18:44:58 +0100
Message-ID: <1456249498-3232-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:45:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYH1r-0001NZ-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbcBWRpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:45:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37121 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699AbcBWRpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:45:17 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj8Tq004812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:45:11 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj6MY012979;
	Tue, 23 Feb 2016 18:45:10 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Feb 2016 18:45:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHj8Tq004812
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854313.96728@pbt0+oZKAC2ZcIvDylxkUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287096>

Rename detection is a very convenient feature, and new users shouldn't
have to dig in the documentation to benefit from it.

Potential objections to activating rename detection are that it
sometimes fail, and it is sometimes slow. But rename detection is
already activated by default in several cases like "git status" and "git
merge", so activating diff.renames does not fundamentally change the
situation. When the rename detection fails, it now fails consistently
between "git diff" and "git status".

This setting does not affect plumbing commands, hence well-written
scripts will not be affected.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/diff-config.txt | 2 +-
 builtin/commit.c              | 1 +
 builtin/diff.c                | 1 +
 builtin/log.c                 | 1 +
 builtin/merge.c               | 1 +
 diff.c                        | 5 +++++
 diff.h                        | 1 +
 t/t4001-diff-rename.sh        | 2 +-
 t/t4013-diff-various.sh       | 2 ++
 t/t4014-format-patch.sh       | 4 ++--
 t/t4047-diff-dirstat.sh       | 3 ++-
 t/t4202-log.sh                | 8 ++++----
 12 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 1acd203..fdf5a79 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -111,7 +111,7 @@ diff.renames::
 	Whether and how Git detects renames.  If set to "false",
 	rename detection is disabled. If set to "true", basic rename
 	detection is enable.  If set to "copies" or "copy", Git will
-	detect copies, as well.  Defaults to false.
+	detect copies, as well.  Defaults to true.
 
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
diff --git a/builtin/commit.c b/builtin/commit.c
index b3bd2d4..3cb4843 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -186,6 +186,7 @@ static void status_init_config(struct wt_status *s, config_fn_t fn)
 	gitmodules_config();
 	git_config(fn, s);
 	determine_whence(s);
+	git_diff_ui_default_config();
 	s->hints = advice_status_hints; /* must come after git_config() */
 }
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 52c98a9..8bd1fd5 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -318,6 +318,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	if (!no_index)
 		gitmodules_config();
+	git_diff_ui_default_config();
 	git_config(git_diff_ui_config, NULL);
 
 	init_revisions(&rev, prefix);
diff --git a/builtin/log.c b/builtin/log.c
index 7f96c64..6e34df3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -103,6 +103,7 @@ static int log_line_range_callback(const struct option *option, const char *arg,
 static void init_log_defaults()
 {
 	init_grep_defaults();
+	git_diff_ui_default_config();
 }
 
 static void cmd_log_init_defaults(struct rev_info *rev)
diff --git a/builtin/merge.c b/builtin/merge.c
index b98a348..cf297d4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1187,6 +1187,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	else
 		head_commit = lookup_commit_or_die(head_sha1, "HEAD");
 
+	git_diff_ui_default_config();
 	git_config(git_merge_config, NULL);
 
 	if (branch_mergeoptions)
diff --git a/diff.c b/diff.c
index 2136b69..d5db898 100644
--- a/diff.c
+++ b/diff.c
@@ -168,6 +168,11 @@ long parse_algorithm_value(const char *value)
  * never be affected by the setting of diff.renames
  * the user happens to have in the configuration file.
  */
+void git_diff_ui_default_config()
+{
+	diff_detect_rename_default = 1;
+}
+
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
diff --git a/diff.h b/diff.h
index 70b2d70..75686d5 100644
--- a/diff.h
+++ b/diff.h
@@ -266,6 +266,7 @@ extern int parse_long_opt(const char *opt, const char **argv,
 			 const char **optarg);
 
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
+extern void git_diff_ui_default_config();
 extern int git_diff_ui_config(const char *var, const char *value, void *cb);
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int, const char *);
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 6844906..15d99a3 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -124,7 +124,7 @@ test_expect_success 'test diff.renames=false' '
 
 test_expect_success 'test diff.renames unset' '
 	git diff --cached $tree >current &&
-	compare_diff_patch current no-rename
+	compare_diff_patch current expected
 '
 
 test_expect_success 'favour same basenames over different ones' '
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6ec6072..94ef500 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -90,6 +90,8 @@ test_expect_success setup '
 	git commit -m "Rearranged lines in dir/sub" &&
 	git checkout master &&
 
+	git config diff.renames false &&
+
 	git show-branch
 '
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3b99434..eed2981 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -549,7 +549,7 @@ test_expect_success 'cover-letter inherits diff options' '
 
 	git mv file foo &&
 	git commit -m foo &&
-	git format-patch --cover-letter -1 &&
+	git format-patch --no-renames --cover-letter -1 &&
 	check_patch 0000-cover-letter.patch &&
 	! grep "file => foo .* 0 *\$" 0000-cover-letter.patch &&
 	git format-patch --cover-letter -1 -M &&
@@ -703,7 +703,7 @@ test_expect_success 'options no longer allowed for format-patch' '
 
 test_expect_success 'format-patch --numstat should produce a patch' '
 	git format-patch --numstat --stdout master..side > output &&
-	test 6 = $(grep "^diff --git a/" output | wc -l)'
+	test 5 = $(grep "^diff --git a/" output | wc -l)'
 
 test_expect_success 'format-patch -- <path>' '
 	git format-patch master..side -- file 2>error &&
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 3b8b792..447a8ff 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -248,7 +248,8 @@ EOF
 	git rm -r src/move/unchanged &&
 	git rm -r src/move/changed &&
 	git rm -r src/move/rearranged &&
-	git commit -m "changes"
+	git commit -m "changes" &&
+	git config diff.renames false
 '
 
 cat <<EOF >expect_diff_stat
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index cb82eb7..128ba93 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -101,8 +101,8 @@ test_expect_success 'oneline' '
 
 test_expect_success 'diff-filter=A' '
 
-	git log --pretty="format:%s" --diff-filter=A HEAD > actual &&
-	git log --pretty="format:%s" --diff-filter A HEAD > actual-separate &&
+	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
+	git log --no-renames --pretty="format:%s" --diff-filter A HEAD > actual-separate &&
 	printf "fifth\nfourth\nthird\ninitial" > expect &&
 	test_cmp expect actual &&
 	test_cmp expect actual-separate
@@ -119,7 +119,7 @@ test_expect_success 'diff-filter=M' '
 
 test_expect_success 'diff-filter=D' '
 
-	actual=$(git log --pretty="format:%s" --diff-filter=D HEAD) &&
+	actual=$(git log --no-renames --pretty="format:%s" --diff-filter=D HEAD) &&
 	expect=$(echo sixth ; echo third) &&
 	verbose test "$actual" = "$expect"
 
@@ -848,7 +848,7 @@ sanitize_output () {
 }
 
 test_expect_success 'log --graph with diff and stats' '
-	git log --graph --pretty=short --stat -p >actual &&
+	git log --no-renames --graph --pretty=short --stat -p >actual &&
 	sanitize_output >actual.sanitized <actual &&
 	test_i18ncmp expect actual.sanitized
 '
-- 
2.7.2.334.g35ed2ae.dirty
