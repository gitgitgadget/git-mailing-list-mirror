From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH 1/4] t9903: add tests for git-prompt pcmode
Date: Thu, 20 Jun 2013 23:25:26 -0300
Message-ID: <3dd104f19a995081d8c8bf89bc9e33052077e052.1371780085.git.erdavila@gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com>
Cc: felipe.contreras@gmail.com, artagnon@gmail.com,
	s.oosthoek@xs4all.nl, gitster@pobox.com, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 04:26:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upr3h-0006YR-T6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 04:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758025Ab3FUC0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 22:26:37 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:34618 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757600Ab3FUC0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 22:26:36 -0400
Received: by mail-yh0-f51.google.com with SMTP id l109so2906111yhq.38
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=7uQv9wwucejxblK8d8q0SQp4VNNEg3D0trgUmG8JQI0=;
        b=ljY95O8w67/KjdU0kF3V4I/A6ACO2rdj3jf2eROvNJWq27tu7OeRpNTmoDIkn111hj
         bv05Ppg91VuY7H6RHAMO5oEX+yJL6kyWtpoF5SVDbNz1aO/RPkfcVH2k7TabQ/MLw6BQ
         LmH7kVWQipi3mtMoqQYZYl6tN8puxGNhGCEq9wqLsS0Vggu0UpdOVMCztSKETahQSoR7
         dMhqIxmX1eH1l/qrwwoJ7JCkDstBjEpb19M/JcoCs1HoKxcUZPYNI8c2c/NRDRLn8JkJ
         MpeNx9o34eN5G0hoxCeY1t/+Z4t/MdpzHDOX4gdwUAWfDwFhltb+Kbu5Q/DJNAQlqMFK
         YIxw==
X-Received: by 10.236.141.134 with SMTP id g6mr6404675yhj.81.1371781595853;
        Thu, 20 Jun 2013 19:26:35 -0700 (PDT)
Received: from localhost.localdomain (201.86.243.62.dynamic.adsl.gvt.net.br. [201.86.243.62])
        by mx.google.com with ESMTPSA id s65sm4968400yhs.14.2013.06.20.19.26.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 19:26:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.g28387b2
In-Reply-To: <cover.1371780085.git.erdavila@gmail.com>
In-Reply-To: <cover.1371780085.git.erdavila@gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228563>

git-prompt.sh lacks tests for PROMPT_COMMAND mode.

Add tests for:
* pcmode prompt without colors
* pcmode prompt with colors for bash
* pcmode prompt with colors for zsh

Having these tests enables an upcoming refactor in
a safe way.

Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
254	0	t/t9903-bash-prompt.sh
 t/t9903-bash-prompt.sh | 254 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 15521cc..6a88778 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -10,6 +10,10 @@ test_description='test git-specific bash prompt functions'
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
+c_red='\\[\\e[31m\\]'
+c_green='\\[\\e[32m\\]'
+c_lblue='\\[\\e[1;34m\\]'
+c_clear='\\[\\e[0m\\]'
 
 test_expect_success 'setup for prompt tests' '
 	mkdir -p subdir/subsubdir &&
@@ -535,4 +539,254 @@ test_expect_success 'prompt - format string starting with dash' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - pc mode' '
+	printf "BEFORE: (master):AFTER" >expected &&
+	printf "" >expected_output &&
+	(
+		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
+		test_cmp expected_output "$actual" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - branch name' '
+	printf "BEFORE: (${c_green}master${c_clear}${c_clear}):AFTER" >expected &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" >"$actual"
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - detached head' '
+	printf "BEFORE: (${c_red}(%s...)${c_clear}${c_clear}):AFTER" $(git log -1 --format="%h" b1^) >expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
+	printf "BEFORE: (${c_green}master${c_clear} ${c_red}*${c_clear}):AFTER" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
+	printf "BEFORE: (${c_green}master${c_clear} ${c_green}+${c_clear}):AFTER" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
+	printf "BEFORE: (${c_green}master${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER" >expected &&
+	echo "dirty index" >file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	echo "dirty worktree" >file &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
+	printf "BEFORE: (${c_green}master${c_clear} ${c_green}#${c_clear}):AFTER" >expected &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		cd otherrepo &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - inside .git directory' '
+	printf "BEFORE: (${c_green}GIT_DIR!${c_clear}${c_clear}):AFTER" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		cd .git &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - stash status indicator' '
+	printf "BEFORE: (${c_green}master${c_clear} ${c_lblue}\$${c_clear}):AFTER" >expected &&
+	echo 2 >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	(
+		GIT_PS1_SHOWSTASHSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
+	printf "BEFORE: (${c_green}master${c_clear} ${c_red}%%${c_clear}):AFTER" >expected &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - branch name' '
+	printf "BEFORE: (%%F{green}master%%f%%f):AFTER" >expected &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" >"$actual"
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - detached head' '
+	printf "BEFORE: (%%F{red}(%s...)%%f%%f):AFTER" $(git log -1 --format="%h" b1^) >expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty worktree' '
+	printf "BEFORE: (%%F{green}master%%f %%F{red}*%%f):AFTER" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty index' '
+	printf "BEFORE: (%%F{green}master%%f %%F{green}+%%f):AFTER" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty index and worktree' '
+	printf "BEFORE: (%%F{green}master%%f %%F{red}*%%F{green}+%%f):AFTER" >expected &&
+	echo "dirty index" >file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	echo "dirty worktree" >file &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - dirty status indicator - before root commit' '
+	printf "BEFORE: (%%F{green}master%%f %%F{green}#%%f):AFTER" >expected &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		cd otherrepo &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - inside .git directory' '
+	printf "BEFORE: (%%F{green}GIT_DIR!%%f%%f):AFTER" >expected &&
+	echo "dirty" >file &&
+	test_when_finished "git reset --hard" &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		cd .git &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - stash status indicator' '
+	printf "BEFORE: (%%F{green}master%%f %%F{blue}$%%f):AFTER" >expected &&
+	echo 2 >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWSTASHSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - untracked files status indicator' '
+	printf "BEFORE: (%%F{green}master%%f %%F{red}%%%%%%f):AFTER" >expected &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWUNTRACKEDFILES=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_done
-- 
1.8.3.1.487.g28387b2
