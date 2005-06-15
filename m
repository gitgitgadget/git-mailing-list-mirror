From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/3] Add test cases for git-commit-script.
Date: Thu, 16 Jun 2005 00:38:08 +1000
Message-ID: <20050615143808.27230.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 15 16:35:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiYxq-0004XS-9d
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 16:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVFOOiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 10:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFOOiu
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 10:38:50 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:31616 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261518AbVFOOiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 10:38:11 -0400
Received: (qmail 27240 invoked by uid 500); 15 Jun 2005 14:38:08 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Adds some tests to show that git-commit-script behaves properly under a number
of different conditions.

The git-commit-script (f88a51a43ce2a3660fa82c13e502df429678d168) at Linus' HEAD
passes these tests.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t1200-commit-script.sh |  153 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 153 insertions(+), 0 deletions(-)

diff --git a/t/t1200-commit-script.sh b/t/t1200-commit-script.sh
new file mode 100644
--- /dev/null
+++ b/t/t1200-commit-script.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+#
+# Copyright (C) 2005 Rene Scharfe
+# Copyright (C) 2005 Jon Seymour [ adapted to git-commit-script ]
+#
+
+test_description='git-commit-script
+
+This test checks that git-commit-script works as expected.
+'
+
+. ./test-lib.sh
+
+one_line()
+{
+echo "this is a commit test"
+}
+
+expected_commit ()
+{
+	tree=$1
+	shift 1
+cat <<EOF
+tree $tree
+EOF
+
+	for p in $*
+	do
+cat <<EOF
+parent $p
+EOF
+	done
+
+cat <<EOF
+author Author Name <author@email> 1117148400 +0000
+committer Committer Name <committer@email> 1117150200 +0000
+
+$(one_line)
+EOF
+}
+
+cat >add_one_line_editor <<EOF
+#!/bin/sh
+file=\$1
+echo "$(one_line)" >> \$file
+EOF
+
+cat >do_nothing_editor <<EOF
+#!/bin/sh
+:
+EOF
+
+cat >delete_sentinel_editor <<EOF
+#!/bin/sh
+file=\$1
+mv \$file \$file.\$\$
+sed "/^#SENTINEL/d" < \$file.\$\$ >\$file
+EOF
+
+chmod u+x add_one_line_editor
+chmod u+x do_nothing_editor
+chmod u+x delete_sentinel_editor
+
+: > foo
+: > bar
+
+run_with_vars()
+{
+     GIT_AUTHOR_NAME="Author Name" \
+     GIT_AUTHOR_EMAIL="author@email" \
+     GIT_AUTHOR_DATE="2005-05-26 23:00" \
+     GIT_COMMITTER_NAME="Committer Name" \
+     GIT_COMMITTER_EMAIL="committer@email" \
+     GIT_COMMITTER_DATE="2005-05-26 23:30" \
+     TZ= "$@" 2>/dev/null
+}
+
+test_phase1()
+{
+     condition=$1
+     editor=$2
+
+     test_expect_success \
+     "$condition - test preparation: add a file" \
+     'git-update-cache --add foo && git-write-tree > treeid'
+
+     test_expect_failure \
+     "$condition - Do not edit the commit message" \
+     "EDITOR=$editor run_with_vars git-commit-script"
+
+     test_expect_failure \
+     "$condition - No HEAD created when commit fails" \
+     '[ -f .git/HEAD ]'
+}
+
+test_phase2()
+{
+    condition=$1
+    editor=$2
+    test_expect_success \
+    "$condition - Single line message works" \
+    "EDITOR=$editor run_with_vars git-commit-script"
+
+    test_expect_success "$condition - HEAD created" '[ -f .git/HEAD ]'
+
+    test_expect_success \
+    "$condition - read commit 1" \
+    'git-cat-file commit HEAD >commit'
+
+    test_expect_success \
+    "$condition - compare commit" \
+    'expected_commit $(cat treeid) > expected && diff expected commit'
+
+    head=$(cat .git/HEAD)
+    test_expect_success \
+    "$condition - create a merge head" \
+    'merge_head=$(git-commit-tree $(cat treeid) -p HEAD < /dev/null)'
+
+    echo $merge_head > .git/MERGE_HEAD
+
+    test_expect_success \
+    "$condition - test preparation: write tree containing" \
+    'git-update-cache --add bar && git-write-tree > treeid.bar'
+
+}
+
+test_phase3()
+{
+    condition=$1
+    editor=$2
+
+    test_expect_success \
+    "$condition - write a tree with one merge head" \
+    "EDITOR=$editor run_with_vars git-commit-script"
+    
+    test_expect_success "$condition - MERGE_HEAD removed" '[ -f .git/HEAD ]'
+    test_expect_success "$condition - MERGE_HEAD removed by successful commit" '! [ -f .git/MERGE_HEAD ]'
+
+    test_expect_success \
+    "$condition - read commit 2" \
+    'git-cat-file commit HEAD >commit'
+
+    test_expect_success \
+    "$condition - compare commit 2" \
+    "expected_commit $(cat treeid.bar) ${head} ${merge_head} > expected && diff expected commit"
+
+}
+
+test_phase1 "simulated user" ./do_nothing_editor
+test_phase2 "simulated user" ./add_one_line_editor
+test_phase3 "simulated used" ./add_one_line_editor
+
+test_done
------------
