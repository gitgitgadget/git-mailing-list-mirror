Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC4CC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiFJArs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiFJArr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:47:47 -0400
Received: from nmsh7.e.nsc.no (nmsh7.e.nsc.no [148.123.160.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A0A193C6
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:47:45 -0700 (PDT)
Received: from Lorule.wifi.realnett.no (unknown [194.19.73.58])
        (Authenticated sender: joak-pet@online.no)
        by nmsh7.e.nsc.no (smtp.online.no) with ESMTPA id 401A0E619C;
        Fri, 10 Jun 2022 02:47:43 +0200 (CEST)
From:   Joakim Petersen <joak-pet@online.no>
To:     git@vger.kernel.org
Cc:     Joakim Petersen <joak-pet@online.no>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] git-prompt: fix expansion of branch colour codes
Date:   Fri, 10 Jun 2022 02:47:37 +0200
Message-Id: <20220610004737.17683-1-joak-pet@online.no>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609204447.32841-1-joak-pet@online.no>
References: <20220609204447.32841-1-joak-pet@online.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.201
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because of the wrapping of the branch name variable $b, the colour codes
in the variable don't get applied, but are instead printed directly in
the output. Move the wrapping of $b to before colour codes are inserted
to correct this. Revert move of branch name colour codes in tests, as
the branch name is now coloured after the wrapping instead of before.

Signed-off-by: Joakim Petersen <joak-pet@online.no>
---
Changes since v1:
 * Tests have been reverted to how they were before the initial
   colouring change in 9470605a1b0 (git-prompt: make colourization
   consistent, 2022-06-07), with the exception of the added $c_clear for
   the test with two active indicators.

Range-diff against v1:
1:  f4e46d37a5 < -:  ---------- git-prompt: fix expansion of branch colour codes
-:  ---------- > 1:  2520d60f0f git-prompt: fix expansion of branch colour codes

 contrib/completion/git-prompt.sh | 12 ++++++------
 t/t9903-bash-prompt.sh           | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index cb01c2fd5d..1435548e00 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -556,9 +556,14 @@ __git_ps1 ()
 		fi
 	fi
 
-	b=${b##refs/heads/}
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
+	b=${b##refs/heads/}
+	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+		__git_ps1_branch_name=$b
+		b="\${__git_ps1_branch_name}"
+	fi
+
 	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
 	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
 		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
@@ -566,11 +571,6 @@ __git_ps1 ()
 		fi
 	fi
 
-	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
-		__git_ps1_branch_name=$b
-		b="\${__git_ps1_branch_name}"
-	fi
-
 	local f="$h$w$i$s$u$p"
 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
 
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index abd82eec35..6a30f5719c 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -541,7 +541,7 @@ test_expect_success 'prompt - pc mode' '
 '
 
 test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_green}main${c_clear}" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
@@ -551,7 +551,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - bash color pc mode - detached head' '
-	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_red}(%s...)"${c_clear} $(git log -1 --format="%h" b1^) >expected &&
+	printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout main" &&
 	(
@@ -563,7 +563,7 @@ test_expect_success 'prompt - bash color pc mode - detached head' '
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
-	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}*${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -576,7 +576,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
-	printf "BEFORE: (\${__git_ps1_branch_name} ${c_green}+${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -590,7 +590,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
-	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}*${c_clear}${c_green}+${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}${c_green}+${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty index" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -605,7 +605,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
-	printf "BEFORE: (\${__git_ps1_branch_name} ${c_green}#${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -617,7 +617,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - befo
 '
 
 test_expect_success 'prompt - bash color pc mode - inside .git directory' '
-	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_green}GIT_DIR!${c_clear}" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nGIT_DIR!" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -631,7 +631,7 @@ test_expect_success 'prompt - bash color pc mode - inside .git directory' '
 '
 
 test_expect_success 'prompt - bash color pc mode - stash status indicator' '
-	printf "BEFORE: (\${__git_ps1_branch_name} ${c_lblue}\$${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmain" >expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
@@ -645,7 +645,7 @@ test_expect_success 'prompt - bash color pc mode - stash status indicator' '
 '
 
 test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
-	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}%%${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
-- 
2.36.1

