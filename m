From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 2/2] rebase: omit patch-identical commits with --fork-point
Date: Wed, 16 Jul 2014 20:23:49 +0100
Message-ID: <374b26180807c67f7bd152ce5a2f52e34397e3a6.1405538598.git.john@keeping.me.uk>
References: <xmqqmwcatgza.fsf@gitster.dls.corp.google.com>
 <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405538598.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Ted Felix <ted@tedfelix.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:24:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Uoa-0007eK-S4
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 21:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935174AbaGPTYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 15:24:17 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:55795 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134AbaGPTYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 15:24:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 5A01222ECA;
	Wed, 16 Jul 2014 20:24:13 +0100 (BST)
X-Quarantine-ID: <AHiziALf8ea4>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AHiziALf8ea4; Wed, 16 Jul 2014 20:24:12 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id E68E922F1A;
	Wed, 16 Jul 2014 20:24:04 +0100 (BST)
X-Mailer: git-send-email 2.0.1.472.g6f92e5f.dirty
In-Reply-To: <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405538598.git.john@keeping.me.uk>
In-Reply-To: <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405538598.git.john@keeping.me.uk>
References: <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405538598.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253684>

When the `--fork-point` argument was added to `git rebase`, we changed
the value of $upstream to be the fork point instead of the point from
which we want to rebase.  When $orig_head..$upstream is empty this does
not change the behaviour, but when there are new changes in the upstream
we are no longer checking if any of them are patch-identical with
changes in $upstream..$orig_head.

Fix this by introducing a new variable to hold the fork point and using
this to restrict the range as an extra (negative) revision argument so
that the set of desired revisions becomes (in fork-point mode):

	git rev-list --cherry-pick --right-only \
		$upstream...$orig_head ^$fork_point

This allows us to correctly handle the scenario where we have the
following topology:

	    C --- D --- E  <- dev
	   /
	  B  <- master@{1}
	 /
	o --- B' --- C* --- D*  <- master

where:
- B' is a fixed-up version of B that is not patch-identical with B;
- C* and D* are patch-identical to C and D respectively and conflict
  textually if applied in the wrong order;
- E depends textually on D.

The correct result of `git rebase master dev` is that B is identified as
the fork-point of dev and master, so that C, D, E are the commits that
need to be replayed onto master; but C and D are patch-identical with C*
and D* and so can be dropped, so that the end result is:

	o --- B' --- C* --- D* --- E  <- dev

If the fork-point is not identified, then picking B onto a branch
containing B' results in a conflict and if the patch-identical commits
are not correctly identified then picking C onto a branch containing D
(or equivalently D*) results in a conflict.

This change allows us to handle both of these cases, where previously we
either identified the fork-point (with `--fork-point`) but not the
patch-identical commits *or* (with `--no-fork-point`) identified the
patch-identical commits but not the fact that master had been rewritten.

Reported-by: Ted Felix <ted@tedfelix.com>
Signed-off-by: John Keeping <john@keeping.me.uk>
---

Change from v1:
    - add a test case

 git-rebase--am.sh          |  6 ++++--
 git-rebase--interactive.sh |  2 +-
 git-rebase.sh              |  7 ++++---
 t/t3400-rebase.sh          | 23 +++++++++++++++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 902bf2d..f923732 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -45,14 +45,16 @@ then
 	# itself well to recording empty patches.  fortunately, cherry-pick
 	# makes this easy
 	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty \
-		--right-only "$revisions"
+		--right-only "$revisions" \
+		${restrict_revision+^$restrict_revision}
 	ret=$?
 else
 	rm -f "$GIT_DIR/rebased-patches"
 
 	git format-patch -k --stdout --full-index --cherry-pick --right-only \
 		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
-		"$revisions" >"$GIT_DIR/rebased-patches"
+		"$revisions" ${restrict_revision+^$restrict_revision} \
+		>"$GIT_DIR/rebased-patches"
 	ret=$?
 
 	if test 0 != $ret
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7e1eda0..b64dd28 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -963,7 +963,7 @@ else
 fi
 git rev-list $merges_option --pretty=oneline --abbrev-commit \
 	--abbrev=7 --reverse --left-right --topo-order \
-	$revisions | \
+	$revisions ${restrict_revision+^$restrict_revision} | \
 	sed -n "s/^>//p" |
 while read -r shortsha1 rest
 do
diff --git a/git-rebase.sh b/git-rebase.sh
index 06c810b..55da9db 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,6 +59,7 @@ If you prefer to skip this patch, run "git rebase --skip" instead.
 To check out the original branch and stop rebasing, run "git rebase --abort".')
 "
 unset onto
+unset restrict_revision
 cmd=
 strategy=
 strategy_opts=
@@ -546,7 +547,7 @@ then
 			"${switch_to:-HEAD}")
 	if test -n "$new_upstream"
 	then
-		upstream=$new_upstream
+		restrict_revision=$new_upstream
 	fi
 fi
 
@@ -572,7 +573,7 @@ require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 # and if this is not an interactive rebase.
 mb=$(git merge-base "$onto" "$orig_head")
 if test "$type" != interactive && test "$upstream" = "$onto" &&
-	test "$mb" = "$onto" &&
+	test "$mb" = "$onto" && test -z "$restrict_revision" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
 then
@@ -626,7 +627,7 @@ if test -n "$rebase_root"
 then
 	revisions="$onto..$orig_head"
 else
-	revisions="$upstream..$orig_head"
+	revisions="${restrict_revision-$upstream}..$orig_head"
 fi
 
 run_specific_rebase
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 80e0a95..47b5682 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -169,6 +169,29 @@ test_expect_success 'default to common base in @{upstream}s reflog if no upstrea
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-picked commits and fork-point work together' '
+	git checkout default-base &&
+	echo Amended >A &&
+	git commit -a --no-edit --amend &&
+	test_commit B B &&
+	test_commit new_B B "New B" &&
+	test_commit C C &&
+	git checkout default &&
+	git reset --hard default-base@{4} &&
+	test_commit D D &&
+	git cherry-pick -2 default-base^ &&
+	test_commit final_B B "Final B" &&
+	git rebase &&
+	echo Amended >expect &&
+	test_cmp A expect &&
+	echo "Final B" >expect &&
+	test_cmp B expect &&
+	echo C >expect &&
+	test_cmp C expect &&
+	echo D >expect &&
+	test_cmp D expect
+'
+
 test_expect_success 'rebase -q is quiet' '
 	git checkout -b quiet topic &&
 	git rebase -q master >output.out 2>&1 &&
-- 
2.0.1.472.g6f92e5f.dirty
