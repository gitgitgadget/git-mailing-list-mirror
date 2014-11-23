From: 0xAX <kuleshovmail@gmail.com>
Subject: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 19:56:21 +0600
Message-ID: <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 0xAX <kuleshovmail@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 14:57:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsXf6-0001do-5Y
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 14:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbaKWN45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 08:56:57 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:61206 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaKWN45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 08:56:57 -0500
Received: by mail-la0-f48.google.com with SMTP id s18so6329915lam.21
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 05:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OX6Oq6j+flvDbpf13s9Mlwo3uaye6ecvMFZSdlfge0w=;
        b=JNFbh8lPxNWGE+DPkK8kgP5ac1qk5XXv7RabDIIWCOyebL55kkZ3CqarhgUhHnnqXG
         R4i+Wc/b9KnWKPInVwwbl9kBvLx4iJ1wlvLU3PgK4wKbe5U99Vppz7vXgmzX4gaBXn/c
         gJoAZHbLpCJkkOpGB6TkCCzVmCb3SWomNF5vmy5GRU+y1kcgH42bE6B40+U7YbsMQlag
         +0wyNHiuJ9YvD87h32SJhu800MDV0pOcd5ix5LjxbQSNxI9gyIM2w82NN8Vj+LTxVGqb
         cD4PzrDfoakv9QX9LtLfl07s1D84zyV6+eQMNWfdrPtyXRObbc4DDkJbMgD2bJHoWNsg
         rT4A==
X-Received: by 10.112.157.194 with SMTP id wo2mr15352296lbb.55.1416751015460;
        Sun, 23 Nov 2014 05:56:55 -0800 (PST)
Received: from localhost.localdomain ([92.46.64.151])
        by mx.google.com with ESMTPSA id xh2sm2744689lbb.7.2014.11.23.05.56.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Nov 2014 05:56:54 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3.191.gfdea3f0
In-Reply-To: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260085>

Signed-off-by: 0xAX <kuleshovmail@gmail.com>
---
 exec_cmd.c | 25 ++++++++++++++++---------
 exec_cmd.h |  4 ++--
 git.c      | 12 +++++++++---
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 698e752..08f8f80 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -6,7 +6,7 @@
 static const char *argv_exec_path;
 static const char *argv0_path;
 
-const char *system_path(const char *path)
+char *system_path(const char *path)
 {
 #ifdef RUNTIME_PREFIX
 	static const char *prefix;
@@ -14,9 +14,10 @@ const char *system_path(const char *path)
 	static const char *prefix = PREFIX;
 #endif
 	struct strbuf d = STRBUF_INIT;
+	char *new_path = NULL;
 
 	if (is_absolute_path(path))
-		return path;
+		return strdup(path);
 
 #ifdef RUNTIME_PREFIX
 	assert(argv0_path);
@@ -32,10 +33,13 @@ const char *system_path(const char *path)
 				"Using static fallback '%s'.\n", prefix);
 	}
 #endif
-
 	strbuf_addf(&d, "%s/%s", prefix, path);
-	path = strbuf_detach(&d, NULL);
-	return path;
+	new_path = malloc((strlen(prefix) + strlen(path)) + 2);
+	sprintf(new_path, "%s/%s", prefix, path);
+
+	strbuf_release(&d);
+
+	return new_path;
 }
 
 const char *git_extract_argv0_path(const char *argv0)
@@ -68,16 +72,16 @@ void git_set_argv_exec_path(const char *exec_path)
 
 
 /* Returns the highest-priority, location to look for git programs. */
-const char *git_exec_path(void)
+char *git_exec_path(void)
 {
 	const char *env;
 
 	if (argv_exec_path)
-		return argv_exec_path;
+		return strdup(argv_exec_path);
 
 	env = getenv(EXEC_PATH_ENVIRONMENT);
 	if (env && *env) {
-		return env;
+		return strdup(env);
 	}
 
 	return system_path(GIT_EXEC_PATH);
@@ -96,7 +100,9 @@ void setup_path(void)
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;
 
-	add_path(&new_path, git_exec_path());
+	char *exec_path = git_exec_path();
+
+	add_path(&new_path, exec_path);
 	add_path(&new_path, argv0_path);
 
 	if (old_path)
@@ -107,6 +113,7 @@ void setup_path(void)
 	setenv("PATH", new_path.buf, 1);
 
 	strbuf_release(&new_path);
+	free(exec_path);
 }
 
 const char **prepare_git_cmd(const char **argv)
diff --git a/exec_cmd.h b/exec_cmd.h
index e4c9702..03c8599 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -3,12 +3,12 @@
 
 extern void git_set_argv_exec_path(const char *exec_path);
 extern const char *git_extract_argv0_path(const char *path);
-extern const char *git_exec_path(void);
+extern char *git_exec_path(void);
 extern void setup_path(void);
 extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
 extern int execl_git_cmd(const char *cmd, ...);
-extern const char *system_path(const char *path);
+extern char *system_path(const char *path);
 
 #endif /* GIT_EXEC_CMD_H */
diff --git a/git.c b/git.c
index 82d7a1c..499dc2a 100644
--- a/git.c
+++ b/git.c
@@ -99,13 +99,19 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
-			puts(system_path(GIT_HTML_PATH));
+			char *git_html_path = system_path(GIT_HTML_PATH);
+			puts(git_html_path);
+			free(git_html_path);
 			exit(0);
 		} else if (!strcmp(cmd, "--man-path")) {
-			puts(system_path(GIT_MAN_PATH));
+			char *git_man_path = system_path(GIT_MAN_PATH);
+			puts(git_man_path);
+			free(git_man_path);
 			exit(0);
 		} else if (!strcmp(cmd, "--info-path")) {
-			puts(system_path(GIT_INFO_PATH));
+			char *git_info_path = system_path(GIT_INFO_PATH);
+			puts(git_info_path);
+			free(git_info_path);
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
-- 
2.2.0.rc3.191.gfdea3f0
