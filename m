From: David Turner <dturner@twopensource.com>
Subject: [PATCH 32/43] refs.c: add method for initializing refs db
Date: Wed,  2 Sep 2015 21:55:02 -0400
Message-ID: <1441245313-11907-33-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlq-0006tn-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbbICB4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:55 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33773 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbbICB4P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:15 -0400
Received: by qgev79 with SMTP id v79so18601543qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2k/jVehpDrC018CgM75NnzgIpJe9eA6a4BcloEgwjZ8=;
        b=BPrNiUt9Nke++hWFafQvlRp+uyqniOxbb21Wa1qRVLDIBMNmdHB/FIdsTXye16Fk5B
         hAb5oDpHvHVbQtWMPhy2lTnthGqbfn0ePwrViN4ny0s4CazA18+o2vpukm9y+/gJHR2m
         p7mjdNJ3DOB7PRej2+LwR6T26xiewuaDLhMdAKXTFI5TwlDnZvQc+76FnvIhIktsgeEa
         vt6M8Qk/5+x7Bge3rF/m2Mmvxs1xs+gtCsYZ/MsIaO/U/n8SAwEJLXuXOZ8H7xAggq5W
         U2HGGUQZU63IwN6qlygP28GiJ55f9M1LB8v9CAMZeIEztSDQN9nfnfMKpT2gu+Qnysd1
         gsxw==
X-Gm-Message-State: ALoCoQlYhQf/KxKDk0xcJQ4y/MiBi478t3spH4fTdfPmwMKgfuPSq2gJgi/n8teMk1vy5CFE2zLS
X-Received: by 10.140.86.70 with SMTP id o64mr2308100qgd.52.1441245375087;
        Wed, 02 Sep 2015 18:56:15 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277163>

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
index 06f8cca..0ce2baf 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -196,6 +196,7 @@ static int create_default_files(const char *template_path)
 	char junk[2];
 	int reinit;
 	int filemode;
+	struct strbuf err = STRBUF_INIT;
 
 	if (len > sizeof(path)-50)
 		die(_("insane git directory %s"), git_dir);
@@ -204,13 +205,6 @@ static int create_default_files(const char *template_path)
 	if (len && path[len-1] != '/')
 		path[len++] = '/';
 
-	/*
-	 * Create .git/refs/{heads,tags}
-	 */
-	safe_create_dir(git_path("refs"), 1);
-	safe_create_dir(git_path("refs/heads"), 1);
-	safe_create_dir(git_path("refs/tags"), 1);
-
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
 
@@ -233,11 +227,11 @@ static int create_default_files(const char *template_path)
 	 */
 	if (shared_repository) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path("refs"));
-		adjust_shared_perm(git_path("refs/heads"));
-		adjust_shared_perm(git_path("refs/tags"));
 	}
 
+	if (refs_initdb(&err, shared_repository))
+		die("failed to set up refs db: %s", err.buf);
+
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
diff --git a/refs-be-files.c b/refs-be-files.c
index c49d44e..acf35b5 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3722,10 +3722,27 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
 	NULL,
+	files_initdb,
 	files_transaction_begin,
 	files_transaction_update,
 	files_transaction_create,
diff --git a/refs.c b/refs.c
index 002d24d..72dd66c 100644
--- a/refs.c
+++ b/refs.c
@@ -995,6 +995,11 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 }
 
 /* backend functions */
+int refs_initdb(struct strbuf *err, int shared)
+{
+	return the_refs_backend->initdb(err, shared);
+}
+
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return the_refs_backend->transaction_begin(err);
diff --git a/refs.h b/refs.h
index da97a14..3134a28 100644
--- a/refs.h
+++ b/refs.h
@@ -68,6 +68,8 @@ extern int ref_exists(const char *refname);
 
 extern int is_branch(const char *refname);
 
+extern int refs_initdb(struct strbuf *err, int shared);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
@@ -587,6 +589,7 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 
 /* refs backends */
 typedef void (*ref_backend_init_fn)(void *data);
+typedef int (*ref_backend_initdb_fn)(struct strbuf *err, int shared);
 typedef struct ref_transaction *(*ref_transaction_begin_fn)(struct strbuf *err);
 typedef int (*ref_transaction_update_fn)(struct ref_transaction *transaction,
 		const char *refname, const unsigned char *new_sha1,
@@ -653,6 +656,7 @@ struct ref_be {
 	struct ref_be *next;
 	const char *name;
 	ref_backend_init_fn init_backend;
+	ref_backend_initdb_fn initdb;
 	ref_transaction_begin_fn transaction_begin;
 	ref_transaction_update_fn transaction_update;
 	ref_transaction_create_fn transaction_create;
-- 
2.0.4.315.gad8727a-twtrsrc
