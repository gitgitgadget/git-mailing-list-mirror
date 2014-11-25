From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/1] change contract between system_path and it's callers
Date: Wed, 26 Nov 2014 00:24:14 +0600
Message-ID: <1416939854-29930-1-git-send-email-kuleshovmail@gmail.com>
References: <CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 19:24:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtKmv-0002U6-7F
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 19:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaKYSY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 13:24:29 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33167 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbaKYSY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 13:24:27 -0500
Received: by mail-lb0-f174.google.com with SMTP id w7so1071628lbi.19
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkdtjgVr14CgmQasWZXCDcio8BMEAKF/1PYi+tSSsz4=;
        b=lNga6W3NLsqucRwjilIApk3S5RMxD0jEM0Uc9QJ3pktNRQXI7sKd/auTytPWKjVxxT
         tW15jHm9UX/I6tmUFrzJX1vXUS6f7AGRCRX4/lUMusj+9zCRAvrmkkGXrZl9kbbfKdSo
         yRzLgyBjZLg6Zgh94H+ByXVhf6beTSN+emj3s98GOuyQq/9t3dpHbqbwaKas1cXlGLR2
         YgLNQSEefiOAWLUjXl/Uzh4uu3zsQqeR4RD+Bckk7xnYyKP25qUALxUT6UB6qXFp8FkP
         gltHweTyLrRb34pdWfQwB/Cui2Of5LeZS+DPmeGsqoqI92MCyVU2nSrqKNTnfaBLwWze
         2ixA==
X-Received: by 10.152.203.199 with SMTP id ks7mr29343882lac.31.1416939865555;
        Tue, 25 Nov 2014 10:24:25 -0800 (PST)
Received: from localhost.localdomain ([178.89.18.183])
        by mx.google.com with ESMTPSA id tl8sm531639lbb.47.2014.11.25.10.24.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Nov 2014 10:24:22 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3.205.gea90ae3.dirty
In-Reply-To: <CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260234>

Now system_path returns path which is allocated string to callers;
It prevents memory leaks in some places. All callers of system_path
are owners of path string and they must release it.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/help.c | 10 +++++++---
 exec_cmd.c     | 17 +++++++++--------
 exec_cmd.h     |  4 ++--
 git.c          | 16 ++++++++++++----
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index b3c818e..544d1cc 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -321,12 +321,13 @@ static void setup_man_path(void)
 {
 	struct strbuf new_path = STRBUF_INIT;
 	const char *old_path = getenv("MANPATH");
-
+	char *git_man_path = system_path(GIT_MAN_PATH);
 	/* We should always put ':' after our path. If there is no
 	 * old_path, the ':' at the end will let 'man' to try
 	 * system-wide paths after ours to find the manual page. If
 	 * there is old_path, we need ':' as delimiter. */
-	strbuf_addstr(&new_path, system_path(GIT_MAN_PATH));
+	strbuf_addstr(&new_path, git_man_path);
+	free(git_man_path);
 	strbuf_addch(&new_path, ':');
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
@@ -372,7 +373,9 @@ static void show_man_page(const char *git_cmd)
 static void show_info_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
-	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
+	char *git_info_path = system_path(GIT_INFO_PATH);
+	setenv("INFOPATH", git_info_path, 1);
+	free(git_info_path);
 	execlp("info", "info", "gitman", page, (char *)NULL);
 	die(_("no info viewer handled the request"));
 }
@@ -392,6 +395,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 
 	strbuf_init(page_path, 0);
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
+	free((char*)html_path);
 }
 
 /*
diff --git a/exec_cmd.c b/exec_cmd.c
index 698e752..e3ebdd6 100644
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
@@ -16,7 +16,7 @@ const char *system_path(const char *path)
 	struct strbuf d = STRBUF_INIT;
 
 	if (is_absolute_path(path))
-		return path;
+		return strdup(path);
 
 #ifdef RUNTIME_PREFIX
 	assert(argv0_path);
@@ -34,8 +34,7 @@ const char *system_path(const char *path)
 #endif
 
 	strbuf_addf(&d, "%s/%s", prefix, path);
-	path = strbuf_detach(&d, NULL);
-	return path;
+	return d.buf;
 }
 
 const char *git_extract_argv0_path(const char *argv0)
@@ -68,16 +67,16 @@ void git_set_argv_exec_path(const char *exec_path)
 
 
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
@@ -95,8 +94,10 @@ void setup_path(void)
 {
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;
+	char* exec_path = git_exec_path();
 
-	add_path(&new_path, git_exec_path());
+	add_path(&new_path, exec_path);
+	free(exec_path);
 	add_path(&new_path, argv0_path);
 
 	if (old_path)
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
index 82d7a1c..d01c4f1 100644
--- a/git.c
+++ b/git.c
@@ -95,17 +95,25 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (*cmd == '=')
 				git_set_argv_exec_path(cmd + 1);
 			else {
-				puts(git_exec_path());
+				char *exec_path = git_exec_path();
+				puts(exec_path);
+				free(exec_path);
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
2.2.0.rc3.205.gea90ae3.dirty
