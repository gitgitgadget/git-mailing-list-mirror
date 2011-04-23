From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 21/23] Introduce git-atomic.
Date: Sat, 23 Apr 2011 17:22:50 +1000
Message-ID: <1303543372-77843-22-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXDD-0005Iv-2V
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab1DWHYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:52 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39715 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1DWHYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:50 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so584380pzk.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=2L/Zw0d5C12qFvb7l6gaVHod5SA9bB+hOKVA00peLF8=;
        b=qyP2pP/NMLBazFUpW0V7lavNEJM08g87SUKcGZj/0Mrc78eggC1/vLGmWkybyuTuA1
         QG3CvCpObldrVjBsTruI4PrJf3m3Wsk+beMg17ef8oYcKtnEq3eFcYS7wdz6BrStXhZN
         m3wAdrGjRIx4jM4usn96qUkpY40BK6WyCwTB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MwIv5Y8eUKMNu4U4Agiu5k8OafIj02HAyQEhgdg9L6d/zDpEXD1Y7QclfwdUloBeil
         YTUuh0uxzhqP3DtIeK0RVYF1oJddE3kQaG9Qfh1SarJBKuf9myTakUiwP1fuxltPNAX/
         elNt336MCObmy0dDVxsT5vHLP1cOHlEX5ZNkA=
Received: by 10.68.41.41 with SMTP id c9mr2023823pbl.32.1303543490018;
        Sat, 23 Apr 2011 00:24:50 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171974>

git atomic is intended to provide a simple way to for porcelains to
execute atomic operations on the git repository.

An atomic operation either completes successfully or the
working tree, index and selected references are returned to their
original state.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 .gitignore                   |    2 +
 Documentation/git-atomic.txt |   92 ++++++++++++++++++++++++++++++++++++++++++
 Makefile                     |    2 +
 git-atomic-lib.sh            |   58 ++++++++++++++++++++++++++
 git-atomic.sh                |    5 ++
 t/t3419-atomic.sh            |   59 +++++++++++++++++++++++++++
 6 files changed, 218 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-atomic.txt
 create mode 100644 git-atomic-lib.sh
 create mode 100755 git-atomic.sh
 create mode 100755 t/t3419-atomic.sh

diff --git a/.gitignore b/.gitignore
index aa0eb8fb..5efc43c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,8 @@
 /git-apply
 /git-archimport
 /git-archive
+/git-atomic
+/git-atomic-lib
 /git-bisect
 /git-bisect--helper
 /git-blame
diff --git a/Documentation/git-atomic.txt b/Documentation/git-atomic.txt
new file mode 100644
index 0000000..02bbee6
--- /dev/null
+++ b/Documentation/git-atomic.txt
@@ -0,0 +1,92 @@
+git-atomic(1)
+===========
+
+NAME
+----
+git-atomic - conditionally execute a command and, if it fails, restore the working tree, index and HEAD to their original state.
+
+SYNOPSIS
+--------
+[verse]
+'git atomic' [options] [--] [cmd args...]
+. $(git --exec-path)/git-atomic-lib.sh
+
+DESCRIPTION
+-----------
+The first form conditionally executes a command depending on whether the pre-conditions are satisified. If the command exits with a non-zero exit code, restores the
+working tree, index and HEAD to their orignal state. If no command is specified, sets the exit code according to the pre-conditions.
+
+'git atomic' exits with:
+
+0::
+	if the pre-conditions are satisified and the command executes successfully
+128::
+	if the command exited with an exit code of 128, 129, 130 or 131.
+129::
+	if git atomic failed during setup or argument parsing
+130::
+	if the pre-conditions were not satisified.
+131::
+	if the command failed and the original state could not be restored.
+
+Otherwise, exits with the actual exit code of the command.
+
+The second form is used to import the definition of a shell function called atomic that can be called by shell scripts that perform git operations. This is useful when the operations to be given atomic behaviour are themselves shell functions rather than external commands.
+
+OPTIONS
+-------
+The following options specify pre-condition tests on various lists which are assumed to be empty in the clean state and non-empty in the dirty state.
+
+The default required state for each specified pre-condition option is clean. The default required state for each unspecified pre-condition option is any, which
+means no tests are applied.
+
+--unstaged [any|clean|dirty]::
+	Fail unless the list of unstaged changes is empty (clean) or non-empty (dirty).	
+--staged   [any|clean|dirty]::
+	Fail unless the list of staged changes is empty (clean) or non-empty (dirty).
+--untracked [any|clean|dirty]::
+	Fail unless the list of untracked files is empty (clean) or non-empty (dirty).
+--tracked [any|clean|dirty]::
+	Fail unless the list of staged and unstaged changes is empty (clean) or non-empty (dirty).
+--unmerged [any|clean|dirty]::
+	Fail unless the list of unmerged files is empty (clean) or non-empty (dirty).
+--rebase [any|clean|dirty]::
+	Fail unless a rebase is not (clean) or is (dirty) in progress.
+--all::
+	Fail unless the list of staged, unstaged changes and untracked files is empty (clean) or non-empty (dirty)
+
+EXAMPLES
+--------
+* Reset the tree only if there are no staged or unstaged changes and no untracked files.
++
+-----------
+git atomic --all clean git reset --hard upstream/master
+-----------
+* Conditionally perform a merge, but rollback and die if it fails.
++
+-----------
+git atomic --all clean git merge topic || die "unable to merge"
+-----------
+* Import git-atomic-lib.sh into a script and make the execution of the function foo atomic with respect to the state of the git workspace
++
+-----------
+. $(git --exec-path)/git-atomic-lib.sh
+foo()
+{
+    git merge $1
+}
+
+atomic foo $1
+-----------
+
+Author
+------
+Written by Jon Seymour <jon.seymour@gmail.com>
+
+Documentation
+-------------
+Documentation by Jon Seymour
+
+GIT
+---
+Part of the linkgit:git[7] suite
diff --git a/Makefile b/Makefile
index 93ff6c6..9ed877a 100644
--- a/Makefile
+++ b/Makefile
@@ -360,6 +360,7 @@ TEST_PROGRAMS_NEED_X =
 unexport CDPATH
 
 SCRIPT_SH += git-am.sh
+SCRIPT_SH += git-atomic.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
@@ -379,6 +380,7 @@ SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-test.sh
 SCRIPT_SH += git-web--browse.sh
 
+SCRIPT_LIB += git-atomic-lib
 SCRIPT_LIB += git-conditions-lib
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
diff --git a/git-atomic-lib.sh b/git-atomic-lib.sh
new file mode 100644
index 0000000..db48300
--- /dev/null
+++ b/git-atomic-lib.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# Provides a function that provides for robust recovery from
+#
+. git-test-lib
+atomic()
+{
+    assert --not-conflicted --message "cannot perform an atomic operation while there are merge conflicts"
+    HEAD=$(git rev-parse --verify HEAD) || setup_failed "failed to resolve HEAD"
+    if REF=$(git symbolic-ref -q HEAD)
+    then
+          BRANCH=${REF#refs/heads/}
+    else
+        BRANCH=${HEAD}
+    fi
+
+    STASH=$(git stash create) || setup_failed "failed to stash"
+    REF=$(git rev-parse --symbolic-full-name HEAD) || setup_failed "failed to acquire REF"
+    REBASE_COUNT=1
+    test_condition -q --rebasing || REBASE_COUNT=0
+
+    (
+      "$@"
+    ) || (
+       RC=$?
+
+       command_failed()
+       {
+           rc=$1
+	   shift
+           echo "command failed: $* rc=$rc" 1>&2
+           exit 1
+       }
+
+       restore_failed()
+       {
+           echo "restore failed: $*" 1>&2
+           exit 2
+       }
+
+       if test $REBASE_COUNT -eq 0 && test -d "$REBASE_DIR"
+       then
+            git rebase --abort || restore_failed "failed to abort rebase"
+       fi
+
+	{
+		git reset --hard HEAD &&
+		git checkout -q ${BRANCH}
+	} || restore_failed "failed to checkout ${BRANCH}"
+
+	if test -n "$STASH"
+	then
+		git stash apply --index "$STASH" || restore_failed "failed to reapply stash $STASH to $HEAD"
+		echo "restored $REF to $(git describe --always --abbrev=6 $HEAD), reapplied stash $(git describe --always --abbrev=6 $STASH)" 1>&2
+	fi
+	command_failed $RC "$*"
+    )
+}
diff --git a/git-atomic.sh b/git-atomic.sh
new file mode 100755
index 0000000..aa14e68
--- /dev/null
+++ b/git-atomic.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+SUBDIRECTORY_OK=true
+. git-sh-setup
+. git-atomic-lib
+atomic "$@"
diff --git a/t/t3419-atomic.sh b/t/t3419-atomic.sh
new file mode 100755
index 0000000..2b651d2
--- /dev/null
+++ b/t/t3419-atomic.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jon Seymour
+#
+
+test_description='git atomic tests
+
+Performs tests on the functions of git atomic
+'
+. ./test-lib.sh
+
+GIT_AUTHOR_NAME=author@name
+GIT_AUTHOR_EMAIL=bogus@email@address
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+
+test_expect_success \
+    'setup' \
+    '
+    test_commit A &&
+    test_commit B &&
+    test_commit C &&
+    test_commit D &&
+    git checkout -b branch A &&
+    test_commit X &&
+    echo >> B.t &&
+    git add B.t &&
+    test_commit Y
+    true
+'
+
+test_expect_success 'no arguments' '
+    git atomic
+'
+
+test_expect_success 'successful command' \
+'
+    git atomic true
+'
+
+test_expect_success 'unsuccessful command' \
+'
+    ! git atomic false
+'
+
+test_expect_success 'rebase' \
+'
+     git reset --hard HEAD &&
+     git checkout master &&
+     MASTER=$(git rev-parse HEAD) &&
+     ! git rebase --onto D A Y &&
+     git test --conflicted &&
+     git rebase --abort &&
+     git checkout master &&
+     ! git atomic git rebase --onto D A Y &&
+     git test --same HEAD refs/heads/master &&
+     git test --same HEAD $MASTER
+'
+
+test_done
-- 
1.7.5.rc1.23.g7f622
