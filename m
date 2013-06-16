From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH/RFC 1/3] t9903: add tests for git-prompt pcmode
Date: Sun, 16 Jun 2013 14:32:10 -0300
Message-ID: <c4c2a37da989c8c39e8cd6be2370ce34dd0675a6.1371402672.git.erdavila@gmail.com>
References: <cover.1371402672.git.erdavila@gmail.com>
Cc: felipe.contreras@gmail.com, t.gummerer@gmail.com,
	artagnon@gmail.com, zoltan.klinger@gmail.com, hegge@resisty.net,
	martinerikwerner@gmail.com, s.oosthoek@xs4all.nl,
	gitster@pobox.com, jonathan@leto.net, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 19:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoGvD-0001ot-Du
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 19:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab3FPRjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 13:39:19 -0400
Received: from mail-ye0-f178.google.com ([209.85.213.178]:62647 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab3FPRjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 13:39:19 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jun 2013 13:39:18 EDT
Received: by mail-ye0-f178.google.com with SMTP id m15so711785yen.37
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=/3hdS/kbrya/uKU//KuNbQ5qsK+n1/GsONwubo9qoc4=;
        b=bGL+U5eL8DfosMzu0fBMD1l63orUCDvotdsijA0DFFgo3QavlBfqJP2rjy51+TKFmO
         TtpTonR4jCf1PWyTySPJixjYYl+ccINKjxYM0y2yVuAaGnsqZQO1Y9EO04nssUDAxV4Y
         dkxaBjwwxgQsjAakeEZGed6XZePPhtKD22/Lu2YwBJ7dFkoL5SpizSAw5T1CRd1X6sj9
         nG5JYdHJ5mLqFb7EGltOq+JNsYPI0yOi8TW82wWhAjadLOFttNbtmRAxO18mNeZ7Q7Bg
         HYUA1mhE2XSup1XiUjB/p1WoPP2DhmzRgBoMVOgIjuCbt69urvPxwmE95TqHffdpZBb2
         1tAQ==
X-Received: by 10.236.133.242 with SMTP id q78mr6260959yhi.78.1371403945820;
        Sun, 16 Jun 2013 10:32:25 -0700 (PDT)
Received: from localhost.localdomain ([177.18.63.49])
        by mx.google.com with ESMTPSA id s29sm18661561yhf.6.2013.06.16.10.32.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 10:32:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.440.g82707f8
In-Reply-To: <cover.1371402672.git.erdavila@gmail.com>
In-Reply-To: <cover.1371402672.git.erdavila@gmail.com>
References: <cover.1371402672.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228020>

git-prompt.sh lacks tests for PROMPT_COMMAND mode.

Add tests for:
* pcmode prompt without colors
* pcmode prompt with colors for bash
* pcmode prompt with colors for zsh

Having these tests enables an upcoming refactor in
a safe way.

Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
250	0	t/t9903-bash-prompt.sh
 t/t9903-bash-prompt.sh | 250 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 15521cc..ebca9de 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -535,4 +535,254 @@ test_expect_success 'prompt - format string starting with dash' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - pc mode' '
+	printf "BEFORE: (master):AFTER" > expected &&
+	printf "" > expected_output &&
+	(
+		__git_ps1 "BEFORE:" ":AFTER" > "$actual" &&
+		test_cmp expected_output "$actual" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - branch name' '
+	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" > expected &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" > "$actual"
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - detached head' '
+	printf "BEFORE: (\\\[\\\e[31m\\\](%s...)\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" $(git log -1 --format="%h" b1^) > expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
+	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[31m\\\]*\\\[\\\e[0m\\\]):AFTER" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
+	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[32m\\\]+\\\[\\\e[0m\\\]):AFTER" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
+	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[31m\\\]*\\\[\\\e[32m\\\]+\\\[\\\e[0m\\\]):AFTER" > expected &&
+	echo "dirty index" > file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	echo "dirty worktree" > file &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
+	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[32m\\\]#\\\[\\\e[0m\\\]):AFTER" > expected &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		cd otherrepo &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - inside .git directory' '
+	printf "BEFORE: (\\\[\\\e[32m\\\]GIT_DIR!\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		cd .git &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - stash status indicator' '
+	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[1;34m\\\]$\\\[\\\e[0m\\\]):AFTER" > expected &&
+	echo 2 >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	(
+		GIT_PS1_SHOWSTASHSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
+	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[31m\\\]%%\\\[\\\e[0m\\\]):AFTER" > expected &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - branch name' '
+	printf "BEFORE: (%%F{green}master%%f%%f):AFTER" > expected &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" > "$actual"
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - detached head' '
+	printf "BEFORE: (%%F{red}(%s...)%%f%%f):AFTER" $(git log -1 --format="%h" b1^) > expected &&
+	git checkout b1^ &&
+	test_when_finished "git checkout master" &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty worktree' '
+	printf "BEFORE: (%%F{green}master%%f %%F{red}*%%f):AFTER" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty index' '
+	printf "BEFORE: (%%F{green}master%%f %%F{green}+%%f):AFTER" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty index and worktree' '
+	printf "BEFORE: (%%F{green}master%%f %%F{red}*%%F{green}+%%f):AFTER" > expected &&
+	echo "dirty index" > file &&
+	test_when_finished "git reset --hard" &&
+	git add -u &&
+	echo "dirty worktree" > file &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - dirty status indicator - before root commit' '
+	printf "BEFORE: (%%F{green}master%%f %%F{green}#%%f):AFTER" > expected &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		cd otherrepo &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - inside .git directory' '
+	printf "BEFORE: (%%F{green}GIT_DIR!%%f%%f):AFTER" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		cd .git &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - stash status indicator' '
+	printf "BEFORE: (%%F{green}master%%f %%F{blue}$%%f):AFTER" > expected &&
+	echo 2 >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWSTASHSTATE=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color pc mode - untracked files status indicator' '
+	printf "BEFORE: (%%F{green}master%%f %%F{red}%%%%%%f):AFTER" > expected &&
+	(
+		ZSH_VERSION=5.0.0 &&
+		GIT_PS1_SHOWUNTRACKEDFILES=y &&
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 "BEFORE:" ":AFTER" &&
+		printf "%s" "$PS1" > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_done
-- 
1.8.3.1.440.g82707f8
