From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 15/20] init: allow alternate backends to be set for new repos
Date: Thu, 14 Jan 2016 11:26:12 -0500
Message-ID: <1452788777-24954-16-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkkE-0002fi-JA
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbcANQ1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:27:17 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35390 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbcANQ0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:48 -0500
Received: by mail-qg0-f53.google.com with SMTP id o11so486492921qge.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q6XdBIo6hC7AprH81wSi/0OLUYFpGuQ5bWy5xPdHogU=;
        b=W4GsX0CdMsdDlAukIKSbEzHiK6JXdiyP4pzqy2k25DyLd0aOqsc7iLuAe+CRISDgp0
         xbqMdyodUGxEOIsNR8p314Doi7N4lyCPXJ1VDNXmS9REnQMPADZSDjutMECKsl53SQ8H
         bUN3p0ontmGCuIfhcAG6cud4FBxp7xf0p3ocuWEVdEHwz/QIF9KrFLBYVf4S28q4oLRS
         Qfr2G3jMNDdRsSR+UP0iRQStNikyiw7XPn2qOzbD3DrkE2LFvG3BUcqNUI3NmW+BE6sp
         fubFPGRaXgnj3hpWcbaK2vk76Zr6h9BKtAGKkjpdPiU1Jf+Mz/DphcJnUdwfTszkiDKI
         5hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q6XdBIo6hC7AprH81wSi/0OLUYFpGuQ5bWy5xPdHogU=;
        b=WWk/Orgof6r3G/dQB+He03IbnV0FYWq+d07v35l+QxjgEcVfQMWFy58vn9j/v0/6NK
         B+psYYRoB9OU8AgA2oLjSAFuJEJrVHdAd2xug4WEBJZf9C3fioheZb61h/sj9M5jyH28
         8Epwp3QOtpZ5CSe4Ar7UtAbj8Y8Xh17ZBSP812x5YwGfj03S0N/CAqSH3Q6uOUcykAy/
         ZtVq1zN0JZy23hNIauPx58I5Bwh2ph2fGAuqXog0KBYQp0HMUHc1BIN/zcunL0M79haW
         goHpKCsbQ8+FhuCVfIS75ua6hMphW9e+9L+7+zHvjempS/MnbVnqiW2jm2cIFgl8SHTn
         VNwQ==
X-Gm-Message-State: ALoCoQlHu+hB6GbniBTnX3yDrHLgxCDPI9knHAIij2HqoBpRZfl63GIN1IeoXr9zFuv8+qaFo9ZOIemW/q/NNb1nakLLq2upcA==
X-Received: by 10.140.86.243 with SMTP id p106mr6795729qgd.1.1452788808121;
        Thu, 14 Jan 2016 08:26:48 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:47 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284050>

git init learns a new argument --ref-storage.  Presently, only
"files" is supported, but later we will add other backends.

When this argument is used, the repository's extensions.refStorage
configuration value is set (as well as core.repositoryformatversion),
and the refs backend's initdb function is used to set up the ref
database.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-init-db.txt |  2 +-
 Documentation/git-init.txt    |  7 ++++++-
 builtin/init-db.c             | 31 ++++++++++++++++++++++++++-----
 cache.h                       |  2 ++
 path.c                        | 29 +++++++++++++++++++++++++++--
 refs.c                        |  8 ++++++++
 refs.h                        |  8 ++++++++
 setup.c                       | 12 ++++++++++++
 t/t0001-init.sh               | 24 ++++++++++++++++++++++++
 9 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd..d03fb69 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]] [--ref-storage=<name>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..d2b150f 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>]
 	  [--shared[=<permissions>]] [directory]
-
+	  [--ref-storage=<name>]
 
 DESCRIPTION
 -----------
@@ -113,6 +113,11 @@ does not exist, it will be created.
 
 --
 
+--ref-storage=<name>::
+Type of refs storage backend. Default is to use the original "files"
+storage, which stores ref data in files in .git/refs and
+.git/packed-refs.
+
 TEMPLATE DIRECTORY
 ------------------
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4771e7e..ebc747c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -24,6 +24,7 @@ static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 static const char *git_link;
+static char *requested_ref_storage_backend;
 
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
@@ -179,6 +180,7 @@ static int create_default_files(const char *template_path)
 	int reinit;
 	int filemode;
 	struct strbuf err = STRBUF_INIT;
+	int repo_version = 0;
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -204,9 +206,6 @@ static int create_default_files(const char *template_path)
 		adjust_shared_perm(get_git_dir());
 	}
 
-	if (refs_init_db(&err, shared_repository))
-		die("failed to set up refs db: %s", err.buf);
-
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
@@ -214,14 +213,34 @@ static int create_default_files(const char *template_path)
 	path = git_path_buf(&buf, "HEAD");
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
-	if (!reinit) {
+	if (reinit) {
+		if (requested_ref_storage_backend &&
+		    strcmp(ref_storage_backend, requested_ref_storage_backend))
+			die("You can't change the refs storage type (was %s; you requested %s)",
+			    ref_storage_backend, requested_ref_storage_backend);
+	} else {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
 	}
 
+	if (requested_ref_storage_backend)
+		ref_storage_backend = requested_ref_storage_backend;
+	if (strcmp(ref_storage_backend, "files")) {
+		git_config_set("extensions.refStorage", ref_storage_backend);
+		git_config_set("core.repositoryformatversion", ref_storage_backend);
+#ifdef USE_LIBLMDB
+		register_ref_storage_backend(&refs_be_lmdb);
+#endif
+		set_ref_storage_backend(ref_storage_backend);
+		repo_version = 1;
+	}
+
+	if (refs_init_db(&err, shared_repository))
+		die("failed to set up refs db: %s", err.buf);
+
 	/* This forces creation of new config file */
 	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", GIT_REPO_VERSION);
+		  "%d", repo_version);
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
 	/* Check filemode trustability */
@@ -469,6 +488,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING(0, "ref-storage", &requested_ref_storage_backend,
+			   N_("name"), N_("name of backend type to use")),
 		OPT_END()
 	};
 
diff --git a/cache.h b/cache.h
index aee1d51..4fb5ba2 100644
--- a/cache.h
+++ b/cache.h
@@ -716,6 +716,8 @@ extern enum object_creation_mode object_creation_mode;
 
 extern char *notes_ref_name;
 
+extern const char *ref_storage_backend;
+
 extern int grafts_replace_parents;
 
 /*
diff --git a/path.c b/path.c
index 8b7e168..2e67a2b 100644
--- a/path.c
+++ b/path.c
@@ -2,6 +2,7 @@
  * Utilities for paths and pathnames
  */
 #include "cache.h"
+#include "refs.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
@@ -511,8 +512,32 @@ int validate_headref(const char *path)
 	int fd;
 	ssize_t len;
 
-	if (lstat(path, &st) < 0)
-		return -1;
+	if (lstat(path, &st) < 0) {
+		int backend_type_set;
+		struct strbuf config_path = STRBUF_INIT;
+		char *pathdup = xstrdup(path);
+		char *git_dir = dirname(pathdup);
+		char *storage = NULL;
+
+		strbuf_addf(&config_path, "%s/%s", git_dir, "config");
+		free(pathdup);
+
+		if (git_config_from_file(ref_storage_backend_config,
+					 config_path.buf, &storage)) {
+			strbuf_release(&config_path);
+			return -1;
+		}
+
+		backend_type_set = !!storage;
+		free((void *)storage);
+		strbuf_release(&config_path);
+		/*
+		 * Alternate backends are assumed to keep HEAD
+		 * in a valid state, so there's no need to do
+		 * further validation.
+		 */
+		return backend_type_set ? 0 : -1;
+	}
 
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
diff --git a/refs.c b/refs.c
index 545823b..9f946d0 100644
--- a/refs.c
+++ b/refs.c
@@ -24,6 +24,14 @@ static struct ref_storage_be *the_refs_backend = &refs_be_files;
  */
 static struct ref_storage_be *refs_backends = &refs_be_files;
 
+const char *ref_storage_backend = "files";
+
+void register_ref_storage_backend(struct ref_storage_be *be)
+{
+	be->next = refs_backends;
+	refs_backends = be;
+}
+
 int set_ref_storage_backend(const char *name)
 {
 	struct ref_storage_be *be;
diff --git a/refs.h b/refs.h
index 4d18886..a916a6b 100644
--- a/refs.h
+++ b/refs.h
@@ -511,8 +511,16 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 void *policy_cb_data);
 
 /*
+ * Read the refdb storage backend name out of the config file
+ */
+int ref_storage_backend_config(const char *var, const char *value, void *ptr);
+
+struct ref_storage_be;
+/*
  * Switch to an alternate ref storage backend.
  */
 int set_ref_storage_backend(const char *name);
 
+void register_ref_storage_backend(struct ref_storage_be *be);
+
 #endif /* REFS_H */
diff --git a/setup.c b/setup.c
index d343725..a329a51 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "refs.h"
 #include "string-list.h"
 
 static int inside_git_dir = -1;
@@ -263,6 +264,15 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 	return ret;
 }
 
+int ref_storage_backend_config(const char *var, const char *value, void *ptr)
+{
+	char **cdata = ptr;
+
+	if (!strcmp(var, "extensions.refstorage"))
+		*cdata = xstrdup(value);
+	return 0;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
@@ -373,6 +383,8 @@ static int check_repo_format(const char *var, const char *value, void *cb)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			repository_format_precious_objects = git_config_bool(var, value);
+		else if (!strcmp(ext, "refstorage"))
+			ref_storage_backend = xstrdup(value);
 		else
 			string_list_append(&unknown_extensions, ext);
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 295aa59..5e77994 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -174,6 +174,30 @@ test_expect_success 'reinit' '
 	test_i18ncmp again/empty again/err2
 '
 
+test_expect_success 'init with bogus storage backend fails' '
+
+	(
+		mkdir again2 &&
+		cd again2 &&
+		git init --ref-storage=test >out2 2>err2
+	)
+'
+
+test_expect_failure 'reinit with changed storage backend fails' '
+
+	(
+		mkdir again3 &&
+		cd again3 &&
+		git init >out1 2>err1 &&
+		git init --ref-storage=test >out2 2>err2
+	) &&
+	test_i18ngrep "Initialized empty" again3/out1 &&
+	test_i18ngrep "Reinitialized existing" again3/out2 &&
+	>again3/empty &&
+	test_i18ncmp again3/empty again3/err1 &&
+	test_i18ncmp again3/empty again3/err2
+'
+
 test_expect_success 'init with --template' '
 	mkdir template-source &&
 	echo content >template-source/file &&
-- 
2.4.2.749.g730654d-twtrsrc
