Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3899920281
	for <e@80x24.org>; Thu,  5 Oct 2017 19:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdJETNe (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 15:13:34 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:3665 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbdJETNd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 15:13:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3y7Mqt650Xz5tlJ
        for <git@vger.kernel.org>; Thu,  5 Oct 2017 21:13:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 226E0137
        for <git@vger.kernel.org>; Thu,  5 Oct 2017 21:13:30 +0200 (CEST)
To:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH/RFC] git-post: the opposite of git-cherry-pick
Message-ID: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org>
Date:   Thu, 5 Oct 2017 21:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new command that can be used to copy an arbitrary commit
to a branch that is not checked out.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I have been using this command since years, but got around to
 write a man page and tests only now. I hope the man page makes
 sense. I don't have the tool chain to build it, though, so
 any hints for improvement are welcome.

 .gitignore                        |  1 +
 Documentation/git-cherry-pick.txt |  3 +-
 Documentation/git-post.txt        | 57 +++++++++++++++++++++++++++++
 Makefile                          |  1 +
 command-list.txt                  |  1 +
 git-post.sh                       | 60 ++++++++++++++++++++++++++++++
 t/t3514-post.sh                   | 77 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-post.txt
 create mode 100755 git-post.sh
 create mode 100755 t/t3514-post.sh

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..a16263249a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -106,6 +106,7 @@
 /git-pack-refs
 /git-parse-remote
 /git-patch-id
+/git-post
 /git-prune
 /git-prune-packed
 /git-pull
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc8..6b34f4d994 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -226,7 +226,8 @@ context lines.
 
 SEE ALSO
 --------
-linkgit:git-revert[1]
+linkgit:git-revert[1],
+linkgit:git-post[1]
 
 GIT
 ---
diff --git a/Documentation/git-post.txt b/Documentation/git-post.txt
new file mode 100644
index 0000000000..e835e62be3
--- /dev/null
+++ b/Documentation/git-post.txt
@@ -0,0 +1,57 @@
+git-post(1)
+===========
+
+NAME
+----
+git-post - Apply a commit on top of a branch that is not checked out
+
+SYNOPSIS
+--------
+[verse]
+'git post' dest-branch [source-rev]
+
+DESCRIPTION
+-----------
+
+Applies the changes made by 'source-rev' (or, if not given, `HEAD`)
+on top of the branch 'dest-branch' and records a new commit.
+'dest-branch' is advanced to point to the new commit.
+The operation that this command performs can be regarded as
+the opposite of cherry-picking.
+
+EXAMPLES
+--------
+
+Assume, while working on a topic, you find and fix an unrelated bug.
+Now:
+
+------------
+$ git commit                                   <1>
+$ git post master                              <2>
+$ git show | git apply -R && git reset HEAD^   <3>
+------------
+
+<1> create a commit with the fix on the current branch
+<2> copy the fix onto the branch where it ought to be
+<3> revert current topic branch to the unfixed state;
+can also be done with `git reset --keep HEAD^` if there are no
+unstaged changes in files that are modified by the fix
+
+Oftentimes, switching branches triggers a rebuild of a code base.
+With the sequence above the branch switch can be avoided.
+That said, it is good practice to test the bug fix on the
+destination branch eventually.
+
+BUGS
+----
+
+The change can be applied on `dest-branch` only if there is
+no textual conflict.
+
+SEE ALSO
+--------
+linkgit:git-cherry-pick[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index b143e4eea3..1753bf176f 100644
--- a/Makefile
+++ b/Makefile
@@ -551,6 +551,7 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
+SCRIPT_SH += git-post.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
diff --git a/command-list.txt b/command-list.txt
index a1fad28fd8..bc95b424d0 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -98,6 +98,7 @@ git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
 git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
+git-post                                mainporcelain
 git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
 git-pull                                mainporcelain           remote
diff --git a/git-post.sh b/git-post.sh
new file mode 100755
index 0000000000..6627d69f73
--- /dev/null
+++ b/git-post.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+# Copyright (c) 2017 Johannes Sixt
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC="\
+git post dest-branch [source-rev]
+--
+"
+. git-sh-setup
+
+while test $# != 0
+do
+	case "$1" in
+	--)	shift; break;;
+	-*)	usage;;
+	*)	break;;
+	esac
+	shift
+done
+
+dest=$(git rev-parse --verify --symbolic-full-name "$1") || exit
+if test -z "$dest"
+then
+	die "$(gettext "Destination must be a branch tip")"
+fi
+
+shift
+case $# in
+0)	set -- HEAD;;
+1)	: good;;
+*)	usage;;
+esac
+
+# apply change to a temporary index
+tmpidx=$GIT_DIR/index-post-$$
+git read-tree --index-output="$tmpidx" "$dest" || exit
+GIT_INDEX_FILE=$tmpidx
+export GIT_INDEX_FILE
+trap 'rm -f "$tmpidx"' 0 1 2 15
+
+git diff-tree -p --binary -M -C "$1" | git apply --cached || exit
+
+newtree=$(git write-tree) &&
+newrev=$(
+	eval "$(get_author_ident_from_commit "$1")" &&
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+	git-cat-file commit "$1" | sed -e '1,/^$/d' |
+	git commit-tree $newtree -p "$dest"
+) || exit
+
+if git check-ref-format "$dest"
+then
+	set_reflog_action post
+	subject=$(git log --no-walk --pretty=%s "$newrev") &&
+	git update-ref -m "$GIT_REFLOG_ACTION: $subject" "$dest" "$newrev" || exit
+fi
+if test -z "$GIT_QUIET"
+then
+	git rev-list -1 --oneline "$newrev"
+fi
diff --git a/t/t3514-post.sh b/t/t3514-post.sh
new file mode 100755
index 0000000000..4d31515c52
--- /dev/null
+++ b/t/t3514-post.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+test_description='test git post
+
+We build this history:
+
+   A--B--C  <-- master, HEAD
+  /
+ O          <-- side-base, side
+
+Then we post B and C on top of branch "side":
+
+   A--B--C  <-- master, HEAD
+  /
+ O          <-- side-base
+  \
+   B*--C*   <-- side
+
+B has a different author, which must be copied to B*.
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	printf "a%s\n" 1 2 3 4 >file-a &&
+	printf "b%s\n" 5 6 7 8 >file-b &&
+
+	test_tick &&
+	git add file-a file-b &&
+	git commit -m initial &&
+	git tag side-base &&
+
+	test_tick &&
+	echo "Advance master" >>file-a &&
+	git commit -a -m advance-master &&
+
+	test_tick &&
+	echo "Unrelated fix" >>file-b &&
+	GIT_AUTHOR_NAME="S O Else" git commit -a -m fix-for-b &&
+
+	test_tick &&
+	echo "Another fix" >>file-b &&
+	git commit -a -m another-fix-for-b
+'
+
+test_expect_success 'post two commits on top of side' '
+
+	git branch -f side side-base &&
+	test_tick &&
+	git post side HEAD^ &&
+	test_tick &&
+	git post side &&
+
+	git log --pretty="%at %an %ae %s" HEAD~2.. >expect &&
+	git log --pretty="%at %an %ae %s" side-base..side >actual &&
+
+	test_cmp expect actual &&
+	git cat-file blob side:file-b >actual &&
+	test_cmp file-b actual &&
+
+	git diff --exit-code side-base side -- file-a	# no change
+'
+
+test_expect_success 'post requiring merge resolution fails' '
+
+	git branch -f side side-base &&
+	test_must_fail git post side HEAD
+'
+
+test_expect_success 'cannot post onto arbitrary commit name' '
+
+	git branch -f side side-base &&
+	test_must_fail git post side^0 HEAD^
+'
+
+test_done
-- 
2.14.2.808.g3bc32f2729
