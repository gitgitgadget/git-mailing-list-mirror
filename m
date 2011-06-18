From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] rebase -i -p: include non-first-parent commits in todo list
Date: Sat, 18 Jun 2011 18:12:01 -0400
Message-ID: <1308435121-9692-1-git-send-email-andrew.kw.w@gmail.com>
References: <20110618121222.03ee0b79@sh9>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 00:16:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY3oO-000385-9A
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 00:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab1FRWPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 18:15:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40724 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab1FRWPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 18:15:21 -0400
Received: by iyb12 with SMTP id 12so1066828iyb.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ylb3/GEZaoW/EYbmkSTEVLYcKkoXhUl6WMUiucOopqE=;
        b=jQ5s+WFI2tKOoTsa9tWTrRubMlLrPqpr9UZum/xYJ9WQzfQp6ifLHEZnbW4WDzhsnq
         9Wxd/1ZlhvR3UBL8+S/1JU66Zcpl2Gnmf9Pcka3OXt1nhcdj75EYZ8MSPm9QDqOUgaWi
         4iU/PWm+h0L/gwyZTCtr2fbObGfLJHwm3+ssE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gXSuKZz5BVf+Qk2IpAIPDedRpUMvsaN+Q1orsIb8kFX+brjqud6BHu8QDC7Zbl7eWU
         Zhd7R+zzbvM12ZYSp/Rrk1KQwnzUY1+fQK6zLkqNQFOoSjvIlg4yfFYfmqZ7+J0wQjus
         WCdkWteJlPAaNChpoXKDMAXnNO5/rkqDxnPlo=
Received: by 10.231.63.83 with SMTP id a19mr3375714ibi.104.1308435320483;
        Sat, 18 Jun 2011 15:15:20 -0700 (PDT)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id ft12sm2243206ibb.36.2011.06.18.15.15.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Jun 2011 15:15:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <20110618121222.03ee0b79@sh9>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175991>

Consider this graph:

        D---E    (topic, HEAD)
       /   /
  A---B---C      (master)
   \
    F            (topic2)

and the following three commands:
  1. git rebase -i -p A
  2. git rebase -i -p --onto F A
  3. git rebase -i -p B

Currently, (1) and (2) will pick B, D, C, and E onto A and F,
respectively.  However, (3) will only pick D and E onto B, but not C,
which is inconsistent with (1) and (2).  As a result, we cannot modify C
during the interactive-rebase.

The current behavior also creates a bug if we do:
  4. git rebase -i -p C

In (4), E is never picked.  And since interactive-rebase resets "HEAD"
to "onto" before picking any commits, D and E are lost after the
interactive-rebase.

This patch fixes the inconsistency and bug by ensuring that all children
of upstream are always picked.  This essentially reverts the commit:
  d80d6bc146232d81f1bb4bc58e5d89263fd228d4

When compiling the todo list, commits reachable from "upstream" should
never be skipped under any conditions.  Otherwise, we lose the ability
to modify them like (3), and create a bug like (4).

Two of the tests contain a scenario like (3).  Since the new behavior
added more commits for picking, these tests need to be updated to
account for the additional pick lines.  A new test has also been added
for (4).

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh               |    3 +--
 t/t3404-rebase-interactive.sh            |    2 +-
 t/t3409-rebase-preserve-merges.sh        |   28 +++++++++++++++++++++++++++-
 t/t3411-rebase-preserve-around-merges.sh |    2 +-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 65690af..c6ba7c1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -713,7 +713,6 @@ then
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
 	merges_option=
-	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$orig_head | head -n 1)"
 else
 	merges_option="--no-merges --cherry-pick"
 fi
@@ -746,7 +745,7 @@ do
 			preserve=t
 			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
 			do
-				if test -f "$rewritten"/$p -a \( $p != $onto -o $sha1 = $first_after_upstream \)
+				if test -f "$rewritten"/$p
 				then
 					preserve=f
 				fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 47c8371..8538813 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -295,7 +295,7 @@ test_expect_success 'preserve merges with -p' '
 '
 
 test_expect_success 'edit ancestor with -p' '
-	FAKE_LINES="1 edit 2 3 4" git rebase -i -p HEAD~3 &&
+	FAKE_LINES="1 2 edit 3 4" git rebase -i -p HEAD~3 &&
 	echo 2 > unrelated-file &&
 	test_tick &&
 	git commit -m L2-modified --amend unrelated-file &&
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 08201e2..6de4e22 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -37,7 +37,15 @@ export GIT_AUTHOR_EMAIL
 #      \
 #       B2     <-- origin/topic
 #
-# In all cases, 'topic' is rebased onto 'origin/topic'.
+# Clone 4 (merge using second parent as base):
+#
+# A1--A2--B3   <-- origin/master
+#  \
+#   B1--A3--M  <-- topic
+#    \     /
+#     \--A4    <-- topic2
+#      \
+#       B2     <-- origin/topic
 
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
@@ -57,6 +65,13 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git merge origin/master
 	) &&
 
+	git clone ./. clone4 &&
+	(
+		cd clone4 &&
+		git checkout -b topic origin/topic &&
+		git merge origin/master
+	) &&
+
 	echo Fifth > B &&
 	git add B &&
 	git commit -m "Add different B" &&
@@ -123,4 +138,15 @@ test_expect_success 'rebase -p preserves no-ff merges' '
 	)
 '
 
+test_expect_success 'rebase -p works when base inside second parent' '
+	(
+	cd clone4 &&
+	git fetch &&
+	git rebase -p HEAD^2 &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify B" | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote-tracking branch " | wc -l)
+	)
+'
+
 test_done
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index 14a23cd..ace8e54 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -37,7 +37,7 @@ test_expect_success 'setup' '
 #        -- C1 --
 #
 test_expect_success 'squash F1 into D1' '
-	FAKE_LINES="1 squash 3 2" git rebase -i -p B1 &&
+	FAKE_LINES="1 squash 4 2 3" git rebase -i -p B1 &&
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse C1)" &&
 	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B1)" &&
 	git tag E2
-- 
1.7.2.2
