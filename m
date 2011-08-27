From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Sat, 27 Aug 2011 19:32:01 -0400
Message-ID: <20110827233201.GA6999@arf.padd.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
 <1313712590-26876-3-git-send-email-vitor.hda@gmail.com>
 <20110820191203.GC7135@arf.padd.com>
 <20110822011319.0a013117@fenix.utopia.dhis.org>
 <20110823022713.GA6005@arf.padd.com>
 <CAOpHH-V92CcWm1tCwvb=pJux5PKbYQoG=E8M_Pc2JGu00wnR8Q@mail.gmail.com>
 <20110823231034.GA11918@arf.padd.com>
 <CAOpHH-V9nm2NRD47gdUj6sLJSTypjABjE-JGCkADE=fxh2nSWg@mail.gmail.com>
 <CAOpHH-Uv=zK9JoL+ooA9eEHg2XyX=k92hL1QZ_WNZwgvpnNj0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 01:32:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxSMI-0002j6-4V
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 01:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193Ab1H0XcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Aug 2011 19:32:08 -0400
Received: from honk.padd.com ([74.3.171.149]:50102 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab1H0XcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 19:32:06 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 9B9525B4F;
	Sat, 27 Aug 2011 16:32:04 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CA705314D1; Sat, 27 Aug 2011 19:32:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAOpHH-Uv=zK9JoL+ooA9eEHg2XyX=k92hL1QZ_WNZwgvpnNj0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180251>

vitor.hda@gmail.com wrote on Wed, 24 Aug 2011 22:23 +0100:
> On Wed, Aug 24, 2011 at 11:46 AM, Vitor Antunes <vitor.hda@gmail.com>=
 wrote:
> > 1. When doing a "checkpoint" it would make sense to have some kind =
of
> > =A0 feedback loop to know when fast-import completes it. In fact, I=
've
> > =A0 just looked at fast-import man page and the "progress" command =
seems
> > =A0 to do exactly that! Myabe we should crease a specific function =
for
> > =A0 "checkpoint" that would call also "progress" instead of calling
> > =A0 os.sleep().
>=20
>     # Force a checkpoint in fast-import and wait for it to finish
>     def checkpoint(self):
>         self.gitStream.write("checkpoint\n\n")
>         self.gitStream.write("progress checkpoint\n\n")
>         out =3D self.gitOutput.readline()
>         if self.verbose:
>             print "checkpoint finished: " + out
>=20
> This seems to work! :)

That's brilliant.  And not even hacky.  :)

> > 2. In order to avoid needing to use "--force" it would be nice to h=
ave
> > =A0 some form of "drop" command in fast-import that would allows us=
 to
> > =A0 actively drop an older commit after calling "reset" (this could=
 even
> > =A0 be an option of "reset"). This way fast-import would not find
> > =A0 dangling commits in the end of the import. =A0Maybe there's alr=
eady
> > =A0 some sort of command to achieve this in fast-import...? We coul=
d
> > =A0 probably ask to one of its maintainers.
>=20
> Just missing point 2 now.

How about this.  Create the commit onto a fake branch name,
something involving the changeid would be okay.  Remember this
so we can delete it later.  For a parent, you can use anything,
so the top of the parent branch would be okay.  Checkpoint.

Use rev-parse like you do.  But go from the most recent commit on
back, hoping that the branch was created recently.  I suspect
this is the case for those using "git-p4 sync" with
detect-branches to discover new ones periodically.

=46or each ref, diff-tree like you do.  When it is found, generate
the commit again, with its real branch name and parent now.

When it exits, remember to delete the temp branches.  Would be
nice to do this even on error exit, but that's harder.  Maybe
the fake branch name should be something like
"refs/git-p4-temp/change-30214" instead of refs/heads/... to
indicate they are special.  GC will commit the commits
eventually.


The other thought I had was to use "blob" with a mark name on
each file.  Use --export-marks=3D...  Checkpoint.  Read the blob
ids corresponding to files on the branch.  Then iterate back the
revs and do "git ls-tree -r ref^{tree}".  Compare its blobs to
the new ones until a matching commit is found.  Finally assemble
the blobs into a commit; no need to write them again.  This seems
harder.


Here's a commit that refactors the tests and adds a bunch more
branch tests.  They all pass with your checkpoint/progress fix,
and still using --force.

		-- Pete


---------------------8<---------------
=46rom f1e11b78cbb74fd4347df5fff64a373c3e449f68 Mon Sep 17 00:00:00 200=
1
=46rom: Pete Wyckoff <pw@padd.com>
Date: Mon, 22 Aug 2011 22:20:33 -0400
Subject: [PATCH] git-p4 tests: refactor and add branch tests

Separate the tests related to detecting p4 branches
into their own file, and add a few more.

Introduce a library for functions that are common to
both git-p4 test files.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh          |   55 ++++++++
 t/t9800-git-p4.sh        |  182 +-------------------------
 t/t9801-git-p4-branch.sh |  326 ++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 388 insertions(+), 175 deletions(-)
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
+	skip_all=3D'skipping git-p4 tests; no p4 or p4d'
+	test_done
+}
+
+GITP4=3D$GIT_BUILD_DIR/contrib/fast-import/git-p4
+P4DPORT=3D10669
+
+export P4PORT=3Dlocalhost:$P4DPORT
+export P4CLIENT=3Dclient
+
+db=3D"$TRASH_DIRECTORY/db"
+cli=3D"$TRASH_DIRECTORY/cli"
+git=3D"$TRASH_DIRECTORY/git"
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
+	pid=3D`pgrep -f p4d` &&
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
index cf3a70e..684aa53 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -2,40 +2,16 @@
=20
 test_description=3D'git-p4 tests'
=20
-. ./test-lib.sh
+. ./lib-git-p4.sh
=20
-( p4 -h && p4d -h ) >/dev/null 2>&1 || {
-	skip_all=3D'skipping git-p4 tests; no p4 or p4d'
-	test_done
-}
-
-GITP4=3D$GIT_BUILD_DIR/contrib/fast-import/git-p4
-P4DPORT=3D10669
-
-export P4PORT=3Dlocalhost:$P4DPORT
-
-db=3D"$TRASH_DIRECTORY/db"
-cli=3D"$TRASH_DIRECTORY/cli"
-git=3D"$TRASH_DIRECTORY/git"
-
-test_debug 'echo p4d -q -d -r "$db" -p $P4DPORT'
-test_expect_success setup '
-	mkdir -p "$db" &&
-	p4d -q -d -r "$db" -p $P4DPORT &&
-	mkdir -p "$cli" &&
-	mkdir -p "$git" &&
-	export P4PORT=3Dlocalhost:$P4DPORT
+test_expect_success 'start p4d' '
+	kill_p4d || : &&
+	start_p4d &&
+	cd "$TRASH_DIRECTORY"
 '
=20
 test_expect_success 'add p4 files' '
 	cd "$cli" &&
-	p4 client -i <<-EOF &&
-	Client: client
-	Description: client
-	Root: $cli
-	View: //depot/... //client/...
-	EOF
-	export P4CLIENT=3Dclient &&
 	echo file1 >file1 &&
 	p4 add file1 &&
 	p4 submit -d "file1" &&
@@ -45,12 +21,6 @@ test_expect_success 'add p4 files' '
 	cd "$TRASH_DIRECTORY"
 '
=20
-cleanup_git() {
-	cd "$TRASH_DIRECTORY" &&
-	rm -rf "$git" &&
-	mkdir "$git"
-}
-
 test_expect_success 'basic git-p4 clone' '
 	"$GITP4" clone --dest=3D"$git" //depot &&
 	test_when_finished cleanup_git &&
@@ -404,146 +374,8 @@ test_expect_success 'detect copies' '
 	p4 filelog //depot/file13 | grep -q "branch from //depot/file"
 '
=20
-# Create a simple branch structure in P4 depot to check if it is corre=
ctly
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
-# Finally, make an update to branch1 on P4 side to check if it is impo=
rted
-# correctly by git-p4.
-test_expect_success 'git-p4 clone simple branches' '
-	test_when_finished cleanup_git &&
-	test_create_repo "$git" &&
-	cd "$git" &&
-	git config git-p4.branchList branch1:branch2 &&
-	git config --add git-p4.branchList branch1:branch3 &&
-	"$GITP4" clone --dest=3D. --detect-branches //depot@all &&
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
-	p4 submit -d "update file2 in branch3" &&
-	cd "$git" &&
-	git reset --hard p4/depot/branch1 &&
-	"$GITP4" rebase &&
-	grep -q file2_ file2
-'
-
-# Create a complex branch structure in P4 depot to check if they are c=
orrectly
-# cloned. The branches are created from older changelists to check if =
git-p4 is
-# able to correctly detect them.
-# The final expected structure is:
-# `branch1
-# | `- file1
-# | `- file2 (updated)
-# | `- file3
-# `branch2
-# | `- file1
-# | `- file2
-# `branch3
-# | `- file1
-# | `- file2 (updated)
-# | `- file3
-# `branch4
-# | `- file1
-# | `- file2
-# `branch5
-#   `- file1
-#   `- file2
-#   `- file3
-test_expect_success 'add p4 complex branches' '
-	cd "$cli" &&
-	changelist=3D$(p4 changes -m1 //depot/... | cut -d" " -f2) &&
-	changelist=3D$((changelist - 5)) &&
-	p4 integrate //depot/branch1/...@$changelist //depot/branch4/... &&
-	p4 submit -d "branch4" &&
-	changelist=3D$((changelist + 2)) &&
-	p4 integrate //depot/branch1/...@$changelist //depot/branch5/... &&
-	p4 submit -d "branch5" &&
-	cd "$TRASH_DIRECTORY"
-'
-
-# Configure branches through git-config and clone them. git-p4 will on=
ly be able
-# to clone the original structure if it is able to detect the origin c=
hangelist
-# of each branch.
-test_expect_success 'git-p4 clone complex branches' '
-	test_when_finished cleanup_git &&
-	test_create_repo "$git" &&
-	cd "$git" &&
-	git config git-p4.branchList branch1:branch2 &&
-	git config --add git-p4.branchList branch1:branch3 &&
-	git config --add git-p4.branchList branch1:branch4 &&
-	git config --add git-p4.branchList branch1:branch5 &&
-	"$GITP4" clone --dest=3D. --detect-branches //depot@all &&
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
-	git reset --hard p4/depot/branch4 &&
-	test -f file1 &&
-	test -f file2 &&
-	test ! -f file3 &&
-	! grep -q update file2 &&
-	git reset --hard p4/depot/branch5 &&
-	test -f file1 &&
-	test -f file2 &&
-	test -f file3 &&
-	! grep -q update file2
-'
-
-test_expect_success 'shutdown' '
-	pid=3D`pgrep -f p4d` &&
-	test -n "$pid" &&
-	test_debug "ps wl `echo $pid`" &&
-	kill $pid
+test_expect_success 'kill p4d' '
+	kill_p4d
 '
=20
 test_done
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
new file mode 100755
index 0000000..c71d1a5
--- /dev/null
+++ b/t/t9801-git-p4-branch.sh
@@ -0,0 +1,326 @@
+#!/bin/sh
+
+test_description=3D'git-p4 p4 branching tests'
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
+	"$GITP4" clone --dest=3D"$git" //depot/main@all &&
+	cd "$git" &&
+	git log --oneline --graph --decorate --all &&
+	git rev-list master >wc &&
+	test_line_count =3D 4 wc
+'
+
+test_expect_success 'import branch1, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest=3D"$git" //depot/branch1@all &&
+	cd "$git" &&
+	git log --oneline --graph --decorate --all &&
+	git rev-list master >wc &&
+	test_line_count =3D 2 wc
+'
+
+test_expect_success 'import branch2, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest=3D"$git" //depot/branch2@all &&
+	cd "$git" &&
+	git log --oneline --graph --decorate --all &&
+	git rev-list master >wc &&
+	test_line_count =3D 2 wc
+'
+
+test_expect_success 'import depot, no branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest=3D"$git" //depot@all &&
+	cd "$git" &&
+	git log --oneline --graph --decorate --all &&
+	git rev-list master >wc &&
+	test_line_count =3D 8 wc
+'
+
+test_expect_success 'import depot, branch detection' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest=3D"$git" --detect-branches //depot@all &&
+	cd "$git" &&
+
+	git log --oneline --graph --decorate --all &&
+
+	# 4 main commits
+	git rev-list master >wc &&
+	test_line_count =3D 4 wc &&
+
+	# 3 main, 1 integrate, 1 on branch2
+	git rev-list p4/depot/branch2 >wc &&
+	test_line_count =3D 5 wc &&
+
+	# no branch1, since no p4 branch created for it
+	test_must_fail git show-ref p4/depot/branch1
+'
+
+test_expect_success 'import depot, branch detection, branchList branch=
 definition' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	cd "$git" &&
+	git config git-p4.branchList main:branch1 &&
+	"$GITP4" clone --dest=3D. --detect-branches //depot@all &&
+
+	git log --oneline --graph --decorate --all &&
+
+	# 4 main commits
+	git rev-list master >wc &&
+	test_line_count =3D 4 wc &&
+
+	# 3 main, 1 integrate, 1 on branch2
+	git rev-list p4/depot/branch2 >wc &&
+	test_line_count =3D 5 wc &&
+
+	# 2 main, 1 integrate, 1 on branch1
+	git rev-list p4/depot/branch1 >wc &&
+	test_line_count =3D 4 wc
+'
+
+test_expect_success 'branch from non-head should find parent' '
+	cd "$cli" &&
+	p4 integrate //depot/main/...@1 //depot/branch3/... &&
+	p4 submit -d "integrate main@1 to branch3" &&
+
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	cd "$git" &&
+
+	git config git-p4.branchList main:branch1 &&
+	git config git-p4.branchList main:branch3 &&
+	"$GITP4" clone --dest=3D. --detect-branches //depot@all &&
+
+	git log --oneline --graph --decorate --all &&
+
+	branch3_parent=3D$(git rev-parse p4/depot/branch3^) &&
+	change1=3D$(git rev-parse :/"change =3D 1") &&
+	echo test $branch3_parent =3D $change1 &&
+	test $branch3_parent =3D $change1
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
+# Finally, make an update to branch1 on P4 side to check if it is impo=
rted
+# correctly by git-p4.
+test_expect_success 'git-p4 clone simple branches' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	cd "$git" &&
+	git config git-p4.branchList branch1:branch2 &&
+	git config --add git-p4.branchList branch1:branch3 &&
+	"$GITP4" clone --dest=3D. --detect-branches //depot@all &&
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
+# Create a complex branch structure in P4 depot to check if they are c=
orrectly
+# cloned. The branches are created from older changelists to check if =
git-p4 is
+# able to correctly detect them.
+#
+# The final expected structure is:
+# `branch1
+# | `- file1
+# | `- file2 (updated)
+# | `- file3
+# `branch2
+# | `- file1
+# | `- file2
+# `branch3
+# | `- file1
+# | `- file2 (updated)
+# | `- file3
+# `branch4
+# | `- file1
+# | `- file2
+# `branch5
+#   `- file1
+#   `- file2
+#   `- file3
+#
+# Changes 1..6 from previous tests, plus two new ones:
+# 1: //depot/branch1/file1
+#    //depot/branch1/file2
+# 2: integrate //depot/branch1/... -> //depot/branch2/...
+# 3: //depot/branch1/file3
+# 4: //depot/branch1/file2 (edit)
+# 5: integrate //depot/branch1/... -> //depot/branch3/...
+# 6: //depot/branch3/file2 (edit, from previous test)
+# 7: integrate //depot/branch1/...@1 -> //depot/branch4/...
+# 8: integrate //depot/branch1/...@3 -> //depot/branch5/...
+#
+test_expect_success 'add p4 complex branches' '
+	cd "$cli" &&
+	p4 integrate //depot/branch1/...@1 //depot/branch4/... &&
+	p4 submit -d "branch4 from branch1@1" &&
+	p4 integrate //depot/branch1/...@3 //depot/branch5/... &&
+	p4 submit -d "branch5 from branch1@3" &&
+	cd "$TRASH_DIRECTORY"
+'
+
+# Configure branches through git-config and clone them.  git-p4 will o=
nly be
+# able to clone the original structure if it is able to detect the ori=
gin
+# changelist of each branch.
+test_expect_success 'git-p4 clone complex branches' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	cd "$git" &&
+	git config git-p4.branchList branch1:branch2 &&
+	git config --add git-p4.branchList branch1:branch3 &&
+	git config --add git-p4.branchList branch1:branch4 &&
+	git config --add git-p4.branchList branch1:branch5 &&
+	"$GITP4" clone --dest=3D. --detect-branches //depot@all &&
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
+	git reset --hard p4/depot/branch4 &&
+	test -f file1 &&
+	test -f file2 &&
+	test ! -f file3 &&
+	test_must_fail grep -q update file2 &&
+	git reset --hard p4/depot/branch5 &&
+	test -f file1 &&
+	test -f file2 &&
+	test -f file3 &&
+	test_must_fail grep -q update file2
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
--=20
1.7.5.4
