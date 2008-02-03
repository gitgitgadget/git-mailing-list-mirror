From: Elvis Pranskevichus <el@prans.net>
Subject: [PATCH] Add "core.excludesperdirfile" configuration variable
Date: Sun,  3 Feb 2008 01:56:31 -0500
Message-ID: <1202021791-5469-1-git-send-email-el@prans.net>
Cc: Elvis Pranskevichus <el@prans.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 08:24:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLZDi-0007gQ-QS
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 08:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613AbYBCHYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 02:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757436AbYBCHYW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 02:24:22 -0500
Received: from mail.prans.org ([64.79.206.200]:54247 "EHLO mail.prans.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbYBCHYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 02:24:21 -0500
X-Greylist: delayed 1661 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Feb 2008 02:24:20 EST
Received: from [99.226.11.52] (helo=asgard.prans.org)
	by mail.prans.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <el@asgard.prans.org>)
	id 1JLYmJ-0004eP-K1; Sat, 02 Feb 2008 22:56:36 -0800
Received: from el by asgard.prans.org with local (Exim 4.68)
	(envelope-from <el@asgard.prans.org>)
	id 1JLYmF-0001QZ-Va; Sun, 03 Feb 2008 01:56:32 -0500
X-Mailer: git-send-email 1.5.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72334>

Make it possible to override the ".gitignore" file name
with "core.excludesperdirfile" configuration variable.

This is particularly useful for repos that are mirrored
from another SCM which uses similar syntax, but different
name, for the exclusion patterns files. The most common
example is CVS with its .cvsignore.

The change is fairly trivial, since the .gitignore name
was hardcoded only in a few places on porcelain level.

Signed-off-by: Elvis Pranskevichus <el@prans.net>
---
 Documentation/config.txt           |   12 ++++++++----
 Documentation/gitignore.txt        |   12 +++++++-----
 cache.h                            |    1 +
 config.c                           |    7 +++++++
 contrib/examples/git-clean.sh      |    9 +++++++--
 dir.c                              |    4 +++-
 environment.c                      |    1 +
 git-checkout.sh                    |    8 +++++++-
 git-merge.sh                       |    7 ++++++-
 t/t3001-ls-files-others-exclude.sh |   19 +++++++++++++++++++
 t/t7300-clean.sh                   |   15 +++++++++++++++
 11 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e222f1..b076bea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -277,11 +277,15 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.excludesperdirfile::
+	The name of the per-directory file containing patterns
+	of files which are not meant to be tracked. The default
+	is ".gitignore".  See linkgit:gitignore[5].
+
 core.excludesfile::
-	In addition to '.gitignore' (per-directory) and
-	'.git/info/exclude', git looks into this file for patterns
-	of files which are not meant to be tracked.  See
-	linkgit:gitignore[5].
+	The name of the file containing exclusion patterns for
+	git to take into consideration in addition to per-directory
+	excludes files and '.git/info/exclude'.  See linkgit:gitignore[5].
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 08373f5..533be1f 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -24,14 +24,16 @@ precedence, the last matching pattern decides the outcome):
  * Patterns read from the command line for those commands that support
    them.
 
- * Patterns read from a `.gitignore` file in the same directory
+ * Patterns read from a special file in the same directory
    as the path, or in any parent directory, with patterns in the
    higher level files (up to the root) being overridden by those in
    lower level files down to the directory containing the file.
-   These patterns match relative to the location of the
-   `.gitignore` file.  A project normally includes such
-   `.gitignore` files in its repository, containing patterns for
-   files generated as part of the project build.
+   The name of the files containing patterns is `.gitignore` by default,
+   which can be overridden by the `core.excludesPerDirFile` configuration
+   variable.
+   The patterns match relative to the location of the holding file.
+   A project normally includes such `.gitignore` files in its repository,
+   containing patterns for files generated as part of the project build.
 
  * Patterns read from `$GIT_DIR/info/exclude`.
 
diff --git a/cache.h b/cache.h
index 549f4bb..33cb1ff 100644
--- a/cache.h
+++ b/cache.h
@@ -614,6 +614,7 @@ extern int pager_use_color;
 
 extern char *editor_program;
 extern char *excludes_file;
+extern char *excludes_per_dir_file;
 
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
diff --git a/config.c b/config.c
index 526a3f4..be1f80b 100644
--- a/config.c
+++ b/config.c
@@ -450,6 +450,13 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.excludesperdirfile")) {
+		if (!value)
+			die("core.excludesperdirfile without value");
+		excludes_per_dir_file = xstrdup(value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.whitespace")) {
 		whitespace_rule_cfg = parse_whitespace_rule(value);
 		return 0;
diff --git a/contrib/examples/git-clean.sh b/contrib/examples/git-clean.sh
index 01c95e9..3e2e936 100755
--- a/contrib/examples/git-clean.sh
+++ b/contrib/examples/git-clean.sh
@@ -86,8 +86,7 @@ if [ "$ignored,$ignoredonly" = "1,1" ]; then
 fi
 
 if [ -z "$ignored" ]; then
-	excl="--exclude-per-directory=.gitignore"
-	excl_info= excludes_file=
+	excl_info= excludes_file= excludes_per_dir_file=
 	if [ -f "$GIT_DIR/info/exclude" ]; then
 		excl_info="--exclude-from=$GIT_DIR/info/exclude"
 	fi
@@ -95,6 +94,12 @@ if [ -z "$ignored" ]; then
 	then
 		excludes_file="--exclude-from=$cfg_excl"
 	fi
+	excludes_per_dir_file=$(git config core.excludesperdirfile)
+	if [ -z "$excludes_per_dir_file" ];
+	then
+		excludes_per_dir_file=".gitignore"
+	fi
+	excl="--exclude-per-directory=$excludes_per_dir_file"
 	if [ "$ignoredonly" ]; then
 		excl="$excl --ignored"
 	fi
diff --git a/dir.c b/dir.c
index 3e345c2..e8c1ea7 100644
--- a/dir.c
+++ b/dir.c
@@ -786,7 +786,9 @@ void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
 
-	dir->exclude_per_dir = ".gitignore";
+	dir->exclude_per_dir = excludes_per_dir_file ?
+				excludes_per_dir_file : ".gitignore";
+
 	path = git_path("info/exclude");
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
diff --git a/environment.c b/environment.c
index 18a1c4e..ee3871f 100644
--- a/environment.c
+++ b/environment.c
@@ -34,6 +34,7 @@ char *pager_program;
 int pager_use_color = 1;
 char *editor_program;
 char *excludes_file;
+char *excludes_per_dir_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 
diff --git a/git-checkout.sh b/git-checkout.sh
index bd74d70..ac56085 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -210,7 +210,13 @@ then
     git read-tree $v --reset -u $new
 else
     git update-index --refresh >/dev/null
-    merge_error=$(git read-tree -m -u --exclude-per-directory=.gitignore $old $new 2>&1) || (
+    excl_per_dir_file=$(git config core.excludesperdirfile)
+    if [ -z "$excl_per_dir_file" ];
+    then
+        excl_per_dir_file=".gitignore"
+    fi
+
+    merge_error=$(git read-tree -m -u --exclude-per-directory=$excl_per_dir_file $old $new 2>&1) || (
 	case "$merge" in
 	'')
 		echo >&2 "$merge_error"
diff --git a/git-merge.sh b/git-merge.sh
index 1c123a3..30b5f0d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -348,8 +348,13 @@ t,1,"$head",*)
 	then
 		msg="$msg (no commit created; -m option ignored)"
 	fi
+	excl_per_dir_file=$(git config core.excludesperdirfile)
+	if [ -z "$excl_per_dir_file" ];
+	then
+		excl_per_dir_file=".gitignore"
+	fi
 	new_head=$(git rev-parse --verify "$1^0") &&
-	git read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
+	git read-tree -v -m -u --exclude-per-directory=$excl_per_dir_file $head "$new_head" &&
 	finish "$new_head" "$msg" || exit
 	dropsave
 	exit 0
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index e25b255..3c99a60 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -99,4 +99,23 @@ EOF
 test_expect_success 'git-status honours core.excludesfile' \
 	'diff -u expect output'
 
+
+git config core.excludesperdirfile .myignore
+cat > .myignore << EOF
+output
+!/*.[47]
+EOF
+
+cat > expect << EOF
+#	.gitignore
+#	.myignore
+#	a.4
+#	a.7
+#	one/
+EOF
+
+test_expect_success 'git status honours core.excludesperdirfile' \
+	'git status | grep "^#	" > output &&
+	 git diff expect output'
+
 test_done
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index dfd1188..500abed 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -316,4 +316,19 @@ test_expect_success 'core.excludesfile' '
 
 '
 
+test_expect_success 'core.excludesperdirfile' '
+
+	mkdir -p build docs src &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	git config core.excludesperdirfile .myignore &&
+	echo a.out >.myignore &&
+	echo lib.so >build/.myignore &&
+	git-clean -f &&
+	test ! -f src/part3.c &&
+	test ! -f obj.o &&
+	test -f build/lib.so &&
+	test -f a.out
+
+'
+
 test_done
-- 
1.5.4.GIT
