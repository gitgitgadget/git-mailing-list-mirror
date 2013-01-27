From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v4 2/2] git: rewrite `git -a` to become a git-for-each-repo command
Date: Sun, 27 Jan 2013 13:46:17 +0100
Message-ID: <1359290777-5483-3-git-send-email-hjemli@gmail.com>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 13:47:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzRdX-0004In-Lc
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 13:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab3A0Mqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 07:46:38 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40282 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696Ab3A0Mqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 07:46:37 -0500
Received: by mail-lb0-f170.google.com with SMTP id ge1so2802456lbb.29
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 04:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XS9MyzKOLzGa3RVuc6qdGVVx38tZikNvWt4PA5mcfck=;
        b=0HFIEjxuSYSHXSnFFAUc8qT65UTyP+HcKicoG0hv4cRBQIdLKYPSRYAlHiYSJHnwF4
         wTcDOxtrBIut42YUk1GmpLmUUZa9gJXvqF0dLaZD+kZrys8JiYCrbjKzSjQyvrCyEb+E
         QGHkKSnRQ/2wdbEtDCLmDXOgeC27YwFvAG97Z8+yk4mEkJNs+18uHCowH+Ld5o2zOye1
         ZZRwqj4xqTi/PiCgzSZIgfxTdSMtiqTqTm7DjiMYlru4X63hWn1eJW61vHU5ARyBP/iX
         W24guOq9X9XcyoJoDGDqzcfbpVaPMvh+6Jipsc+YRDmXOwUp3oQBKz1PqCqLqYIi6soB
         t48A==
X-Received: by 10.152.105.103 with SMTP id gl7mr10225515lab.41.1359290795635;
        Sun, 27 Jan 2013 04:46:35 -0800 (PST)
Received: from slacktop.getinternet.no (cm-84.212.47.55.getinternet.no. [84.212.47.55])
        by mx.google.com with ESMTPS id tm10sm2326630lab.10.2013.01.27.04.46.34
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 04:46:34 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.349.g4cdd23e
In-Reply-To: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214696>

With this rewriting, it is now possible to run e.g. `git -ad gui` to
start up git-gui in each repo within the current directory which
contains uncommited work.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git.c                    | 36 +++++++++++++++++++++++++++
 t/t6400-for-each-repo.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/git.c b/git.c
index 6b53169..f933b5d 100644
--- a/git.c
+++ b/git.c
@@ -31,8 +31,42 @@ static void commit_pager_choice(void) {
 	}
 }
 
+/*
+ * Rewrite 'git -ad status' to 'git for-each-repo -d status'
+ */
+static int rewrite_foreach_repo(const char ***orig_argv,
+				const char **curr_argv,
+				int *curr_argc)
+{
+	const char **new_argv;
+	char *tmp;
+	int new_argc, curr_pos, i, j;
+
+	curr_pos = curr_argv - *orig_argv;
+	if (strlen(curr_argv[0]) == 2) {
+		curr_argv[0] = "for-each-repo";
+		return curr_pos - 1;
+	}
+
+	new_argc = curr_pos + *curr_argc + 1;
+	new_argv = xmalloc(new_argc * sizeof(void *));
+	for (i = j = 0; j < new_argc; i++, j++) {
+		if (i == curr_pos) {
+			asprintf(&tmp, "-%s", (*orig_argv)[i] + 2);
+			new_argv[j] = "for-each-repo";
+			new_argv[++j] = tmp;
+		} else {
+			new_argv[j] = (*orig_argv)[i];
+		}
+	}
+	*orig_argv = new_argv;
+	(*curr_argc)++;
+	return curr_pos;
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
+	const char ***pargv = argv;
 	const char **orig_argv = *argv;
 
 	while (*argc > 0) {
@@ -143,6 +177,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strncmp(cmd, "-a", 2)) {
+			return rewrite_foreach_repo(pargv, *argv, argc);
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/t/t6400-for-each-repo.sh b/t/t6400-for-each-repo.sh
index af02c0c..eaa4518 100755
--- a/t/t6400-for-each-repo.sh
+++ b/t/t6400-for-each-repo.sh
@@ -147,4 +147,67 @@ test_expect_success "-dx executes any command in dirty repos" '
 	test_cmp expect actual
 '
 
+test_expect_success "rewrite 'git -a'" '
+	echo "." >expect &&
+	echo "clean" >>expect &&
+	echo "clean/gitfile" >>expect &&
+	echo "dirty-idx" >>expect &&
+	echo "dirty-wt" >>expect &&
+	echo "$qqname" >>expect &&
+	git -a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "rewrite 'git -az'" '
+	echo "(.)" >expect &&
+	echo "(clean)" >>expect &&
+	echo "(clean/gitfile)" >>expect &&
+	echo "(dirty-idx)" >>expect &&
+	echo "(dirty-wt)" >>expect &&
+	echo "($qname)" >>expect &&
+	git -az | xargs -0 printf "(%s)\n"  >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "rewrite 'git -ad'" '
+	echo "clean/gitfile" >expect &&
+	echo "dirty-idx" >>expect &&
+	echo "dirty-wt" >>expect &&
+	git -ad >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "rewrite 'git -ac'" '
+	echo "." >expect &&
+	echo "clean" >>expect &&
+	echo "$qqname" >>expect &&
+	git -ac >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "rewrite 'git -a status -suno'" '
+	echo "[.]" >expect &&
+	echo "[clean]" >>expect &&
+	echo "[clean/gitfile]" >>expect &&
+	echo " M foo2.t" >>expect &&
+	echo "[dirty-idx]" >>expect &&
+	echo "D  foo3.t" >>expect &&
+	echo "[dirty-wt]" >>expect &&
+	echo " D foo4.t" >> expect
+	echo "[$qname]" >>expect &&
+	git -a status -suno >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "rewrite 'git -acx pwd'" '
+	echo "[.]" >expect &&
+	echo "$HOME" >>expect &&
+	echo "[clean]" >>expect &&
+	echo "$HOME/clean" >>expect &&
+	echo "[$qname]" >>expect &&
+	echo "$HOME/$qname" >>expect &&
+	git -acx pwd >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.1.1.349.g4cdd23e
