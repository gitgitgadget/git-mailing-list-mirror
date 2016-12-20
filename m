Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036891FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934870AbcLTXV6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:21:58 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33953 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932479AbcLTXV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 18:21:57 -0500
Received: by mail-pf0-f180.google.com with SMTP id c4so30987993pfb.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XvVBiyg8MCqx6CZFFWMvKS4HRY+IIVXNs2psNbM5TE=;
        b=ThnY511kLkN2jgOZos02/3gDvvc1e3/u7NO/JA4jzVOjZiwXnQlWY+sKEF62MCT39M
         6qK6N/GNGwzWItqb30iRr2IbW1PYW2xXfzAzx/FMy4lLYaRp0qNflRDnWI9PUH0nwbqx
         aAcVS0Zhw48IU7zVe4GPY0r0HM88Zp5BodSOcHQtEbqlUIiaoydpurVi1M+46notOlrz
         r61/Z0lPmFqGrMTy8n3rv1CHw75zLJBGp5QZJOOt5hgW/Doo1+EAktJ2Yr03tR7a2oIV
         ENHYYu/7+RuMGVj7WgHiEHbVHbcqpqyfFMB/W7KULWGlUkd/qsSfVqDzfulVLifCVaMG
         IT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/XvVBiyg8MCqx6CZFFWMvKS4HRY+IIVXNs2psNbM5TE=;
        b=krMZ9MCPQrOLfq6lFL2sezHwUgZmDgAk1w/JXchRlTAx+T2tKsmN7yU3rcDILqV3nk
         /VBgVH0Er9YOVdGp+Lj3m76Xx6nfy8/O4b3KSQIjN+XJQ3FiaJmmD/+PZAwxYUtWeSHz
         MjqilhWi/ySHStHU7QmDlYAdfCEqaGdU82dZmuwhIXrhO1LmFwTix7zafOLXyz92dVBK
         A197HfaU7q3yDey61fOYD8MmEGk+yvpNHkZ2MQ4zcuxx+qGyqtvFLm/PDgfnz3QT+Fp8
         e75DwLo7AW7ELShHxDq4QGA58bOoDNCo9P/Wpomt71d2aB0SAaxQrzK5jlV7nDN9Z9a/
         Lfjw==
X-Gm-Message-State: AIkVDXKFCpFYrCiestay640/EW8MXjH+Wpmx7QkFB7f9OqC4+NpI1KWHCrboFOeaJTasSD/M
X-Received: by 10.98.166.70 with SMTP id t67mr1454391pfe.132.1482275567709;
        Tue, 20 Dec 2016 15:12:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6c5b:c771:3806:a807])
        by smtp.gmail.com with ESMTPSA id i194sm41810616pgc.46.2016.12.20.15.12.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Dec 2016 15:12:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/4] submodule: rename and add flags to ok_to_remove_submodule
Date:   Tue, 20 Dec 2016 15:12:26 -0800
Message-Id: <20161220231227.14115-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161220231227.14115-1-sbeller@google.com>
References: <20161220231227.14115-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In different contexts the question "Is it ok to delete a submodule?"
may be answered differently.

In 293ab15eea (submodule: teach rm to remove submodules unless they
contain a git directory, 2012-09-26) a case was made that we can safely
ignore ignored untracked files for removal as we explicitely ask for the
removal of the submodule.

In a later patch we want to remove submodules even when the user doesn't
explicitly ask for it (e.g. checking out a tree-ish in which the submodule
doesn't exist).  In that case we want to be more careful when it comes
to deletion of untracked files. As of this patch it is unclear how this
will be implemented exactly, so we'll offer flags in which the caller
can specify how the different untracked files ought to be handled.

As the flags allow the function to not die on an error when spawning
a child process, we need to find an appropriate return code for the
case when the child process could not be started. As in that case we
cannot tell if the submodule is ok to remove, we'd want to return 'false'.

As only 0 is understood as false, rename the function to invert the
meaning, i.e. the return code of 0 signals the removal of the submodule
is fine, and other values can be used to return a more precise answer
what went wrong.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rm.c |  4 +++-
 submodule.c  | 49 +++++++++++++++++++++++++++++++++++++------------
 submodule.h  |  6 +++++-
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 3f3e24eb36..5a5a66272b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -187,7 +187,9 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 */
 		if (ce_match_stat(ce, &st, 0) ||
 		    (S_ISGITLINK(ce->ce_mode) &&
-		     !ok_to_remove_submodule(ce->name)))
+		     bad_to_remove_submodule(ce->name,
+				SUBMODULE_REMOVAL_DIE_ON_ERROR |
+				SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)))
 			local_changes = 1;
 
 		/*
diff --git a/submodule.c b/submodule.c
index 9f0b544ebe..1cc04d24e5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1019,39 +1019,64 @@ int submodule_uses_gitfile(const char *path)
 	return 1;
 }
 
-int ok_to_remove_submodule(const char *path)
+/*
+ * Check if it is a bad idea to remove a submodule, i.e. if we'd lose data
+ * when doing so.
+ *
+ * Return 1 if we'd lose data, return 0 if the removal is fine,
+ * and negative values for errors.
+ */
+int bad_to_remove_submodule(const char *path, unsigned flags)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	int ok_to_remove = 1;
+	int ret = 0;
 
 	if (!file_exists(path) || is_empty_dir(path))
-		return 1;
+		return 0;
 
 	if (!submodule_uses_gitfile(path))
-		return 0;
+		return 1;
 
-	argv_array_pushl(&cp.args, "status", "--porcelain", "-u",
+	argv_array_pushl(&cp.args, "status", "--porcelain",
 				   "--ignore-submodules=none", NULL);
+
+	if (flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED)
+		argv_array_push(&cp.args, "-uno");
+	else
+		argv_array_push(&cp.args, "-uall");
+
+	if (!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED))
+		argv_array_push(&cp.args, "--ignored");
+
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
-	if (start_command(&cp))
-		die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
+	if (start_command(&cp)) {
+		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
+			die(_("could not start 'git status in submodule '%s'"),
+				path);
+		ret = -1;
+		goto out;
+	}
 
 	len = strbuf_read(&buf, cp.out, 1024);
 	if (len > 2)
-		ok_to_remove = 0;
+		ret = 1;
 	close(cp.out);
 
-	if (finish_command(&cp))
-		die(_("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s"), path);
-
+	if (finish_command(&cp)) {
+		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
+			die(_("could not run 'git status in submodule '%s'"),
+				path);
+		ret = -1;
+	}
+out:
 	strbuf_release(&buf);
-	return ok_to_remove;
+	return ret;
 }
 
 static int find_first_merges(struct object_array *result, const char *path,
diff --git a/submodule.h b/submodule.h
index 61fb610749..21b1569413 100644
--- a/submodule.h
+++ b/submodule.h
@@ -59,7 +59,11 @@ extern int fetch_populated_submodules(const struct argv_array *options,
 			       int quiet, int max_parallel_jobs);
 extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
 extern int submodule_uses_gitfile(const char *path);
-extern int ok_to_remove_submodule(const char *path);
+
+#define SUBMODULE_REMOVAL_DIE_ON_ERROR (1<<0)
+#define SUBMODULE_REMOVAL_IGNORE_UNTRACKED (1<<1)
+#define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
+extern int bad_to_remove_submodule(const char *path, unsigned flags);
 extern int merge_submodule(unsigned char result[20], const char *path,
 			   const unsigned char base[20],
 			   const unsigned char a[20],
-- 
2.11.0.rc2.53.gb7b3fba.dirty

