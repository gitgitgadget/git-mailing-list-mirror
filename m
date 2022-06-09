Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50F8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 11:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244970AbiFILrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbiFILqh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 07:46:37 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE6B1C04
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 04:44:35 -0700 (PDT)
Received: from Lorule.wifi.realnett.no (unknown [194.19.73.58])
        (Authenticated sender: joak-pet@online.no)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPA id 31B82521B6;
        Thu,  9 Jun 2022 13:44:30 +0200 (CEST)
From:   Joakim Petersen <joak-pet@online.no>
To:     git@vger.kernel.org
Cc:     Joakim Petersen <joak-pet@online.no>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v8] git-prompt: make colouring consistent
Date:   Thu,  9 Jun 2022 13:44:25 +0200
Message-Id: <20220609114425.15122-1-joak-pet@online.no>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607115024.64724-1-joak-pet@online.no>
References: <20220607115024.64724-1-joak-pet@online.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The short upstream state indicator inherits the colour of the last short
state indicator before it (if there is one), and the sparsity state
indicator inherits this colour as well. This behaviour was introduced by
0ec7c23cdc6 (git-prompt: make upstream state indicator location
consistent, 2022-02-27), while before this change the aforementioned
indicators were white/the default text colour. Some examples to
illustrate this behaviour (assuming all indicators are enabled and
colourization is on):
 * If there is something in the stash, both the '$' and the short
   upstream state indicator following it will be blue.
 * If the local tree has new, untracked files and there is nothing in
   the stash, both the '%' and the short upstream state indicator
   will be red.
 * If all local changes are added to the index and the stash is empty,
   both the '+' and the short upstream state indicator following it will
   be green.
 * If the local tree is clean and there is nothing in the stash, the
   short upstream state indicator will be white/${default text colour}.

This appears to be an unintended side-effect of the change, and makes
little sense semantically (e.g. why is it bad to be in sync with
upstream when you have uncommitted local changes?). The cause of the
change in colour is that previously, the short upstream state indicator
appeared immediately after the rebase/revert/bisect/merge state
indicator (note the position of $p in $gitstring):

	local f="$h$w$i$s$u"
	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
	
Said indicator is prepended with the clear colour code, and the short
upstream state indicator is thus also uncoloured. Now, the short
upstream state indicator follows the sequence of coloured indicators,
without any clearing of colour (again note the position of $p, now in
$f):

	local f="$h$w$i$s$u$p"
	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"

If the user is in a sparse checkout, the sparsity state indicator
follows a similar pattern to the short upstream state indicator.
However, clearing colour of the coloured indicators changes how the
sparsity state indicator is coloured, as it currently inherits (and
before the change referenced also inherited) the colour of the last
short state indicator before it. Reading the commit message of the
change that introduced the sparsity state indicator, afda36dbf3b
(git-prompt: include sparsity state as well, 2020-06-21), it appears
this colouring also was unintended, so clearing the colour for said
indicator further increases consistency.

Make the colouring of these state indicators consistent by making all
coloured indicators clear their own colour. Make colouring of $c
dependent on it not being empty, as it is no longer being used to colour
the branch name. Change $w to follow the same behaviour so changes to
its content don't change how it is coloured. Move clearing of $b's
prefix to before colouring so it gets cleared properly when colour codes
are inserted into it. These changes make changing the layout of the
prompt less prone to unintended colour changes in the future.

Change coloured Bash prompt tests to reflect the colourization changes:
 * Move the colour codes to wrap the expected content of the expanded
   $__git_ps1_branch_name in all tests.
 * Insert a clear-colour code after the symbol for the first indicator
   in "prompt - bash color pc mode - dirty status indicator - dirty
   index and worktree", to reflect that all indicators should clear
   their own colour.

Having each indicator clear its own colour lessens the cost of
refactoring the prompt layout, as the outcome of colouring becomes
independent on the position of indicators in the final prompt.

Signed-off-by: Joakim Petersen <joak-pet@online.no>
---
Changes since v7:
 * Fixed branch name ($b) not being coloured, but rather having its
   colour codes printed as text.
 * Added mention of the change to the check for whether to colour $w.
 * Replaced use of "colourize" and derivatives in the message with
   "colour".

Range-diff against v7:
1:  50765eeb95 ! 1:  1082f46b4c git-prompt: make colourization consistent
    @@ contrib/completion/git-prompt.sh: __git_ps1_colorize_gitstring ()
      
      # Helper function to read the first line of a file into a variable.
     @@ contrib/completion/git-prompt.sh: __git_ps1 ()
    - 		fi
      	fi
      
    -+	b=${b##refs/heads/}
      	local z="${GIT_PS1_STATESEPARATOR-" "}"
    ++	b=${b##refs/heads/}
    ++	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
    ++		__git_ps1_branch_name=$b
    ++		b="\${__git_ps1_branch_name}"
    ++	fi
    ++
      
      	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
    + 	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
     @@ contrib/completion/git-prompt.sh: __git_ps1 ()
      		fi
      	fi
      
     -	b=${b##refs/heads/}
    - 	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
    - 		__git_ps1_branch_name=$b
    - 		b="\${__git_ps1_branch_name}"
    +-	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
    +-		__git_ps1_branch_name=$b
    +-		b="\${__git_ps1_branch_name}"
    +-	fi
    +-
    + 	local f="$h$w$i$s$u$p"
    + 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
    + 
     
      ## t/t9903-bash-prompt.sh ##
     @@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - pc mode' '

 contrib/completion/git-prompt.sh | 32 +++++++++++++++++---------------
 t/t9903-bash-prompt.sh           | 18 +++++++++---------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 87b2b916c0..44bfc7972e 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -245,7 +245,8 @@ __git_ps1_show_upstream ()
 
 # Helper function that is meant to be called from __git_ps1.  It
 # injects color codes into the appropriate gitstring variables used
-# to build a gitstring.
+# to build a gitstring. Colored variables are responsible for clearing
+# their own color.
 __git_ps1_colorize_gitstring ()
 {
 	if [[ -n ${ZSH_VERSION-} ]]; then
@@ -271,22 +272,23 @@ __git_ps1_colorize_gitstring ()
 	else
 		branch_color="$bad_color"
 	fi
-	c="$branch_color$c"
+	if [ -n "$c" ]; then
+		c="$branch_color$c$c_clear"
+	fi
+	b="$branch_color$b$c_clear"
 
-	z="$c_clear$z"
-	if [ "$w" = "*" ]; then
-		w="$bad_color$w"
+	if [ -n "$w" ]; then
+		w="$bad_color$w$c_clear"
 	fi
 	if [ -n "$i" ]; then
-		i="$ok_color$i"
+		i="$ok_color$i$c_clear"
 	fi
 	if [ -n "$s" ]; then
-		s="$flags_color$s"
+		s="$flags_color$s$c_clear"
 	fi
 	if [ -n "$u" ]; then
-		u="$bad_color$u"
+		u="$bad_color$u$c_clear"
 	fi
-	r="$c_clear$r"
 }
 
 # Helper function to read the first line of a file into a variable.
@@ -555,6 +557,12 @@ __git_ps1 ()
 	fi
 
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
+	b=${b##refs/heads/}
+	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+		__git_ps1_branch_name=$b
+		b="\${__git_ps1_branch_name}"
+	fi
+
 
 	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
 	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
@@ -563,12 +571,6 @@ __git_ps1 ()
 		fi
 	fi
 
-	b=${b##refs/heads/}
-	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
-		__git_ps1_branch_name=$b
-		b="\${__git_ps1_branch_name}"
-	fi
-
 	local f="$h$w$i$s$u$p"
 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
 
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index bbd513bab0..abd82eec35 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -541,7 +541,7 @@ test_expect_success 'prompt - pc mode' '
 '
 
 test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmain" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_green}main${c_clear}" >expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
@@ -551,7 +551,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - bash color pc mode - detached head' '
-	printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_red}(%s...)"${c_clear} $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout main" &&
 	(
@@ -563,7 +563,7 @@ test_expect_success 'prompt - bash color pc mode - detached head' '
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmain" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}*${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -576,7 +576,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmain" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name} ${c_green}+${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -590,7 +590,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmain" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}*${c_clear}${c_green}+${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
 	echo "dirty index" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -605,7 +605,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmain" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name} ${c_green}#${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -617,7 +617,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - befo
 '
 
 test_expect_success 'prompt - bash color pc mode - inside .git directory' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nGIT_DIR!" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_green}GIT_DIR!${c_clear}" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -631,7 +631,7 @@ test_expect_success 'prompt - bash color pc mode - inside .git directory' '
 '
 
 test_expect_success 'prompt - bash color pc mode - stash status indicator' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmain" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name} ${c_lblue}\$${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
@@ -645,7 +645,7 @@ test_expect_success 'prompt - bash color pc mode - stash status indicator' '
 '
 
 test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmain" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}%%${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
-- 
2.36.1

