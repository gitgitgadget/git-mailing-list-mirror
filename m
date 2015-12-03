From: David Turner <dturner@twopensource.com>
Subject: [PATCH 08/16] refs: add methods to init refs backend and db
Date: Wed,  2 Dec 2015 19:35:13 -0500
Message-ID: <1449102921-7707-9-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HtC-0007rt-Jt
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbbLCAgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:18 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37528 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429AbbLCAfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:48 -0500
Received: by igcto18 with SMTP id to18so850893igc.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P9zWFh3II1Jr9OJeLexCVMDorCqDPHFkSIv/K4zdy+g=;
        b=LP/l2j+85VTPVxEQ3ZfWZl1U9U9o3fweRJSwD0SACaSUjJa/ooDJbj6Th6/lnNl2OE
         a2sTJWFrotYbklb7P8ogLfc9Be9uZH4C9lc/xwQnjfxMFJIySQm/EAcfohm4doJtUg9I
         nVCDUJNhM1PZvxddBp2qB8vzcZtG5/Csddh0W4AEvZnH46IRI1o/3bBxaz+NaJ9OchK+
         IlvgTs7mY6pOnXbquH5VrM/jmXODMsP8ogUvdOaO6QFdncsJZDCqLg13MBB0iRHR/gJZ
         UUYkWgBUsdxRyqNI1gtVRGJw9yKXLwo79FUcxJlZbhyfXi2Y1cGx7pj1RkBAv8KBeV3F
         SxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P9zWFh3II1Jr9OJeLexCVMDorCqDPHFkSIv/K4zdy+g=;
        b=NYCPftMO39Xj+4cqAAYzsgxTipRh83oxlogRKQpNXFfoK8wGDM666iwuKM0D8eBnoI
         94pv/ZmmPjcTAh82oCHSDhySy81t0VUoO6e+5CydYlTlpN/wnATImPBNMalutAhxVKdV
         xmebuXeMY329zNtFupeVrKZftzw0aCde757YS33353YgnKu/xiztdUsI1cocqRCHjpnk
         D9dlmy1JYY9M2KrVKFUkxMzTcq0S8M0yTAsvFesnYLkElW2c89JM965y8JSfH8fjQedL
         u0GdwFf2Bix8OYtoHEdWliM79VWhZakoX+eErawJJeBIuwBcMujZg43aDdJ61pEft2IB
         ACXA==
X-Gm-Message-State: ALoCoQntBeweP50Hp34y8HMXt8fTgARSzpWZrBwSBnSbZ++CvW6szAtHqlvlpby1fnSiy4A9a2CF
X-Received: by 10.50.143.4 with SMTP id sa4mr35433607igb.76.1449102948011;
        Wed, 02 Dec 2015 16:35:48 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:47 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281938>

Alternate refs backends might not need the refs/heads directory and so
on, so we make ref db initialization part of the backend.  We also
might need to initialize ref backends themselves, so we'll add a
method for that as well.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c    | 14 ++++----------
 refs.c               |  8 +++++++-
 refs.h               |  4 +++-
 refs/files-backend.c | 23 +++++++++++++++++++++++
 refs/refs-internal.h |  4 ++++
 5 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 26e1cc3..4771e7e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -178,13 +178,7 @@ static int create_default_files(const char *template_path)
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
@@ -208,11 +202,11 @@ static int create_default_files(const char *template_path)
 	 */
 	if (shared_repository) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path_buf(&buf, "refs"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/tags"));
 	}
 
+	if (refs_init_db(&err, shared_repository))
+		die("failed to set up refs db: %s", err.buf);
+
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
diff --git a/refs.c b/refs.c
index 9a2fed7..bdeb276 100644
--- a/refs.c
+++ b/refs.c
@@ -22,13 +22,14 @@ struct ref_be *refs_backends = &refs_be_files;
 /*
  * This function is used to switch to an alternate backend.
  */
-int set_refs_backend(const char *name)
+int set_refs_backend(const char *name, void *data)
 {
 	struct ref_be *be;
 
 	for (be = refs_backends; be; be = be->next)
 		if (!strcmp(be->name, name)) {
 			the_refs_backend = be;
+			be->init_backend(data);
 			return 0;
 		}
 	return 1;
@@ -1109,6 +1110,11 @@ int rename_ref_available(const char *oldname, const char *newname)
 }
 
 /* backend functions */
+int refs_init_db(struct strbuf *err, int shared)
+{
+	return the_refs_backend->init_db(err, shared);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index 4e5477d..c211b9e 100644
--- a/refs.h
+++ b/refs.h
@@ -66,6 +66,8 @@ extern int ref_exists(const char *refname);
 
 extern int is_branch(const char *refname);
 
+extern int refs_init_db(struct strbuf *err, int shared);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
@@ -508,6 +510,6 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
-int set_refs_backend(const char *name);
+int set_refs_backend(const char *name, void *data);
 
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e769242..6600c02 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3313,6 +3313,11 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
+void files_init_backend(void *data)
+{
+	/* do nothing */
+}
+
 static int files_initial_transaction_commit(struct ref_transaction *transaction,
 					    struct strbuf *err)
 {
@@ -3534,9 +3539,27 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	return -1;
 }
 
+static int files_init_db(struct strbuf *err, int shared)
+{
+	/*
+	 * Create .git/refs/{heads,tags}
+	 */
+	safe_create_dir(git_path("refs"), 1);
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
 struct ref_be refs_be_files = {
 	NULL,
 	"files",
+	files_init_backend,
+	files_init_db,
 	files_transaction_commit,
 	files_initial_transaction_commit,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 478ad54..85a0b91 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -208,6 +208,8 @@ const char *find_descendant_ref(const char *dirname,
 int rename_ref_available(const char *oldname, const char *newname);
 
 /* refs backends */
+typedef void ref_backend_init_fn(void *data);
+typedef int ref_backend_init_db_fn(struct strbuf *err, int shared);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 
@@ -267,6 +269,8 @@ typedef int for_each_replace_ref_fn(each_ref_fn fn, void *cb_data);
 struct ref_be {
 	struct ref_be *next;
 	const char *name;
+	ref_backend_init_fn *init_backend;
+	ref_backend_init_db_fn *init_db;
 	ref_transaction_commit_fn *transaction_commit;
 	ref_transaction_commit_fn *initial_transaction_commit;
 
-- 
2.4.2.749.g0ed01d8-twtrsrc
