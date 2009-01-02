From: Thomas Rast <trast@student.ethz.ch>
Subject: [INTERDIFF v3 3/4] rebase -i: learn to rebase root commit
Date: Fri, 2 Jan 2009 23:41:39 +0100
Message-ID: <200901022341.40667.trast@student.ethz.ch>
References: <200901022320.14055.trast@student.ethz.ch> <7c74d8be216b4667f470e34644c4aa26dcfe0cfb.1230935095.git.trast@student.ethz.ch> <43e09eaf2b9a9a3805b9262957ece32190ae4c32.1230935095.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, bss@iguanasuicide.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 23:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsj8-0003cK-M9
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559AbZABWl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757528AbZABWl2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:41:28 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:58764 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757436AbZABWl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:41:28 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:41:24 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:41:24 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <43e09eaf2b9a9a3805b9262957ece32190ae4c32.1230935095.git.trast@student.ethz.ch>
Content-Disposition: inline
X-OriginalArrivalTime: 02 Jan 2009 22:41:24.0428 (UTC) FILETIME=[3DC790C0:01C96D2B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104435>

This is the interdiff to v2.  Some of the changes are noise from 1/4.

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d6f54eb..14d3e38 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -238,7 +238,9 @@ pick_one_preserving_merges () {
 			if test -f "$DROPPED"/$p
 			then
 				fast_forward=f
-				pend=" $(cat "$DROPPED"/$p)$pend"
+				replacement="$(cat "$DROPPED"/$p)"
+				test -z "$replacement" && replacement=root
+				pend=" $replacement$pend"
 			else
 				new_parents="$new_parents $p"
 			fi
@@ -569,7 +571,6 @@ first and then run 'git rebase --continue' again."
 		;;
 	--)
 		shift
-		run_pre_rebase_hook ${1+"$@"}
 		test ! -z "$REBASE_ROOT" -o $# -eq 1 -o $# -eq 2 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
@@ -577,19 +578,22 @@ first and then run 'git rebase --continue' again."
 		git var GIT_COMMITTER_IDENT >/dev/null ||
 			die "You need to set your committer info first"
 
-		comment_for_reflog start
-
-		require_clean_work_tree
-
 		if test -z "$REBASE_ROOT"
 		then
+			UPSTREAM_ARG="$1"
 			UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
 			test -z "$ONTO" && ONTO=$UPSTREAM
 			shift
 		else
+			UPSTREAM_ARG=--root
 			test -z "$ONTO" &&
 				die "You must specify --onto when using --root"
 		fi
+		run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
+
+		comment_for_reflog start
+
+		require_clean_work_tree
 
 		if test ! -z "$1"
 		then
@@ -651,7 +655,7 @@ first and then run 'git rebase --continue' again."
 			REVISIONS=$UPSTREAM...$HEAD
 			SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
 		else
-			REVISIONS=$HEAD
+			REVISIONS=$ONTO...$HEAD
 			SHORTREVISIONS=$SHORTHEAD
 		fi
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
@@ -710,6 +714,7 @@ first and then run 'git rebase --continue' again."
 				fi
 			done
 		fi
+
 		test -s "$TODO" || echo noop >> "$TODO"
 		cat >> "$TODO" << EOF
 
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index c845dfc..cbf3414 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -15,7 +15,9 @@ test_expect_success 'prepare repository' '
 	git commit -m 2 &&
 	git symbolic-ref HEAD refs/heads/other &&
 	rm .git/index &&
-	rm A &&
+	echo 1 > A &&
+	git add A &&
+	git commit -m 1b &&
 	echo 3 > B &&
 	git add B &&
 	git commit -m 3 &&
@@ -28,6 +30,14 @@ test_expect_success 'rebase --root expects --onto' '
 	test_must_fail git rebase --root
 '
 
+test_expect_success 'setup pre-rebase hook' '
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/pre-rebase <<EOF &&
+#!$SHELL_PATH
+echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+EOF
+	chmod +x .git/hooks/pre-rebase
+'
 cat > expect <<EOF
 4
 3
@@ -42,6 +52,10 @@ test_expect_success 'rebase --root --onto <newbase>' '
 	test_cmp expect rebased
 '
 
+test_expect_success 'pre-rebase got correct input (1)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,
+'
+
 test_expect_success 'rebase --root --onto <newbase> <branch>' '
 	git branch work2 other &&
 	git rebase --root --onto master work2 &&
@@ -49,6 +63,10 @@ test_expect_success 'rebase --root --onto <newbase> <branch>' '
 	test_cmp expect rebased2
 '
 
+test_expect_success 'pre-rebase got correct input (2)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work2
+'
+
 test_expect_success 'rebase -i --root --onto <newbase>' '
 	git checkout -b work3 other &&
 	GIT_EDITOR=: git rebase -i --root --onto master &&
@@ -56,6 +74,10 @@ test_expect_success 'rebase -i --root --onto <newbase>' '
 	test_cmp expect rebased3
 '
 
+test_expect_success 'pre-rebase got correct input (3)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,
+'
+
 test_expect_success 'rebase -i --root --onto <newbase> <branch>' '
 	git branch work4 other &&
 	GIT_EDITOR=: git rebase -i --root --onto master work4 &&
@@ -63,6 +85,10 @@ test_expect_success 'rebase -i --root --onto <newbase> <branch>' '
 	test_cmp expect rebased4
 '
 
+test_expect_success 'pre-rebase got correct input (4)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work4
+'
+
 test_expect_success 'rebase -i -p with linear history' '
 	git checkout -b work5 other &&
 	GIT_EDITOR=: git rebase -i -p --root --onto master &&
@@ -70,6 +96,10 @@ test_expect_success 'rebase -i -p with linear history' '
 	test_cmp expect rebased5
 '
 
+test_expect_success 'pre-rebase got correct input (5)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,
+'
+
 test_expect_success 'set up merge history' '
 	git checkout other^ &&
 	git checkout -b side &&
@@ -131,4 +161,27 @@ test_expect_success 'rebase -i -p with two roots' '
 	test_cmp expect-third rebased7
 '
 
+test_expect_success 'setup pre-rebase hook that fails' '
+	mkdir -p .git/hooks &&
+	cat >.git/hooks/pre-rebase <<EOF &&
+#!$SHELL_PATH
+false
+EOF
+	chmod +x .git/hooks/pre-rebase
+'
+
+test_expect_success 'pre-rebase hook stops rebase' '
+	git checkout -b stops1 other &&
+	GIT_EDITOR=: test_must_fail git rebase --root --onto master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops1
+	test 0 = $(git rev-list other...stops1 | wc -l)
+'
+
+test_expect_success 'pre-rebase hook stops rebase -i' '
+	git checkout -b stops2 other &&
+	GIT_EDITOR=: test_must_fail git rebase --root --onto master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops2
+	test 0 = $(git rev-list other...stops2 | wc -l)
+'
+
 test_done

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
