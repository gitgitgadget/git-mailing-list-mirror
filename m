Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94766C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8006135C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhETWYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 18:24:51 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:51726 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhETWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 18:24:51 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:12f:f769:9e2d:d907:5e8f:73c3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 42F3146FB71;
        Fri, 21 May 2021 00:22:55 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1621549377; bh=6z+Sju15eVg+4T4RqWV6g+JRPgwHgYmiXvoDqzFpAwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=5mM3t4070yvocqFlDAjUYFtn/9XO1+0xXypKnnHPQ8IJNAVwhZnHcH8+PzW4J5enA
         fiatGj8SgjzGMfAuRzft7dERepX+N6knIpWcpoZM3oFGWz8zoqudd0dEUZxzkmMWWO
         VCi/hhciOeLxPByPmC/qJwaMK7zq+7Pt76n7NHeY=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v3 1/4] cache.h: rename "xdg_config_home" to "xdg_config_home_git"
Date:   Fri, 21 May 2021 00:13:56 +0200
Message-Id: <20210520221359.75615-2-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520221359.75615-1-lenaic@lhuard.fr>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current implementation of `xdg_config_home(str)` returns
`$XDG_CONFIG_HOME/git/$str`, with the `git` subdirectory inserted
between the `XDG_CONFIG_HOME` environment variable and the parameter.

This patch re-purposes `xdg_config_home(…)` to be more generic. It now
only concatenates "$XDG_CONFIG_HOME", or "$HOME/.config" if the former
isn’t defined, with the parameter, without adding `git` in between.
Its parameter is now a format string.

The previous functionality is now provided by a new
`xdg_config_home_git(…)` function whose implementation leverages
`xdg_config_home(…)`.

`xdg_cache_home(…)` has been renamed `xdg_cache_home_git(…)` for
consistency.

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 attr.c                     |  2 +-
 builtin/config.c           |  2 +-
 builtin/credential-cache.c |  2 +-
 builtin/credential-store.c |  2 +-
 cache.h                    | 12 ++++++++++--
 config.c                   |  2 +-
 dir.c                      |  2 +-
 path.c                     | 35 +++++++++++++++++++++++++++--------
 sequencer.c                |  2 +-
 9 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/attr.c b/attr.c
index ac8ec7ce51..0efafbd308 100644
--- a/attr.c
+++ b/attr.c
@@ -831,7 +831,7 @@ static const char *git_etc_gitattributes(void)
 static const char *get_home_gitattributes(void)
 {
 	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
+		git_attributes_file = xdg_config_home_git("attributes");
 
 	return git_attributes_file;
 }
diff --git a/builtin/config.c b/builtin/config.c
index f71fa39b38..8cf2394eb8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -672,7 +672,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (use_global_config) {
 		char *user_config = expand_user_path("~/.gitconfig", 0);
-		char *xdg_config = xdg_config_home("config");
+		char *xdg_config = xdg_config_home_git("config");
 
 		if (!user_config)
 			/*
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 76a6ba3722..4c0b7c4d43 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -94,7 +94,7 @@ static char *get_socket_path(void)
 	if (old_dir && !stat(old_dir, &sb) && S_ISDIR(sb.st_mode))
 		socket = xstrfmt("%s/socket", old_dir);
 	else
-		socket = xdg_cache_home("credential/socket");
+		socket = xdg_cache_home_git("credential/socket");
 	free(old_dir);
 	return socket;
 }
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index ae3c1ba75f..34ca419bb6 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -175,7 +175,7 @@ int cmd_credential_store(int argc, const char **argv, const char *prefix)
 	} else {
 		if ((file = expand_user_path("~/.git-credentials", 0)))
 			string_list_append_nodup(&fns, file);
-		file = xdg_config_home("credentials");
+		file = xdg_config_home_git("credentials");
 		if (file)
 			string_list_append_nodup(&fns, file);
 	}
diff --git a/cache.h b/cache.h
index 148d9ab5f1..34fa48a438 100644
--- a/cache.h
+++ b/cache.h
@@ -1263,19 +1263,27 @@ int is_ntfs_dotgitattributes(const char *name);
  */
 int looks_like_command_line_option(const char *str);
 
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CONFIG_HOME/$fmt..." if $XDG_CONFIG_HOME is non-empty, otherwise
+ * "$HOME/.config/$fmt...". Return NULL upon error.
+ */
+char *xdg_config_home(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
+
 /**
  * Return a newly allocated string with the evaluation of
  * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
  * "$HOME/.config/git/$filename". Return NULL upon error.
  */
-char *xdg_config_home(const char *filename);
+char *xdg_config_home_git(const char *filename);
 
 /**
  * Return a newly allocated string with the evaluation of
  * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, otherwise
  * "$HOME/.cache/git/$filename". Return NULL upon error.
  */
-char *xdg_cache_home(const char *filename);
+char *xdg_cache_home_git(const char *filename);
 
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
diff --git a/config.c b/config.c
index 6428393a41..648ae9b918 100644
--- a/config.c
+++ b/config.c
@@ -1883,7 +1883,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 				  config_fn_t fn, void *data)
 {
 	int ret = 0;
-	char *xdg_config = xdg_config_home("config");
+	char *xdg_config = xdg_config_home_git("config");
 	char *user_config = expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
 	enum config_scope prev_parsing_scope = current_parsing_scope;
diff --git a/dir.c b/dir.c
index 3474e67e8f..3fdba7b6fe 100644
--- a/dir.c
+++ b/dir.c
@@ -2990,7 +2990,7 @@ void setup_standard_excludes(struct dir_struct *dir)
 
 	/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
 	if (!excludes_file)
-		excludes_file = xdg_config_home("ignore");
+		excludes_file = xdg_config_home_git("ignore");
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_patterns_from_file_1(dir, excludes_file,
 					 dir->untracked ? &dir->ss_excludes_file : NULL);
diff --git a/path.c b/path.c
index 7b385e5eb2..15e2143e9f 100644
--- a/path.c
+++ b/path.c
@@ -1498,22 +1498,41 @@ int looks_like_command_line_option(const char *str)
 	return str && str[0] == '-';
 }
 
-char *xdg_config_home(const char *filename)
+char *xdg_config_home(const char *fmt, ...)
 {
 	const char *home, *config_home;
+	struct strbuf buf = STRBUF_INIT;
+	char *out = NULL;
+	va_list args;
+
+	va_start(args, fmt);
+	strbuf_vaddf(&buf, fmt, args);
+	va_end(args);
 
-	assert(filename);
 	config_home = getenv("XDG_CONFIG_HOME");
-	if (config_home && *config_home)
-		return mkpathdup("%s/git/%s", config_home, filename);
+	if (config_home && *config_home) {
+		out = mkpathdup("%s/%s", config_home, buf.buf);
+		goto done;
+	}
 
 	home = getenv("HOME");
-	if (home)
-		return mkpathdup("%s/.config/git/%s", home, filename);
-	return NULL;
+	if (home) {
+		out = mkpathdup("%s/.config/%s", home, buf.buf);
+		goto done;
+	}
+
+done:
+	strbuf_release(&buf);
+	return out;
+}
+
+char *xdg_config_home_git(const char *filename)
+{
+	assert(filename);
+	return xdg_config_home("git/%s", filename);
 }
 
-char *xdg_cache_home(const char *filename)
+char *xdg_cache_home_git(const char *filename)
 {
 	const char *home, *cache_home;
 
diff --git a/sequencer.c b/sequencer.c
index fd183b5593..25f467e685 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1241,7 +1241,7 @@ N_("Your name and email address were configured automatically based\n"
 static const char *implicit_ident_advice(void)
 {
 	char *user_config = expand_user_path("~/.gitconfig", 0);
-	char *xdg_config = xdg_config_home("config");
+	char *xdg_config = xdg_config_home_git("config");
 	int config_exists = file_exists(user_config) || file_exists(xdg_config);
 
 	free(user_config);
-- 
2.31.1

