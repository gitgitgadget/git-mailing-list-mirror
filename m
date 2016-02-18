From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 10/27] refs: add methods to init refs db
Date: Thu, 18 Feb 2016 00:17:33 -0500
Message-ID: <1455772670-21142-11-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzK-0001Hk-2u
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424868AbcBRFSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:44 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34428 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424573AbcBRFSk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:40 -0500
Received: by mail-qk0-f175.google.com with SMTP id x1so14776539qkc.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+eKdIdCHCCDiqEmnPzny3453yIxpcQsrSoF4pX30xHw=;
        b=CLrz0cN7OBXXSeS6EJyLcpWprwQRyQftOOuTDPhaW6yPkK4tZ05CptQ/78qD/GO0ec
         pmQuhuBvjlC0Ywfe32SFcSOawwdR7BbcYJQYCi72bwQ/CQGxV5dNR2XKeZCUL94W0+6s
         tVMbPh+EgKsdqGBddielES7OUbJDTPXETwHD8A1Q/wWjDmGimC2MubA6JmB3rNc/VmDu
         xrXIl+f/Wdppk15J9MB2rXgbCt3ZO3PY0jiX9SoBAt+CKZ/jcwUCKhrwyLaNwQwXoRT5
         eQ/EuNvjxm7Dplv1hH/q14uIAM50YS+xQ6iAH3WOwOyHR8OECWnOo2I9muaCLZIhr29y
         gX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+eKdIdCHCCDiqEmnPzny3453yIxpcQsrSoF4pX30xHw=;
        b=ELfV0vtkgufc6w6ykjWxeA8wtM4CEZFZzlt6qqCcCZVhwJrHIrIxad5RzQgnLyP1WL
         4nJoDxuWPG8b2ZyooAWLKq88JRTawdzjS//x3/jgM/dxz3cRklyZGcvlaIuxWqMZjpqD
         yHaPGURO6xlyCwwU3kNvhkGl+H6ZaI0eeexhclmwugMMCaL29Jd6QzXgME16i36S+7LN
         gKpw0W/dtrWKYFq+9ejntMp84epHiI2H/x31LIn3r9SVJygFaxx1glBnqjOYA5ENYYwF
         cMAsgsnADKRKn36H5VtxGnjelKhr/E6mN1ddV+8Gfu6EpupRsk48ui3AHISyCSI1uUrj
         zTOQ==
X-Gm-Message-State: AG10YOSheilYtVwqo+2iRM3+/15g0uNDljkrhdQMHGBdQIoq2zFAnhni+h37hUQ1V1uAtA==
X-Received: by 10.55.80.135 with SMTP id e129mr4623987qkb.65.1455772719882;
        Wed, 17 Feb 2016 21:18:39 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:39 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286580>

Alternate refs backends might not need the refs/heads directory and so
on, so we make ref db initialization part of the backend.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c    | 20 ++++++++++----------
 refs.c               |  5 +++++
 refs.h               |  2 ++
 refs/files-backend.c | 16 ++++++++++++++++
 refs/refs-internal.h |  2 ++
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 07229d6..0c8f4ac 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -177,13 +177,7 @@ static int create_default_files(const char *template_path)
 	char junk[2];
 	int reinit;
 	int filemode;
-
-	/*
-	 * Create .git/refs/{heads,tags}
-	 */
-	safe_create_dir(git_path_buf(&buf, "refs"), 1);
-	safe_create_dir(git_path_buf(&buf, "refs/heads"), 1);
-	safe_create_dir(git_path_buf(&buf, "refs/tags"), 1);
+	struct strbuf err = STRBUF_INIT;
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -207,12 +201,18 @@ static int create_default_files(const char *template_path)
 	 */
 	if (shared_repository) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path_buf(&buf, "refs"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/tags"));
 	}
 
 	/*
+	 * We need to create a "refs" dir in any case so that older
+	 * versions of git can tell that this is a repository.
+	 */
+	safe_create_dir(git_path("refs"), 1);
+
+	if (refs_init_db(shared_repository, &err))
+		die("failed to set up refs db: %s", err.buf);
+
+	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
diff --git a/refs.c b/refs.c
index 1a24046..e222d02 100644
--- a/refs.c
+++ b/refs.c
@@ -1192,6 +1192,11 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 }
 
 /* backend functions */
+int refs_init_db(int shared, struct strbuf *err)
+{
+	return the_refs_backend->init_db(shared, err);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index 5bc3fbc..feff82e 100644
--- a/refs.h
+++ b/refs.h
@@ -66,6 +66,8 @@ extern int ref_exists(const char *refname);
 
 extern int is_branch(const char *refname);
 
+extern int refs_init_db(int shared, struct strbuf *err);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e3e2b03..5377e3f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3480,9 +3480,25 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	return -1;
 }
 
+static int files_init_db(int shared, struct strbuf *err)
+{
+	/*
+	 * Create .git/refs/{heads,tags}
+	 */
+	safe_create_dir(git_path("refs/heads"), 1);
+	safe_create_dir(git_path("refs/tags"), 1);
+	if (shared) {
+		adjust_shared_perm(git_path("refs"));
+		adjust_shared_perm(git_path("refs/heads"));
+		adjust_shared_perm(git_path("refs/tags"));
+	}
+	return 0;
+}
+
 struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
+	files_init_db,
 	files_transaction_commit,
 	files_initial_transaction_commit,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 466dd34..94227cf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -214,6 +214,7 @@ int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
 /* refs backends */
+typedef int ref_init_db_fn(int shared, struct strbuf *err);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 
@@ -258,6 +259,7 @@ typedef int do_for_each_ref_fn(const char *submodule, const char *base,
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
+	ref_init_db_fn *init_db;
 	ref_transaction_commit_fn *transaction_commit;
 	ref_transaction_commit_fn *initial_transaction_commit;
 
-- 
2.4.2.767.g62658d5-twtrsrc
