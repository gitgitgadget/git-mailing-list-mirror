From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH v4] Add an explicit GIT_DIR to the list of excludes
Date: Mon, 26 May 2014 20:56:47 -0700
Message-ID: <1401163007-5808-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: jrnieder@gmail.com, git@vger.kernel.org,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue May 27 05:57:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp8Va-0005cG-L5
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 05:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbaE0D46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 23:56:58 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46922 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaE0D45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 23:56:57 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so8457950pad.30
        for <git@vger.kernel.org>; Mon, 26 May 2014 20:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=a9z2UsP6Ixty2kfkZFOttCQeC2nhylDh9FThmF4fJwA=;
        b=tWywFzudFiTP5NntTZxz3KwvOdwHQY3RCsyD9GAipakkVlk8H+5r2EJeW0XsuyBC4H
         v0lONlndFBDYUmHw5SxizpGNeWvRtFCxenjlWGLv0WatDBub3mVkQvYKqbXDCj2GuPVO
         b8euk7N9oFjLqAmtBSX+iC1MoJvtYRDAcTougSEu7rfW6idVPmr/hOYUtPNMu5Nn2/mH
         iwwSNe8QNdU8K8kG806nh6tSMN8hRsJYrdF6FRidw5yX96akaOE85Kavk+wAxgiHShvd
         g8o6NzKnjMa4D+96Mpl+b5HWc0Ahx7h47jO8QjQ7eZR45LEhU9N7FDGSekEPKIqHjy8l
         YR2g==
X-Received: by 10.68.100.162 with SMTP id ez2mr22563072pbb.18.1401163016670;
        Mon, 26 May 2014 20:56:56 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id iv2sm20740880pbc.19.2014.05.26.20.56.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 May 2014 20:56:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250139>

When an explicit '--git-dir' option points to a directory inside
the work tree, git treats it as if it were any other directory.
In particular, 'git status' lists it as untracked, while 'git add -A'
stages the metadata directory entirely

Add GIT_DIR to the list of excludes in setup_standard_excludes(),
while checking that GIT_DIR is not just '.git', in which case it
would be ignored by default, and that GIT_DIR is inside GIT_WORK_TREE

Although an analogous comparison of any given path against '.git'
is done in treat_path(), this does not seem to be the right place
to compare against GIT_DIR. Instead, the excludes provide an
effective mechanism of ignoring a file/directory, and adding GIT_DIR
as an exclude is equivalent of putting it into '.gitignore'. Function
setup_standard_excludes() was chosen because that is the place where
the excludes are initialized by the commands that are concerned about
excludes

Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
---
Improve test tree structure.
Add a check for work_tree==NULL in dir.c:setup_standard_excludes
When work_tree is NULL, there is no concept of whether the
repo is within work tree or not, but we still default to ignoring
GIT_DIR

 Documentation/technical/api-directory-listing.txt |   4 +-
 dir.c                                             |  32 +++++
 t/t2205-add-gitdir.sh                             | 163 ++++++++++++++++++++++
 3 files changed, 197 insertions(+), 2 deletions(-)
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
index 98bb50f..dd76da1 100644
--- a/dir.c
+++ b/dir.c
@@ -1588,6 +1588,38 @@ void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
 	char *xdg_path;
+	const char *r_git, *gitdir = get_git_dir();
+	char *n_git, *basename;
+	int len, i;
+
+	/*
+	 * Add git directory to the ignores; do this only if
+	 * GIT_DIR does not end with "/.git"
+	 */
+	r_git = real_path(absolute_path(gitdir));
+	n_git = xmalloc(strlen(r_git) + 1 + 1);
+	normalize_path_copy(n_git, r_git);
+
+	len = strlen(n_git); /* real_path() has stripped trailing slash */
+	for (i = len - 1; i > 0 && !is_dir_sep(n_git[i]); i--) ;
+	basename = n_git + i;
+	if (is_dir_sep(*basename))
+		basename++;
+	if (strcmp(basename, ".git")) {
+		const char *worktree = get_git_work_tree();
+
+		if (worktree == NULL ||
+		    dir_inside_of(n_git, get_git_work_tree()) >= 0) {
+			struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
+							"GIT_DIR setup");
+
+			/* append a trailing slash to exclude directories */
+			n_git[len] = '/';
+			n_git[len + 1] = '\0';
+			add_exclude(basename, "", 0, el, 0);
+		}
+	}
+	free(n_git);
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
diff --git a/t/t2205-add-gitdir.sh b/t/t2205-add-gitdir.sh
new file mode 100755
index 0000000..4cc26af
--- /dev/null
+++ b/t/t2205-add-gitdir.sh
@@ -0,0 +1,163 @@
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
+# 	a  b  c  d  subdir/ [meta/]
+#
+# repo-inside/subdir:
+# 	e  f  g  h  meta/  ssubdir/
+#
+# repo-inside/subdir/meta:
+# 	aa
+#
+# repo-inside/subdir/ssubdir:
+# 	meta/
+#
+# repo-inside/subdir/ssubdir/meta:
+# 	aaa
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
+		mkdir subdir subdir/meta &&
+		mkdir subdir/ssubdir subdir/ssubdir/meta &&
+		for f in e f g h
+		do
+			echo "MORE DATA" >"subdir/$f" || exit 1
+		done &&
+		echo "EVEN more Data" >subdir/meta/aa &&
+		echo "Data and BAIT" >subdir/ssubdir/meta/aaa &&
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
+		echo "Stream of data and BAIT" >sub/meta/bbb &&
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
+		git --git-dir=meta --work-tree=. status --porcelain >status.out &&
+		test_might_fail grep meta status.out >out &&
+		! test -s out
+	)
+'
+
+test_expect_success "'git add -A' ignores the repository directory" '
+	(
+		cd repo-inside &&
+		git --git-dir=meta --work-tree=. add -A &&
+		git --git-dir=meta --work-tree=. status --porcelain >status1.out &&
+		test_might_fail grep meta status1.out >out1 &&
+		! test -s out1
+	)
+'
+
+test_expect_success "'git grep --exclude-standard' ignores the repository directory" '
+	(
+		cd repo-inside &&
+		test_might_fail git --git-dir=meta \
+			grep --no-index --exclude-standard BAIT >out2 &&
+		! test -s out2
+	)
+'
+
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
+		git --git-dir=../external/meta --work-tree=. status --porcelain >status3.out &&
+		test_might_fail grep meta status3.out >out3 &&
+		test -s out3
+	)
+'
+
+test_expect_success "'git add -A' adds 'meta' if the repo is outside the work tree" '
+	(
+		cd repo-outside/tree &&
+		git --git-dir=../external/meta --work-tree=. add -A &&
+		git --git-dir=../external/meta --work-tree=. status --porcelain >status4.out &&
+		test_might_fail grep meta status4.out >out4 &&
+		test -s out4
+	)
+'
+
+test_done
-- 
1.9.1
