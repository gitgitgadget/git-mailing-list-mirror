From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH v3 2/2] git: rewrite `git -a` to become a git-for-each-repo command
Date: Wed, 23 Jan 2013 20:59:40 +0100
Message-ID: <1358971180-10652-3-git-send-email-hjemli@gmail.com>
References: <1358971180-10652-1-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 21:00:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6Ul-0005kz-UD
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab3AWUAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:00:04 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:52559 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab3AWUAB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:00:01 -0500
Received: by mail-lb0-f179.google.com with SMTP id j14so1795988lbo.10
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 11:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Rkc1r3Zl9FdGNYC5UKFcu2BV+kG61cms2H+XGMNo5Lg=;
        b=hdYDpGAUb3SuccnC8UDwHNBTIwuPYwrk+MzYkIT60PRO7CDF280qbs5awJjj9vRlZ/
         SW0IelsTDb9zxpVCL1Iox0X+6Fg98BnSnSLRHCh+QVY+55R2GLrLiTZcPxC+MO7+YJKa
         GZ3MCxssBExfkxxoSv1G2HW3Z9IkWWx5L2np4tgb9YDgxefkK4C4svdIfF9V7T263JCj
         Hgn4f9Jp+3/GoYqhtPmblCMZNlLW+SNzSQBth2E0gDB2qCNAo8mjMlNtjW7Ga/sjbeEe
         eqlj11QJVqQyT61Qhe0pmO/1zGK3KOq9zhC2Wl3mzNE+cMA/9FsqcCMv6yYdoZYLFhvM
         HKBQ==
X-Received: by 10.112.10.3 with SMTP id e3mr1241794lbb.33.1358971199499;
        Wed, 23 Jan 2013 11:59:59 -0800 (PST)
Received: from slacko.getinternet.no (cm-84.212.47.55.getinternet.no. [84.212.47.55])
        by mx.google.com with ESMTPS id hc20sm8804885lab.11.2013.01.23.11.59.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 11:59:58 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.350.g3346805
In-Reply-To: <1358971180-10652-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214353>

With this rewriting, it is now possible to run e.g. `git -ad gui` to
start up git-gui in each repo within the current directory which
contains uncommited work.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git.c                    | 36 ++++++++++++++++++++++++++++++++++++
 t/t6400-for-each-repo.sh |  6 ++++++
 2 files changed, 42 insertions(+)

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
index 4797629..b501605 100755
--- a/t/t6400-for-each-repo.sh
+++ b/t/t6400-for-each-repo.sh
@@ -27,6 +27,8 @@ test_expect_success "without flags, all repos are included" '
 	echo "dirty-idx" >>expect &&
 	echo "dirty-wt" >>expect &&
 	git for-each-repo | sort >actual &&
+	test_cmp expect actual &&
+	git -a | sort >actual &&
 	test_cmp expect actual
 '
 
@@ -35,6 +37,8 @@ test_expect_success "--dirty only includes dirty repos" '
 	echo "dirty-idx" >>expect &&
 	echo "dirty-wt" >>expect &&
 	git for-each-repo --dirty | sort >actual &&
+	test_cmp expect actual &&
+	git -ad | sort >actual &&
 	test_cmp expect actual
 '
 
@@ -42,6 +46,8 @@ test_expect_success "--clean only includes clean repos" '
 	echo "." >expect &&
 	echo "clean" >>expect &&
 	git for-each-repo --clean | sort >actual &&
+	test_cmp expect actual &&
+	git -ac | sort >actual &&
 	test_cmp expect actual
 '
 
-- 
1.8.1.1.350.g3346805
