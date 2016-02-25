From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 0/5] activate diff.renames by default
Date: Thu, 25 Feb 2016 09:59:16 +0100
Message-ID: <1456390761-27015-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 09:59:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrlv-0007lY-G8
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759232AbcBYI7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:59:35 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55605 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758272AbcBYI7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:59:34 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8xONK013639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:59:24 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8xP4x010992;
	Thu, 25 Feb 2016 09:59:25 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Feb 2016 09:59:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8xONK013639
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456995564.7305@A/tgTHJamTh/+76pY+u1+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287347>

Remarks on v1 applied:

* document that diff.renames applies only to porcelain

* use <<- instead of << in tests

* rename git_diff_ui_default_config to init_diff_ui_defaults

* f() -> f(void)

Interdiff follows:

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index fdf5a79..69389ae 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -111,7 +111,10 @@ diff.renames::
 	Whether and how Git detects renames.  If set to "false",
 	rename detection is disabled. If set to "true", basic rename
 	detection is enable.  If set to "copies" or "copy", Git will
-	detect copies, as well.  Defaults to true.
+	detect copies, as well.  Defaults to true.  Note that this
+	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
+	linkgit:git-log[1], and not lower level commands such as
+	linkgit:git-diff-files[1].
 
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
diff --git a/builtin/commit.c b/builtin/commit.c
index 3cb4843..109742e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -186,7 +186,7 @@ static void status_init_config(struct wt_status *s, config_fn_t fn)
 	gitmodules_config();
 	git_config(fn, s);
 	determine_whence(s);
-	git_diff_ui_default_config();
+	init_diff_ui_defaults();
 	s->hints = advice_status_hints; /* must come after git_config() */
 }
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 8bd1fd5..343c6b8 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -318,7 +318,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	if (!no_index)
 		gitmodules_config();
-	git_diff_ui_default_config();
+	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
 
 	init_revisions(&rev, prefix);
diff --git a/builtin/log.c b/builtin/log.c
index 6e34df3..c05a5f6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -103,7 +103,7 @@ static int log_line_range_callback(const struct option *option, const char *arg,
 static void init_log_defaults()
 {
 	init_grep_defaults();
-	git_diff_ui_default_config();
+	init_diff_ui_defaults();
 }
 
 static void cmd_log_init_defaults(struct rev_info *rev)
diff --git a/builtin/merge.c b/builtin/merge.c
index cf297d4..4cb4f6a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1187,7 +1187,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	else
 		head_commit = lookup_commit_or_die(head_sha1, "HEAD");
 
-	git_diff_ui_default_config();
+	init_diff_ui_defaults();
 	git_config(git_merge_config, NULL);
 
 	if (branch_mergeoptions)
diff --git a/diff.c b/diff.c
index d5db898..b4dea07 100644
--- a/diff.c
+++ b/diff.c
@@ -168,7 +168,7 @@ long parse_algorithm_value(const char *value)
  * never be affected by the setting of diff.renames
  * the user happens to have in the configuration file.
  */
-void git_diff_ui_default_config()
+void init_diff_ui_defaults(void)
 {
 	diff_detect_rename_default = 1;
 }
diff --git a/diff.h b/diff.h
index 75686d5..0a3ce86 100644
--- a/diff.h
+++ b/diff.h
@@ -266,7 +266,7 @@ extern int parse_long_opt(const char *opt, const char **argv,
 			 const char **optarg);
 
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
-extern void git_diff_ui_default_config();
+extern void init_diff_ui_defaults(void);
 extern int git_diff_ui_config(const char *var, const char *value, void *cb);
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int, const char *);
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 15d99a3..c7e58b6 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -10,83 +10,83 @@ test_description='Test rename detection in diff engine.
 . "$TEST_DIRECTORY"/diff-lib.sh
 
 test_expect_success 'setup' '
-	cat >path0 <<\EOF &&
-Line 1
-Line 2
-Line 3
-Line 4
-Line 5
-Line 6
-Line 7
-Line 8
-Line 9
-Line 10
-line 11
-Line 12
-Line 13
-Line 14
-Line 15
-EOF
-	cat >expected <<\EOF &&
-diff --git a/path0 b/path1
-rename from path0
-rename to path1
---- a/path0
-+++ b/path1
-@@ -8,7 +8,7 @@ Line 7
- Line 8
- Line 9
- Line 10
--line 11
-+Line 11
- Line 12
- Line 13
- Line 14
-EOF
-	cat >no-rename <<\EOF
-diff --git a/path0 b/path0
-deleted file mode 100644
-index fdbec44..0000000
---- a/path0
-+++ /dev/null
-@@ -1,15 +0,0 @@
--Line 1
--Line 2
--Line 3
--Line 4
--Line 5
--Line 6
--Line 7
--Line 8
--Line 9
--Line 10
--line 11
--Line 12
--Line 13
--Line 14
--Line 15
-diff --git a/path1 b/path1
-new file mode 100644
-index 0000000..752c50e
---- /dev/null
-+++ b/path1
-@@ -0,0 +1,15 @@
-+Line 1
-+Line 2
-+Line 3
-+Line 4
-+Line 5
-+Line 6
-+Line 7
-+Line 8
-+Line 9
-+Line 10
-+Line 11
-+Line 12
-+Line 13
-+Line 14
-+Line 15
-EOF
+	cat >path0 <<-\EOF &&
+	Line 1
+	Line 2
+	Line 3
+	Line 4
+	Line 5
+	Line 6
+	Line 7
+	Line 8
+	Line 9
+	Line 10
+	line 11
+	Line 12
+	Line 13
+	Line 14
+	Line 15
+	EOF
+	cat >expected <<-\EOF &&
+	diff --git a/path0 b/path1
+	rename from path0
+	rename to path1
+	--- a/path0
+	+++ b/path1
+	@@ -8,7 +8,7 @@ Line 7
+	 Line 8
+	 Line 9
+	 Line 10
+	-line 11
+	+Line 11
+	 Line 12
+	 Line 13
+	 Line 14
+	EOF
+	cat >no-rename <<-\EOF
+	diff --git a/path0 b/path0
+	deleted file mode 100644
+	index fdbec44..0000000
+	--- a/path0
+	+++ /dev/null
+	@@ -1,15 +0,0 @@
+	-Line 1
+	-Line 2
+	-Line 3
+	-Line 4
+	-Line 5
+	-Line 6
+	-Line 7
+	-Line 8
+	-Line 9
+	-Line 10
+	-line 11
+	-Line 12
+	-Line 13
+	-Line 14
+	-Line 15
+	diff --git a/path1 b/path1
+	new file mode 100644
+	index 0000000..752c50e
+	--- /dev/null
+	+++ b/path1
+	@@ -0,0 +1,15 @@
+	+Line 1
+	+Line 2
+	+Line 3
+	+Line 4
+	+Line 5
+	+Line 6
+	+Line 7
+	+Line 8
+	+Line 9
+	+Line 10
+	+Line 11
+	+Line 12
+	+Line 13
+	+Line 14
+	+Line 15
+	EOF
 '
 
 test_expect_success \




Matthieu Moy (5):
  Documentation/diff-config: fix description of diff.renames
  t4001-diff-rename: wrap file creations in a test
  t: add tests for diff.renames (true/false/unset)
  log: introduce init_log_defaults()
  diff: activate diff.renames by default

 Documentation/diff-config.txt |  10 +++-
 builtin/commit.c              |   1 +
 builtin/diff.c                |   1 +
 builtin/log.c                 |  16 ++++--
 builtin/merge.c               |   1 +
 diff.c                        |   5 ++
 diff.h                        |   1 +
 t/t4001-diff-rename.sh        | 125 +++++++++++++++++++++++++++++++-----------
 t/t4013-diff-various.sh       |   2 +
 t/t4014-format-patch.sh       |   4 +-
 t/t4047-diff-dirstat.sh       |   3 +-
 t/t4202-log.sh                |   8 +--
 12 files changed, 131 insertions(+), 46 deletions(-)

-- 
2.7.2.334.g35ed2ae.dirty
