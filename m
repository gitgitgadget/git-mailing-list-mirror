From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] cvstrack: work on imported cvs and other git branches
Date: Sun,  1 Jul 2007 15:16:36 +0200
Message-ID: <11832957963860-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 01 15:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4zLF-0002dN-CG
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 15:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbXGANTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 09:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbXGANTn
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 09:19:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:46128 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755812AbXGANTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 09:19:42 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l61DGa9r012510
	for <git@vger.kernel.org>; Sun, 1 Jul 2007 15:19:40 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l61DGaU4016728;
	Sun, 1 Jul 2007 15:16:36 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51294>

The idea is to import a cvs repository using git cvsimport; build
a perfect history in git by cherry picking commits that are only
in cvs but not in git; and export only summaries back to cvs. Cvs
imports are organized on a separate git branch. git is used for
merging. The differences can be sent back to cvs as a squashed
commit together with a shortlog. Sent git commits are noted in
the cvs commit message and will be ignored in subsequent cvs
imports.

To get the idea you can run t/t9250-git-cvstrack.sh and explore
the git repository created in t/trash/gitwork.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 .gitignore                     |    4 +
 Documentation/git-cvstrack.txt |  128 +++++++++++++++++++
 Makefile                       |    1 +
 git-cvstrack-fetch.sh          |   52 ++++++++
 git-cvstrack-init.sh           |   20 +++
 git-cvstrack-pull.sh           |   10 ++
 git-cvstrack-pushcvs.sh        |   60 +++++++++
 t/t9250-git-cvstrack.sh        |  270 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 545 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-cvstrack.txt
 create mode 100755 git-cvstrack-fetch.sh
 create mode 100755 git-cvstrack-init.sh
 create mode 100755 git-cvstrack-pull.sh
 create mode 100755 git-cvstrack-pushcvs.sh
 create mode 100755 t/t9250-git-cvstrack.sh


I am using these scripts successfully for some time. 

What do you think?
- Is the general concept useful?
- Comments on the coding style?
- Is using branches and tags to maintain the state a bad idea?



diff --git a/.gitignore b/.gitignore
index e8b060c..9924d07 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,10 @@ git-count-objects
 git-cvsexportcommit
 git-cvsimport
 git-cvsserver
+git-cvstrack-fetch
+git-cvstrack-init
+git-cvstrack-pull
+git-cvstrack-pushcvs
 git-daemon
 git-diff
 git-diff-files
diff --git a/Documentation/git-cvstrack.txt b/Documentation/git-cvstrack.txt
new file mode 100644
index 0000000..10f2de1
--- /dev/null
+++ b/Documentation/git-cvstrack.txt
@@ -0,0 +1,128 @@
+git-cvstrack(1)
+=============
+
+NAME
+----
+git-cvstrack - work on imported cvs and other git branches 
+
+SYNOPSIS
+--------
+'git-cvstrack-init' <cvsbranch>
+'git-cvstrack-fetch' [<cvsbranch>]
+'git-cvstrack-pull' <cvsbranch>
+'git-cvstrack-pushcvs' <cvsbranch> <cvsworkingcopy>
+
+DESCRIPTION
+-----------
+git-cvstrack tracks cvs branches imported by git-cvsimport and provides a
+mechanism to sent changes from git back to cvs squashed into a single commit.
+
+cvstrack can be used to start building a sane git history that integrates an
+exiting, active cvs and work done in git. Eventually the cvs repository can
+be closed and git will serve as the only SCM. At that time you already have a
+sane history from the point you started to use cvstrack.
+
+The basic workflow is as follows.
+
+1) Initial import from cvs and clone a tracking repository
+
+    git cvsimport -d /path/to/cvsroot -i -k -u  -C cvsimported.git -o cvshead
+    git clone cvsimported.git cvstracker
+
+2) Initialize tracking
+
+    cd cvstracker
+    git checkout master
+    git cvstrack-init cvshead
+    cd ..
+
+3) Incrementally import work from cvs 
+
+    git cvsimport -d /path/to/cvsroot -i -k -u  -C cvsimported.git -o cvshead module
+
+4) Incrementally fetch to cvstracker
+
+    cd cvstracker
+    git checkout master
+    git cvstrack-pull cvshead  # or git-cvstrack-fetch to avoid merge
+    cd ..
+
+5) Work on a git branch (you may want to clone cvstracker first to separate
+    working branches from cvstrack)
+
+    cd cvstracker
+    git checkout -b topic master
+    # edit files
+    git commit
+    cd ..
+
+6) Send changes to cvs
+
+    cvs -d /path/to/cvsroot checkout -d cvsworkingcopy module  # or cvs update
+    cd cvstracker
+    git checkout master
+    git merge topic
+    git cvstrack-pushcvs cvshead ../cvsworkingcopy
+    # follow instructions from cvstrack-pushcvs here:
+    # edit message and cvs commit
+
+You can do (3)-(6) in any order. Note however, it is recommended to merge topic
+branches only if you plan to send them to cvs right away. It is a bad idea to
+let master and cvs diverge too much. 
+
+Technical Details
+-----------------
+git-cvstrack maintains its state using two git branches and one tag per cvs
+branch. Commits imported by git-cvsimport are on origin/cvsbranch. From there
+commits are cherry-picked to cvspending/cvsbranch. Only commits that did not
+originate from git are cherry-picked. Commits originating from git are detected
+by examining if the cvs commit message contains 'git-cvstrack-revs:'. The tag
+cvspicked/cvsbranch marks the latest commit that was cherry picked.
+
+Because commits originating from git are filtered from the imported cvs branch
+the git history only contains 'real' changes. The git history is in a sense a
+perfect git history. Changes from cvs are handled as just another topic branch.
+Merges sent to cvs are filtered and will not enter the git side of the history
+twice.
+
+All the merging machinery of git can be used to merge git and cvs topic
+branches. cvs is treated as a second level citizen. Changes done in git are
+only sent back as a squashed commit. This is a good compromise because cvs
+can't handle nonlinear history anyway.
+
+Advanced Topics
+---------------
+You can track several cvsbranches by running git cvstrack-init multiple times.
+
+If a new cvs branch X is created after you started tracking with cvstrack
+you'll need to rebase cvstrack/X created by git cvstrack-init X to the parent
+of an existing cvstrack/... branch that corresponds to the cherry picked commit
+of the root point of the cvs topic branch.
+
+You may need to fix the parent commit of a cvs topic branch. git-cvsimport
+chooses the wrong parent for cvs topic branches if changes were commited to the
+head between the creation of the cvs branch and the first commit to it.
+See the following threads on the mailing list:
+
+http://marc.info/?l=git&m=118260312708709
+http://marc.info/?l=git&m=118262688431613
+
+OPTIONS
+-------
+<cvsbranch>::
+	Branch imported from cvs by git-cvsimport.
+
+<cvsworkingcopy>::
+	CVS working copy that matches <cvsbranch>.
+
+Author
+------
+Written by Steffen Prohaska <prohaska@zib.de>
+
+Documentation
+-------------
+Documentation by Steffen Prohaska <prohaska@zib.de>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 5d60dc8..8026e38 100644
--- a/Makefile
+++ b/Makefile
@@ -212,6 +212,7 @@ SCRIPT_SH = \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
+	git-cvstrack-fetch.sh git-cvstrack-init.sh git-cvstrack-pull.sh git-cvstrack-pushcvs.sh \
 	git-filter-branch.sh
 
 SCRIPT_PERL = \
diff --git a/git-cvstrack-fetch.sh b/git-cvstrack-fetch.sh
new file mode 100755
index 0000000..d4aa13b
--- /dev/null
+++ b/git-cvstrack-fetch.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+
+# need exactly one argument
+USAGE="[<branch>]"
+. git-sh-setup
+[[ $# -le 1 ]] || usage
+
+if [[ $# -eq 1 ]]
+then
+    branch=$1
+# which must be a remote branch
+    git branch -r | grep -q "/$branch\$" || die "Error: $branch must be a remote branch." 
+
+# safety nets
+    git tag -l "cvspicked/$branch" >/dev/null || die "Error: missing tag cvspicked/$branch." 
+    git branch | grep -q "cvspending/$branch" || die "Error: missing branch cvspending/$branch." 
+
+    branches=$branch
+else
+    branches=$(git branch -l  | cut -b 3- | grep ^cvspending/ | cut -b 12-)
+fi
+
+# fetch and cherry pick
+git fetch || exit 1
+
+origbranch=$(git branch | grep '^\*' | cut -b3-)
+
+for branch in $branches ; do
+    echo "Fetching new cvs commits to cvspending/$branch"
+    git branch -r | grep -q "/$branch\$" || { "Error: missing remote branch $branch, skipping ..." ; continue ; }
+    git tag -l "cvspicked/$branch" >/dev/null || { "Error: missing tag cvspicked/$branch, skipping ..." ; continue ; }
+
+    git checkout "cvspending/$branch" || exit 1
+#for r in $(git rev-list --pretty=oneline --reverse cvspicked/$branch..origin/$branch | grep -v '\[from git\]' | cut -d ' ' -f 1) ; do
+    for r in $(git rev-list --reverse "cvspicked/$branch..origin/$branch") ; do
+        git cat-file -p "$r" | egrep -q '^\[from git\]' && { echo "skipping $r" ; continue ; }
+        git cat-file -p "$r" | egrep -q '^git-cvstrack-revs: [0-9a-f]{40}\.\.[0-9a-f]{40}' && { echo "skipping $r" ; continue ; }
+        echo "picking $r"
+        output="$(git cherry-pick "$r")" || 
+        {
+            ret=$?
+            echo "$output"
+            echo "$output" | grep -q  "CONFLICT" && die "Error: git cherry-pick detected CONFLICT and exited with $ret."
+            echo "Warning: git cherry-pick exited with $ret but didn't report a severe problem, continuing."
+        }
+    done
+    rm -f .msg
+    git tag -f -m "cherry-picked cvs $branch up to here" "cvspicked/$branch" "origin/$branch"
+done
+
+git checkout "$origbranch"
diff --git a/git-cvstrack-init.sh b/git-cvstrack-init.sh
new file mode 100755
index 0000000..cb60fe9
--- /dev/null
+++ b/git-cvstrack-init.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+# need exactly one argument
+USAGE="<branch>"
+. git-sh-setup
+[[ $# == 1 ]] || usage
+
+branch=$1
+
+# which must be a remote branch
+git branch -r | grep -q "/$branch\$" || die "Error: $branch must be a remote branch" 
+
+# safety nets
+git tag -l "cvspicked/$branch" | grep -q "cvspicked/$branch" && die "Error: tag cvspicked/$branch already exists" 
+git branch | grep -q "cvspending/$branch" && die "Error: branch cvspending/$branch already exists" 
+
+
+# setup tracking
+git tag -f -m "cherry-picked cvs $branch up to here" cvspicked/$branch origin/$branch || exit 1 
+git branch --no-track "cvspending/$branch" "origin/$branch" || exit 1
diff --git a/git-cvstrack-pull.sh b/git-cvstrack-pull.sh
new file mode 100755
index 0000000..3fd61c3
--- /dev/null
+++ b/git-cvstrack-pull.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+USAGE="<branch>"
+. git-sh-setup
+[[ $# == 1 ]] || usage
+
+. git-cvstrack-fetch
+
+echo "Pulling new cvs commits"
+git pull . "cvspending/$branch"
diff --git a/git-cvstrack-pushcvs.sh b/git-cvstrack-pushcvs.sh
new file mode 100755
index 0000000..85e85fa
--- /dev/null
+++ b/git-cvstrack-pushcvs.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+# need exactly two arguments
+USAGE="<branch> <cvsworkingcopy>"
+. git-sh-setup
+[[ $# == 2 ]] || usage
+
+branch=$1
+cvswc=$2
+
+# branch must be a remote branch
+git branch -r | grep -q "/$branch\$" || die "Error: $branch must be a remote branch." 
+
+[[ -d "$cvswc/CVS" ]] || die "Error: $cvswc must be a CVS working copy" 
+
+# safety nets
+git tag -l "cvspicked/$branch" >/dev/null || die "Error: missing tag cvspicked/$branch." 
+git branch | grep -q "cvspending/$branch" || die "Error: missing branch cvspending/$branch."
+
+# User should have fetched and pulled.
+# However, we don't require a fetch but enforce at least a local pull.
+origbranch="$(git branch | grep '^\*' | cut -b3-)"
+[[ $(git rev-parse "$origbranch") != $(git rev-parse "cvspending/$branch") ]]  || { echo "Nothing to do. $origbranch and cvspending/$branch are identical." ; git checkout "$origbranch"; exit 0 ; } 
+
+origbranchhead="$(git rev-parse HEAD)"
+
+git pull --no-commit . "cvspending/$branch" || die "local pull failed"
+git commit -m "Merge cvspending/$branch into $origbranch (preparing cvstrack-pushcvs)"
+git checkout "cvspending/$branch" || die "checkout cvspending/$branch failed"
+from=$(git rev-parse HEAD)
+git pull .  "$origbranch" || die "local pull $origbranch failed"
+to=$(git rev-parse HEAD)
+
+echo "applying changes to cvs working copy $cvswc"
+cvsexportmsg="$( export GIT_DIR=$(cd "$GIT_DIR" ; pwd) ; cd "$cvswc" ; git cvsexportcommit -p -v -P "$from" "cvspending/$branch" )" \
+    || \
+    { 
+        echo "git cvsexportcommit failed: rolling back changes to git repository."
+        git reset --hard "$from"
+        git checkout "$origbranch"
+        git reset --hard "$origbranchhead"
+        die "Error: git cvsexporcommit failed. Please carefully check message above."
+    }
+commitcmd=$(echo "$cvsexportmsg" | egrep '^ *cvs commit -F .msg')
+
+echo "YOUR SUMMARY HERE" >$cvswc/.msg
+echo "" >>$cvswc/.msg
+git log $from..$to | git shortlog >>$cvswc/.msg
+echo "" >>$cvswc/.msg
+echo "git-cvstrack-revs: $from..$to" >>$cvswc/.msg
+
+git checkout "$origbranch"
+
+echo ""
+echo "*Did not commit changes to CVS.*"
+echo "You need to edit the message in"
+echo "   $cvswc/.msg"
+echo "and commit with"
+echo "   (cd $cvswc ; $commitcmd)"
+echo ""
diff --git a/t/t9250-git-cvstrack.sh b/t/t9250-git-cvstrack.sh
new file mode 100755
index 0000000..274ed1d
--- /dev/null
+++ b/t/t9250-git-cvstrack.sh
@@ -0,0 +1,270 @@
+#!/bin/sh
+
+test_description='CVS export comit. '
+
+. ./test-lib.sh
+
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+    test_expect_success 'skipping git-cvstrack tests, cvs not found' :
+    test_done
+    exit
+fi
+
+CVSROOT=$(pwd)/cvsroot
+CVSWORK=$(pwd)/cvswork
+export CVSROOT CVSWORK
+
+cvspscache="$HOME/.cvsps/$(echo $CVSROOT | sed -e 's%/%#%g')#src"
+rm -f $cvspscache
+
+rm -rf "$CVSROOT" "$CVSWORK"
+mkdir "$CVSROOT" &&
+cvs init &&
+mkdir "$CVSROOT/src"
+cvs -Q co -d "$CVSWORK" src &&
+rm -rf .git || 
+exit 1
+
+test_expect_success \
+	'initial cvs commit' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 1" >>a.txt &&
+	   echo "b: line 1" >>b.txt &&
+	   cvs add a.txt b.txt &&
+	   cvs commit -m "cvs commit 1"
+	)'
+
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C cvstracker -o cvshead src'
+
+test_expect_success \
+	'cloning git and initializing cvstrack' \
+	'git-clone cvstracker gitwork && 
+	 ( cd gitwork && 
+	   git-cvstrack-init cvshead
+	 )'
+
+test_expect_success \
+	'second initialization should fail' \
+	'( cd gitwork && 
+	   ! git-cvstrack-init cvshead
+	 )'
+
+test_expect_success \
+	'initialization of non-existing branch should fail' \
+	'( cd gitwork && 
+	   ! git-cvstrack-init wrong-name
+	 )'
+
+test_expect_success \
+	'cvs commit 2' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 2" >>a.txt &&
+	   echo "b: line 2" >>b.txt &&
+	   cvs commit -m "cvs commit 2"
+	)'
+
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'cvs commit 3' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 3" >>a.txt &&
+	   echo "b: line 3" >>b.txt &&
+	   cvs commit -m "cvs commit 3"
+	)'
+
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C cvstracker -o cvshead src'
+
+test_expect_success \
+	'commiting to git' \
+	'( cd gitwork &&
+	   git-checkout master &&
+	   echo "a: line 3 from git" >>a.txt &&
+	   git-add a.txt &&
+	   git-commit -m "git commit 1" &&
+  	   echo "c: line 1" >>c.txt &&
+  	   git-add c.txt &&
+	   git-commit -a -m "git commit 2" &&
+	   rm b.txt &&
+	   git-rm b.txt &&
+	   git-commit -a -m "git commit 3"
+	 )'
+
+test_expect_success \
+	'tracking cvs commits 2-3' \
+	'( cd gitwork && 
+       git-cvstrack-fetch cvshead
+     )'
+
+test_expect_success \
+	'cvs commit 4' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 4" >>a.txt &&
+	   echo "b: line 4" >>b.txt &&
+	   cvs commit -m "cvs commit 4"
+	)'
+
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C cvstracker -o cvshead src'
+
+test_expect_success \
+	'tracking cvs commits 4' \
+	'( cd gitwork && 
+       git-cvstrack-fetch cvshead
+     )'
+
+test_expect_success \
+	'merging' \
+	'( cd gitwork && 
+	   git-checkout master && 
+	   ! git-cvstrack-pull cvshead &&
+	   git-rm b.txt &&
+	   echo "a: line 1" >a.txt &&
+	   echo "a: line 2" >>a.txt &&
+	   echo "a: line 3" from git >>a.txt &&
+	   echo "a: line 4" >>a.txt &&
+	   git-add a.txt &&
+	   git-commit -m "Merge cvspending/cvshead into master (resolved conflicts)"
+     )'
+
+test_expect_success \
+	'cvs commit 5' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 5" >>a.txt &&
+	   echo "b: line 5" >>b.txt &&
+	   cvs commit -m "cvs commit 5"
+	)'
+
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C cvstracker -o cvshead src'
+
+test_expect_success \
+	'tracking cvs commits 5' \
+	'( cd gitwork && 
+       git-cvstrack-fetch cvshead
+     )'
+
+test_expect_success \
+	'merging' \
+	'( cd gitwork && 
+	   git-checkout master && 
+	   ! git-cvstrack-pull cvshead &&
+	   git-rm b.txt &&
+	   git-commit -m "Merge cvspending/cvshead into master (resolved conflicts)"
+     )'
+
+test_expect_success \
+	'cvs commit 6' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 6" >>a.txt &&
+	   cvs commit -m "cvs commit 6"
+	)'
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C cvstracker -o cvshead src'
+
+test_expect_success \
+	'tracking cvs commits 6' \
+	'( cd gitwork && 
+       git-cvstrack-fetch cvshead
+     )'
+
+test_expect_success \
+	'pushcvs' \
+	'( cd gitwork &&
+	   git-cvstrack-pushcvs cvshead "$CVSWORK"
+	 ) &&
+	 ( cd "$CVSWORK" &&
+	   cvs commit -F .msg &&
+	   rm .msg
+	 )'
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'cvs commit 7' \
+	'( cd "$CVSWORK" &&
+	   echo "a: line 7" >>a.txt &&
+	   cvs commit -m "cvs commit 7"
+	)'
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C cvstracker -o cvshead src'
+
+test_expect_success \
+	'tracking cvs commits 7' \
+	'( cd gitwork && 
+       git-cvstrack-fetch cvshead
+     )'
+
+test_expect_success \
+	'more work in git' \
+	'( cd gitwork && 
+       git-cvstrack-pull cvshead &&
+	   echo "c: line 2 from git" >>c.txt &&
+	   git-commit -a -m "another git commit" 
+     )'
+
+test_expect_success \
+	'if pushcvs fails git repository must be unchanged' \
+	'( rm "$CVSWORK/c.txt" &&
+       cd gitwork &&
+       before=$(find .git/refs -type f -print -exec cat \{\} \;) && 
+	   ! git-cvstrack-pushcvs cvshead "$CVSWORK" &&
+       after=$(find .git/refs -type f -print -exec cat \{\} \;) &&
+       test "$before" = "$after"
+	 )'
+
+test_expect_success \
+	'pushcvs' \
+	'( cd "$CVSWORK" &&	
+	   cvs up 
+	 ) &&
+	( cd gitwork &&
+	   git-cvstrack-pushcvs cvshead "$CVSWORK"
+	 ) &&
+	 ( cd "$CVSWORK" &&
+	   cvs commit -F .msg &&
+	   rm .msg
+	 )'
+# fighting cvsps' fuzz
+sleep 2
+
+test_expect_success \
+	'importing to git' \
+	'git-cvsimport -v -a -i -k -u -z 1 -a -C cvstracker -o cvshead src'
+
+test_expect_success \
+	'tracking cvs commits' \
+	'( cd gitwork && 
+       git-cvstrack-fetch cvshead
+     )'
+
+test_done
-- 
1.5.2.2.660.gc5eb3
