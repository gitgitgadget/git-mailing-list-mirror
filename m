From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Adapt tutorial to cygwin and add test case
Date: Tue, 11 Oct 2005 13:35:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510111333160.27109@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 11 13:38:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPIQC-0000O2-5y
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 13:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVJKLft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 07:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVJKLft
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 07:35:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42148 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932072AbVJKLfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 07:35:48 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5CEFD13EE40; Tue, 11 Oct 2005 13:35:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 415069E492; Tue, 11 Oct 2005 13:35:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 201449E48A; Tue, 11 Oct 2005 13:35:47 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0254E13EE40; Tue, 11 Oct 2005 13:35:47 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9963>

Lacking reliable symlinks, the instructions in the tutorial did not work 
in a cygwin setup. Also, a few outputs were not correct.

This patch fixes these, and adds a test case which follows the 
instructions of the tutorial (except git-clone, -fetch and -push, which I 
have not done yet).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

 Documentation/tutorial.txt |   71 ++++++++++++++------
 t/t1200-tutorial.sh        |  160 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+), 19 deletions(-)


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 19da3e2..7148da4 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -51,7 +51,9 @@ your new project. You will now have a `.
 inspect that with `ls`. For your new empty project, it should show you
 three entries, among other things:
 
- - a symlink called `HEAD`, pointing to `refs/heads/master`
+ - a symlink called `HEAD`, pointing to `refs/heads/master` (if your
+   platform does not have native symlinks, it is a file containing the
+   line "ref: refs/heads/master")
 +
 Don't worry about the fact that the file that the `HEAD` link points to
 doesn't even exist yet -- you haven't created the commit that will
@@ -227,6 +229,7 @@ which will spit out
 
 ------------
 diff --git a/hello b/hello
+index 557db03..263414f 100644
 --- a/hello
 +++ b/hello
 @@ -1 +1,2 @@
@@ -289,13 +292,14 @@ also wants to get a commit message
 on its standard input, and it will write out the resulting object name for the
 commit to its standard output.
 
-And this is where we start using the `.git/HEAD` file. The `HEAD` file is
+And this is where we create the `.git/refs/heads/master` file. This file is
 supposed to contain the reference to the top-of-tree, and since that's
 exactly what `git-commit-tree` spits out, we can do this all with a simple
 shell pipeline:
 
 ------------------------------------------------
-echo "Initial commit" | git-commit-tree $(git-write-tree) > .git/HEAD
+echo "Initial commit" | \
+	git-commit-tree $(git-write-tree) > .git/refs/heads/master
 ------------------------------------------------
 
 which will say:
@@ -691,7 +695,9 @@ other point in the history than the curr
 just telling `git checkout` what the base of the checkout would be.
 In other words, if you have an earlier tag or branch, you'd just do
 
-	git checkout -b mybranch earlier-commit
+------------
+git checkout -b mybranch earlier-commit
+------------
 
 and it would create the new branch `mybranch` at the earlier commit,
 and check out the state at that time.
@@ -699,17 +705,29 @@ and check out the state at that time.
 
 You can always just jump back to your original `master` branch by doing
 
-	git checkout master
+------------
+git checkout master
+------------
 
 (or any other branch-name, for that matter) and if you forget which
 branch you happen to be on, a simple
 
-	ls -l .git/HEAD
+------------
+ls -l .git/HEAD
+------------
 
-will tell you where it's pointing. To get the list of branches
-you have, you can say
+will tell you where it's pointing (Note that on platforms with bad or no
+symlink support, you have to execute
 
-	git branch
+------------
+cat .git/HEAD
+------------
+
+instead). To get the list of branches you have, you can say
+
+------------
+git branch
+------------
 
 which is nothing more than a simple script around `ls .git/refs/heads`.
 There will be asterisk in front of the branch you are currently on.
@@ -717,7 +735,9 @@ There will be asterisk in front of the b
 Sometimes you may wish to create a new branch _without_ actually
 checking it out and switching to it. If so, just use the command
 
-	git branch <branchname> [startingpoint]
+------------
+git branch <branchname> [startingpoint]
+------------
 
 which will simply _create_ the branch, but will not do anything further. 
 You can then later -- once you decide that you want to actually develop
@@ -843,7 +863,6 @@ $ git show-branch master mybranch
  ! [mybranch] Some work.
 --
 +  [master] Merged "mybranch" changes.
-+  [master~1] Some fun.
 ++ [mybranch] Some work.
 ------------------------------------------------
 
@@ -870,8 +889,10 @@ Now, let's pretend you are the one who d
 to the `master` branch. Let's go back to `mybranch`, and run
 resolve to get the "upstream changes" back to your branch.
 
-	git checkout mybranch
-	git resolve HEAD master "Merge upstream changes."
+------------
+git checkout mybranch
+git resolve HEAD master "Merge upstream changes."
+------------
 
 This outputs something like this (the actual commit object names
 would be different)
@@ -1087,13 +1108,17 @@ i.e. `<project>.git`. Let's create such 
 project `my-git`. After logging into the remote machine, create
 an empty directory:
 
-	mkdir my-git.git
+------------
+mkdir my-git.git
+------------
 
 Then, make that directory into a git repository by running
 `git init-db`, but this time, since its name is not the usual
 `.git`, we do things slightly differently:
 
-	GIT_DIR=my-git.git git-init-db
+------------
+GIT_DIR=my-git.git git-init-db
+------------
 
 Make sure this directory is available for others you want your
 changes to be pulled by via the transport of your choice. Also
@@ -1117,7 +1142,9 @@ Your "public repository" is now ready to
 Come back to the machine you have your private repository. From
 there, run this command:
 
-	git push <public-host>:/path/to/my-git.git master
+------------
+git push <public-host>:/path/to/my-git.git master
+------------
 
 This synchronizes your public repository to match the named
 branch head (i.e. `master` in this case) and objects reachable
@@ -1127,7 +1154,9 @@ As a real example, this is how I update 
 repository. Kernel.org mirror network takes care of the
 propagation to other publicly visible machines:
 
-	git push master.kernel.org:/pub/scm/git/git.git/ 
+------------
+git push master.kernel.org:/pub/scm/git/git.git/ 
+------------
 
 
 Packing your repository
@@ -1140,7 +1169,9 @@ not so convenient to transport over the 
 immutable once they are created, there is a way to optimize the
 storage by "packing them together". The command
 
-	git repack
+------------
+git repack
+------------
 
 will do it for you. If you followed the tutorial examples, you
 would have accumulated about 17 objects in `.git/objects/??/`
@@ -1164,7 +1195,9 @@ Our programs are always perfect ;-).
 Once you have packed objects, you do not need to leave the
 unpacked objects that are contained in the pack file anymore.
 
-	git prune-packed
+------------
+git prune-packed
+------------
 
 would remove them for you.
 
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
new file mode 100644
index 0000000..35db799
--- /dev/null
+++ b/t/t1200-tutorial.sh
@@ -0,0 +1,160 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Johannes Schindelin
+#
+
+test_description='Test git-rev-parse with different parent options'
+
+. ./test-lib.sh
+
+echo "Hello World" > hello
+echo "Silly example" > example
+
+git-update-index --add hello example
+
+test_expect_success 'blob' "test blob = \"$(git-cat-file -t 557db03)\""
+
+test_expect_success 'blob 557db03' "test \"Hello World\" = \"$(git-cat-file blob 557db03)\""
+
+echo "It's a new day for git" >>hello
+cat > diff.expect << EOF
+diff --git a/hello b/hello
+index 557db03..263414f 100644
+--- a/hello
++++ b/hello
+@@ -1 +1,2 @@
+ Hello World
++It's a new day for git
+EOF
+git-diff-files -p > diff.output
+test_expect_success 'git-diff-files -p' 'cmp diff.expect diff.output'
+git diff > diff.output
+test_expect_success 'git diff' 'cmp diff.expect diff.output'
+
+tree=$(git-write-tree 2>/dev/null)
+
+test_expect_success 'tree' "test 8988da15d077d4829fc51d8544c097def6644dbb = $tree"
+
+output="$(echo "Initial commit" | git-commit-tree $(git-write-tree) 2>&1 > .git/refs/heads/master)"
+
+test_expect_success 'commit' "test 'Committing initial tree 8988da15d077d4829fc51d8544c097def6644dbb' = \"$output\""
+
+git-diff-index -p HEAD > diff.output
+test_expect_success 'git-diff-index -p HEAD' 'cmp diff.expect diff.output'
+
+git diff HEAD > diff.output
+test_expect_success 'git diff HEAD' 'cmp diff.expect diff.output'
+
+#rm hello
+#test_expect_success 'git-read-tree --reset HEAD' "git-read-tree --reset HEAD ; test \"hello: needs update\" = \"$(git-update-index --refresh)\""
+
+cat > whatchanged.expect << EOF
+diff-tree VARIABLE (from root)
+Author: VARIABLE
+Date:   VARIABLE
+
+    Initial commit
+
+diff --git a/example b/example
+new file mode 100644
+index 0000000..f24c74a
+--- /dev/null
++++ b/example
+@@ -0,0 +1 @@
++Silly example
+diff --git a/hello b/hello
+new file mode 100644
+index 0000000..557db03
+--- /dev/null
++++ b/hello
+@@ -0,0 +1 @@
++Hello World
+EOF
+
+git-whatchanged -p --root | \
+	sed -e "1s/^\(.\{10\}\).\{40\}/\1VARIABLE/" \
+		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
+> whatchanged.output
+test_expect_success 'git-whatchanged -p --root' 'cmp whatchanged.expect whatchanged.output'
+
+git tag my-first-tag
+test_expect_success 'git tag my-first-tag' 'cmp .git/refs/heads/master .git/refs/tags/my-first-tag'
+
+# TODO: test git-clone
+
+git checkout -b mybranch
+test_expect_success 'git checkout -b mybranch' 'cmp .git/refs/heads/master .git/refs/heads/mybranch'
+
+cat > branch.expect <<EOF
+  master
+* mybranch
+EOF
+
+git branch > branch.output
+test_expect_success 'git branch' 'cmp branch.expect branch.output'
+
+git checkout mybranch
+echo "Work, work, work" >>hello
+git commit -m 'Some work.' hello
+
+git checkout master
+
+echo "Play, play, play" >>hello
+echo "Lots of fun" >>example
+git commit -m 'Some fun.' hello example
+
+test_expect_failure 'git resolve now fails' 'git resolve HEAD mybranch "Merge work in mybranch"'
+
+cat > hello << EOF
+Hello World
+It's a new day for git
+Play, play, play
+Work, work, work
+EOF
+
+git commit -m 'Merged "mybranch" changes.' hello
+
+cat > show-branch.expect << EOF
+* [master] Merged "mybranch" changes.
+ ! [mybranch] Some work.
+--
++  [master] Merged "mybranch" changes.
+++ [mybranch] Some work.
+EOF
+
+git show-branch master mybranch > show-branch.output
+test_expect_success 'git show-branch' 'cmp show-branch.expect show-branch.output'
+
+git checkout mybranch
+
+cat > resolve.expect << EOF
+Updating from VARIABLE to VARIABLE.
+ example |    1 +
+ hello   |    1 +
+ 2 files changed, 2 insertions(+), 0 deletions(-)
+EOF
+
+git resolve HEAD master "Merge upstream changes." | \
+	sed -e "1s/[0-9a-f]\{40\}/VARIABLE/g" > resolve.output
+test_expect_success 'git resolve' 'cmp resolve.expect resolve.output'
+
+cat > show-branch2.expect << EOF
+! [master] Merged "mybranch" changes.
+ * [mybranch] Merged "mybranch" changes.
+--
+++ [master] Merged "mybranch" changes.
+EOF
+
+git show-branch master mybranch > show-branch2.output
+test_expect_success 'git show-branch' 'cmp show-branch2.expect show-branch2.output'
+
+# TODO: test git fetch
+
+# TODO: test git push
+
+test_expect_success 'git repack' 'git repack'
+test_expect_success 'git prune-packed' 'git prune-packed'
+test_expect_failure '-> only packed objects' 'find -type f .git/objects/[0-9a-f][0-9a-f]'
+
+test_done
+
