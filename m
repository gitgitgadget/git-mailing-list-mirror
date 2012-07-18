From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 7/7] rebase (without -p): correctly calculate patches to rebase
Date: Wed, 18 Jul 2012 00:27:35 -0700
Message-ID: <1342596455-17046-8-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-6-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-7-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Knut Franke <Knut.Franke@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:28:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOgE-0000Ii-G2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab2GRH2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:28:10 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:57558 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab2GRH1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:50 -0400
Received: by qcqs25 with SMTP id s25so131376qcq.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=veUYWLjWOnSMX2aX4wxpZ8PNyfPg81mtB38s1f/sSNU=;
        b=mdqM7RgeYWugjP1NIj4JIFEC2R8pqoOxvXpZ9zu7jbirJwajoysAvGQ7Zga0SoKtOV
         4BvQvXFEbyBxdB2Aj3tJ+Yxtnq7oq7NbxrMS7ODTKPu178FGjkBULI7M+58I+CljkutC
         3sHGniJBCgCgYD0zvJK+3xX3pyswVvi3gZdMX0p2cou44cUZ4XlN8lIQel8qMvEqh/EC
         VzTwaDF9t68Dxg2s+XtZpBSfU2DQLn7dNQpspD4c2okaXWFk8Vk8+j/aoLXvaorldoXF
         KIVv3gX+r2u3a32YMdVi/4kgm+BQFLyfZzLZeN6mERCoJn/l+OO7tsUqVhN7Cb2MADx+
         Z6Dw==
Received: by 10.236.191.40 with SMTP id f28mr992259yhn.2.1342596469946;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by 10.236.191.40 with SMTP id f28mr992255yhn.2.1342596469904;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i27si5973837yhe.4.2012.07.18.00.27.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id B86C31E0043;
	Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 59773C19C4; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1342596455-17046-7-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQljFn3WSi1O8PjKGPYy/VMDtDwNRaFt0gMvBVBlTgWxfhUkCmNF83LtovQIBhjp4/JJtUnKSGROmCA2nvcUNs3OmUgmfCs0N3CXzZ3ffz/vRj8wEt/ZKVzt2zREe51DVCXkjchNokKJLYpjFRd+/PEvCJuoucS7G4Eq0BadYF6cBMeBXbZLHU4oXEyZJt7K8X96W8xg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201664>

The different types of rebase use different ways of calculating the
patches to rebase.

'git rebase' (without -m/-i/-p) uses

  git format-patch --ignore-if-in-upstream $upstream..$orig_head

'git rebase -m' uses

  git rev-list $upstream..$orig_head

'git rebase -i' (without -p) uses

  git rev-list $upstream...$orig_head --left-right --no-merges \
          --cherry-pick | sed -n "s/^>//p"

, which could also have been written

  git rev-list $upstream...$orig_head --right-only --no-merges \
          --cherry-pick

'git rebase -p' uses

  git rev-list $upstream...$orig_head --right-only

followed by cherry-picked commits found by

  git rev-list $upstream...$orig_head --cherry-mark --right-only |
  | sed -ne "s/^=//p"

As Knut Franke reported in [1], the fact that there is no
--ignore-if-in-upstream or equivalent when using merge-based rebase
means that unnecessary conflicts can arise due to commits
cherry-picked between $orig_head and $upstream.

With all the other types, there is a different problem with the method
of calculating the commits to rebase. Copying the example history from
[1]:

      .-c
     /
a---b---d---e---f
         \
          .-g---E

Commit E is here a cherry-pick of e. If we now run 'git rebase [-i|-p]
--onto c f E', the commits to rebase will be those on E that are not
equivalent to any of those in f, which in this case would be only
'g'. Commit 'E' would thus be lost.

To solve both of the above problems, we want to find the commits in
$upstream..$orig_head that are not cherry-picked in
$orig_head..$onto. There is unfortunately no direct way of finding
these commits using 'git rev-list', so we will have to resort to using
'git cherry' and filter for lines starting with '+'. This works for
all but 'rebase -p', since 'git cherry' ignores merges.

As a side-effect, we also avoid the cost of formatting patches.

Test case updates for 'rebase -m' by Knut, the rest by Martin.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/161917

Helped-by: Knut Franke <Knut.Franke@gmx.de>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--am.sh          |  6 ++----
 git-rebase--interactive.sh |  8 +++-----
 git-rebase--merge.sh       |  2 +-
 git-rebase.sh              | 11 ++++-------
 t/t3401-rebase-partial.sh  | 17 +++++++++++++++++
 t/t3406-rebase-message.sh  | 14 +++++++-------
 6 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 37c1b23..fe3fdd1 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -16,11 +16,9 @@ skip)
 	;;
 esac
 
-test -n "$rebase_root" && root_flag=--root
 test -n "$keep_empty" && git_am_opt="$git_am_opt --keep-empty"
-git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-	--src-prefix=a/ --dst-prefix=b/ \
-	--no-renames $root_flag "$revisions" |
+generate_revisions |
+sed -e 's/\([0-9a-f]\{40\}\)/From \1 Mon Sep 17 00:00:00 2001/' |
 git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
 move_to_original_branch
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cd5a2cc..da32ca7 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -800,10 +800,8 @@ if test -z "$rebase_root"
 	# this is now equivalent to ! -z "$upstream"
 then
 	shortupstream=$(git rev-parse --short $upstream)
-	revisions=$upstream...$orig_head
 	shortrevisions=$shortupstream..$shorthead
 else
-	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
 
@@ -822,6 +820,7 @@ if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
 	then
+		revisions=$upstream...$orig_head
 		mkdir "$rewritten" &&
 		for c in $(git merge-base --all $orig_head $upstream)
 		do
@@ -829,6 +828,7 @@ then
 				die "Could not init rewritten commits"
 		done
 	else
+		revisions=$onto...$orig_head
 		mkdir "$rewritten" &&
 		echo $onto > "$rewritten"/root ||
 			die "Could not init rewritten commits"
@@ -876,9 +876,7 @@ then
 		fi
 	done
 else
-	git rev-list $revisions --reverse --left-right --topo-order \
-		--no-merges --cherry-pick |
-	sed -n "s/^>//p" |
+	generate_revisions |
 	while read -r sha1
 	do
 		add_pick_line $sha1
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index b10f2cf..bf4ec4b 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -131,7 +131,7 @@ echo "$onto_name" > "$state_dir/onto_name"
 write_basic_state
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
+for cmt in $(generate_revisions)
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$state_dir/cmt.$msgnum"
diff --git a/git-rebase.sh b/git-rebase.sh
index 1cd0633..0fdff87 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -530,6 +530,10 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
+generate_revisions () {
+	git cherry $onto $orig_head $upstream | sed -ne 's/^+ //p'
+}
+
 test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
@@ -546,11 +550,4 @@ then
 	exit 0
 fi
 
-if test -n "$rebase_root"
-then
-	revisions="$onto..$orig_head"
-else
-	revisions="$upstream..$orig_head"
-fi
-
 run_specific_rebase
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 7f8693b..9c5d815 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -50,4 +50,21 @@ test_expect_success 'rebase ignores empty commit' '
 	test $(git log --format=%s C..) = "D"
 '
 
+test_expect_success 'rebase --onto does not re-apply patches in $onto' '
+	git checkout C &&
+	test_commit C2 C.t &&
+	git checkout -B my-topic-branch master &&
+	test_commit E &&
+	git rebase --onto C2 A2 &&
+	test "$(git log --format=%s C2..)" = E
+'
+
+test_expect_success 'rebase --onto does not lose patches in $upstream' '
+	git rebase --onto A2 E &&
+	test "$(git log --format=%s A2..)" = "E
+C2
+C
+B"
+'
+
 test_done
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 6898377..3eecc66 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -5,8 +5,10 @@ test_description='messages from rebase operation'
 . ./test-lib.sh
 
 quick_one () {
-	echo "$1" >"file$1" &&
-	git add "file$1" &&
+	fileno=$2
+	test -z "$fileno" && fileno=$1
+	echo "$1" >"file$fileno" &&
+	git add "file$fileno" &&
 	test_tick &&
 	git commit -m "$1"
 }
@@ -16,21 +18,19 @@ test_expect_success setup '
 	git branch topic &&
 	quick_one X &&
 	quick_one A &&
-	quick_one B &&
+	quick_one B A &&
 	quick_one Y &&
 
 	git checkout topic &&
 	quick_one A &&
-	quick_one B &&
+	quick_one B A &&
 	quick_one Z &&
 	git tag start
 
 '
 
 cat >expect <<\EOF
-Already applied: 0001 A
-Already applied: 0002 B
-Committed: 0003 Z
+Committed: 0001 Z
 EOF
 
 test_expect_success 'rebase -m' '
-- 
1.7.11.1.104.ge7b44f1
