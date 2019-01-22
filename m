Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE8D1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAVVqL (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:46:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39212 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfAVVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:46:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so44482lfh.6
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybYAMtx+ksqBvxqqjTGVAqWnJ1AGNl0k/geEXPeKJOM=;
        b=HCFLi6cgLy/ZtvNcdDrE3Q7RQ/eVjXgqxJb04AQ1P9rFwZnxyg8FYMHSg0N49c8HkZ
         7r7La/G9oA1gxFbo2LL+EKZo/Bemr9obPOjK6d9WPFLGpi3msX6lXhOyUXEUm5eA4cE3
         XcusY3vr9xodNKyAaG3yVlyoQL6PEulPIg1cKAafwIsPW3v4rc+V+P0IB4bITSMjuiM+
         S00itA9zpd8oL90C+4aFqANoJAyt6j56yYoxmPsvLDBz78YNgl6EzZvyrqnTR5XwNPhS
         yI7VP4RLvO0S+jK119I34O/ObfWvamFy6fnzZIKukoFP42k1MKuC1XjMGsG/j21gkGyW
         eAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybYAMtx+ksqBvxqqjTGVAqWnJ1AGNl0k/geEXPeKJOM=;
        b=dV1h85jFh+OdKNRirFtjVKNbrRnFaU1EotC0dK3VJLTQWL20qp6foNWXZleli+PX/q
         KPldxY4WFoJ6ksJlWvBhd7imLGVbrSohC6JgOAn4vStkKdNYmIF+DgJlqUyS0KJQcqPV
         nDlEsRCfja4LRY4+1/fgOJCNSKrZxTZhkXsNaaor8ZHU9xEeSWP9T35VPn1+XSYrED2x
         A0iNd4UpJsMk8wkpVfb9W/OJMC/GEvadSwJuIs/qetautCt0IvdRCHRB9imwasflGP/m
         OIkQOboMvDHMFo1ryhyvt5bN6BjbMMGffzTyE0Z6eLCpbTLJYNs0N9KuqhCXolRCSCvo
         dRUA==
X-Gm-Message-State: AJcUukeypVwoEON+ZPDLM4jbB2PPHMJuXKicP1O3ie4wiPZm1pwr+ANl
        EiTv5kzz5lBsGpbOvOzx82OJx8fP
X-Google-Smtp-Source: ALg8bN5jRcog89xB8jB2HPAF4Fjin8rzfBVQylROATU5cUlXxenHZRkOKZvdNbskNQq+sLEACU3nLQ==
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr20778329lfg.93.1548193567569;
        Tue, 22 Jan 2019 13:46:07 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k3-v6sm188706lja.8.2019.01.22.13.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:46:06 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 2/2] setup: fix memory leaks with `struct repository_format`
Date:   Tue, 22 Jan 2019 22:45:48 +0100
Message-Id: <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1.98.gecbdaf0899
In-Reply-To: <cover.1548186510.git.martin.agren@gmail.com>
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com> <cover.1548186510.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we set up a `struct repository_format`, it owns various pieces of
allocated memory. We then either use those members, because we decide we
want to use the "candidate" repository format, or we discard the
candidate / scratch space. In the first case, we transfer ownership of
the memory to a few global variables. In the latter case, we just
silently drop the struct and end up leaking memory.

Introduce an initialization macro `REPOSITORY_FORMAT_INIT` and a
function `clear_repository_format()`, to be used on each side of
`read_repository_format()`. To have a clear and simple memory ownership,
let all users of `struct repository_format` duplicate the strings that
they take from it, rather than stealing the pointers.

Call `clear_...()` at the start of `read_...()` instead of just zeroing
the struct, since we sometimes enter the function multiple times. This
means that it is important to initialize the struct before calling
`read_...()`, so document that. Teach `read_...()` to clear the struct
upon an error, so that it is reset to a safe state, and document this.

About that very last point: In `setup_git_directory_gently()`, we look
at `repo_fmt.hash_algo` even if `repo_fmt.version` is -1, which we
weren't actually supposed to do per the API. After this commit, that's
ok.

We inherit the existing code's combining "error" and "no version found".
Both are signalled through `version == -1` and now both cause us to
clear any partial configuration we have picked up. For "extensions.*",
that's fine, since they require a positive version number. For
"core.bare" and "core.worktree", we're already verifying that we have a
non-negative version number before using them.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 cache.h           | 27 ++++++++++++++++++++++++---
 builtin/init-db.c |  3 ++-
 repository.c      |  3 ++-
 setup.c           | 32 ++++++++++++++++++++------------
 worktree.c        |  4 +++-
 5 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index ca36b44ee0..ec7c043412 100644
--- a/cache.h
+++ b/cache.h
@@ -972,14 +972,35 @@ struct repository_format {
 	struct string_list unknown_extensions;
 };
 
+/*
+ * Always use this to initialize a `struct repository_format`
+ * to a well-defined, default state before calling
+ * `read_repository()`.
+ */
+#define REPOSITORY_FORMAT_INIT \
+{ \
+	.version = -1, \
+	.is_bare = -1, \
+	.hash_algo = GIT_HASH_SHA1, \
+	.unknown_extensions = STRING_LIST_INIT_DUP, \
+}
+
 /*
  * Read the repository format characteristics from the config file "path" into
- * "format" struct. Returns the numeric version. On error, -1 is returned,
- * format->version is set to -1, and all other fields in the struct are
- * undefined.
+ * "format" struct. Returns the numeric version. On error, or if no version is
+ * found in the configuration, -1 is returned, format->version is set to -1,
+ * and all other fields in the struct are set to the default configuration
+ * (REPOSITORY_FORMAT_INIT). Always initialize the struct using
+ * REPOSITORY_FORMAT_INIT before calling this function.
  */
 int read_repository_format(struct repository_format *format, const char *path);
 
+/*
+ * Free the memory held onto by `format`, but not the struct itself.
+ * (No need to use this after `read_repository_format()` fails.)
+ */
+void clear_repository_format(struct repository_format *format);
+
 /*
  * Verify that the repository described by repository_format is something we
  * can read. If it is, return 0. Otherwise, return -1, and "err" will describe
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 41faffd28d..04c60eaad5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -96,7 +96,7 @@ static void copy_templates(const char *template_dir)
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf template_path = STRBUF_INIT;
 	size_t template_len;
-	struct repository_format template_format;
+	struct repository_format template_format = REPOSITORY_FORMAT_INIT;
 	struct strbuf err = STRBUF_INIT;
 	DIR *dir;
 	char *to_free = NULL;
@@ -148,6 +148,7 @@ static void copy_templates(const char *template_dir)
 	free(to_free);
 	strbuf_release(&path);
 	strbuf_release(&template_path);
+	clear_repository_format(&template_format);
 }
 
 static int git_init_db_config(const char *k, const char *v, void *cb)
diff --git a/repository.c b/repository.c
index 7b02e1dffa..df88705574 100644
--- a/repository.c
+++ b/repository.c
@@ -148,7 +148,7 @@ int repo_init(struct repository *repo,
 	      const char *gitdir,
 	      const char *worktree)
 {
-	struct repository_format format;
+	struct repository_format format = REPOSITORY_FORMAT_INIT;
 	memset(repo, 0, sizeof(*repo));
 
 	repo->objects = raw_object_store_new();
@@ -165,6 +165,7 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	clear_repository_format(&format);
 	return 0;
 
 error:
diff --git a/setup.c b/setup.c
index bb633942bb..14c2f8ce24 100644
--- a/setup.c
+++ b/setup.c
@@ -477,7 +477,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	repository_format_partial_clone = candidate->partial_clone;
+	repository_format_partial_clone = xstrdup_or_null(candidate->partial_clone);
 	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 
@@ -500,11 +500,9 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		}
 		if (candidate->work_tree) {
 			free(git_work_tree_cfg);
-			git_work_tree_cfg = candidate->work_tree;
+			git_work_tree_cfg = xstrdup(candidate->work_tree);
 			inside_work_tree = -1;
 		}
-	} else {
-		free(candidate->work_tree);
 	}
 
 	return 0;
@@ -512,15 +510,21 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 
 int read_repository_format(struct repository_format *format, const char *path)
 {
-	memset(format, 0, sizeof(*format));
-	format->version = -1;
-	format->is_bare = -1;
-	format->hash_algo = GIT_HASH_SHA1;
-	string_list_init(&format->unknown_extensions, 1);
+	clear_repository_format(format);
 	git_config_from_file(check_repo_format, path, format);
+	if (format->version == -1)
+		clear_repository_format(format);
 	return format->version;
 }
 
+void clear_repository_format(struct repository_format *format)
+{
+	string_list_clear(&format->unknown_extensions, 0);
+	free(format->work_tree);
+	free(format->partial_clone);
+	*format = (struct repository_format)REPOSITORY_FORMAT_INIT;
+}
+
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err)
 {
@@ -1008,7 +1012,7 @@ int discover_git_directory(struct strbuf *commondir,
 	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
 	size_t commondir_offset = commondir->len;
-	struct repository_format candidate;
+	struct repository_format candidate = REPOSITORY_FORMAT_INIT;
 
 	if (strbuf_getcwd(&dir))
 		return -1;
@@ -1045,9 +1049,11 @@ int discover_git_directory(struct strbuf *commondir,
 		strbuf_release(&err);
 		strbuf_setlen(commondir, commondir_offset);
 		strbuf_setlen(gitdir, gitdir_offset);
+		clear_repository_format(&candidate);
 		return -1;
 	}
 
+	clear_repository_format(&candidate);
 	return 0;
 }
 
@@ -1056,7 +1062,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
 	const char *prefix;
-	struct repository_format repo_fmt;
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
 	 * We may have read an incomplete configuration before
@@ -1146,6 +1152,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
+	clear_repository_format(&repo_fmt);
 
 	return prefix;
 }
@@ -1203,9 +1210,10 @@ int git_config_perm(const char *var, const char *value)
 
 void check_repository_format(void)
 {
-	struct repository_format repo_fmt;
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	check_repository_format_gently(get_git_dir(), &repo_fmt, NULL);
 	startup_info->have_repository = 1;
+	clear_repository_format(&repo_fmt);
 }
 
 /*
diff --git a/worktree.c b/worktree.c
index d6a0ee7f73..b45bfeb9d3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -444,7 +444,7 @@ int submodule_uses_worktrees(const char *path)
 	DIR *dir;
 	struct dirent *d;
 	int ret = 0;
-	struct repository_format format;
+	struct repository_format format = REPOSITORY_FORMAT_INIT;
 
 	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
 	if (!submodule_gitdir)
@@ -462,8 +462,10 @@ int submodule_uses_worktrees(const char *path)
 	read_repository_format(&format, sb.buf);
 	if (format.version != 0) {
 		strbuf_release(&sb);
+		clear_repository_format(&format);
 		return 1;
 	}
+	clear_repository_format(&format);
 
 	/* Replace config by worktrees. */
 	strbuf_setlen(&sb, sb.len - strlen("config"));
-- 
2.20.1.98.gecbdaf0899

