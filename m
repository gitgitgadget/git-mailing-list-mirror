Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949911F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbdGYVkZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:40:25 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35918 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbdGYVkB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:40:01 -0400
Received: by mail-pg0-f47.google.com with SMTP id 125so75323250pgi.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hcY/42sww4GxC1HoJ8VNEJ0kictVSfJ99naQ26WrXNY=;
        b=f5wcZVZaR9jHJpcqfaQkoz3vo217DI0L34rt3rYmKUp4yDosWTS53HxPW222Hx+iqc
         4eU4fOvjNKDlyfnRQ+IONaOPnCgqqrU1Opdf3MznOgbeM6Y224h159wg8ry6fdGQSth4
         3lREwSTzVWJtj3NER6zWmM1ANtcN5mndJKBbMTZBY2aRKo9Hhbp8DNnGd76pxcFVyVdm
         Ld2a4TkfzGFEp55Mpw4XvjppPJmp91BUd2XPxBsjeTwUKa9FKBF8V11gUpjlTRZWs36h
         ThQ5f/4QdecDPyHu+jAofXipjxaQGYGKWNTdummhEgMd97zfcBH8JaV0CkbSn1jo6xCI
         HARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hcY/42sww4GxC1HoJ8VNEJ0kictVSfJ99naQ26WrXNY=;
        b=qtx++vsSdzDducSBs9+4haHB3hkEQFvWCaLxQTKisB48Wj+OA8VcQGqB2PFjkIz18G
         eMj6Idvv39BwExKlUdmHuLRq8vF4lU6InfDThny3tIqN9R17rHtAYgwWPuF5iTVaPxdy
         Ytx4WBf8Kho0pIDP//nII39skBS1VprGYGgNsbSaeSN+bq6h3d8bhoTg3XN8UJ6h+g4T
         eicGePhqkLOHyVZ7DPXD7gteTjSBiW2ShxeaM7U6GAicBPDXZdwE2zH+APij0LxUbYkh
         mlTbfmlaSz1xC+Fw+7JHtztqvyw3Pt4skOg+PnmVCCxMZR4QS0oaaQSFUK3jIsiP8N2A
         KN6A==
X-Gm-Message-State: AIVw111WhcL/wIwxBCA2XN+WemmDqxPpcVyvlxzk6miovHMTqmBgP3Lx
        Fg67v2qlZEVdkRCkmDJSzQ==
X-Received: by 10.84.169.3 with SMTP id g3mr22660593plb.136.1501018800740;
        Tue, 25 Jul 2017 14:40:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 13/15] submodule-config: lazy-load a repository's .gitmodules file
Date:   Tue, 25 Jul 2017 14:39:26 -0700
Message-Id: <20170725213928.125998-14-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to use the submodule-config subsystem, callers first need to
initialize it by calling 'repo_read_gitmodules()' or
'gitmodules_config()' (which just redirects to
'repo_read_gitmodules()').  There are a couple of callers who need to
load an explicit revision of the repository's .gitmodules file (grep) or
need to modify the .gitmodules file so they would need to load it before
modify the file (checkout), but the majority of callers are simply
reading the .gitmodules file present in the working tree.  For the
common case it would be nice to avoid the boilerplate of initializing
the submodule-config system before using it, so instead let's perform
lazy-loading of the submodule-config system.

Remove the calls to reading the gitmodules file from ls-files to show
that lazy-loading the .gitmodules file works.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c |  5 -----
 submodule-config.c | 27 ++++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d14612057..bd74ee07d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -211,8 +211,6 @@ static void show_submodule(struct repository *superproject,
 	if (repo_read_index(&submodule) < 0)
 		die("index file corrupt");
 
-	repo_read_gitmodules(&submodule);
-
 	show_files(&submodule, dir);
 
 	repo_clear(&submodule);
@@ -611,9 +609,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	if (recurse_submodules)
-		repo_read_gitmodules(the_repository);
-
 	if (recurse_submodules &&
 	    (show_stage || show_deleted || show_others || show_unmerged ||
 	     show_killed || show_modified || show_resolve_undo || with_tree))
diff --git a/submodule-config.c b/submodule-config.c
index 86636654b..56d9d76d4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -18,6 +18,7 @@ struct submodule_cache {
 	struct hashmap for_path;
 	struct hashmap for_name;
 	unsigned initialized:1;
+	unsigned gitmodules_read:1;
 };
 
 /*
@@ -93,6 +94,7 @@ static void submodule_cache_clear(struct submodule_cache *cache)
 	hashmap_free(&cache->for_path, 1);
 	hashmap_free(&cache->for_name, 1);
 	cache->initialized = 0;
+	cache->gitmodules_read = 0;
 }
 
 void submodule_cache_free(struct submodule_cache *cache)
@@ -557,8 +559,6 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 	struct repository *repo = data;
 	struct parse_config_parameter parameter;
 
-	submodule_cache_check_init(repo);
-
 	parameter.cache = repo->submodule_cache;
 	parameter.treeish_name = NULL;
 	parameter.gitmodules_sha1 = null_sha1;
@@ -569,6 +569,8 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 
 void repo_read_gitmodules(struct repository *repo)
 {
+	submodule_cache_check_init(repo);
+
 	if (repo->worktree) {
 		char *gitmodules;
 
@@ -582,6 +584,8 @@ void repo_read_gitmodules(struct repository *repo)
 
 		free(gitmodules);
 	}
+
+	repo->submodule_cache->gitmodules_read = 1;
 }
 
 void gitmodules_config_oid(const struct object_id *commit_oid)
@@ -589,24 +593,37 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 	struct strbuf rev = STRBUF_INIT;
 	struct object_id oid;
 
+	submodule_cache_check_init(the_repository);
+
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
 		git_config_from_blob_oid(gitmodules_cb, rev.buf,
 					 &oid, the_repository);
 	}
 	strbuf_release(&rev);
+
+	the_repository->submodule_cache->gitmodules_read = 1;
+}
+
+static void gitmodules_read_check(struct repository *repo)
+{
+	submodule_cache_check_init(repo);
+
+	/* read the repo's .gitmodules file if it hasn't been already */
+	if (!repo->submodule_cache->gitmodules_read)
+		repo_read_gitmodules(repo);
 }
 
 const struct submodule *submodule_from_name(const struct object_id *treeish_name,
 		const char *name)
 {
-	submodule_cache_check_init(the_repository);
+	gitmodules_read_check(the_repository);
 	return config_from(the_repository->submodule_cache, treeish_name, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(const struct object_id *treeish_name,
 		const char *path)
 {
-	submodule_cache_check_init(the_repository);
+	gitmodules_read_check(the_repository);
 	return config_from(the_repository->submodule_cache, treeish_name, path, lookup_path);
 }
 
@@ -614,7 +631,7 @@ const struct submodule *submodule_from_cache(struct repository *repo,
 					     const struct object_id *treeish_name,
 					     const char *key)
 {
-	submodule_cache_check_init(repo);
+	gitmodules_read_check(repo);
 	return config_from(repo->submodule_cache, treeish_name,
 			   key, lookup_path);
 }
-- 
2.14.0.rc0.400.g1c36432dff-goog

