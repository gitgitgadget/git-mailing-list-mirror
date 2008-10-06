From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Teach rebase -i to honor pre-rebase hook
Date: Mon, 06 Oct 2008 14:14:24 +0900
Message-ID: <20081006141424.6117@nanako3.lavabit.com>
References: <20081005222654.6117@nanako3.lavabit.com> <b19eae4e0810021710v14a3901an1f793de00c439ba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 07:18:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmiUa-0005T3-8q
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 07:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbYJFFOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 01:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYJFFOr
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 01:14:47 -0400
Received: from karen.lavabit.com ([72.249.41.33]:39034 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbYJFFOq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 01:14:46 -0400
Received: from f.earth.lavabit.com (f.earth.lavabit.com [192.168.111.15])
	by karen.lavabit.com (Postfix) with ESMTP id 9DF5BC7AC5;
	Mon,  6 Oct 2008 00:14:45 -0500 (CDT)
Received: from 5936.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 8WD9CSYJ3LJO; Mon, 06 Oct 2008 00:14:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=xaFD18aDNOQVJbpzqPZCg9cmw3PGbCNNIuck+8+av49cOVXjKoaCggb7PHbyVHXYorF2pDb1WtOGVwFAvdFpyCNedv54xwwthwNb0HxYs436Ul2XitcnEIhurmTwkpQgdgxX3A7Eui1fh9R4a3vqP2WQsuxSSjAzBu389g7I2c4=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <20081005222654.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97561>

The original git-rebase honored pre-rebase hook so that public branches
can be protected from getting rebased, but rebase --interactive ignored
the hook entirely.  This fixes it.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 git-rebase--interactive.sh |   11 ++++
 git-rebase.sh              |   18 ++++---
 t/t3409-rebase-hook.sh     |  126 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 7 deletions(-)
 create mode 100755 t/t3409-rebase-hook.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index edb6ec6..3350f90 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -65,6 +65,16 @@ output () {
 	esac
 }
 
+run_pre_rebase_hook () {
+	if test -x "$GIT_DIR/hooks/pre-rebase"
+	then
+		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
+			echo >&2 "The pre-rebase hook refused to rebase."
+			exit 1
+		}
+	fi
+}
+
 require_clean_work_tree () {
 	# test if working tree is dirty
 	git rev-parse --verify HEAD > /dev/null &&
@@ -507,6 +517,7 @@ first and then run 'git rebase --continue' again."
 		;;
 	--)
 		shift
+		run_pre_rebase_hook ${1+"$@"}
 		test $# -eq 1 -o $# -eq 2 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
diff --git a/git-rebase.sh b/git-rebase.sh
index 528b604..a30d40c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -144,6 +144,16 @@ is_interactive () {
 	done && test -n "$1"
 }
 
+run_pre_rebase_hook () {
+	if test -x "$GIT_DIR/hooks/pre-rebase"
+	then
+		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
+			echo >&2 "The pre-rebase hook refused to rebase."
+			exit 1
+		}
+	fi
+}
+
 test -f "$GIT_DIR"/rebase-apply/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
@@ -320,13 +330,7 @@ onto_name=${newbase-"$upstream_name"}
 onto=$(git rev-parse --verify "${onto_name}^0") || exit
 
 # If a hook exists, give it a chance to interrupt
-if test -x "$GIT_DIR/hooks/pre-rebase"
-then
-	"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
-		echo >&2 "The pre-rebase hook refused to rebase."
-		exit 1
-	}
-fi
+run_pre_rebase_hook ${1+"$@"}
 
 # If the branch to rebase is given, that is the branch we will rebase
 # $branch_name -- branch being rebased, or HEAD (already detached)
diff --git a/t/t3409-rebase-hook.sh b/t/t3409-rebase-hook.sh
new file mode 100755
index 0000000..bc93dda
--- /dev/null
+++ b/t/t3409-rebase-hook.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+
+test_description='git rebase with its hook(s)'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo hello >file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo goodbye >file &&
+	git add file &&
+	test_tick &&
+	git commit -m second &&
+	git checkout -b side HEAD^ &&
+	echo world >git &&
+	git add git &&
+	test_tick &&
+	git commit -m side &&
+	git checkout master &&
+	git log --pretty=oneline --abbrev-commit --graph --all &&
+	git branch test side
+'
+
+test_expect_success 'rebase' '
+	git checkout test &&
+	git reset --hard side &&
+	git rebase master &&
+	test "z$(cat git)" = zworld
+'
+
+test_expect_success 'rebase -i' '
+	git checkout test &&
+	git reset --hard side &&
+	EDITOR=true git rebase -i master &&
+	test "z$(cat git)" = zworld
+'
+
+test_expect_success 'setup pre-rebase hook' '
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/pre-rebase <<EOF &&
+#!$SHELL_PATH
+echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+EOF
+	chmod +x .git/hooks/pre-rebase
+'
+
+test_expect_success 'pre-rebase hook gets correct input (1)' '
+	git checkout test &&
+	git reset --hard side &&
+	git rebase master &&
+	test "z$(cat git)" = zworld &&
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,
+
+'
+
+test_expect_success 'pre-rebase hook gets correct input (2)' '
+	git checkout test &&
+	git reset --hard side &&
+	git rebase master test &&
+	test "z$(cat git)" = zworld &&
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+'
+
+test_expect_success 'pre-rebase hook gets correct input (3)' '
+	git checkout test &&
+	git reset --hard side &&
+	git checkout master &&
+	git rebase master test &&
+	test "z$(cat git)" = zworld &&
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+'
+
+test_expect_success 'pre-rebase hook gets correct input (4)' '
+	git checkout test &&
+	git reset --hard side &&
+	EDITOR=true git rebase -i master &&
+	test "z$(cat git)" = zworld &&
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,
+
+'
+
+test_expect_success 'pre-rebase hook gets correct input (5)' '
+	git checkout test &&
+	git reset --hard side &&
+	EDITOR=true git rebase -i master test &&
+	test "z$(cat git)" = zworld &&
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+'
+
+test_expect_success 'pre-rebase hook gets correct input (6)' '
+	git checkout test &&
+	git reset --hard side &&
+	git checkout master &&
+	EDITOR=true git rebase -i master test &&
+	test "z$(cat git)" = zworld &&
+	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+'
+
+test_expect_success 'setup pre-rebase hook that fails' '
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/pre-rebase <<EOF &&
+#!$SHELL_PATH
+false
+EOF
+	chmod +x .git/hooks/pre-rebase
+'
+
+test_expect_success 'pre-rebase hook stops rebase (1)' '
+	git checkout test &&
+	git reset --hard side &&
+	test_must_fail git rebase master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
+	test 0 = $(git rev-list HEAD...side | wc -l)
+'
+
+test_expect_success 'pre-rebase hook stops rebase (2)' '
+	git checkout test &&
+	git reset --hard side &&
+	EDITOR=true test_must_fail git rebase -i master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
+	test 0 = $(git rev-list HEAD...side | wc -l)
+'
+
+test_done
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
