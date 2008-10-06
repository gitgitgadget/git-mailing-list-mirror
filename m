From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] rebase --no-verify
Date: Mon, 06 Oct 2008 14:14:29 +0900
Message-ID: <20081006141429.6117@nanako3.lavabit.com>
References: <20081005222654.6117@nanako3.lavabit.com> <b19eae4e0810021710v14a3901an1f793de00c439ba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 07:18:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmiUb-0005T3-90
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 07:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYJFFOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 01:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbYJFFOx
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 01:14:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:39039 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbYJFFOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 01:14:52 -0400
Received: from f.earth.lavabit.com (f.earth.lavabit.com [192.168.111.15])
	by karen.lavabit.com (Postfix) with ESMTP id 00737C7AC5;
	Mon,  6 Oct 2008 00:14:52 -0500 (CDT)
Received: from 5936.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id D9520QBOPCYW; Mon, 06 Oct 2008 00:14:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=grxqX/Q0U/8maQleOwgsF+Jt9cmAou0acmVw6soMoEAFYQpW1qqPRSK0eXyUOxkW3EnjuDLOvpKuxsP8wrpFkSiC5Xn9R4jDUXXlxyCHs4sWMlp31A4dw5euGBSJ0vItnMZzmTYx11/6nqw+6cH4l0V2eTHTH6ODBsSAVgOzjk4=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <20081005222654.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97562>

It is sometimes desirable to disable the safety net of pre-rebase hook
when the user knows what he is doing (for example, when the original
changes on the branch have not been shown to the public yet).

This teaches --no-verify option to git-rebase, which is similar to the way
pre-commit hook is bypassed by git-commit.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

    It probably is better to fix "rebase -i" to share more code with the main
    "rebase" script to avoid duplicated run-pre-rebase-hook function, but it
    is beyond what I can do right now.  Perhaps people more smart and
    beautiful than me can help (^_^;)

 git-rebase--interactive.sh |   10 +++++++++-
 git-rebase.sh              |    7 ++++++-
 t/t3409-rebase-hook.sh     |   16 ++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3350f90..b0d757d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -26,6 +26,7 @@ i,interactive      always used (no-op)
 continue           continue rebasing process
 abort              abort rebasing process and restore original branch
 skip               skip current patch and continue rebasing process
+no-verify          override pre-rebase hook from stopping the operation
 "
 
 . git-sh-setup
@@ -41,6 +42,7 @@ PRESERVE_MERGES=
 STRATEGY=
 ONTO=
 VERBOSE=
+OK_TO_SKIP_PRE_REBASE=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -66,7 +68,8 @@ output () {
 }
 
 run_pre_rebase_hook () {
-	if test -x "$GIT_DIR/hooks/pre-rebase"
+	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
+	   test -x "$GIT_DIR/hooks/pre-rebase"
 	then
 		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
 			echo >&2 "The pre-rebase hook refused to rebase."
@@ -416,6 +419,11 @@ get_saved_options () {
 while test $# != 0
 do
 	case "$1" in
+	--no-verify)
+		OK_TO_SKIP_PRE_REBASE=yes
+		;;
+	--verify)
+		;;
 	--continue)
 		is_standalone "$@" || usage
 		get_saved_options
diff --git a/git-rebase.sh b/git-rebase.sh
index a30d40c..f2742aa 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,6 +34,7 @@ set_reflog_action rebase
 require_work_tree
 cd_to_toplevel
 
+OK_TO_SKIP_PRE_REBASE=
 RESOLVEMSG="
 When you have resolved this problem run \"git rebase --continue\".
 If you would prefer to skip this patch, instead run \"git rebase --skip\".
@@ -145,7 +146,8 @@ is_interactive () {
 }
 
 run_pre_rebase_hook () {
-	if test -x "$GIT_DIR/hooks/pre-rebase"
+	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
+	   test -x "$GIT_DIR/hooks/pre-rebase"
 	then
 		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
 			echo >&2 "The pre-rebase hook refused to rebase."
@@ -170,6 +172,9 @@ fi
 while test $# != 0
 do
 	case "$1" in
+	--no-verify)
+		OK_TO_SKIP_PRE_REBASE=yes
+		;;
 	--continue)
 		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
 			die "No rebase in progress?"
diff --git a/t/t3409-rebase-hook.sh b/t/t3409-rebase-hook.sh
index bc93dda..1f1b850 100755
--- a/t/t3409-rebase-hook.sh
+++ b/t/t3409-rebase-hook.sh
@@ -123,4 +123,20 @@ test_expect_success 'pre-rebase hook stops rebase (2)' '
 	test 0 = $(git rev-list HEAD...side | wc -l)
 '
 
+test_expect_success 'rebase --no-verify overrides pre-rebase (1)' '
+	git checkout test &&
+	git reset --hard side &&
+	git rebase --no-verify master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
+	test "z$(cat git)" = zworld
+'
+
+test_expect_success 'rebase --no-verify overrides pre-rebase (2)' '
+	git checkout test &&
+	git reset --hard side &&
+	EDITOR=true git rebase --no-verify -i master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
+	test "z$(cat git)" = zworld
+'
+
 test_done
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
