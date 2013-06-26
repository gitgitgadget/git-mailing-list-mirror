From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH v2 1/5] t9903: add tests for git-prompt pcmode
Date: Wed, 26 Jun 2013 00:05:13 -0300
Message-ID: <76906ef44cb50773cd4965ee83cfd62255640553.1372211661.git.erdavila@gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, "Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 05:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urg4i-0004p8-2p
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 05:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab3FZDHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 23:07:09 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:35578 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3FZDHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 23:07:07 -0400
Received: by mail-yh0-f45.google.com with SMTP id b20so6124211yha.4
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 20:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=2n+6XfK4EKoWlgI6+4/2lFAp0ms8yzYgvL2gqfZS/Qs=;
        b=TwCcUDbOf2Xw+SaW31WKP+oRiurmDAANfg97QRYZKePWVJQ/U0jC5qqf8KXo4hmqk2
         qVF4BCVxKl/DlzmRR9bJ/KhwjzRrxnTj2+FZRI+q3Bptb67GfhFRujDpvmf6Dy7dPwZy
         elzKEZixIuL52VJIVwsgf6rNfF65HHnZukMufFmI6QsE/v07ScD/OsZiuIzPw7o4JA44
         pC672kG/H735kuOS4CEDay/K3y/77HHIIUxOA92SlhXvYZRAAytfiC4YbCP/spvPoPNq
         jbx6zWs/4oeQ3ml4DT2yn0o3Ae36zYyz1BpW6oeJIgUw4VBFmI2wZfYqbVZOEaj+szem
         CnzQ==
X-Received: by 10.236.182.167 with SMTP id o27mr985033yhm.153.1372216027035;
        Tue, 25 Jun 2013 20:07:07 -0700 (PDT)
Received: from localhost.localdomain (200.175.80.235.dynamic.adsl.gvt.net.br. [200.175.80.235])
        by mx.google.com with ESMTPSA id y70sm42415518yhe.15.2013.06.25.20.07.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 20:07:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.590.g42a98dd
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com>
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229022>

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
1.8.3.1.590.g42a98dd
