Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA7D1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 17:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951605AbdDYRzL (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 13:55:11 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34265 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947413AbdDYRzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 13:55:00 -0400
Received: by mail-pg0-f47.google.com with SMTP id v1so20181237pgv.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=efdojc8Z0PimaKo3pUtujE73pwBw+za4KHa4TS5Knac=;
        b=RHaipvXLUFAnH1INlcRCREAokt7LX1qN18Tq4G9QHDoIvyNqgBsFfVKWrb1Ll/3PTU
         TO/vn/c+hU2lJ61v6Fti/bNRhDAlAqKWIaSzxoBZRoREE189/bnC/OikgTmdU8YXag9j
         m3hDVRmX4AFBrBEb0X0vWxHhzfmkRTIu2oqfObTR/qsBZxgYLLC8E6m/iGN5X5nTFui9
         bJfvs8QVw7dTgMSNYbaTcUTBt7yFcJMKBgQUMKVlrcQAbILlAPvSIEPzgcO6eJJAzIEr
         8+r8kKSzXfVblkAgy0CZsgCy3fo2riHjURWJCItdcyrOqe3JtOOaWtsm5gA9n8VPHJxT
         vleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=efdojc8Z0PimaKo3pUtujE73pwBw+za4KHa4TS5Knac=;
        b=sWFcDXmIwqt0Izvd+vK7QcEQptjkwYUz+qeauDqifmwNq5Cl6fo9HEQ5t5Rng8l/K+
         Y3MKjCTGaqJHsY67Pl35DSytpNOgGSts2Mr5JgE6oEVDVTQ4Z88h/IsFeLy+u9orDxZ1
         xbVCI4OtKWkRBFds9773cK2cMFnxJQ1N46B1JIPo4ISIFkFDK+dToR3/8RQWTC8KbfbS
         2KUAmrknA5Wd7DxrcXKmL/KPBESeWXtYu0TbMs610MLxlI1VRpG1KXolYMY7F+yFidpx
         7UjtVMGX9u8TfpzCdNGmwPr5TaqTCNPczBic9FW8vT6ctfTq6uckphxEroXOoIezWVTP
         HM/A==
X-Gm-Message-State: AN3rC/6t1WU9iAMZSgXe1nfahxooOyfCgOxAbY2xFpezR6FHLTS0hT3c
        tAUS7MIeRAopyEWu
X-Received: by 10.98.13.19 with SMTP id v19mr29622075pfi.89.1493142898970;
        Tue, 25 Apr 2017 10:54:58 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s89sm37701549pfi.79.2017.04.25.10.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 10:54:58 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v7 1/2] exec_cmd: expose is_executable function
Date:   Tue, 25 Apr 2017 10:54:45 -0700
Message-Id: <20170425175446.113553-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170424235042.26627-1-bmwill@google.com>
References: <20170424235042.26627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the logic for 'is_executable()' from help.c to exec_cmd.c and
expose it so that callers from outside help.c can access the function.
This is to enable run-command to be able to query if a file is
executable in a future patch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 exec_cmd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 exec_cmd.h |  1 +
 help.c     | 42 ------------------------------------------
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index fb94aeba9..6d9481e26 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -149,3 +149,45 @@ int execl_git_cmd(const char *cmd,...)
 	argv[argc] = NULL;
 	return execv_git_cmd(argv);
 }
+
+int is_executable(const char *name)
+{
+	struct stat st;
+
+	if (stat(name, &st) || /* stat, not lstat */
+	    !S_ISREG(st.st_mode))
+		return 0;
+
+#if defined(GIT_WINDOWS_NATIVE)
+	/*
+	 * On Windows there is no executable bit. The file extension
+	 * indicates whether it can be run as an executable, and Git
+	 * has special-handling to detect scripts and launch them
+	 * through the indicated script interpreter. We test for the
+	 * file extension first because virus scanners may make
+	 * it quite expensive to open many files.
+	 */
+	if (ends_with(name, ".exe"))
+		return S_IXUSR;
+
+{
+	/*
+	 * Now that we know it does not have an executable extension,
+	 * peek into the file instead.
+	 */
+	char buf[3] = { 0 };
+	int n;
+	int fd = open(name, O_RDONLY);
+	st.st_mode &= ~S_IXUSR;
+	if (fd >= 0) {
+		n = read(fd, buf, 2);
+		if (n == 2)
+			/* look for a she-bang */
+			if (!strcmp(buf, "#!"))
+				st.st_mode |= S_IXUSR;
+		close(fd);
+	}
+}
+#endif
+	return st.st_mode & S_IXUSR;
+}
diff --git a/exec_cmd.h b/exec_cmd.h
index ff0b48048..48dd18a0d 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -12,5 +12,6 @@ extern int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
 extern int execl_git_cmd(const char *cmd, ...);
 extern char *system_path(const char *path);
+extern int is_executable(const char *name);
 
 #endif /* GIT_EXEC_CMD_H */
diff --git a/help.c b/help.c
index bc6cd19cf..50f84b430 100644
--- a/help.c
+++ b/help.c
@@ -96,48 +96,6 @@ static void pretty_print_cmdnames(struct cmdnames *cmds, unsigned int colopts)
 	string_list_clear(&list, 0);
 }
 
-static int is_executable(const char *name)
-{
-	struct stat st;
-
-	if (stat(name, &st) || /* stat, not lstat */
-	    !S_ISREG(st.st_mode))
-		return 0;
-
-#if defined(GIT_WINDOWS_NATIVE)
-	/*
-	 * On Windows there is no executable bit. The file extension
-	 * indicates whether it can be run as an executable, and Git
-	 * has special-handling to detect scripts and launch them
-	 * through the indicated script interpreter. We test for the
-	 * file extension first because virus scanners may make
-	 * it quite expensive to open many files.
-	 */
-	if (ends_with(name, ".exe"))
-		return S_IXUSR;
-
-{
-	/*
-	 * Now that we know it does not have an executable extension,
-	 * peek into the file instead.
-	 */
-	char buf[3] = { 0 };
-	int n;
-	int fd = open(name, O_RDONLY);
-	st.st_mode &= ~S_IXUSR;
-	if (fd >= 0) {
-		n = read(fd, buf, 2);
-		if (n == 2)
-			/* look for a she-bang */
-			if (!strcmp(buf, "#!"))
-				st.st_mode |= S_IXUSR;
-		close(fd);
-	}
-}
-#endif
-	return st.st_mode & S_IXUSR;
-}
-
 static void list_commands_in_dir(struct cmdnames *cmds,
 					 const char *path,
 					 const char *prefix)
-- 
2.13.0.rc0.306.g87b477812d-goog

