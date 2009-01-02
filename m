From: Thomas Rast <trast@student.ethz.ch>
Subject: [INTERDIFF v3 2/4] rebase: learn to rebase root commit
Date: Fri, 2 Jan 2009 23:41:32 +0100
Message-ID: <200901022341.36562.trast@student.ethz.ch>
References: <200901022320.14055.trast@student.ethz.ch> <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch> <7c74d8be216b4667f470e34644c4aa26dcfe0cfb.1230935095.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, bss@iguanasuicide.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 23:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsj8-0003cK-0D
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbZABWlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZABWlY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:41:24 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:58751 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbZABWlX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:41:23 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:41:21 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:41:20 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7c74d8be216b4667f470e34644c4aa26dcfe0cfb.1230935095.git.trast@student.ethz.ch>
Content-Disposition: inline
X-OriginalArrivalTime: 02 Jan 2009 22:41:20.0866 (UTC) FILETIME=[3BA80C20:01C96D2B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104436>

The interdiff to v2.

diff --git a/git-rebase.sh b/git-rebase.sh
index 89de3c4..9437e51 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -354,17 +354,20 @@ if test -z "$rebase_root"; then
 	shift
 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
 	die "invalid upstream $upstream_name"
+	unset root_flag
+else
+	test -z "$newbase" && die "--root must be used with --onto"
+	unset upstream_name
+	unset upstream
+	root_flag="--root"
 fi
 
-test ! -z "$rebase_root" -a -z "$newbase" &&
-	die "--root must be used with --onto"
-
 # Make sure the branch to rebase onto is valid.
 onto_name=${newbase-"$upstream_name"}
 onto=$(git rev-parse --verify "${onto_name}^0") || exit
 
 # If a hook exists, give it a chance to interrupt
-run_pre_rebase_hook ${upstream_name+"$upstream_name"} "$@"
+run_pre_rebase_hook $root_flag $upstream_name "$@"
 
 # If the branch to rebase is given, that is the branch we will rebase
 # $branch_name -- branch being rebased, or HEAD (already detached)
@@ -403,8 +406,8 @@ case "$#" in
 esac
 orig_head=$branch
 
-# Now we are rebasing commits $upstream..$branch (or simply $branch
-# with --root) on top of $onto
+# Now we are rebasing commits $upstream..$branch (or with --root,
+# everything leading up to $branch) on top of $onto
 
 # Check if we are already based on $onto with linear history,
 # but this should be done only when upstream and onto are the same.
@@ -441,17 +444,15 @@ then
 fi
 
 if test ! -z "$rebase_root"; then
-	revisions="$orig_head"
-	fp_flag="--root"
+	revisions="$onto..$orig_head"
 else
 	revisions="$upstream..$orig_head"
-	fp_flag="--ignore-if-in-upstream"
 fi
 
 if test -z "$do_merge"
 then
-	git format-patch -k --stdout --full-index "$fp_flag" \
-		"$revisions" |
+	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+		$root_flag "$revisions" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 63ec5e6..1978512 100755
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
@@ -49,4 +63,24 @@ test_expect_success 'rebase --root --onto <newbase> <branch>' '
 	test_cmp expect rebased2
 '
 
+test_expect_success 'pre-rebase got correct input (2)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work2
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
+test_expect_success 'pre-rebase hook stops rebase' '
+	git checkout -b stops1 other &&
+	GIT_EDITOR=: test_must_fail git rebase --root --onto master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops1
+	test 0 = $(git rev-list other...stops1 | wc -l)
+'
+
 test_done

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
