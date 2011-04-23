From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 23/23] Introduce support for the git-work command.
Date: Sat, 23 Apr 2011 17:22:52 +1000
Message-ID: <1303543372-77843-24-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:25:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXDE-0005Iv-93
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab1DWHY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:59 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab1DWHY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:57 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=XrBy9VXgW+5RBhAsp7lnYEV/wxNzcqKdlJxW8uTRmeM=;
        b=wGux37RDnyV+tExobLHdz7eO5ABuuUrf8OKyZb1G65F5MW/rRh2WypMobAQAVBrJ+V
         jZFxMFWi7PW+avvCYGF3x38BJ6iW+Dn1b9uYa1UsrCGosRM0GypViDsAbxoCa5evua+z
         CdXx6O3eOV+3QGLbTV+4Ty9WCG9gcaRGudixU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZH5bTEvppr8OhWDN9mkf0cdhOdu+fbqjMs0XEmiReP6x55sAxo+xCnLNjUjrtc1gmC
         sFgy8WLUpl34EcQKqwFUHVFsXY8eQ/WvVcKYLapb+j8JAfgHqRAStL/YD511ClGiM3Ny
         p0Rbz7+NFvJNDRG4j7qlNZKClilRA3q+VoapA=
Received: by 10.68.48.228 with SMTP id p4mr604987pbn.490.1303543496883;
        Sat, 23 Apr 2011 00:24:56 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171976>

The git work command uses the implicit base defined by git base
to help perform dependency management on a working branch.

See the Documentation for a description of the philosophy
underlying git-work.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 .gitignore                 |    1 +
 Documentation/git-work.txt |  163 ++++++++++++++++++++++
 Makefile                   |    1 +
 git-work.sh                |  323 ++++++++++++++++++++++++++++++++++++++++++++
 t/t3421-work.sh            |  174 ++++++++++++++++++++++++
 5 files changed, 662 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-work.txt
 create mode 100644 git-work.sh
 create mode 100755 t/t3421-work.sh

diff --git a/.gitignore b/.gitignore
index 54fa567..5fb3119 100644
--- a/.gitignore
+++ b/.gitignore
@@ -159,6 +159,7 @@
 /git-verify-tag
 /git-web--browse
 /git-whatchanged
+/git-work
 /git-write-tree
 /git-core-*/?*
 /gitk-git/gitk-wish
diff --git a/Documentation/git-work.txt b/Documentation/git-work.txt
new file mode 100644
index 0000000..1cae786
--- /dev/null
+++ b/Documentation/git-work.txt
@@ -0,0 +1,163 @@
+git-work(1)
+===========
+
+NAME
+----
+git-work - manage the current branch as a working branch
+
+SYNOPSIS
+--------
+[verse]
+'git work'
+'git work' 'list'   ['commit'|'dependency']
+'git work' 'merge'  [merge-options] [dependency ...]
+'git work' 'remerge' [--keep-tree]
+'git work' 'rebase' ['-i'|[dependency [rebase-options]]]
+'git work' 'pivot'  [pivot]
+'git work' 'create' ['--pivot-first'] topic [pivot [on-base]]
+'git work' 'update' ['--pivot-first'] topic [pivot]
+
+DESCRIPTION
+-----------
+In the discussion that follows, the current branch is referred to by the symbol \{branch\} and the commit at the base of \{branch\} is referred to by the symbol \{base\}. The symbol \{head\} is used to refer to the commit at the tip of \{branch\}.
+
+COMMANDS
+--------
+Without arguments, reports the base and head of the current branch as a range suitable for use with git rev-list. Use --as-refs to print the range with symbolic references.
+
+'list'::
+	Lists the commits in the working branch or the dependencies of the working branch.
+
+'merge'::
+	Merge the specified dependencies with \{base\}, then rebase \{base\}..\{head\} onto that merge. The head reference is updated with the result of the merge. The base reference is updated with dependency. If not specified, dependency defaults to the tracked branch, if any.
+
+'remerge'::
+	Rebuild the base of the branch using the current dependencies. Unless --keep-tree is specified, perform a piece-wise merge of each dependency. If --keep-tree is specified, then perform an information only merge of the current dependencies and preserve the tree of existing base.
+
+'rebase'::
+	Rebase \{base\}..\{head\} onto dependency and the base reference is updated to refer to dependency. If the -i option is specified, invokes git rebase -i \{base\}..\{branch\}. If not specified, dependency defaults to the tracked branch, if any.
+
+'pivot'::
+	Rebase pivot..\{head\} onto \{base\} and then rebase \{base\}..pivot onto the result of the first rebase. The head reference of the branch is updated to refer to the result of the final rebase. The pivot argument must satisfy the base invariant of \{branch\}.
+
+'create'::
+
+	Rebase pivot..\{branch\} onto on-base and initialize the topic head reference to the resulting commit; the topic base reference to on-base and the head reference of \{branch\} to pivot. Then merge the topic head into the base of \{branch\} using git work merge. If specified, pivot must satisfy the base invariant. If not specified, on-base and pivot default to \{base\}.
+
+'update'::
+	Performs the same operation as create but uses the head of an existing topic as on-base.
+
+Unless otherwise specified, if this command completes successfully the base reference will be updated to reflect the current calculated base for \{branch\}.
+
+OPTIONS
+-------
+--as-refs::
+	For the default subcommand, report the SHA1 hashes as symbolic reference names, not as SHA1 hashes.
+--pivot-first::
+	If this option is specified on a create or update subcommand, a pivot operation is logically performed first, in effect allowing
+        the commits below, rather than above, the pivot point to be moved from the current topic to the specified topic.
+
+ERROR HANDLING
+--------------
+Any rebases and merges performed by git work must succeed otherwise the working tree, index and references touched by git base are rolled back to their initial state, which must be clean to begin with.
+
+DISCUSSION
+----------
+git work is designed to support workflows where a developer's workspace perpetually contains a mixture of work items at different levels of maturity. Examples of such work items might be:
+
+* the upstream integration branch
+* published topics that are yet to be integrated into the integraton branch
+* completed, but unpublished topics
+* published topics received from other developers that have not yet been integrated in the integration branch
+* adhoc patches
+
+One way to manage such complexity is to maintain separate topic branches for each work item and then create temporary or throw-away branches to test the combined work. Such a practice has the advantage of keeping the artifacts of each work stream separate but can potentially incur significant process overheads and can be confusing for a developer to manage since at any given point in time a given work item that was recently worked on may, or may not be, integrated into the current work tree.
+
+From an individual developer's point of view, it can be more productive to work on a single working branch which accretes recent work and dependencies over time and only use isolated topic branches for the purposes of sharing stabilised work with others.
+
+The key to making this work is to ensure that dependencies are always merged into the base of the working branch, new work is done on the head of the branch, and mature work is rebased from the head of the working branch to heads of stable topic branches and then reintegrated back into the base of the working branch.
+
+With such a practice, the developer gains the convenience of a single working branch without sacrificing the cleanliness of topic-based development.
+
+git work is a porcelain that enables such work practices by providing commands that understand the concept of a branch base, how it relates to the branch head and the importance of merging dependencies into the branch base, rather than into the branch head. In particular, git work knows how to discover, establish and maintain the base of a branch as the maturity of work items merged into the branch evolves over time.
+
+In summary, git work allows a developer to keep his working tree stable while keeping his commit history sane.
+
+EXAMPLES
+--------
+* print the range of commits in the current working branch
++
+---------
+$ git work
+---------
+* lists the commits in the current working branch
++
+---------
+$ git work list
+---------
+* list the dependencies of the current working branch
++
+---------
+$ git work list dependency
+---------
+* start gitk, showing only the current work
++
+---------
+$ git work $(git work)
+---------
+* list the commits in the current working branch with a one line description
++
+---------
+$ git rev-list --oneline $(git work)
+---------
+* merge the upstream/master into the base of the current branch
++
+---------
+$ git work merge upstream/master
+---------
+* rebase the working branch onto the upstream/master
++
+---------
+$ git work rebase upstream/master
+---------
+* create a topic branch based on upstream/master from the top 2 commits of the current branch
++
+---------
+$ git work create mytopic HEAD~2 upstream/master
+---------
+* create a topic branch using the commits under the top 2 commits of the current branch
++
+---------
+$ git work --pivot-first create mytopic HEAD~2 upstream/master
+---------
+* update an existing topic branch with the top commit of the current branch
++
+---------
+$ git work update mytopic HEAD~1
+---------
+* clean up the base history by rewriting the base as an octopus merge with the same tree as the current base
++
+---------
+$ git work remerge --keep-tree
+---------
+* visualize the merge structure of the dependencies of the current work
++
+---------
+gitk $(git base) --not $(git work list dependency)
+---------
+
+SEE ALSO
+--------
+linkgit:git-base[1]
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
index 6aee4a8..42854cb 100644
--- a/Makefile
+++ b/Makefile
@@ -380,6 +380,7 @@ SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-test.sh
 SCRIPT_SH += git-web--browse.sh
+SCRIPT_SH += git-work.sh
 
 SCRIPT_LIB += git-atomic-lib
 SCRIPT_LIB += git-conditions-lib
diff --git a/git-work.sh b/git-work.sh
new file mode 100644
index 0000000..f6b378d
--- /dev/null
+++ b/git-work.sh
@@ -0,0 +1,323 @@
+#!/bin/sh
+USAGE='[help|list|merge|remerge|rebase|pivot|create|update]'
+LONG_USAGE='
+git work
+    Print the range that defines the boundaries of the branch
+git work list [commit|dependency]
+    List the commits or dependencies of the current working branch.
+git work merge [dependency ...]
+    Merge the specified dependencies into the base of the branch
+git work remerge [--keep-tree]
+    Rebuild the base of the current working branch from the dependencies
+git work pivot [pivot]
+    Swap two segments of the working branch at the commit specified by the pivot
+git work rebase [-i]
+    Invoke an interactive rebase on the branch
+git work rebase [dependency]
+    Rebase the current working branch onto the specified dependency.
+git work create [--pivot-first] topic [pivot] [on-base]
+    Rebase the top N commits onto new topic based on a specified commit, then merge the result into the base of the current branch
+git work update [--pivot-first] topic [pivot]
+    Rebase the top N commits onto an existing topic, then merge the updated topic into the base of the current branch
+git work help
+    Print this help
+
+Please use "git help work" to get the full man page.'
+
+SUBDIRECTORY_OK=true
+OPTIONS_SPEC="
+$LONG_USAGE
+--
+pivot-first perform a pivot first, then do..
+as-refs print the range as references
+X pass-thru options to merge or rebase
+i,interactive perform an interactive rebase
+"
+. git-sh-setup
+. git-atomic-lib
+
+warn()
+{
+    echo "warn: $*" 1>&2
+}
+
+not_implemented()
+{
+    die "not yet implemented"
+}
+
+work_default()
+{
+   if $AS_REFS
+   then
+       echo $BASEREF..$BRANCH
+   else
+       echo $(git base)..$(git rev-parse HEAD)
+   fi
+}
+
+work_list_dependency()
+{
+    limits=''
+    while true
+    do
+         top=$(git rev-list $BASE $limits --no-merges --max-count=1)
+	 if test -z "$top"
+         then
+             break;
+         else
+	     echo $top
+             limits="$limits ^$top"
+         fi
+    done
+}
+
+work_list()
+{
+    type=$1
+    case "$type" in
+       ""|commit)
+	    git rev-list $(work_default)
+       ;;
+       dependency)
+            work_list_dependency "$@"
+       ;;
+       *)
+	    die "$type is not a supported type for this command"
+       ;;
+    esac
+}
+
+work_merge()
+{
+   DEPENDENCY=$1
+   shift
+
+   test -n "${DEPENDENCY}" || die "usage: git work merge [dependency [merge-options]]"
+
+   assert --not-staged --not-unstaged --commit-exists "${DEPENDENCY}"
+
+   atomic eval \
+"
+	DEPENDENCY=${DEPENDENCY} &&
+	BASE=${BASE} &&
+	BASEREF=${BASEREF} &&
+	BRANCH=${BRANCH} &&
+	MERGE_OPTIONS='${MERGE_OPTIONS}'
+	git checkout -q \${BASE} &&
+	git merge -q \${DEPENDENCY} \${MERGE_OPTIONS} &&
+	MERGE=\$(git rev-parse HEAD) &&
+	git rebase --onto HEAD \${BASE} \${BRANCH} &&
+	git update-ref \${BASEREF} \${MERGE}
+"
+}
+
+work_remerge()
+{
+   assert --not-staged --not-unstaged
+   not_yet_implemented
+}
+
+work_rebase()
+{
+   git base -q check || die "use 'git base' to establish a base for this branch"
+   if test -n "${INTERACTIVE}"
+   then
+        PIVOT=${1:-$(git base)}
+	git base -q check ${PIVOT} || die "${PIVOT} is not a valid pivot commit"
+	git rebase -i ${PIVOT} HEAD "$@"
+   else
+
+      DEPENDENCY=$1
+
+      assert --not-staged --not-unstaged --commit-exists "${DEPENDENCY}"
+      atomic eval "
+      git rebase --onto \${DEPENDENCY} \${BASE} \${BRANCH} &&
+      git update-ref \${BASEREF} \${DEPENDENCY}
+"
+   fi
+}
+
+work_create()
+{
+   TOPIC=$1
+   PIVOT=$2
+   DEPENDENCY=$3
+
+   test -n "${DEPENDENCY}" || die "usage: git work create topic [pivot [dependency]]"
+
+   PIVOT=$(git rev-parse --verify "$PIVOT" 2>/dev/null) || die "$2 is not a commit"
+
+   git base check "${PIVOT}" > /dev/null || die "$PIVOT does not lie between $BASE and $HEAD"
+
+   assert --commit-exists "${DEPENDENCY}" --not-branch-exists "${TOPIC}" --not-staged --not-unstaged
+
+   if $PIVOT_FIRST
+   then
+   atomic eval "
+	BASE=${BASE} &&
+	TOPIC=${TOPIC} &&
+	PIVOT=${PIVOT} &&
+	HEAD=${HEAD} &&
+	BRANCHREF=${BRANCHREF} &&
+	DEPENDENCY=${DEPENDENCY} &&
+	git rebase -q --onto \${DEPENDENCY} \${BASE} \${PIVOT} &&
+	git branch \${TOPIC} &&
+	git base -q -b \${TOPIC} set \${DEPENDENCY} &&
+	git rebase -q --onto \${BASE} \${PIVOT} \${BRANCH} &&
+	git work merge \${TOPIC}
+"
+   else
+   atomic eval "
+	TOPIC=${TOPIC} &&
+	PIVOT=${PIVOT} &&
+	HEAD=${HEAD} &&
+	BRANCHREF=${BRANCHREF} &&
+	DEPENDENCY=${DEPENDENCY} &&
+	git rebase -q --onto \${DEPENDENCY} \${PIVOT} \${HEAD} &&
+	git branch \${TOPIC} &&
+	git base -b \${TOPIC} set \${DEPENDENCY} &&
+	git update-ref \${BRANCHREF} \${PIVOT} &&
+	git checkout \${BRANCH} &&
+	git work merge \${TOPIC}
+"
+   fi
+
+}
+
+work_update()
+{
+   TOPIC=$1
+   PIVOT=$2
+
+   test -n "${PIVOT}" || die "usage: git work update topic [pivot [dependency]]"
+
+   PIVOT=$(git rev-parse --verify "$PIVOT" 2>/dev/null) || die "$2 is not a commit"
+
+   git base check "${PIVOT}" > /dev/null || die "$PIVOT does not lie between $BASE and $HEAD"
+
+   assert --branch-exists "${TOPIC}" --not-staged --not-unstaged
+
+   if $PIVOT_FIRST
+   then
+   atomic eval "
+	TOPIC=${TOPIC} &&
+	PIVOT=${PIVOT} &&
+	BASE=${BASE} &&
+	HEAD=${HEAD} &&
+	BRANCHREF=${BRANCHREF} &&
+	git base -q -b \${TOPIC} \${TOPIC} &&
+	git rebase -q --onto \${TOPIC} \${BASE} \${PIVOT} &&
+	git branch -f \${TOPIC} &&
+	git rebase -q --onto \${BASE} \${PIVOT} \${BRANCH} &&
+	git work merge \${TOPIC}
+"
+   else
+   atomic eval "
+	TOPIC=${TOPIC} &&
+	PIVOT=${PIVOT} &&
+	HEAD=${HEAD} &&
+	BRANCHREF=${BRANCHREF} &&
+	git base -q -b \${TOPIC} \${TOPIC} &&
+	git rebase -q --onto \${TOPIC} \${PIVOT} \${HEAD} &&
+	git branch -f \${TOPIC} &&
+	git update-ref \${BRANCHREF} \${PIVOT} &&
+	git checkout \${BRANCH} &&
+	git work merge \${TOPIC}
+"
+   fi
+
+}
+
+work_pivot()
+{
+   PIVOT=$1
+
+   test -n "${PIVOT}" || die "usage: git work update topic [pivot [dependency]]"
+
+   PIVOT=$(git rev-parse --verify "$PIVOT" 2>/dev/null) || die "$1 is not a commit"
+
+   git base check "${PIVOT}" > /dev/null || die "$PIVOT does not lie between $BASE and $HEAD"
+
+   assert --not-staged --not-unstaged
+
+   atomic eval "
+      git rebase -q --onto \${BASE} \${PIVOT} \${HEAD} &&
+      git rebase -q --onto HEAD \${BASE} \${PIVOT} &&
+      git update-ref \${BRANCHREF} HEAD &&
+      git checkout -q \${BRANCH}
+"
+}
+
+INTERACTIVE=
+CURRENT_BRANCH=$(git branch | grep "^\* [^(]" | cut -c3-)
+AS_REFS=false
+PIVOT_FIRST=false
+if test -n "$CURRENT_BRANCH"
+then
+   BRANCHREF=refs/heads/${CURRENT_BRANCH}
+   BASEREF=refs/bases/${CURRENT_BRANCH}
+   BRANCH=${CURRENT_BRANCH}
+else
+   BRANCHREF=HEAD
+   BASEREF=BASE
+   BRANCH=HEAD
+fi
+
+while test $# != 0
+do
+	case $1 in
+		-b)
+		shift
+		BRANCHREF=refs/heads/$1
+		BASEREF=refs/bases/$1
+		shift
+		(git rev-parse --verify $BRANCHREF 1>/dev/null) || die "$1 is not a valid local branch"
+		;;
+		-i)
+			INTERACTIVE=-i
+			shift
+		;;
+		--as-refs)
+		shift
+		AS_REFS=true
+		;;
+		--pivot-first)
+		shift
+		PIVOT_FIRST=true
+		;;
+		--)
+		shift
+		break;
+		;;
+		*)
+		break;
+		;;
+	esac
+done
+
+
+# ensure that a base is established.
+git base -q || die "Please use 'git base init' to initialise the reset command for this branch."
+
+HEAD=$(git rev-parse --verify ${BRANCHREF} 2>/dev/null)
+BASE=$(git rev-parse --verify ${BASEREF} 2>/dev/null)
+
+test -n "$BASE" || die "can't derive BASE from BASEREF=${BASEREF}"
+
+case "$#" in
+0)
+    work_default "$@" ;;
+*)
+    cmd="$1"
+    shift
+    if test $cmd = 'trace'; then set -x; cmd=$1; shift; fi
+    case "$cmd" in
+    help)
+	    git work -h "$@" ;;
+    list|merge|remerge|rebase|pivot|create|update)
+	    work_$cmd "$@" ;;
+    *)
+	    usage "$@" ;;
+    esac
+esac
diff --git a/t/t3421-work.sh b/t/t3421-work.sh
new file mode 100755
index 0000000..9c6ed35
--- /dev/null
+++ b/t/t3421-work.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jon Seymour
+#
+
+test_description='git work tests
+
+Performs tests on the functions of git work
+'
+#
+#       H-I
+#      /
+# A-B-C---M-P-Q
+#  \     /
+#   X-Y-Z
+#
+
+. ./test-lib.sh
+. $(git --exec-path)/git-test-lib
+
+GIT_AUTHOR_NAME=author@name
+GIT_AUTHOR_EMAIL=bogus@email@address
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+
+reset_test()
+{
+    git reset --hard HEAD &&
+    git checkout master &&
+    git base set M && {
+       test_condition -q --not-branch-exists test ||
+       git branch -D test
+    } &&
+    test_condition -q --not-branch-exists topic || {
+        git base init -d -b topic &&
+	git branch -D topic
+    }
+}
+
+test_expect_success 'setup' \
+    '
+    test_commit A &&
+    test_commit B &&
+    test_commit C &&
+    git checkout -b fork-X A &&
+    test_commit X &&
+    test_commit Y &&
+    test_commit Z &&
+    git checkout master &&
+    test_merge M Z &&
+    git base -q set HEAD &&
+    test_commit P &&
+    test_commit Q &&
+    git checkout -b fork-H C &&
+    test_commit H &&
+    test_commit I &&
+    git checkout master &&
+    true
+'
+
+test_expect_success 'work --as-refs' \
+'
+   test "$(git work --as-refs)" = "refs/bases/master..master"
+'
+
+test_expect_success 'work' \
+'
+   test "$(git work)" = "$(git rev-parse M)..$(git rev-parse Q)"
+'
+
+test_expect_success 'work list' \
+'
+   test "$(git rev-parse Q; git rev-parse P)" = "$(git work list)"
+'
+
+test_expect_success 'git work rebase Z <=> rebase --onto Z M..Q' \
+'
+    reset_test &&
+    git checkout -b test Q &&
+    git base -q set M &&
+    git work rebase Z &&
+    test_condition --same $(git base) Z &&
+    test_condition --checked-out test &&
+    test "$(git diff M Q | git patch-id)" = "$(git diff $(git work) | git patch-id)"
+'
+
+test_expect_success 'git work merge I <=> rebase --onto I M..Q' \
+'
+    reset_test &&
+    git checkout -b test Q &&
+    git base -q set M &&
+    git work merge I &&
+    test_condition --not-same I $(git base) &&
+    test_condition --checked-out test &&
+    test "$(git diff M Q | git patch-id)" = "$(git diff $(git work) | git patch-id)"
+'
+
+test_expect_success 'git work create topic I from P..Q' \
+'
+    reset_test &&
+    git checkout -b test Q &&
+    git base -q set M &&
+    git work create topic P I &&
+    test_condition --same $(git base -b topic) I &&
+    test_condition --checked-out test &&
+    test "$(git diff I topic | git patch-id)" = "$(git diff P Q | git patch-id)" &&
+    test "$(git diff $(git base) test | git patch-id)" = "$(git diff M P | git patch-id)"
+'
+
+test_expect_success 'git work create topic --pivot-first I from P..Q' \
+'
+    reset_test &&
+    git checkout -b test Q &&
+    git base -q set M &&
+    git work create --pivot-first topic P I &&
+    test_condition  --same $(git base -b topic) I &&
+    test_condition  --checked-out test &&
+    test "$(git diff I topic | git patch-id)" = "$(git diff M P | git patch-id)" &&
+    test "$(git diff $(git base)  test | git patch-id)" = "$(git diff P Q | git patch-id)"
+'
+
+test_expect_success 'git work update topic I from P..Q' \
+'
+    reset_test &&
+    git checkout -b test Q &&
+    git base -q set M &&
+    git branch topic I &&
+    git work update topic P &&
+    test_condition  --same "$(git base -b topic)" I &&
+    test_condition  --checked-out test &&
+    test "$(git diff I topic | git patch-id)" = "$(git diff P Q | git patch-id)" &&
+    test "$(git diff $(git base)  test | git patch-id)" = "$(git diff M P | git patch-id)"
+'
+
+test_expect_success 'git work update --pivot-first topic I from P..Q' \
+'
+    reset_test &&
+    git checkout -b test Q &&
+    git base -q set M &&
+    git branch topic I &&
+    git work update --pivot-first topic P &&
+    test_condition  --same "$(git base -b topic)" I &&
+    test_condition  --checked-out test &&
+    test "$(git diff I topic | git patch-id)" = "$(git diff M P | git patch-id)" &&
+    test "$(git diff $(git base)  test | git patch-id)" = "$(git diff P Q | git patch-id)"
+'
+
+test_expect_success 'git work update topic I from P..Q - unitialized topic' \
+'
+    git base init -d topic &&
+    reset_test &&
+    git checkout -b test Q &&
+    git base -q set M &&
+    git branch topic I &&
+    git work update topic P &&
+    test_condition  --same "$(git base -b topic)" I &&
+    test_condition  --checked-out test &&
+    test "$(git diff I topic | git patch-id)" = "$(git diff P Q | git patch-id)" &&
+    test "$(git diff $(git base)  test | git patch-id)" = "$(git diff M P | git patch-id)"
+'
+
+test_expect_success 'git work pivot P' \
+'
+    reset_test &&
+    git checkout -b test Q &&
+    git base -q set M &&
+    git work pivot P &&
+    test_condition  --same "$(git base -b test)" M &&
+    test_condition  --checked-out test &&
+    test "$(git diff M test | git patch-id)" = "$(git diff M Q | git patch-id)" &&
+    test "$(git diff M test~1 | git patch-id)" = "$(git diff P Q | git patch-id)" &&
+    test "$(git diff test~1 test | git patch-id)" = "$(git diff M P | git patch-id)"
+'
+
+test_done
-- 
1.7.5.rc1.23.g7f622
