Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB3C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AFA2081E
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wcj7VsB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAMMsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37778 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728778AbgAMMsD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE05A60426
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919682;
        bh=p6LyMHfLO9C/x/4+XyDdKQB8BT4dmp10KBhfSzaqfdY=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=wcj7VsB5BIhoJpmQemxLFwJJi57tohRv2ooN69+y1J5LK1NraOIW6+L6hi46/AICx
         K470R4FcYSjyhAXa9CCKKUHvUkahTo1r5XMOOC3N+Xjy7n+lJe2q6vHXoEk7csljap
         DRLp2HKUMHMiwD67/3y2T2TM+Vfe+oEU9ldh4rfl25x61OyLIJGKUWyRdeXz2/9exs
         eGNrub+83WuzbVPiZfNaYmeTgMLC8Wqs7DzUTeaHn2LSHIAkQoUmmltCoeA+J5VAia
         JzZ9GLzrlndUGEGfM0gSXhfL4AimX+mOn71mZXH/kUiYC9uTlCojYq6H86bZvm4yrL
         DiypbidSzh0oEzlM5An8tvoPPF/xJwrUx7N6oNyWM5s7/gf312HVInGVV0auvd9KkC
         CDgIyFDDuJSfWvMCKUdkgFXR8nB3KewaClErQrbZAIou97NJGuzatgTMzsMgFYCYA7
         D+ASR9CTfOrmqvdfiutYKuK4Q+xr61wR/qGvazDib3dXz00jVEY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 11/22] builtin/init-db: allow specifying hash algorithm on command line
Date:   Mon, 13 Jan 2020 12:47:18 +0000
Message-Id: <20200113124729.3684846-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow the user to specify the hash algorithm on the command line by
using the --object-format option to git init.  Validate that the user is
not attempting to reinitialize a repository with a different hash
algorithm.  Ensure that if we are writing a non-SHA-1 repository that we
set the repository version to 1 and write the objectFormat extension.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-init.txt |  7 +++++-
 builtin/clone.c            |  2 +-
 builtin/init-db.c          | 47 +++++++++++++++++++++++++++++++++-----
 cache.h                    |  3 ++-
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 32880aafb0..adc6adfd38 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
-	  [--separate-git-dir <git dir>]
+	  [--separate-git-dir <git dir>] [--object-format=<format]
 	  [--shared[=<permissions>]] [directory]
 
 
@@ -48,6 +48,11 @@ Only print error and warning messages; all other output will be suppressed.
 Create a bare repository. If `GIT_DIR` environment is not set, it is set to the
 current working directory.
 
+--object-format=<format>::
+
+Specify the given object format (hash algorithm) for the repository.  The valid
+values are 'sha1' and (if enabled) 'sha256'.  'sha1' is the default.
+
 --template=<template_directory>::
 
 Specify the directory from which templates will be used.  (See the "TEMPLATE
diff --git a/builtin/clone.c b/builtin/clone.c
index 0fc89ae2b9..df895133b3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1096,7 +1096,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_db(git_dir, real_git_dir, option_template, INIT_DB_QUIET);
+	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
 
 	if (real_git_dir)
 		git_dir = real_git_dir;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index b11f07064d..acb1fa1ad9 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -177,7 +177,8 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 }
 
 static int create_default_files(const char *template_path,
-				const char *original_git_dir)
+				const char *original_git_dir,
+				const struct repository_format *fmt)
 {
 	struct stat st1;
 	struct strbuf buf = STRBUF_INIT;
@@ -187,6 +188,7 @@ static int create_default_files(const char *template_path,
 	int reinit;
 	int filemode;
 	struct strbuf err = STRBUF_INIT;
+	int repo_version = GIT_REPO_VERSION;
 
 	/* Just look for `init.templatedir` */
 	init_db_template_dir = NULL; /* re-set in case it was set before */
@@ -244,11 +246,18 @@ static int create_default_files(const char *template_path,
 			exit(1);
 	}
 
+	if (fmt->hash_algo != GIT_HASH_SHA1)
+		repo_version = GIT_REPO_VERSION_READ;
+
 	/* This forces creation of new config file */
 	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", GIT_REPO_VERSION);
+		  "%d", repo_version);
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
+	if (fmt->hash_algo != GIT_HASH_SHA1)
+		git_config_set("extensions.objectformat",
+			       hash_algos[fmt->hash_algo].name);
+
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
 	filemode = TEST_FILEMODE;
@@ -340,12 +349,26 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 	write_file(git_link, "gitdir: %s", git_dir);
 }
 
+static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash)
+{
+	/*
+	 * If we already have an initialized repo, don't allow the user to
+	 * specify a different algorithm, as that could cause corruption.
+	 * Otherwise, if the user has specified one on the command line, use it.
+	 */
+	if (repo_fmt->version >= 0 && hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
+		die(_("attempt to reinitialize repository with different hash"));
+	else if (hash != GIT_HASH_UNKNOWN)
+		repo_fmt->hash_algo = hash;
+}
+
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, unsigned int flags)
+	    const char *template_dir, int hash, unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -378,9 +401,11 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format(NULL);
+	check_repository_format(&repo_fmt);
 
-	reinit = create_default_files(template_dir, original_git_dir);
+	validate_hash_algorithm(&repo_fmt, hash);
+
+	reinit = create_default_files(template_dir, original_git_dir, &repo_fmt);
 
 	create_object_directory();
 
@@ -482,6 +507,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *work_tree;
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
+	const char *object_format = NULL;
+	int hash_algo = GIT_HASH_UNKNOWN;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
@@ -494,6 +521,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING(0, "object-format", &object_format, N_("hash"),
+			   N_("specify the hash algorithm to use")),
 		OPT_END()
 	};
 
@@ -546,6 +575,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		free(cwd);
 	}
 
+	if (object_format) {
+		hash_algo = hash_algo_by_name(object_format);
+		if (hash_algo == GIT_HASH_UNKNOWN)
+			die(_("unknown hash algorithm '%s'"), object_format);
+	}
+
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
 
@@ -597,5 +632,5 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	UNLEAK(work_tree);
 
 	flags |= INIT_DB_EXIST_OK;
-	return init_db(git_dir, real_git_dir, template_dir, flags);
+	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
 }
diff --git a/cache.h b/cache.h
index 75f95f6f10..14321f55da 100644
--- a/cache.h
+++ b/cache.h
@@ -627,7 +627,8 @@ int path_inside_repo(const char *prefix, const char *path);
 #define INIT_DB_EXIST_OK 0x0002
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, unsigned int flags);
+	    const char *template_dir, int hash_algo,
+	    unsigned int flags);
 
 void sanitize_stdfds(void);
 int daemonize(void);
