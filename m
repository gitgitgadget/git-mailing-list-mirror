Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB39120282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbdFNSH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:07:56 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33587 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdFNSHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:07:51 -0400
Received: by mail-pf0-f172.google.com with SMTP id 83so3975453pfr.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RSAPWxAWY+lwytfGDWW8Okdu3u12QkHPTU5yAoA2iL8=;
        b=vtq4YhVzZCHxw5nPgee5mWFfa0PlY/tm3hnos/w50kNIvFSA0T9tymDC/dzS9KlYYL
         IGYf8slVRoBfJ84ZuOYyR0V8XpCTCEVg5JvZpHmwuAUTaj1E1BNC9IVHg2ozX4wmM8d4
         4UtWnHlJP6NHAbnu/5ajyi/OntFNvnLKEE0AvpATHGmUIZd/ZqzykBhtMHj1ym0ett2X
         cJrShw/7/urQ5QoX1jCot1FSoeY5Dj1Z4yWzz0nNX8ETofd89a72aU6RgzUJMGC91IV6
         uDqrOMvYg8euBT2b7UgErILV4yzRxT+S3tKj3eESs7RaVb3uZrs/0GbHXaXA7tOomlCM
         hmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RSAPWxAWY+lwytfGDWW8Okdu3u12QkHPTU5yAoA2iL8=;
        b=SGWNhCnLXgHRsoCEiVXKwIDwVNLjr0WG0W+4RDmn3K/OY0razVrKKvmKAcxdfrRVKE
         QJGYQH5u+YNBk6hR/Emqtgnz3zGWf57eJgRO4DtXLmsKGRvDT3cpfqSroZPGQ52rRahp
         MI6bhGV5MOZZrLMiXj6xBJpodOG8x2767R8LGL1VNoi/xOh5Gs3NFGwuniE/yYuCI7jG
         7Ks/XX2yXQgH28XkV4EGC3Z0LpkCdzhmK3ob8htHZRkejNFKFfZv7yCReKjfQAZuqbKW
         KOCbXStTvB9u931Gi1fmqb8cL6FeYsE1Oe8fee6bbpBTLw0XMgrB//20tmk/P4UKLLSH
         j9dw==
X-Gm-Message-State: AKS2vOyz4pSEXf9PnsjZOsjWqmdKbhE6Sv7iAUTDh5W+kl+JYrX4SqqX
        lAxZfh/z7aX/R6hT/4+BpQ==
X-Received: by 10.84.232.71 with SMTP id f7mr1436086pln.252.1497463670119;
        Wed, 14 Jun 2017 11:07:50 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t2sm1001646pfi.76.2017.06.14.11.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:07:49 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 4/6] setup: teach discover_git_directory to respect the commondir
Date:   Wed, 14 Jun 2017 11:07:37 -0700
Message-Id: <20170614180739.72193-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170614180739.72193-1-bmwill@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
 <20170614180739.72193-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'discover_git_directory' only looks at the gitdir to determine
if a git directory was discovered.  This causes a problem in the event
that the gitdir which was discovered was in fact a per-worktree git
directory and not the common git directory.  This is because the
repository config, which is checked to verify the repository's format,
is stored in the commondir and not in the per-worktree gitdir.  Correct
this behavior by checking the config stored in the commondir.

It will also be of use for callers to have access to the commondir, so
lets also return that upon successfully discovering a git directory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h  | 15 +++++++++------
 config.c | 10 ++++++----
 setup.c  | 17 +++++++++++------
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index fd45b8c55..8fb2dfd27 100644
--- a/cache.h
+++ b/cache.h
@@ -525,12 +525,15 @@ extern void set_git_work_tree(const char *tree);
 
 extern void setup_work_tree(void);
 /*
- * Find GIT_DIR of the repository that contains the current working directory,
- * without changing the working directory or other global state. The result is
- * appended to gitdir. The return value is either NULL if no repository was
- * found, or pointing to the path inside gitdir's buffer.
- */
-extern const char *discover_git_directory(struct strbuf *gitdir);
+ * Find the commondir and gitdir of the repository that contains the current
+ * working directory, without changing the working directory or other global
+ * state. The result is appended to commondir and gitdir.  If the discovered
+ * gitdir does not correspond to a worktree, then 'commondir' and 'gitdir' will
+ * both have the same result appended to the buffer.  The return value is
+ * either 0 upon success and non-zero if no repository was found.
+ */
+extern int discover_git_directory(struct strbuf *commondir,
+				  struct strbuf *gitdir);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
diff --git a/config.c b/config.c
index 990f15dc4..e82e1d987 100644
--- a/config.c
+++ b/config.c
@@ -1655,7 +1655,8 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 void read_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = {0};
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf commondir = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
 
 	opts.respect_includes = 1;
 
@@ -1669,12 +1670,13 @@ void read_early_config(config_fn_t cb, void *data)
 	 * notably, the current working directory is still the same after the
 	 * call).
 	 */
-	else if (discover_git_directory(&buf))
-		opts.git_dir = buf.buf;
+	else if (!discover_git_directory(&commondir, &gitdir))
+		opts.git_dir = gitdir.buf;
 
 	git_config_with_options(cb, data, NULL, &opts);
 
-	strbuf_release(&buf);
+	strbuf_release(&commondir);
+	strbuf_release(&gitdir);
 }
 
 static void git_config_check_init(void);
diff --git a/setup.c b/setup.c
index c6c00463a..c26f1e0a3 100644
--- a/setup.c
+++ b/setup.c
@@ -946,19 +946,21 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	}
 }
 
-const char *discover_git_directory(struct strbuf *gitdir)
+int discover_git_directory(struct strbuf *commondir,
+			   struct strbuf *gitdir)
 {
 	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
+	size_t commondir_offset = commondir->len;
 	struct repository_format candidate;
 
 	if (strbuf_getcwd(&dir))
-		return NULL;
+		return -1;
 
 	cwd_len = dir.len;
 	if (setup_git_directory_gently_1(&dir, gitdir, 0) <= 0) {
 		strbuf_release(&dir);
-		return NULL;
+		return -1;
 	}
 
 	/*
@@ -974,8 +976,10 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
 	}
 
+	get_common_dir(commondir, gitdir->buf + gitdir_offset);
+
 	strbuf_reset(&dir);
-	strbuf_addf(&dir, "%s/config", gitdir->buf + gitdir_offset);
+	strbuf_addf(&dir, "%s/config", commondir->buf + commondir_offset);
 	read_repository_format(&candidate, dir.buf);
 	strbuf_release(&dir);
 
@@ -983,11 +987,12 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		warning("ignoring git dir '%s': %s",
 			gitdir->buf + gitdir_offset, err.buf);
 		strbuf_release(&err);
+		strbuf_setlen(commondir, commondir_offset);
 		strbuf_setlen(gitdir, gitdir_offset);
-		return NULL;
+		return -1;
 	}
 
-	return gitdir->buf + gitdir_offset;
+	return 0;
 }
 
 const char *setup_git_directory_gently(int *nongit_ok)
-- 
2.13.1.518.g3df882009-goog

