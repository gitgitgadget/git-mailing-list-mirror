Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7A320387
	for <e@80x24.org>; Tue, 18 Jul 2017 19:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbdGRTF4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:56 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35549 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdGRTFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:54 -0400
Received: by mail-pf0-f179.google.com with SMTP id e199so15608856pfh.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpDOPlZGdVHSTWbaWGuxPktF/L+H7Qu28eLkXrFcP4g=;
        b=ns4pMxf03vEgBA43GqBIjTLsD5doh1f0MFeqIO+pcZ0mV1H6/O/dYllP2YwRIzohMw
         TqnyJ29pfdAxvNYKLbeRXRIYQb4o9BPmyV7AXMzRdqaSWmj5vMZsZ9lzEC3dVLqLYm2t
         1bB6AF6YBJuDThKj+Db/TQVUdtBrSWT33K4lHizl8X2sIeHj9tiujs0LhY+hoL9DjdgO
         DDNeOh+W1UxGfNF3vqEmvx5ssXQfSo88fa5Z3UkF8Kl1hnZ50WpMllqUyTn//B7DgYOb
         GEsxZtfhBPQVUYEfwt2aLdbMk+poYYsyhADUKuXJUwn1+PRDV9uPVVPnQ/bsgDTN51Dh
         RzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JpDOPlZGdVHSTWbaWGuxPktF/L+H7Qu28eLkXrFcP4g=;
        b=dElwnbEZmT+Kv3ULIafFvVBA4Hepub4WpJeBqcKOkoK6tC6lC/YPgRctrl7gAt59w2
         X8MzA/Z0VJNIYmsoe3iJ8xt6oMTOzJzph7NVmJ8cTGKEjhDOkr1ZOkXdOEoNuVJ1jgd2
         Vn32aK+Wx0OtPBfyM/pptZd8Y5hPjxR8Prw5v6YhSq96yptd9KBDzAXS3Ky9FX2GPgM/
         mwo6z7TW1NnkkTrFQm4wlmZhnhIu0jpUcjXfB3Gdh2ixuUh9wdwg4GgT8IH//4np+Htd
         YJU5RvI30D1C9R76jS60ZgV2uOQGw5L4IznF37/yq1eX+tjK1o5OYUDDTg3sw86x+hGI
         w0YA==
X-Gm-Message-State: AIVw111H4aNTfgP7I1ulu+j/qi5qR0GuGwVvtTsvTzQzf2eskekU1bje
        CS8NIuMnO2lLiUogrGZvZg==
X-Received: by 10.98.139.11 with SMTP id j11mr3326508pfe.18.1500404752848;
        Tue, 18 Jul 2017 12:05:52 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 09/10] submodule: merge repo_read_gitmodules and gitmodules_config
Date:   Tue, 18 Jul 2017 12:05:26 -0700
Message-Id: <20170718190527.78049-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 69aba5329 (submodule: add repo_read_gitmodules) there have been
two ways to load a repository's .gitmodules file:
'repo_read_gitmodules()' is used if you have a repository object you are
working with or 'gitmodules_config()' if you are implicitly working with
'the_repository'.  Merge the logic of these two functions to remove
duplicate code.

In addition, 'repo_read_gitmodules()' can segfault by passing in a NULL
pointer to 'git_config_from_file()' if a repository doesn't have a
worktree.  Instead check for the existence of a worktree before
attempting to load the .gitmodules file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/submodule.c b/submodule.c
index a5f825e37..ab0b74926 100644
--- a/submodule.c
+++ b/submodule.c
@@ -230,23 +230,6 @@ void load_submodule_cache(void)
 	git_config(submodule_config, NULL);
 }
 
-void gitmodules_config(void)
-{
-	const char *work_tree = get_git_work_tree();
-	if (work_tree) {
-		struct strbuf gitmodules_path = STRBUF_INIT;
-		strbuf_addstr(&gitmodules_path, work_tree);
-		strbuf_addstr(&gitmodules_path, "/.gitmodules");
-		if (read_cache() < 0)
-			die("index file corrupt");
-
-		if (!is_gitmodules_unmerged(&the_index))
-			git_config_from_file(git_modules_config,
-				gitmodules_path.buf, NULL);
-		strbuf_release(&gitmodules_path);
-	}
-}
-
 static int gitmodules_cb(const char *var, const char *value, void *data)
 {
 	struct repository *repo = data;
@@ -255,10 +238,24 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 
 void repo_read_gitmodules(struct repository *repo)
 {
-	char *gitmodules_path = repo_worktree_path(repo, ".gitmodules");
+	if (repo->worktree) {
+		char *gitmodules;
+
+		if (repo_read_index(repo) < 0)
+			return;
 
-	git_config_from_file(gitmodules_cb, gitmodules_path, repo);
-	free(gitmodules_path);
+		gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
+
+		if (!is_gitmodules_unmerged(repo->index))
+			git_config_from_file(gitmodules_cb, gitmodules, repo);
+
+		free(gitmodules);
+	}
+}
+
+void gitmodules_config(void)
+{
+	repo_read_gitmodules(the_repository);
 }
 
 void gitmodules_config_sha1(const unsigned char *commit_sha1)
-- 
2.13.2.932.g7449e964c-goog

