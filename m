From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH v2 2/3] git-prompt.sh: refactor colored prompt code
Date: Mon, 17 Jun 2013 23:16:51 -0300
Message-ID: <1371521811-9819-1-git-send-email-erdavila@gmail.com>
References: <7vhagxicu9.fsf@alter.siamese.dyndns.org>
Cc: felipe.contreras@gmail.com, t.gummerer@gmail.com,
	artagnon@gmail.com, zoltan.klinger@gmail.com, hegge@resisty.net,
	martinerikwerner@gmail.com, s.oosthoek@xs4all.nl,
	gitster@pobox.com, jonathan@leto.net, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:17:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolTw-0004XP-QV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843Ab3FRCRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 22:17:13 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:51148 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3FRCRM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:17:12 -0400
Received: by mail-qc0-f172.google.com with SMTP id j10so2003847qcx.17
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jgYt5gppCIW2iO2IjETFT8EZiRdqCLX/ubSmx8QBU3o=;
        b=DwvUYn4/EmFsvTrdjhtw8Exae8QnqR9ziv0YizfvJkUgxt9ba1Lt4C1VK0Y1PadTjf
         pIA8aROdIuNuR+fI3uJvPu73pltx6XkNrfibUVxi3tV6LYPWIvtJP1FqTtQ6/qwE+/vV
         S9SD9LgKwE0Ycg5mFDG66aFX3t/RluLpTGf2asci4qrkPA3FoRfwjNsbKCBCfbGj25xr
         kuLvfMGJrhEYHbPGjtmdVuchJmEBcwJEfVz61a5uDrndnc4/bieQSKMrvlpJv/BPJbTu
         0te78AZlzr7UcLyVwlndttk29/A7sVNae43lz/43DnqZYtHn69X49TKDsS8rO/0jwT/4
         UiRw==
X-Received: by 10.224.174.6 with SMTP id r6mr20467674qaz.87.1371521831764;
        Mon, 17 Jun 2013 19:17:11 -0700 (PDT)
Received: from localhost.localdomain ([177.97.121.196])
        by mx.google.com with ESMTPSA id gn4sm25236019qab.8.2013.06.17.19.17.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 19:17:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.440.g82707f8
In-Reply-To: <7vhagxicu9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228131>

__git_ps1_colorize_gitstring() sets color codes and
builds the prompt gitstring. It has duplicated code
to handle color codes for bash and zsh shells.
__git_ps1() also has duplicated logic to build the
prompt gitstring.

Remove duplication of logic to build gitstring in
__git_ps1_colorize_gitstring() and __git_ps1().

Leave in __git_ps1_colorize_gitstring() only logic
to set color codes.

Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
26	59	contrib/completion/git-prompt.sh
6	6	t/t9903-bash-prompt.sh
 contrib/completion/git-prompt.sh | 85 ++++++++++++----------------------------
 t/t9903-bash-prompt.sh           | 12 +++---
 2 files changed, 32 insertions(+), 65 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 86a4f3f..70515cc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -225,8 +225,8 @@ __git_ps1_show_upstream ()
 }
 
 # Helper function that is meant to be called from __git_ps1.  It
-# builds up a gitstring injecting color codes into the appropriate
-# places.
+# injects color codes into the appropriate gitstring variables used
+# to build a gitstring.
 __git_ps1_colorize_gitstring ()
 {
 	if [[ -n ${ZSH_VERSION-} ]]; then
@@ -234,74 +234,40 @@ __git_ps1_colorize_gitstring ()
 		local c_green='%F{green}'
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
-		local bad_color=$c_red
-		local ok_color=$c_green
-		local branch_color="$c_clear"
-		local flags_color="$c_lblue"
-		local branchstring="$c${b##refs/heads/}"
-
-		if [ $detached = no ]; then
-			branch_color="$ok_color"
-		else
-			branch_color="$bad_color"
-		fi
-
-		gitstring="$branch_color$branchstring$c_clear"
-
-		if [ -n "$w$i$s$u$r$p" ]; then
-			gitstring="$gitstring$z"
-		fi
-		if [ "$w" = "*" ]; then
-			gitstring="$gitstring$bad_color$w"
-		fi
-		if [ -n "$i" ]; then
-			gitstring="$gitstring$ok_color$i"
-		fi
-		if [ -n "$s" ]; then
-			gitstring="$gitstring$flags_color$s"
-		fi
-		if [ -n "$u" ]; then
-			gitstring="$gitstring$bad_color$u"
-		fi
-		gitstring="$gitstring$c_clear$r$p"
-		return
+	else
+		# Using \[ and \] around colors
+		# is necessary to prevent wrapping issues!
+		local c_red='\[\e[31m\]'
+		local c_green='\[\e[32m\]'
+		local c_lblue='\[\e[1;34m\]'
+		local c_clear='\[\e[0m\]'
 	fi
-	local c_red='\e[31m'
-	local c_green='\e[32m'
-	local c_lblue='\e[1;34m'
-	local c_clear='\e[0m'
 	local bad_color=$c_red
 	local ok_color=$c_green
-	local branch_color="$c_clear"
 	local flags_color="$c_lblue"
-	local branchstring="$c${b##refs/heads/}"
 
+	local branch_color=""
 	if [ $detached = no ]; then
 		branch_color="$ok_color"
 	else
 		branch_color="$bad_color"
 	fi
+	c="$branch_color$c"
 
-	# Setting gitstring directly with \[ and \] around colors
-	# is necessary to prevent wrapping issues!
-	gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
-
-	if [ -n "$w$i$s$u$r$p" ]; then
-		gitstring="$gitstring$z"
-	fi
+	z="$c_clear$z"
 	if [ "$w" = "*" ]; then
-		gitstring="$gitstring\[$bad_color\]$w"
+		w="$bad_color$w"
 	fi
 	if [ -n "$i" ]; then
-		gitstring="$gitstring\[$ok_color\]$i"
+		i="$ok_color$i"
 	fi
 	if [ -n "$s" ]; then
-		gitstring="$gitstring\[$flags_color\]$s"
+		s="$flags_color$s"
 	fi
 	if [ -n "$u" ]; then
-		gitstring="$gitstring\[$bad_color\]$u"
+		u="$bad_color$u"
 	fi
-	gitstring="$gitstring\[$c_clear\]$r$p"
+	r="$c_clear$r"
 }
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
@@ -443,19 +409,20 @@ __git_ps1 ()
 		fi
 
 		local z="${GIT_PS1_STATESEPARATOR-" "}"
+
+		# NO color option unless in PROMPT_COMMAND mode
+		if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+			__git_ps1_colorize_gitstring
+		fi
+
 		local f="$w$i$s$u"
+		local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
+
 		if [ $pcmode = yes ]; then
-			local gitstring=
-			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-				__git_ps1_colorize_gitstring
-			else
-				gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
-			fi
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 			PS1="$ps1pc_start$gitstring$ps1pc_end"
 		else
-			# NO color option unless in PROMPT_COMMAND mode
-			printf -- "$printf_format" "$c${b##refs/heads/}${f:+$z$f}$r$p"
+			printf -- "$printf_format" "$gitstring"
 		fi
 	fi
 }
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6a88778..1101adf 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -551,7 +551,7 @@ test_expect_success 'prompt - pc mode' '
 '
 
 test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (${c_green}master${c_clear}${c_clear}):AFTER" >expected &&
+	printf "BEFORE: (${c_green}master${c_clear}):AFTER" >expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual"
@@ -561,7 +561,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - bash color pc mode - detached head' '
-	printf "BEFORE: (${c_red}(%s...)${c_clear}${c_clear}):AFTER" $(git log -1 --format="%h" b1^) >expected &&
+	printf "BEFORE: (${c_red}(%s...)${c_clear}):AFTER" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
@@ -627,7 +627,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - befo
 '
 
 test_expect_success 'prompt - bash color pc mode - inside .git directory' '
-	printf "BEFORE: (${c_green}GIT_DIR!${c_clear}${c_clear}):AFTER" >expected &&
+	printf "BEFORE: (${c_green}GIT_DIR!${c_clear}):AFTER" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -666,7 +666,7 @@ test_expect_success 'prompt - bash color pc mode - untracked files status indica
 '
 
 test_expect_success 'prompt - zsh color pc mode - branch name' '
-	printf "BEFORE: (%%F{green}master%%f%%f):AFTER" >expected &&
+	printf "BEFORE: (%%F{green}master%%f):AFTER" >expected &&
 	(
 		ZSH_VERSION=5.0.0 &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -677,7 +677,7 @@ test_expect_success 'prompt - zsh color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - zsh color pc mode - detached head' '
-	printf "BEFORE: (%%F{red}(%s...)%%f%%f):AFTER" $(git log -1 --format="%h" b1^) >expected &&
+	printf "BEFORE: (%%F{red}(%s...)%%f):AFTER" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
@@ -748,7 +748,7 @@ test_expect_success 'prompt - zsh color pc mode - dirty status indicator - befor
 '
 
 test_expect_success 'prompt - zsh color pc mode - inside .git directory' '
-	printf "BEFORE: (%%F{green}GIT_DIR!%%f%%f):AFTER" >expected &&
+	printf "BEFORE: (%%F{green}GIT_DIR!%%f):AFTER" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
-- 
1.8.3.1.440.g82707f8
