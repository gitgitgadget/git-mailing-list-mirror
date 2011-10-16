From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/6] git-p4 tests: refactor and cleanup
Date: Sun, 16 Oct 2011 10:43:19 -0400
Message-ID: <20111016144319.GD22144@arf.padd.com>
References: <20111016144215.GC22144@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 16:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFRwF-0005XR-GT
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 16:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833Ab1JPOnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 10:43:39 -0400
Received: from honk.padd.com ([74.3.171.149]:35496 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab1JPOni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 10:43:38 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 030A91FEA;
	Sun, 16 Oct 2011 07:43:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BD3C3313B8; Sun, 16 Oct 2011 10:43:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20111016144215.GC22144@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183716>

Introduce a library for functions that are common to
multiple git-p4 test files.

Be a bit more clever about starting and stopping p4d.
Specify a unique port number for each test, so that
tests can run in parallel.  Start p4d not in daemon mode,
and save the pid, to be able to kill it cleanly later.
Never kill p4d at startup; always shutdown cleanly.

Handle directory changes better.  Always chdir inside
a subshell, and remove any post-test directory changes.

Clean up whitespace, and use test_cmp and test_must_fail
more consistently.

Separate the tests related to detecting p4 branches
into their own file, and add a few more.

Acked-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh          |   74 +++++++
 t/t9800-git-p4.sh        |  544 ++++++++++++++++++++--------------------------
 t/t9801-git-p4-branch.sh |  233 ++++++++++++++++++++
 3 files changed, 543 insertions(+), 308 deletions(-)
 create mode 100644 t/lib-git-p4.sh
 create mode 100755 t/t9801-git-p4-branch.sh

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
new file mode 100644
index 0000000..a870f9a
--- /dev/null
+++ b/t/lib-git-p4.sh
@@ -0,0 +1,74 @@
+#
+# Library code for git-p4 tests
+#
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all='skipping git-p4 tests; python not available'
+	test_done
+fi
+( p4 -h && p4d -h ) >/dev/null 2>&1 || {
+	skip_all='skipping git-p4 tests; no p4 or p4d'
+	test_done
+}
+
+GITP4="$GIT_BUILD_DIR/contrib/fast-import/git-p4"
+
+# Try to pick a unique port: guess a large number, then hope
+# no more than one of each test is running.
+#
+# This does not handle the case where somebody else is running the
+# same tests and has chosen the same ports.
+testid=${this_test#t}
+git_p4_test_start=9800
+P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
+
+export P4PORT=localhost:$P4DPORT
+export P4CLIENT=client
+
+db="$TRASH_DIRECTORY/db"
+cli="$TRASH_DIRECTORY/cli"
+git="$TRASH_DIRECTORY/git"
+pidfile="$TRASH_DIRECTORY/p4d.pid"
+
+start_p4d() {
+	mkdir -p "$db" "$cli" "$git" &&
+	(
+		p4d -q -r "$db" -p $P4DPORT &
+		echo $! >"$pidfile"
+	) &&
+	for i in 1 2 3 4 5 ; do
+		p4 info >/dev/null 2>&1 && break || true &&
+		echo waiting for p4d to start &&
+		sleep 1
+	done &&
+	# complain if it never started
+	p4 info >/dev/null &&
+	(
+		cd "$cli" &&
+		p4 client -i <<-EOF
+		Client: client
+		Description: client
+		Root: $cli
+		View: //depot/... //client/...
+		EOF
+	)
+}
+
+kill_p4d() {
+	pid=$(cat "$pidfile")
+	# it had better exist for the first kill
+	kill $pid &&
+	for i in 1 2 3 4 5 ; do
+		kill $pid >/dev/null 2>&1 || break
+		sleep 1
+	done &&
+	# complain if it would not die
+	test_must_fail kill $pid >/dev/null 2>&1 &&
+	rm -rf "$db" "$cli" "$pidfile"
+}
+
+cleanup_git() {
+	rm -rf "$git"
+}
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 01ba041..8fbed66 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -2,76 +2,51 @@
 
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
+	start_p4d
 '
 
 test_expect_success 'add p4 files' '
-	cd "$cli" &&
-	p4 client -i <<-EOF &&
-	Client: client
-	Description: client
-	Root: $cli
-	View: //depot/... //client/...
-	EOF
-	export P4CLIENT=client &&
-	echo file1 >file1 &&
-	p4 add file1 &&
-	p4 submit -d "file1" &&
-	echo file2 >file2 &&
-	p4 add file2 &&
-	p4 submit -d "file2" &&
-	cd "$TRASH_DIRECTORY"
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "file1" &&
+		echo file2 >file2 &&
+		p4 add file2 &&
+		p4 submit -d "file2"
+	)
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
-	cd "$git" &&
-	git log --oneline >lines &&
-	test_line_count = 1 lines
+	(
+		cd "$git" &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
 '
 
 test_expect_success 'git-p4 clone @all' '
 	"$GITP4" clone --dest="$git" //depot@all &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	git log --oneline >lines &&
-	test_line_count = 2 lines
+	(
+		cd "$git" &&
+		git log --oneline >lines &&
+		test_line_count = 2 lines
+	)
 '
 
 test_expect_success 'git-p4 sync uninitialized repo' '
 	test_create_repo "$git" &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	test_must_fail "$GITP4" sync
+	(
+		cd "$git" &&
+		test_must_fail "$GITP4" sync
+	)
 '
 
 #
@@ -81,17 +56,19 @@ test_expect_success 'git-p4 sync uninitialized repo' '
 test_expect_success 'git-p4 sync new branch' '
 	test_create_repo "$git" &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	test_commit head &&
-	"$GITP4" sync --branch=refs/remotes/p4/depot //depot@all &&
-	git log --oneline p4/depot >lines &&
-	test_line_count = 2 lines
+	(
+		cd "$git" &&
+		test_commit head &&
+		"$GITP4" sync --branch=refs/remotes/p4/depot //depot@all &&
+		git log --oneline p4/depot >lines &&
+		test_line_count = 2 lines
+	)
 '
 
 test_expect_success 'exit when p4 fails to produce marshaled output' '
 	badp4dir="$TRASH_DIRECTORY/badp4dir" &&
-	mkdir -p "$badp4dir" &&
-	test_when_finished "rm -rf $badp4dir" &&
+	mkdir "$badp4dir" &&
+	test_when_finished "rm \"$badp4dir/p4\" && rmdir \"$badp4dir\"" &&
 	cat >"$badp4dir"/p4 <<-EOF &&
 	#!$SHELL_PATH
 	exit 1
@@ -103,61 +80,61 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 '
 
 test_expect_success 'add p4 files with wildcards in the names' '
-	cd "$cli" &&
-	echo file-wild-hash >file-wild#hash &&
-	echo file-wild-star >file-wild\*star &&
-	echo file-wild-at >file-wild@at &&
-	echo file-wild-percent >file-wild%percent &&
-	p4 add -f file-wild* &&
-	p4 submit -d "file wildcards"
+	(
+		cd "$cli" &&
+		echo file-wild-hash >file-wild#hash &&
+		echo file-wild-star >file-wild\*star &&
+		echo file-wild-at >file-wild@at &&
+		echo file-wild-percent >file-wild%percent &&
+		p4 add -f file-wild* &&
+		p4 submit -d "file wildcards"
+	)
 '
 
 test_expect_success 'wildcard files git-p4 clone' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	test -f file-wild#hash &&
-	test -f file-wild\*star &&
-	test -f file-wild@at &&
-	test -f file-wild%percent
+	(
+		cd "$git" &&
+		test -f file-wild#hash &&
+		test -f file-wild\*star &&
+		test -f file-wild@at &&
+		test -f file-wild%percent
+	)
 '
 
 test_expect_success 'clone bare' '
 	"$GITP4" clone --dest="$git" --bare //depot &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	test ! -d .git &&
-	bare=`git config --get core.bare` &&
-	test "$bare" = true
+	(
+		cd "$git" &&
+		test ! -d .git &&
+		bare=`git config --get core.bare` &&
+		test "$bare" = true
+	)
 '
 
 p4_add_user() {
-    name=$1
-    fullname=$2
-    p4 user -f -i <<EOF &&
-User: $name
-Email: $name@localhost
-FullName: $fullname
-EOF
-    p4 passwd -P secret $name
+	name=$1 fullname=$2 &&
+	p4 user -f -i <<-EOF &&
+	User: $name
+	Email: $name@localhost
+	FullName: $fullname
+	EOF
+	p4 passwd -P secret $name
 }
 
 p4_grant_admin() {
-    name=$1
-    p4 protect -o |\
-	awk "{print}END{print \"    admin user $name * //depot/...\"}" |\
-	p4 protect -i
+	name=$1 &&
+	{
+		p4 protect -o &&
+		echo "    admin user $name * //depot/..."
+	} | p4 protect -i
 }
 
 p4_check_commit_author() {
-    file=$1
-    user=$2
-    if p4 changes -m 1 //depot/$file | grep $user > /dev/null ; then
-	return 0
-    else
-	echo "file $file not modified by user $user" 1>&2
-	return 1
-    fi
+	file=$1 user=$2 &&
+	p4 changes -m 1 //depot/$file | grep -q $user
 }
 
 make_change_by_user() {
@@ -174,15 +151,17 @@ test_expect_success 'preserve users' '
 	p4_grant_admin alice &&
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	echo "username: a change by alice" >> file1 &&
-	echo "username: a change by bob" >> file2 &&
-	git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
-	git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
-	git config git-p4.skipSubmitEditCheck true &&
-	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
-	p4_check_commit_author file1 alice &&
-	p4_check_commit_author file2 bob
+	(
+		cd "$git" &&
+		echo "username: a change by alice" >>file1 &&
+		echo "username: a change by bob" >>file2 &&
+		git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
+		git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
+		git config git-p4.skipSubmitEditCheck true &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
+		p4_check_commit_author file1 alice &&
+		p4_check_commit_author file2 bob
+	)
 '
 
 # Test username support, submitting as bob, who lacks admin rights. Should
@@ -190,32 +169,37 @@ test_expect_success 'preserve users' '
 test_expect_success 'refuse to preserve users without perms' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	git config git-p4.skipSubmitEditCheck true &&
-	echo "username-noperms: a change by alice" >> file1 &&
-	git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
-	! P4EDITOR=touch P4USER=bob P4PASSWD=secret "$GITP4" commit --preserve-user &&
-	! git diff --exit-code HEAD..p4/master > /dev/null
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		echo "username-noperms: a change by alice" >>file1 &&
+		git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
+		P4EDITOR=touch P4USER=bob P4PASSWD=secret test_must_fail "$GITP4" commit --preserve-user &&
+		test_must_fail git diff --exit-code HEAD..p4/master
+	)
 '
 
 # What happens with unknown author? Without allowMissingP4Users it should fail.
 test_expect_success 'preserve user where author is unknown to p4' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	git config git-p4.skipSubmitEditCheck true &&
-	echo "username-bob: a change by bob" >> file1 &&
-	git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
-	echo "username-unknown: a change by charlie" >> file1 &&
-	git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
-	! P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
-	! git diff --exit-code HEAD..p4/master > /dev/null &&
-	echo "$0: repeat with allowMissingP4Users enabled" &&
-	git config git-p4.allowMissingP4Users true &&
-	git config git-p4.preserveUser true &&
-	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit &&
-	git diff --exit-code HEAD..p4/master > /dev/null &&
-	p4_check_commit_author file1 alice
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		echo "username-bob: a change by bob" >>file1 &&
+		git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
+		echo "username-unknown: a change by charlie" >>file1 &&
+		git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret test_must_fail "$GITP4" commit --preserve-user &&
+		test_must_fail git diff --exit-code HEAD..p4/master &&
+
+		echo "$0: repeat with allowMissingP4Users enabled" &&
+		git config git-p4.allowMissingP4Users true &&
+		git config git-p4.preserveUser true &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit &&
+		git diff --exit-code HEAD..p4/master &&
+		p4_check_commit_author file1 alice
+	)
 '
 
 # If we're *not* using --preserve-user, git-p4 should warn if we're submitting
@@ -225,28 +209,30 @@ test_expect_success 'preserve user where author is unknown to p4' '
 test_expect_success 'not preserving user with mixed authorship' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	git config git-p4.skipSubmitEditCheck true &&
-	p4_add_user derek Derek &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		p4_add_user derek Derek &&
 
-	make_change_by_user usernamefile3 Derek derek@localhost &&
-	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
-	grep "git author derek@localhost does not match" actual &&
+		make_change_by_user usernamefile3 Derek derek@localhost &&
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		grep "git author derek@localhost does not match" &&
 
-	make_change_by_user usernamefile3 Charlie charlie@localhost &&
-	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
-	grep "git author charlie@localhost does not match" actual &&
+		make_change_by_user usernamefile3 Charlie charlie@localhost &&
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		grep "git author charlie@localhost does not match" &&
 
-	make_change_by_user usernamefile3 alice alice@localhost &&
-	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
-	! grep "git author.*does not match" actual &&
+		make_change_by_user usernamefile3 alice alice@localhost &&
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" |\
+		test_must_fail grep "git author.*does not match" &&
 
-	git config git-p4.skipUserNameCheck true &&
-	make_change_by_user usernamefile3 Charlie charlie@localhost &&
-	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
-	! grep "git author.*does not match" actual &&
+		git config git-p4.skipUserNameCheck true &&
+		make_change_by_user usernamefile3 Charlie charlie@localhost &&
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		test_must_fail grep "git author.*does not match" &&
 
-	p4_check_commit_author usernamefile3 alice
+		p4_check_commit_author usernamefile3 alice
+	)
 '
 
 marshal_dump() {
@@ -263,10 +249,12 @@ test_expect_success 'initial import time from top change time' '
 	sleep 3 &&
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	gittime=$(git show -s --raw --pretty=format:%at HEAD) &&
-	echo $p4time $gittime &&
-	test $p4time = $gittime
+	(
+		cd "$git" &&
+		gittime=$(git show -s --raw --pretty=format:%at HEAD) &&
+		echo $p4time $gittime &&
+		test $p4time = $gittime
+	)
 '
 
 # Rename a file and confirm that rename is not detected in P4.
@@ -279,47 +267,49 @@ test_expect_success 'initial import time from top change time' '
 test_expect_success 'detect renames' '
 	"$GITP4" clone --dest="$git" //depot@all &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	git config git-p4.skipSubmitEditCheck true &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
 
-	git mv file1 file4 &&
-	git commit -a -m "Rename file1 to file4" &&
-	git diff-tree -r -M HEAD &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file4 &&
-	! p4 filelog //depot/file4 | grep -q "branch from" &&
+		git mv file1 file4 &&
+		git commit -a -m "Rename file1 to file4" &&
+		git diff-tree -r -M HEAD &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file4 &&
+		p4 filelog //depot/file4 | test_must_fail grep -q "branch from" &&
 
-	git mv file4 file5 &&
-	git commit -a -m "Rename file4 to file5" &&
-	git diff-tree -r -M HEAD &&
-	git config git-p4.detectRenames true &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file5 &&
-	p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
+		git mv file4 file5 &&
+		git commit -a -m "Rename file4 to file5" &&
+		git diff-tree -r -M HEAD &&
+		git config git-p4.detectRenames true &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file5 &&
+		p4 filelog //depot/file5 | grep -q "branch from //depot/file4" &&
 
-	git mv file5 file6 &&
-	echo update >>file6 &&
-	git add file6 &&
-	git commit -a -m "Rename file5 to file6 with changes" &&
-	git diff-tree -r -M HEAD &&
-	level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
-	test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
-	git config git-p4.detectRenames $((level + 2)) &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file6 &&
-	! p4 filelog //depot/file6 | grep -q "branch from" &&
+		git mv file5 file6 &&
+		echo update >>file6 &&
+		git add file6 &&
+		git commit -a -m "Rename file5 to file6 with changes" &&
+		git diff-tree -r -M HEAD &&
+		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
+		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
+		git config git-p4.detectRenames $(($level + 2)) &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file6 &&
+		p4 filelog //depot/file6 | test_must_fail grep -q "branch from" &&
 
-	git mv file6 file7 &&
-	echo update >>file7 &&
-	git add file7 &&
-	git commit -a -m "Rename file6 to file7 with changes" &&
-	git diff-tree -r -M HEAD &&
-	level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
-	test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
-	git config git-p4.detectRenames $((level - 2)) &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file7 &&
-	p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
+		git mv file6 file7 &&
+		echo update >>file7 &&
+		git add file7 &&
+		git commit -a -m "Rename file6 to file7 with changes" &&
+		git diff-tree -r -M HEAD &&
+		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
+		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
+		git config git-p4.detectRenames $(($level - 2)) &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file7 &&
+		p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
+	)
 '
 
 # Copy a file and confirm that copy is not detected in P4.
@@ -336,141 +326,79 @@ test_expect_success 'detect renames' '
 test_expect_success 'detect copies' '
 	"$GITP4" clone --dest="$git" //depot@all &&
 	test_when_finished cleanup_git &&
-	cd "$git" &&
-	git config git-p4.skipSubmitEditCheck true &&
-
-	cp file2 file8 &&
-	git add file8 &&
-	git commit -a -m "Copy file2 to file8" &&
-	git diff-tree -r -C HEAD &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file8 &&
-	! p4 filelog //depot/file8 | grep -q "branch from" &&
-
-	cp file2 file9 &&
-	git add file9 &&
-	git commit -a -m "Copy file2 to file9" &&
-	git diff-tree -r -C HEAD &&
-	git config git-p4.detectCopies true &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file9 &&
-	! p4 filelog //depot/file9 | grep -q "branch from" &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
 
-	echo "file2" >>file2 &&
-	cp file2 file10 &&
-	git add file2 file10 &&
-	git commit -a -m "Modify and copy file2 to file10" &&
-	git diff-tree -r -C HEAD &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file10 &&
-	p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
+		cp file2 file8 &&
+		git add file8 &&
+		git commit -a -m "Copy file2 to file8" &&
+		git diff-tree -r -C HEAD &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file8 &&
+		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
 
-	cp file2 file11 &&
-	git add file11 &&
-	git commit -a -m "Copy file2 to file11" &&
-	git diff-tree -r -C --find-copies-harder HEAD &&
-	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-	test "$src" = file10 &&
-	git config git-p4.detectCopiesHarder true &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file11 &&
-	p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
+		cp file2 file9 &&
+		git add file9 &&
+		git commit -a -m "Copy file2 to file9" &&
+		git diff-tree -r -C HEAD &&
+		git config git-p4.detectCopies true &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file9 &&
+		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
 
-	cp file2 file12 &&
-	echo "some text" >>file12 &&
-	git add file12 &&
-	git commit -a -m "Copy file2 to file12 with changes" &&
-	git diff-tree -r -C --find-copies-harder HEAD &&
-	level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
-	test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
-	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-	test "$src" = file10 &&
-	git config git-p4.detectCopies $((level + 2)) &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file12 &&
-	! p4 filelog //depot/file12 | grep -q "branch from" &&
+		echo "file2" >>file2 &&
+		cp file2 file10 &&
+		git add file2 file10 &&
+		git commit -a -m "Modify and copy file2 to file10" &&
+		git diff-tree -r -C HEAD &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file10 &&
+		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
 
-	cp file2 file13 &&
-	echo "different text" >>file13 &&
-	git add file13 &&
-	git commit -a -m "Copy file2 to file13 with changes" &&
-	git diff-tree -r -C --find-copies-harder HEAD &&
-	level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
-	test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
-	src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-	test "$src" = file10 &&
-	git config git-p4.detectCopies $((level - 2)) &&
-	"$GITP4" submit &&
-	p4 filelog //depot/file13 &&
-	p4 filelog //depot/file13 | grep -q "branch from //depot/file"
-'
+		cp file2 file11 &&
+		git add file11 &&
+		git commit -a -m "Copy file2 to file11" &&
+		git diff-tree -r -C --find-copies-harder HEAD &&
+		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+		test "$src" = file10 &&
+		git config git-p4.detectCopiesHarder true &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file11 &&
+		p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
 
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
+		cp file2 file12 &&
+		echo "some text" >>file12 &&
+		git add file12 &&
+		git commit -a -m "Copy file2 to file12 with changes" &&
+		git diff-tree -r -C --find-copies-harder HEAD &&
+		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
+		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
+		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+		test "$src" = file10 &&
+		git config git-p4.detectCopies $(($level + 2)) &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file12 &&
+		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
 
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
+		cp file2 file13 &&
+		echo "different text" >>file13 &&
+		git add file13 &&
+		git commit -a -m "Copy file2 to file13 with changes" &&
+		git diff-tree -r -C --find-copies-harder HEAD &&
+		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
+		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
+		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
+		test "$src" = file10 &&
+		git config git-p4.detectCopies $(($level - 2)) &&
+		"$GITP4" submit &&
+		p4 filelog //depot/file13 &&
+		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
+	)
 '
 
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
index 0000000..a25f18d
--- /dev/null
+++ b/t/t9801-git-p4-branch.sh
@@ -0,0 +1,233 @@
+#!/bin/sh
+
+test_description='git-p4 p4 branching tests'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
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
+	(
+		cd "$cli" &&
+		mkdir -p main &&
+
+		echo f1 >main/f1 &&
+		p4 add main/f1 &&
+		p4 submit -d "main/f1" &&
+
+		echo f2 >main/f2 &&
+		p4 add main/f2 &&
+		p4 submit -d "main/f2" &&
+
+		p4 integrate //depot/main/... //depot/branch1/... &&
+		p4 submit -d "integrate main to branch1" &&
+
+		echo f4 >main/f4 &&
+		p4 add main/f4 &&
+		p4 submit -d "main/f4" &&
+
+		echo f5 >branch1/f5 &&
+		p4 add branch1/f5 &&
+		p4 submit -d "branch1/f5" &&
+
+		p4 branch -i <<-EOF &&
+		Branch: branch2
+		View: //depot/main/... //depot/branch2/...
+		EOF
+
+		p4 integrate -b branch2 &&
+		p4 submit -d "integrate main to branch2" &&
+
+		echo f7 >branch2/f7 &&
+		p4 add branch2/f7 &&
+		p4 submit -d "branch2/f7" &&
+
+		echo f8 >main/f8 &&
+		p4 add main/f8 &&
+		p4 submit -d "main/f8"
+	)
+'
+
+test_expect_success 'import main, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot/main@all &&
+	(
+		cd "$git" &&
+		git log --oneline --graph --decorate --all &&
+		git rev-list master >wc &&
+		test_line_count = 4 wc
+	)
+'
+
+test_expect_success 'import branch1, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot/branch1@all &&
+	(
+		cd "$git" &&
+		git log --oneline --graph --decorate --all &&
+		git rev-list master >wc &&
+		test_line_count = 2 wc
+	)
+'
+
+test_expect_success 'import branch2, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot/branch2@all &&
+	(
+		cd "$git" &&
+		git log --oneline --graph --decorate --all &&
+		git rev-list master >wc &&
+		test_line_count = 2 wc
+	)
+'
+
+test_expect_success 'import depot, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log --oneline --graph --decorate --all &&
+		git rev-list master >wc &&
+		test_line_count = 8 wc
+	)
+'
+
+test_expect_success 'import depot, branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" --detect-branches //depot@all &&
+	(
+		cd "$git" &&
+
+		git log --oneline --graph --decorate --all &&
+
+		# 4 main commits
+		git rev-list master >wc &&
+		test_line_count = 4 wc &&
+
+		# 3 main, 1 integrate, 1 on branch2
+		git rev-list p4/depot/branch2 >wc &&
+		test_line_count = 5 wc &&
+
+		# no branch1, since no p4 branch created for it
+		test_must_fail git show-ref p4/depot/branch1
+	)
+'
+
+test_expect_success 'import depot, branch detection, branchList branch definition' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList main:branch1 &&
+		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+
+		git log --oneline --graph --decorate --all &&
+
+		# 4 main commits
+		git rev-list master >wc &&
+		test_line_count = 4 wc &&
+
+		# 3 main, 1 integrate, 1 on branch2
+		git rev-list p4/depot/branch2 >wc &&
+		test_line_count = 5 wc &&
+
+		# 2 main, 1 integrate, 1 on branch1
+		git rev-list p4/depot/branch1 >wc &&
+		test_line_count = 4 wc
+	)
+'
+
+test_expect_success 'restart p4d' '
+	kill_p4d &&
+	start_p4d
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
+	(
+		cd "$cli" &&
+		mkdir branch1 &&
+		cd branch1 &&
+		echo file1 >file1 &&
+		echo file2 >file2 &&
+		p4 add file1 file2 &&
+		p4 submit -d "branch1" &&
+		p4 integrate //depot/branch1/... //depot/branch2/... &&
+		p4 submit -d "branch2" &&
+		echo file3 >file3 &&
+		p4 add file3 &&
+		p4 submit -d "add file3 in branch1" &&
+		p4 open file2 &&
+		echo update >>file2 &&
+		p4 submit -d "update file2 in branch1" &&
+		p4 integrate //depot/branch1/... //depot/branch3/... &&
+		p4 submit -d "branch3"
+	)
+'
+
+# Configure branches through git-config and clone them.
+# All files are tested to make sure branches were cloned correctly.
+# Finally, make an update to branch1 on P4 side to check if it is imported
+# correctly by git-p4.
+test_expect_success 'git-p4 clone simple branches' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList branch1:branch2 &&
+		git config --add git-p4.branchList branch1:branch3 &&
+		"$GITP4" clone --dest=. --detect-branches //depot@all &&
+		git log --all --graph --decorate --stat &&
+		git reset --hard p4/depot/branch1 &&
+		test -f file1 &&
+		test -f file2 &&
+		test -f file3 &&
+		grep -q update file2 &&
+		git reset --hard p4/depot/branch2 &&
+		test -f file1 &&
+		test -f file2 &&
+		test ! -f file3 &&
+		test_must_fail grep -q update file2 &&
+		git reset --hard p4/depot/branch3 &&
+		test -f file1 &&
+		test -f file2 &&
+		test -f file3 &&
+		grep -q update file2 &&
+		cd "$cli" &&
+		cd branch1 &&
+		p4 edit file2 &&
+		echo file2_ >>file2 &&
+		p4 submit -d "update file2 in branch3" &&
+		cd "$git" &&
+		git reset --hard p4/depot/branch1 &&
+		"$GITP4" rebase &&
+		grep -q file2_ file2
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.7
