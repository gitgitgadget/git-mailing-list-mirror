From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH/RFC 2/3] git-prompt.sh: refactor colored prompt code
Date: Sun, 16 Jun 2013 14:32:11 -0300
Message-ID: <4e4fb1731cc8e7890d917fa4d3d6b522a46989ff.1371402672.git.erdavila@gmail.com>
References: <cover.1371402672.git.erdavila@gmail.com>
Cc: felipe.contreras@gmail.com, t.gummerer@gmail.com,
	artagnon@gmail.com, zoltan.klinger@gmail.com, hegge@resisty.net,
	martinerikwerner@gmail.com, s.oosthoek@xs4all.nl,
	gitster@pobox.com, jonathan@leto.net, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 19:32:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoGoq-00009v-3j
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 19:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381Ab3FPRci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 13:32:38 -0400
Received: from mail-gh0-f182.google.com ([209.85.160.182]:59356 "EHLO
	mail-gh0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347Ab3FPRc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 13:32:29 -0400
Received: by mail-gh0-f182.google.com with SMTP id z15so714330ghb.41
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=856BiZf4+rO9w9927xhCpA/xhpd0xDMjZSX26KINNLc=;
        b=MDp0UzfS+dqmzyi55yCrDVIrqSgwy1LU0TFaMp/cnvLQ1Vo49bbgUOuD5wFB/OR5ys
         FstuxP8+zh6lzbTsvY7n/T1hSlkYW6W4RvdjRhGSBB7+djIQ5uUh6PM6Aj3MrqCTC9WT
         uUsflPYV0N+goh5kLrxH0g9vvrA9ZrIqKULnXdsqJwRQMvYwToWT9EfInrLqGPMaziv1
         v3WnvPedId6F51Q2PKq3J/MMeeBkqqZ+pVslEOFnLTKWrzCFFGHPW5AeVKK6jYbtWRUo
         zMaAXck6sR7zxSy3h81g4TZr1QFROq8+aiWU7TuIHDXzOjOB2HIC3w4nzGogXcZb5loZ
         AYbw==
X-Received: by 10.236.230.40 with SMTP id i38mr6543864yhq.170.1371403949164;
        Sun, 16 Jun 2013 10:32:29 -0700 (PDT)
Received: from localhost.localdomain ([177.18.63.49])
        by mx.google.com with ESMTPSA id s29sm18661561yhf.6.2013.06.16.10.32.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 10:32:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.440.g82707f8
In-Reply-To: <cover.1371402672.git.erdavila@gmail.com>
In-Reply-To: <cover.1371402672.git.erdavila@gmail.com>
References: <cover.1371402672.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228018>

Remove duplication of logic to build gitstring.

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
index ebca9de..22484c1 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -547,7 +547,7 @@ test_expect_success 'prompt - pc mode' '
 '
 
 test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" > expected &&
+	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\]):AFTER" > expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" > "$actual"
@@ -557,7 +557,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - bash color pc mode - detached head' '
-	printf "BEFORE: (\\\[\\\e[31m\\\](%s...)\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" $(git log -1 --format="%h" b1^) > expected &&
+	printf "BEFORE: (\\\[\\\e[31m\\\](%s...)\\\[\\\e[0m\\\]):AFTER" $(git log -1 --format="%h" b1^) > expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
@@ -623,7 +623,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - befo
 '
 
 test_expect_success 'prompt - bash color pc mode - inside .git directory' '
-	printf "BEFORE: (\\\[\\\e[32m\\\]GIT_DIR!\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" > expected &&
+	printf "BEFORE: (\\\[\\\e[32m\\\]GIT_DIR!\\\[\\\e[0m\\\]):AFTER" > expected &&
 	echo "dirty" > file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -662,7 +662,7 @@ test_expect_success 'prompt - bash color pc mode - untracked files status indica
 '
 
 test_expect_success 'prompt - zsh color pc mode - branch name' '
-	printf "BEFORE: (%%F{green}master%%f%%f):AFTER" > expected &&
+	printf "BEFORE: (%%F{green}master%%f):AFTER" > expected &&
 	(
 		ZSH_VERSION=5.0.0 &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -673,7 +673,7 @@ test_expect_success 'prompt - zsh color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - zsh color pc mode - detached head' '
-	printf "BEFORE: (%%F{red}(%s...)%%f%%f):AFTER" $(git log -1 --format="%h" b1^) > expected &&
+	printf "BEFORE: (%%F{red}(%s...)%%f):AFTER" $(git log -1 --format="%h" b1^) > expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
@@ -744,7 +744,7 @@ test_expect_success 'prompt - zsh color pc mode - dirty status indicator - befor
 '
 
 test_expect_success 'prompt - zsh color pc mode - inside .git directory' '
-	printf "BEFORE: (%%F{green}GIT_DIR!%%f%%f):AFTER" > expected &&
+	printf "BEFORE: (%%F{green}GIT_DIR!%%f):AFTER" > expected &&
 	echo "dirty" > file &&
 	test_when_finished "git reset --hard" &&
 	(
-- 
1.8.3.1.440.g82707f8
