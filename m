From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/5] git-p4 tests: refactor, split out common functions
Date: Sat, 17 Sep 2011 21:27:13 -0400
Message-ID: <20110918012713.GA4619@arf.padd.com>
References: <20110918012634.GA4578@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 03:27:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R56AE-00069K-W6
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 03:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab1IRB1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 21:27:18 -0400
Received: from honk.padd.com ([74.3.171.149]:50727 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679Ab1IRB1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 21:27:17 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 4F0E8BFC;
	Sat, 17 Sep 2011 18:27:16 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 81E8331448; Sat, 17 Sep 2011 21:27:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110918012634.GA4578@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181593>

Introduce a library for functions that are common to
multiple git-p4 test files.

Separate the tests related to detecting p4 branches
into their own file, and add a few more.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh          |   55 ++++++++++++
 t/t9800-git-p4.sh        |  108 ++---------------------
 t/t9801-git-p4-branch.sh |  221 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+), 101 deletions(-)
 create mode 100644 t/lib-git-p4.sh
 create mode 100755 t/t9801-git-p4-branch.sh

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
new file mode 100644
index 0000000..dbc1499
--- /dev/null
+++ b/t/lib-git-p4.sh
@@ -0,0 +1,55 @@
+#
+# Library code for git-p4 tests
+#
+
+. ./test-lib.sh
+
+( p4 -h && p4d -h ) >/dev/null 2>&1 || {
+	skip_all='skipping git-p4 tests; no p4 or p4d'
+	test_done
+}
+
+GITP4=$GIT_BUILD_DIR/contrib/fast-import/git-p4
+P4DPORT=10669
+
+export P4PORT=localhost:$P4DPORT
+export P4CLIENT=client
+
+db="$TRASH_DIRECTORY/db"
+cli="$TRASH_DIRECTORY/cli"
+git="$TRASH_DIRECTORY/git"
+
+start_p4d()
+{
+	mkdir -p "$db" &&
+	p4d -q -d -r "$db" -p $P4DPORT &&
+	mkdir -p "$cli" &&
+	mkdir -p "$git" &&
+	cd "$cli" &&
+	p4 client -i <<-EOF
+	Client: client
+	Description: client
+	Root: $cli
+	View: //depot/... //client/...
+	EOF
+}
+
+kill_p4d()
+{
+	pid=`pgrep -f p4d` &&
+	test -n "$pid" &&
+	for i in {1..5} ; do
+	    test_debug "ps wl `echo $pid`" &&
+	    kill $pid 2>/dev/null &&
+	    pgrep -f p4d >/dev/null || break &&
+	    sleep 0.2
+	done &&
+	rm -rf "$db" &&
+	rm -rf "$cli"
+}
+
+cleanup_git() {
+	cd "$TRASH_DIRECTORY" &&
+	rm -rf "$git" &&
+	mkdir "$git"
+}
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 01ba041..bb89b63 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -2,40 +2,16 @@
 
 test_description='git-p4 tests'
 
-. ./test-lib.sh
+. ./lib-git-p4.sh
 
-( p4 -h && p4d -h ) >/dev/null 2>&1 || {
-	skip_all='skipping git-p4 tests; no p4 or p4d'
-	test_done
-}
-
-GITP4=$GIT_BUILD_DIR/contrib/fast-import/git-p4
-P4DPORT=10669
-
-export P4PORT=localhost:$P4DPORT
-
-db="$TRASH_DIRECTORY/db"
-cli="$TRASH_DIRECTORY/cli"
-git="$TRASH_DIRECTORY/git"
-
-test_debug 'echo p4d -q -d -r "$db" -p $P4DPORT'
-test_expect_success setup '
-	mkdir -p "$db" &&
-	p4d -q -d -r "$db" -p $P4DPORT &&
-	mkdir -p "$cli" &&
-	mkdir -p "$git" &&
-	export P4PORT=localhost:$P4DPORT
+test_expect_success 'start p4d' '
+	kill_p4d || : &&
+	start_p4d &&
+	cd "$TRASH_DIRECTORY"
 '
 
 test_expect_success 'add p4 files' '
 	cd "$cli" &&
-	p4 client -i <<-EOF &&
-	Client: client
-	Description: client
-	Root: $cli
-	View: //depot/... //client/...
-	EOF
-	export P4CLIENT=client &&
 	echo file1 >file1 &&
 	p4 add file1 &&
 	p4 submit -d "file1" &&
@@ -45,12 +21,6 @@ test_expect_success 'add p4 files' '
 	cd "$TRASH_DIRECTORY"
 '
 
-cleanup_git() {
-	cd "$TRASH_DIRECTORY" &&
-	rm -rf "$git" &&
-	mkdir "$git"
-}
-
 test_expect_success 'basic git-p4 clone' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
@@ -405,72 +375,8 @@ test_expect_success 'detect copies' '
 	p4 filelog //depot/file13 | grep -q "branch from //depot/file"
 '
 
-# Create a simple branch structure in P4 depot to check if it is correctly
-# cloned.
-test_expect_success 'add simple p4 branches' '
-	cd "$cli" &&
-	mkdir branch1 &&
-	cd branch1 &&
-	echo file1 >file1 &&
-	echo file2 >file2 &&
-	p4 add file1 file2 &&
-	p4 submit -d "branch1" &&
-	p4 integrate //depot/branch1/... //depot/branch2/... &&
-	p4 submit -d "branch2" &&
-	echo file3 >file3 &&
-	p4 add file3 &&
-	p4 submit -d "add file3 in branch1" &&
-	p4 open file2 &&
-	echo update >>file2 &&
-	p4 submit -d "update file2 in branch1" &&
-	p4 integrate //depot/branch1/... //depot/branch3/... &&
-	p4 submit -d "branch3" &&
-	cd "$TRASH_DIRECTORY"
-'
-
-# Configure branches through git-config and clone them.
-# All files are tested to make sure branches were cloned correctly.
-# Finally, make an update to branch1 on P4 side to check if it is imported
-# correctly by git-p4.
-test_expect_success 'git-p4 clone simple branches' '
-	test_when_finished cleanup_git &&
-	test_create_repo "$git" &&
-	cd "$git" &&
-	git config git-p4.branchList branch1:branch2 &&
-	git config --add git-p4.branchList branch1:branch3 &&
-	"$GITP4" clone --dest=. --detect-branches //depot@all &&
-	git log --all --graph --decorate --stat &&
-	git reset --hard p4/depot/branch1 &&
-	test -f file1 &&
-	test -f file2 &&
-	test -f file3 &&
-	grep -q update file2 &&
-	git reset --hard p4/depot/branch2 &&
-	test -f file1 &&
-	test -f file2 &&
-	test ! -f file3 &&
-	! grep -q update file2 &&
-	git reset --hard p4/depot/branch3 &&
-	test -f file1 &&
-	test -f file2 &&
-	test -f file3 &&
-	grep -q update file2 &&
-	cd "$cli" &&
-	cd branch1 &&
-	p4 edit file2 &&
-	echo file2_ >>file2 &&
-	p4 submit -d "update file2 in branch1" &&
-	cd "$git" &&
-	git reset --hard p4/depot/branch1 &&
-	"$GITP4" rebase &&
-	grep -q file2_ file2
-'
-
-test_expect_success 'shutdown' '
-	pid=`pgrep -f p4d` &&
-	test -n "$pid" &&
-	test_debug "ps wl `echo $pid`" &&
-	kill $pid
+test_expect_success 'kill p4d' '
+	kill_p4d
 '
 
 test_done
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
new file mode 100755
index 0000000..0b6c1d1
--- /dev/null
+++ b/t/t9801-git-p4-branch.sh
@@ -0,0 +1,221 @@
+#!/bin/sh
+
+test_description='git-p4 p4 branching tests'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	kill_p4d || : &&
+	start_p4d &&
+	cd "$TRASH_DIRECTORY"
+'
+
+#
+# 1: //depot/main/f1
+# 2: //depot/main/f2
+# 3: integrate //depot/main/... -> //depot/branch1/...
+# 4: //depot/main/f4
+# 5: //depot/branch1/f5
+# .: named branch branch2
+# 6: integrate -b branch2
+# 7: //depot/branch2/f7
+# 8: //depot/main/f8
+#
+test_expect_success 'basic p4 branches' '
+	cd "$cli" &&
+	mkdir -p main &&
+
+	echo f1 >main/f1 &&
+	p4 add main/f1 &&
+	p4 submit -d "main/f1" &&
+
+	echo f2 >main/f2 &&
+	p4 add main/f2 &&
+	p4 submit -d "main/f2" &&
+
+	p4 integrate //depot/main/... //depot/branch1/... &&
+	p4 submit -d "integrate main to branch1" &&
+
+	echo f4 >main/f4 &&
+	p4 add main/f4 &&
+	p4 submit -d "main/f4" &&
+
+	echo f5 >branch1/f5 &&
+	p4 add branch1/f5 &&
+	p4 submit -d "branch1/f5" &&
+
+	p4 branch -i <<-EOF &&
+	Branch: branch2
+	View: //depot/main/... //depot/branch2/...
+	EOF
+
+	p4 integrate -b branch2 &&
+	p4 submit -d "integrate main to branch2" &&
+
+	echo f7 >branch2/f7 &&
+	p4 add branch2/f7 &&
+	p4 submit -d "branch2/f7" &&
+
+	echo f8 >main/f8 &&
+	p4 add main/f8 &&
+	p4 submit -d "main/f8" &&
+
+	cd "$TRASH_DIRECTORY"
+'
+
+test_expect_success 'import main, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot/main@all &&
+	cd "$git" &&
+	git log --oneline --graph --decorate --all &&
+	git rev-list master >wc &&
+	test_line_count = 4 wc
+'
+
+test_expect_success 'import branch1, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot/branch1@all &&
+	cd "$git" &&
+	git log --oneline --graph --decorate --all &&
+	git rev-list master >wc &&
+	test_line_count = 2 wc
+'
+
+test_expect_success 'import branch2, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot/branch2@all &&
+	cd "$git" &&
+	git log --oneline --graph --decorate --all &&
+	git rev-list master >wc &&
+	test_line_count = 2 wc
+'
+
+test_expect_success 'import depot, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	cd "$git" &&
+	git log --oneline --graph --decorate --all &&
+	git rev-list master >wc &&
+	test_line_count = 8 wc
+'
+
+test_expect_success 'import depot, branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" --detect-branches //depot@all &&
+	cd "$git" &&
+
+	git log --oneline --graph --decorate --all &&
+
+	# 4 main commits
+	git rev-list master >wc &&
+	test_line_count = 4 wc &&
+
+	# 3 main, 1 integrate, 1 on branch2
+	git rev-list p4/depot/branch2 >wc &&
+	test_line_count = 5 wc &&
+
+	# no branch1, since no p4 branch created for it
+	test_must_fail git show-ref p4/depot/branch1
+'
+
+test_expect_success 'import depot, branch detection, branchList branch definition' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	cd "$git" &&
+	git config git-p4.branchList main:branch1 &&
+	"$GITP4" clone --dest=. --detect-branches //depot@all &&
+
+	git log --oneline --graph --decorate --all &&
+
+	# 4 main commits
+	git rev-list master >wc &&
+	test_line_count = 4 wc &&
+
+	# 3 main, 1 integrate, 1 on branch2
+	git rev-list p4/depot/branch2 >wc &&
+	test_line_count = 5 wc &&
+
+	# 2 main, 1 integrate, 1 on branch1
+	git rev-list p4/depot/branch1 >wc &&
+	test_line_count = 4 wc
+'
+
+test_expect_success 'restart p4d' '
+	kill_p4d &&
+	start_p4d &&
+	cd "$TRASH_DIRECTORY"
+'
+
+#
+# 1: //depot/branch1/file1
+#    //depot/branch1/file2
+# 2: integrate //depot/branch1/... -> //depot/branch2/...
+# 3: //depot/branch1/file3
+# 4: //depot/branch1/file2 (edit)
+# 5: integrate //depot/branch1/... -> //depot/branch3/...
+#
+## Create a simple branch structure in P4 depot.
+test_expect_success 'add simple p4 branches' '
+	cd "$cli" &&
+	mkdir branch1 &&
+	cd branch1 &&
+	echo file1 >file1 &&
+	echo file2 >file2 &&
+	p4 add file1 file2 &&
+	p4 submit -d "branch1" &&
+	p4 integrate //depot/branch1/... //depot/branch2/... &&
+	p4 submit -d "branch2" &&
+	echo file3 >file3 &&
+	p4 add file3 &&
+	p4 submit -d "add file3 in branch1" &&
+	p4 open file2 &&
+	echo update >>file2 &&
+	p4 submit -d "update file2 in branch1" &&
+	p4 integrate //depot/branch1/... //depot/branch3/... &&
+	p4 submit -d "branch3" &&
+	cd "$TRASH_DIRECTORY"
+'
+
+# Configure branches through git-config and clone them.
+# All files are tested to make sure branches were cloned correctly.
+# Finally, make an update to branch1 on P4 side to check if it is imported
+# correctly by git-p4.
+test_expect_success 'git-p4 clone simple branches' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	cd "$git" &&
+	git config git-p4.branchList branch1:branch2 &&
+	git config --add git-p4.branchList branch1:branch3 &&
+	"$GITP4" clone --dest=. --detect-branches //depot@all &&
+	git log --all --graph --decorate --stat &&
+	git reset --hard p4/depot/branch1 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	grep -q update file2 &&
+	git reset --hard p4/depot/branch2 &&
+	test -f file1 &&
+	test -f file2 &&
+	test ! -f file3 &&
+	test_must_fail grep -q update file2 &&
+	git reset --hard p4/depot/branch3 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	grep -q update file2 &&
+	cd "$cli" &&
+	cd branch1 &&
+	p4 edit file2 &&
+	echo file2_ >>file2 &&
+	p4 submit -d "update file2 in branch3" &&
+	cd "$git" &&
+	git reset --hard p4/depot/branch1 &&
+	"$GITP4" rebase &&
+	grep -q file2_ file2
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.6.3
