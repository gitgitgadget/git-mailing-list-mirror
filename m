From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH v6] Add an explicit GIT_DIR to the list of excludes
Date: Wed, 11 Jun 2014 16:28:28 -0700
Message-ID: <1402529308-3940-1-git-send-email-pasha.bolokhov@gmail.com>
References: <CACsJy8Cgu792Tamej3+_9w=Krg8nezYYA6k604gikebHG=yVUg@mail.gmail.com>
Cc: jrnieder@gmail.com, jnareb@gmail.com, git@vger.kernel.org,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 12 01:28:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wurws-0004KH-0t
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 01:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbaFKX2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 19:28:49 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36480 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbaFKX2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 19:28:48 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so302969pdj.35
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vlbnC6RoMafddHfMxVOMrg//FnjGG2sPjILZ0IBlopw=;
        b=eWoYrlIt6c8Wb/jLTZs18HzG7tSRIl8RfRfb3U7AYsnCB56Vdjjjur8C6sDw7d+V4w
         kgTjIVQVBfeoLpwWle+mvJRtXLvrFKUYxmG2FIq8SfcfVNIijIRe+AHwxkCWWaKvVWh6
         y2kJYNl9tl8S6Bu+9B+Qgcew2OucR5kloBeGxopsOqRg7EGqHk1MFAQQyj7jUIuMDedY
         1guguk/Mtz0hu5MN5XzHncF1EqPvsYh7CN2jtQmvKkV6EuirHAEK6pK9KwS8VQHArc4P
         AY0KTuESW1VosermJfDILWHk5eEtEYu+AKT/IaiqFw/0e7PILsFZbWtH8ji1g8aEf50O
         08wg==
X-Received: by 10.68.178.194 with SMTP id da2mr8540935pbc.151.1402529327953;
        Wed, 11 Jun 2014 16:28:47 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id qq5sm76994116pbb.24.2014.06.11.16.28.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jun 2014 16:28:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CACsJy8Cgu792Tamej3+_9w=Krg8nezYYA6k604gikebHG=yVUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251390>

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
Negate the 'basename(GIT_DIR) != ".git"' check for better readability
in add_git_dir_exclude()

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
index 797805d..3f57e34 100644
--- a/dir.c
+++ b/dir.c
@@ -1608,11 +1608,44 @@ int remove_dir_recursively(struct strbuf *path, int flag)
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
+	if (!(len >= 4 && !strcmp(n_git + len - 4, ".git") &&
+	      (len == 4 || n_git[len - 5] == '/'))) {
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
