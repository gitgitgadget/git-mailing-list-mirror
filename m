From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH v5] Add an explicit GIT_DIR to the list of excludes
Date: Wed,  4 Jun 2014 13:15:09 -0700
Message-ID: <1401912909-29654-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: jrnieder@gmail.com, jnareb@gmail.com, git@vger.kernel.org,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 04 22:15:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsHam-00061P-Ip
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 22:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbaFDUPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 16:15:19 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:56202 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbaFDUPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 16:15:18 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so10655pbc.14
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xzwpxse//QjDbtmlsJE9o0pKMRNGqwZZEHyP+ptLl8Y=;
        b=vZFP+7kR1jtUkl44o4fqKKPXd+QkwWntnh9YfDBHfjyFlFcoNfCXOa2bWEpqRHSbI1
         4JHnr3x87WElyh0fGhyxO2WFTrAZz6pcNVdBfzq1sayHUB+iLmetHSDKnW4u5X5iqUrB
         qo/vcHJuaZ2OftzGaETmP/j8itN8xExWGJABT9kDFij8B3RW7lC4XNjIGpmVLSP6EHmd
         NMQumLQ1sotZ1gW15ACs56HvcqVj8rNc6hhy6O1GPqj+wZdYKBJ58eFjuyBNxsUUe7Og
         /NwZ/fY5/AHL1H+0+CIgI6yAE0B1G4NKQ1lTwE2ZjJUhw0l7GpfUE4Fr85j0A8kMM+8O
         HoHA==
X-Received: by 10.68.222.196 with SMTP id qo4mr67511114pbc.14.1401912917478;
        Wed, 04 Jun 2014 13:15:17 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id ue3sm13552265pbc.49.2014.06.04.13.15.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 13:15:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250777>

When an explicit '--git-dir' option points to a directory inside
the work tree, git treats it as if it were any other directory.
In particular, 'git status' lists it as untracked, while 'git add -A'
stages the metadata directory entirely

Add GIT_DIR to the list of excludes in a dedicated function
add_git_dir_exclude(), while checking that GIT_DIR is not just '.git'
or its basename is not '.git', in which cases it would be ignored
by default, and that GIT_DIR is inside GIT_WORK_TREE. Function
add_git_dir_exclude() is invoked at the beginning of
dir.c:setup_standard_excludes()

Although an analogous comparison of any given path against '.git'
is done in treat_path(), this does not seem to be the right place
to compare against GIT_DIR. Instead, the excludes provide an
effective mechanism of ignoring a file/directory, and adding GIT_DIR
as an exclude is equivalent to putting it into '.gitignore'. Function
setup_standard_excludes() was chosen because that is the place where
the excludes are initialized by the commands that are concerned about
excludes

Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
---
basename() is not needed anymore, as we are excluding a "full" path GIT_DIR
but relative to GIT_WORK_TREE. Now, a full path ensures that nothing
else gets excluded (i.e. files with the same basename), and this behaviour
is checked in tests

Docs (git-grep, git-ls-files, gitignore) will be updated in the
subsequent version, wanted to check right now if you agree with code.
Docs kind of depend on what we decide about the code

 Documentation/technical/api-directory-listing.txt |   4 +-
 dir.c                                             |  33 ++++
 t/t2205-add-gitdir.sh                             | 187 ++++++++++++++++++++++
 3 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100755 t/t2205-add-gitdir.sh

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 7f8e78d..fd4a178 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -90,8 +90,8 @@ marked. If you to exclude files, make sure you have loaded index first.
   `add_exclude()`.
 
 * To add patterns from a file (e.g. `.git/info/exclude`), call
-  `add_excludes_from_file()` , and/or set `dir.exclude_per_dir`.  A
-  short-hand function `setup_standard_excludes()` can be used to set
+  `add_excludes_from_file()` , and/or set `dir.exclude_per_dir`.  The
+  short-hand function `setup_standard_excludes()` must be used to set
   up the standard set of exclude settings.
 
 * Set options described in the Data Structure section above.
diff --git a/dir.c b/dir.c
index eb6f581..300ce1c 100644
--- a/dir.c
+++ b/dir.c
@@ -1604,11 +1604,44 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 	return remove_dir_recurse(path, flag, NULL);
 }
 
+static void add_git_dir_exclude(struct dir_struct *dir)
+{
+	const char *r_git, *gitdir = get_git_dir();
+	char *n_git;
+	int len;
+
+	r_git = real_path(absolute_path(gitdir));
+	n_git = xmalloc(strlen(r_git) + 1 + 1);
+	normalize_path_copy(n_git, r_git);
+	len = strlen(n_git);
+
+	/* only add it if GIT_DIR does not end with '.git' or '/.git' */
+	if (len < 4 || strcmp(n_git + len - 4, ".git") ||
+	    (len > 4 && n_git[len - 5] != '/')) {
+		const char *worktree = get_git_work_tree();
+
+		if (!worktree ||
+		    dir_inside_of(n_git, worktree) >= 0) {
+			struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
+							"GIT_DIR setup");
+			char *reldir = worktree ? n_git + strlen(worktree) : n_git;
+
+			/* append a trailing slash to exclude directories only */
+			n_git[len] = '/';
+			n_git[len + 1] = '\0';
+			add_exclude(reldir, "", 0, el, 0);
+		}
+	}
+	free(n_git);
+}
+
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
 	char *xdg_path;
 
+	add_git_dir_exclude(dir);
+
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
 	if (!excludes_file) {
diff --git a/t/t2205-add-gitdir.sh b/t/t2205-add-gitdir.sh
new file mode 100755
index 0000000..721970e
--- /dev/null
+++ b/t/t2205-add-gitdir.sh
@@ -0,0 +1,187 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Pasha Bolokhov
+#
+
+test_description='alternative repository path specified by --git-dir is ignored by add and status'
+
+. ./test-lib.sh
+
+#
+# Create a tree:
+#
+#	repo-inside/  repo-outside/
+#
+#
+# repo-inside:
+# 	a  b  c  d  dir1/ dir2/ [meta/]
+#
+# repo-inside/dir1:
+# 	e  f  g  h  meta/  ssubdir/
+#
+# repo-inside/dir1/meta:
+# 	aa
+#
+# repo-inside/dir1/ssubdir:
+# 	meta/
+#
+# repo-inside/dir1/ssubdir/meta:
+# 	aaa
+#
+# repo-inside/dir2:
+#	meta
+#
+#
+#
+# repo-outside:
+#	external/  tree/
+#
+# repo-outside/external:
+#	[meta/]
+#
+# repo-outside/tree:
+#	n  o  p  q  meta/  sub/
+#
+# repo-outside/tree/meta:
+#	bb
+#
+# repo-outside/tree/sub:
+#	meta/
+#
+# repo-outside/tree/sub/meta:
+#	bbb
+#
+#
+# (both of the above [meta/] denote the actual repositories)
+#
+
+#
+# First set of tests (in "repo-inside/"):
+# ---------------------------------------
+#
+# Name the repository "meta" and see whether or not "git status" includes or
+# ignores directories named "meta". Directory "meta" at the top level of
+# "repo-inside/"is the repository and appears upon the first "git init"
+#
+#
+# Second set of tests (in "repo-outside/"):
+# -----------------------------------------
+#
+# Put the work tree into "tree/" and repository into "external/meta"
+# (the latter directory appears upon the corresponding "git init").
+# The work tree again contains directories named "meta", but those ones are
+# tested not to be ignored now
+#
+
+test_expect_success "setup" '
+	mkdir repo-inside/ &&
+	(
+		cd repo-inside/ &&
+		for f in a b c d
+		do
+			echo "DATA" >"$f" || exit 1
+		done &&
+		mkdir dir1 dir1/meta &&
+		mkdir dir1/ssubdir dir1/ssubdir/meta &&
+		for f in e f g h
+		do
+			echo "MORE DATA" >"dir1/$f" || exit 1
+		done &&
+		echo "EVEN more Data" >dir1/meta/aa &&
+		echo "Data and BAIT" >dir1/ssubdir/meta/aaa &&
+		mkdir dir2
+		echo "Not a Metadata File" >dir2/meta
+		git --git-dir=meta init
+	) &&
+	mkdir repo-outside/ repo-outside/external repo-outside/tree &&
+	(
+		cd repo-outside/tree &&
+		for f in n o p q
+		do
+			echo "Literal Data" >"$f" || exit 1
+		done &&
+		mkdir meta sub sub/meta &&
+		echo "Sample data" >meta/bb &&
+		echo "Stream of data" >sub/meta/bbb &&
+		git --git-dir=../external/meta init
+	)
+'
+
+
+#
+# The first set of tests (the repository is inside the work tree)
+#
+test_expect_success "'git status' ignores the repository directory" '
+	(
+		cd repo-inside &&
+		git --git-dir=meta --work-tree=. status --porcelain --untracked=all |
+			grep meta | sort >status.actual.2 &&
+		cat >status.expect.2 <<-\EOF &&
+		?? dir1/meta/aa
+		?? dir1/ssubdir/meta/aaa
+		?? dir2/meta
+		EOF
+		test_cmp status.actual.2 status.expect.2
+	)
+'
+
+test_expect_success "'git add -A' ignores the repository directory" '
+	(
+		cd repo-inside &&
+		git --git-dir=meta --work-tree=. add -A &&
+		git --git-dir=meta --work-tree=. status --porcelain | grep meta | sort >status.actual.3 &&
+		cat >status.expect.3 <<-\EOF &&
+		A  dir1/meta/aa
+		A  dir1/ssubdir/meta/aaa
+		A  dir2/meta
+		EOF
+		test_cmp status.actual.3 status.expect.3
+	)
+'
+
+test_expect_success "'git grep --exclude-standard' ignores the repository directory" '
+	(
+		cd repo-inside &&
+		test_might_fail git --git-dir=meta \
+			grep --no-index --exclude-standard BAIT >grep.actual.4 &&
+		cat >grep.expect.4 <<-\EOF &&
+		dir1/ssubdir/meta/aaa:Data and BAIT
+		EOF
+		test_cmp grep.actual.4 grep.expect.4
+	)
+'
+
+#
+# The second set of tests (the repository is outside of the work tree)
+#
+test_expect_success "'git status' acknowledges directories 'meta' \
+if repo is not within work tree" '
+	test_might_fail rm -rf meta/ &&
+	(
+		cd repo-outside/tree &&
+		git --git-dir=../external/meta init &&
+		git --git-dir=../external/meta --work-tree=. status --porcelain --untracked=all |
+			grep meta | sort >status.actual.5 &&
+		cat >status.expect.5 <<-\EOF &&
+		?? meta/bb
+		?? sub/meta/bbb
+		EOF
+		test_cmp status.actual.5 status.expect.5
+	)
+'
+
+test_expect_success "'git add -A' adds 'meta' if the repo is outside the work tree" '
+	(
+		cd repo-outside/tree &&
+		git --git-dir=../external/meta --work-tree=. add -A &&
+		git --git-dir=../external/meta --work-tree=. status --porcelain --untracked=all |
+			grep meta | sort >status.actual.6 &&
+		cat >status.expect.6 <<-\EOF &&
+		A  meta/bb
+		A  sub/meta/bbb
+		EOF
+		test_cmp status.actual.6 status.expect.6
+	)
+'
+
+test_done
-- 
1.9.1
