From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 33/44] refs.c: add method for initializing refs db
Date: Mon, 12 Oct 2015 17:51:54 -0400
Message-ID: <1444686725-27660-35-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1d-0004jW-HD
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbbJLVww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:52 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36441 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbbJLVwu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:50 -0400
Received: by qkht68 with SMTP id t68so63044636qkh.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vUA8F9PkjdNIiY778uA5Z9C65sZj0x29LS7fcuIxHnY=;
        b=CA38u8GxXedbNx5udoXNCCZ3ABH1PPK704xzkmTBHy5KjtD/Mmg/KBD2CpQEaby4F3
         pKuvs7mlNlt4oGHiBvRrXgQXLjU+SxI/eK4AsdSS2SkBzhepV/mQL4xZsNg81HhJksXA
         bVGHUqOXx7q7OPK09uCPGeQvlOzGjTy8HCKolRH98g+qb0F9wUYyNi0T41Vz/M9oJHcm
         IMlT6ji7HjSWFGGomvKW+iFwdu4iDf30kfc10kBhHoQzT9U8tSGJu00Yn8ILGtFxBk5c
         gRRW2pRCekTIMj9U7J3emoDzG/oummM9ztioAzEfHcUV1ke2HM7pxZUFRzxJ5O9cwOaw
         v1eA==
X-Gm-Message-State: ALoCoQlFDXAnzUITZA4ETbgTaf5hm91icvkvrh+1xejWzJlynL9WCREzhAXbQ19uZyMTsXbLZjjl
X-Received: by 10.55.192.15 with SMTP id o15mr35511246qki.2.1444686769860;
        Mon, 12 Oct 2015 14:52:49 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279435>

Alternate refs backends might not need refs/heads and so on, so we make
ref db initialization part of the backend.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c | 14 ++++----------
 refs-be-files.c   | 17 +++++++++++++++++
 refs.c            |  5 +++++
 refs.h            |  4 ++++
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f6f7259..2705739 100644
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
 
+	if (refs_initdb(&err, shared_repository))
+		die("failed to set up refs db: %s", err.buf);
+
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
diff --git a/refs-be-files.c b/refs-be-files.c
index 7560a55..5f2602c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3538,10 +3538,27 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	return -1;
 }
 
+static int files_initdb(struct strbuf *err, int shared)
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
 	files_init_backend,
+	files_initdb,
 	files_transaction_commit,
 	files_initial_transaction_commit,
 	files_for_each_reflog_ent,
diff --git a/refs.c b/refs.c
index 6e41ed8..5fc8eb7 100644
--- a/refs.c
+++ b/refs.c
@@ -1102,6 +1102,11 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 }
 
 /* backend functions */
+int refs_initdb(struct strbuf *err, int shared)
+{
+	return the_refs_backend->initdb(err, shared);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index e3136ee..ce71d33 100644
--- a/refs.h
+++ b/refs.h
@@ -68,6 +68,8 @@ extern int ref_exists(const char *refname);
 
 extern int is_branch(const char *refname);
 
+extern int refs_initdb(struct strbuf *err, int shared);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
@@ -676,6 +678,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 
 /* refs backends */
 typedef void ref_backend_init_fn(void *data);
+typedef int ref_backend_initdb_fn(struct strbuf *err, int shared);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 typedef void ref_transaction_free_fn(struct ref_transaction *transaction);
@@ -737,6 +740,7 @@ struct ref_be {
 	struct ref_be *next;
 	const char *name;
 	ref_backend_init_fn *init_backend;
+	ref_backend_initdb_fn *initdb;
 	ref_transaction_commit_fn *transaction_commit;
 	ref_transaction_commit_fn *initial_transaction_commit;
 	for_each_reflog_ent_fn *for_each_reflog_ent;
-- 
2.4.2.644.g97b850b-twtrsrc
