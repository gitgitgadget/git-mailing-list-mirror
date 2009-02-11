From: Eric Kidd <git@randomhacks.net>
Subject: [PATCH] Rough draft: Split a git repo into superproject and submodule
Date: Tue, 10 Feb 2009 21:36:14 -0500
Message-ID: <1234319774-48037-1-git-send-email-git@randomhacks.net>
Cc: Eric Kidd <git@randomhacks.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 03:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX50A-00082S-P9
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 03:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbZBKCgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 21:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbZBKCgX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 21:36:23 -0500
Received: from randomhacks.net ([69.93.127.95]:57391 "EHLO randomhacks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbZBKCgW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 21:36:22 -0500
Received: from pool-64-222-85-242.burl.east.myfairpoint.net ([64.222.85.242] helo=localhost.localdomain)
	by randomhacks.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <git@randomhacks.net>)
	id 1LX4xZ-0006xI-9B; Tue, 10 Feb 2009 21:36:21 -0500
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109367>

I have some extremely large git repositories which I want to split into
modules.  This could be done using 'git filter-branch' and the following
steps:

 1) Create a submodule using --subdirectory-filter.
 2) Create a superproject using an index filter to delete the submodule.
 3) Commit the submodule to the latest version of the superproject.

Unfortunately, this approach loses all the historical connections
between the superproject and the submodule, breaking tools like 'git
bisect', and making it difficult to recover old releases.

Ideally, each version of the newly created superproject would be linked
to the correct version of the submodule (and all the .gitmodules entries
would be set up correctly, too, throughout the project's history).

The attached patch contains a _very_ rough draft of a git
submodule-split command.  You can run it as follows:

  git submodule-split original-repo superproject directory-to-split
  git clone superproject.git superproject
  cd superproject
  git submodule update --init

It will output two repositories named superproject.git and
subproject.git.  Internally, it runs 'git filter-branch' on a bare
repository.

There's a test suite, too.

I still have quite a few things left to do before this script is
actually useful:

  Rename submodule-split to something more appropriate
  Update .gitmodules using git config
  Merge new entries with existing .gitmodules
  Add support for directory and repository names which differ
  Add support for multiple possible directory names
  Add support for directories which move around the tree
  Add support for directories which are missing in some revisions

I'm releasing this version for feedback on the general design and the
coding style.  I don't often write shell scripts of this magnitude, and
there are almost certainly some portability and style problems.  So please
let me know what needs improvement, and I'll try to fix it.

Thank you for your feedback!
---
 .gitignore                 |    1 +
 Makefile                   |    1 +
 git-submodule-split.sh     |  113 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7404-submodule-split.sh |   36 ++++++++++++++
 4 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100644 git-submodule-split.sh
 create mode 100755 t/t7404-submodule-split.sh

diff --git a/.gitignore b/.gitignore
index 13311f1..fa6ed07 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,6 +119,7 @@ git-show
 git-show-branch
 git-show-index
 git-show-ref
+git-submodule-split
 git-stage
 git-stash
 git-status
diff --git a/Makefile b/Makefile
index 27b9569..aceac8f 100644
--- a/Makefile
+++ b/Makefile
@@ -277,6 +277,7 @@ SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
+SCRIPT_SH += git-submodule-split.sh
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
diff --git a/git-submodule-split.sh b/git-submodule-split.sh
new file mode 100644
index 0000000..d7d1080
--- /dev/null
+++ b/git-submodule-split.sh
@@ -0,0 +1,113 @@
+#!/bin/sh
+# 
+# Split a repository into a submodule and main module, with history
+#
+# Copyright 2009 Eric Kidd
+# License: GNU General Public License, version 2 or later
+
+USAGE="src-repo dst-repo submodule-repo"
+
+OPTIONS_SPEC=
+NONGIT_OK=Yes
+. git-sh-setup
+
+# Keep our argument parsing simple for now.
+test "$#" = 3 || usage
+src_repo="$1"
+dst_repo="$2.git"
+sub_repo="$3.git"
+submodule_dir="$3"
+revs="--all"
+
+# Make a bare clone of a git repo with identical branches.
+git_mirror() {
+	git clone --mirror "$1" "$2" || exit 1
+	# For some reason, git clone --mirror doesn't actually create our
+	# local branch references for us.
+	(cd "$2" && git fetch || exit 1)
+}
+
+# We export these variables so that they can be used from scripts passed to
+# git filter-branch.  Thanks to gitte for this trick, which also allows us
+# to do the right thing when subdirectory names contain spaces and quotes.
+export SPLIT_SUB_REPO="$sub_repo"
+export SPLIT_SUBMODULE_DIR="$submodule_dir"
+export SPLIT_MAP_DIR="`pwd`/$sub_repo/split-map"
+
+
+#--------------------------------------------------------------------------
+# Create the new submodule
+
+# Create a copy of $src_repo to transform.
+git_mirror "$src_repo" "$sub_repo"
+
+# For each commit ID, we will create a files in containing
+# information that we'll later use to rewrite the subproject.
+mkdir "$SPLIT_MAP_DIR" || exit 1
+
+index_filter=$(cat << \EOF
+map_info="$SPLIT_MAP_DIR/$GIT_COMMIT"
+if git rev-parse -q --verify $GIT_COMMIT:"$SPLIT_SUBMODULE_DIR"; then
+	# Adapted from git-filter-branch.
+	err=$(git read-tree -i -m $GIT_COMMIT:"$SPLIT_SUBMODULE_DIR" 2>&1) ||
+		die "$err"
+        echo -n "$SPLIT_SUBMODULE_DIR" > "$map_info-dir"
+else
+	# We will use an empty file to indicate that the directory
+        # doesn't exist in the tree.
+	# touch "$map_info-skipped"
+	die "Directory is missing"
+fi
+EOF
+)
+
+commit_filter=$(cat << \EOF
+map_info="$SPLIT_MAP_DIR/$GIT_COMMIT"
+new_commit="$(git commit-tree "$@")" || exit 1
+echo $new_commit
+echo $new_commit > "$map_info-submodule-commit" ||
+	die "Can't record the commit ID of the new commit"
+EOF
+)
+
+# Run our filters.
+(cd "$sub_repo" &&
+ git filter-branch --index-filter "$index_filter" \
+     --commit-filter "$commit_filter" -- "$revs") || exit 1
+
+
+#--------------------------------------------------------------------------
+# Create the new superproject
+
+# Next, create our new parent repository.
+git_mirror "$src_repo" "$dst_repo"
+
+index_filter=$(cat << \EOF
+map_info="$SPLIT_MAP_DIR/$GIT_COMMIT"
+
+# Splice the repo into the tree.
+test -f "$map_info-submodule-commit" || die "Can't find map for $GIT_COMMIT"
+git rm -q --cached -r "$SPLIT_SUBMODULE_DIR" || exit 1
+echo "160000 $(cat "$map_info-submodule-commit")	$SPLIT_SUBMODULE_DIR" |
+	git update-index --index-info || exit 1
+
+# Construct a new .gitmodules file.
+cat > "$SPLIT_MAP_DIR/gitmodules" <<EOC
+[submodule "$SPLIT_SUBMODULE_DIR"]
+	path = $SPLIT_SUBMODULE_DIR
+	url = ../$SPLIT_SUB_REPO
+EOC
+
+# Write the new .gitmodules file into the tree.
+new_obj=$(git hash-object -t blob -w "$SPLIT_MAP_DIR/gitmodules") ||
+	die "Error adding new .gitmodules file to tree"
+git update-index --add --cacheinfo 100644 "$new_obj" .gitmodules || exit 1
+
+EOF
+)
+
+# Run our filter.
+(cd "$dst_repo" &&
+ git filter-branch --index-filter "$index_filter" -- "$revs") || exit 1
+
+exit 0
diff --git a/t/t7404-submodule-split.sh b/t/t7404-submodule-split.sh
new file mode 100755
index 0000000..b490c60
--- /dev/null
+++ b/t/t7404-submodule-split.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright 2009 Eric Kidd
+
+test_description='git submodule-split tests'
+. ./test-lib.sh
+
+rm -rf .git
+test_create_repo original
+
+test_expect_success \
+	'create original repository' \
+	'(cd original &&
+	  echo "In main project" > main-file &&
+	  mkdir sub1 &&
+	  echo "In sub1" > sub1/sub1-file &&
+	  git add . &&
+	  git commit -m "Original project and sub1")'
+
+test_expect_success \
+	'split out sub1' \
+	'git submodule-split original split1 sub1 &&
+	 git clone split1.git split1 &&
+	 test -f split1/main-file &&
+	 ! test -f split1/sub1/sub1-file &&
+	 git clone sub1.git sub1 &&
+	 test -f sub1/sub1-file'
+
+test_expect_success \
+	'compare split repositories with original' \
+	'rm -rf split1 &&
+	 git clone split1.git split1 &&
+	 (cd split1 && git submodule init sub1 && git submodule update) &&
+	 diff -uNr -x .git -x .gitmodules original split1'
+
+test_done
-- 
1.6.0.4
