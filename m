From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH v2 1/3] t9903: add tests for git-prompt pcmode
Date: Mon, 17 Jun 2013 23:15:41 -0300
Message-ID: <1371521743-9744-1-git-send-email-erdavila@gmail.com>
References: <7vhagxicu9.fsf@alter.siamese.dyndns.org>
Cc: felipe.contreras@gmail.com, t.gummerer@gmail.com,
	artagnon@gmail.com, zoltan.klinger@gmail.com, hegge@resisty.net,
	martinerikwerner@gmail.com, s.oosthoek@xs4all.nl,
	gitster@pobox.com, jonathan@leto.net, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:16:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolSy-0002Ld-RV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab3FRCQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 22:16:13 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:40849 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760Ab3FRCQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:16:11 -0400
Received: by mail-qc0-f170.google.com with SMTP id s1so2058079qcw.1
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 19:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RrXm604ELwGsjmbyjNrcrcVifZjz4KNlUOQGGR1PZhM=;
        b=UJkbWb6MmF6KqvafK3p+3RkkxqcwIl2f0RTHJ4NzVvoB7QJu3AWYd4Ov8C1h3QvmG3
         +kGcf71fJfrpanPhuw6dt5rZLFaUiTiV2nMd0pxGc0yhGy5lXOdVKCwPJ9crfIwJoaxc
         NPygENT8nm8LTbxr8q0phI1SCuMiM+5fTduGvfnVReK8ENXPxN/1yWFUyHEL9Qt5yCci
         vdmIy5hhA6mbz6KSiLIhxM38GyETXITgkNdyp28OUmJO/cNWT1T2ZTnMhvQHcv7OXtZw
         ousv4iO/0wHvBkkOBCz0D7ncLRP6DoL47dwNwd7X4FDE1hWT7QYLCX9YuA4Zf20uoLhK
         XssQ==
X-Received: by 10.224.187.198 with SMTP id cx6mr20157291qab.71.1371521771022;
        Mon, 17 Jun 2013 19:16:11 -0700 (PDT)
Received: from localhost.localdomain ([177.97.121.196])
        by mx.google.com with ESMTPSA id 15sm25222390qaa.9.2013.06.17.19.16.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 19:16:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.440.g82707f8
In-Reply-To: <7vhagxicu9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228130>

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
1.8.3.1.440.g82707f8
