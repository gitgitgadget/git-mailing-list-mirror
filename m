From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Fri, 23 May 2014 10:33:31 -0700
Message-ID: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: jrnieder@gmail.com, git@vger.kernel.org,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 23 19:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WntLm-0001uv-B1
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 19:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbaEWRdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 13:33:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:51151 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaEWRdl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 13:33:41 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so4396483pad.18
        for <git@vger.kernel.org>; Fri, 23 May 2014 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WJLhMyMk4viJU+TkMLtssphDoF+b4YYKIYgweo5Q3vk=;
        b=p0zl/0ia6beHJfQUnNwxvbbKGFoR2lNyv1BQZi6yDgbICGWJau8P/UcSptxczU6VT9
         Vx8Edjh2Y2si6G2/AE8Pv1P15qkqHZF4e7czdFHbCgmQsb7CSwmTF3MmAt1tJ0uvSEX1
         WLEswTWsJluoyJ/VPer8vSsk37pJT7HtQCWv11Mc5mfqfas5PZ2tLf3+l4OTxb3YDg6p
         4h0XdbJCMcKiGwbxt6NZZb3KA6F3FhXNIbhEgpKCFvP0GH2rc5YrFfbfVE/1o/NtIggc
         s8dH/IOPB20Tj9noaoduYtFEu0JT2Z2DtAnKIy16s9QOIMeaPdqZyoAtUQ4fjmQ6qS8M
         vN3g==
X-Received: by 10.66.136.131 with SMTP id qa3mr7689345pab.77.1400866421113;
        Fri, 23 May 2014 10:33:41 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id ay3sm5568323pbb.62.2014.05.23.10.33.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 May 2014 10:33:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250005>

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
Slightly brush-up comments, and fix ">file" style in the test, together
with fixing the &&-chain.
One thing is, when you do "git --git-dir meta init", and then explicitly
say "add meta/", the message you get is
"The following paths are ignored by one of your .gitignore files:"
which is not exactly correct.

 Documentation/technical/api-directory-listing.txt |  4 +-
 dir.c                                             | 20 ++++++
 t/t2205-add-gitdir.sh                             | 84 +++++++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)
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
index 98bb50f..76969a7 100644
--- a/dir.c
+++ b/dir.c
@@ -1588,6 +1588,26 @@ void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
 	char *xdg_path;
+	const char *gitdir = get_git_dir();
+
+	/* Add git directory to the ignores first */
+	if (strcmp(gitdir, ".git") != 0) { /* "--git-dir" has been given */
+		char ngit[PATH_MAX + 1];
+
+		/*
+		 * See if GIT_DIR is inside the work tree; need to normalize
+		 * 'gitdir', whereas 'get_git_work_tree()' always appears
+		 * absolute and normalized
+		 */
+		normalize_path_copy(ngit, real_path(absolute_path(gitdir)));
+
+		if (dir_inside_of(ngit, get_git_work_tree()) >= 0) {
+			struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
+							"--git-dir option");
+
+			add_exclude(gitdir, "", 0, el, 0);
+		}
+	}
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
diff --git a/t/t2205-add-gitdir.sh b/t/t2205-add-gitdir.sh
new file mode 100755
index 0000000..0c99508
--- /dev/null
+++ b/t/t2205-add-gitdir.sh
@@ -0,0 +1,84 @@
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
+# 	a  b  c  d  subdir/
+#
+# subdir:
+# 	e  f  g  h  meta/  ssubdir/
+#
+# subdir/meta:
+# 	aa
+#
+# subdir/ssubdir:
+# 	meta/
+#
+# subdir/ssubdir/meta:
+# 	aaa
+#
+# Name the repository "meta" and see whether or not "git status" includes
+# or ignores directories named "meta". The slightly deeper hierarchy is
+# needed in order to be able to put the repository into "../meta", that is,
+# outside the work tree and still have files called "meta" within the tree
+#
+
+test_expect_success "setup" '
+	git --git-dir=meta init &&
+	for f in a b c d
+	do
+		echo "DATA" >"$f" || exit 1
+	done &&
+	mkdir subdir &&
+	for f in e f g h
+	do
+		echo "MORE DATA" >"subdir/$f" || exit 1
+	done &&
+	mkdir subdir/meta &&
+	echo "EVEN more Data" >subdir/meta/aa &&
+	mkdir subdir/ssubdir subdir/ssubdir/meta &&
+	echo "So much more data" >subdir/ssubdir/meta/aaa
+'
+
+test_expect_success "'git status' ignores the repository directory" '
+	git --git-dir=meta --work-tree=. status --porcelain >status.out &&
+	test_might_fail grep meta status.out >out &&
+	! test -s out
+'
+
+test_expect_success "'git add -A' ignores the repository directory" '
+	git --git-dir=meta --work-tree=. add -A &&
+	git --git-dir=meta --work-tree=. status --porcelain >status1.out &&
+	test_might_fail grep meta status1.out >out1 &&
+	! test -s out1
+'
+
+test_expect_success "'git status' acknowledges files 'meta' if repository is not within work tree" '
+	test_might_fail rm -rf meta/ &&
+	(
+		cd subdir &&
+		git --git-dir=../meta init &&
+		git --git-dir=../meta --work-tree=. status --porcelain >status2.out &&
+		test_might_fail grep meta status2.out >out2 &&
+		test -s out2
+	)
+'
+
+test_expect_success "'git add -A' adds 'meta' if the repository is outside the work tree" '
+	(
+		cd subdir &&
+		git --git-dir=../meta --work-tree=. add -A &&
+		git --git-dir=../meta --work-tree=. status --porcelain >status3.out &&
+		test_might_fail grep meta status3.out >out3 &&
+		test -s out3
+	)
+'
+
+test_done
-- 
1.9.1
