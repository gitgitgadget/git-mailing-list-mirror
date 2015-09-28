From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 33/43] refs.c: add method for initializing refs db
Date: Mon, 28 Sep 2015 18:02:08 -0400
Message-ID: <1443477738-32023-34-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggX7-00025S-5b
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbbI1WEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:22 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:32922 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbbI1WDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:30 -0400
Received: by qgev79 with SMTP id v79so133380839qge.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cgkVS2/LGcTTJFkUWo3b11FaxKQr5KM+3wxHhQHgAQ8=;
        b=fgpIo6V+BNg6/gKPp+nNeZ/lEBKt5Ig7ZSGtgl4JooUoQjFe32YKgb6yGvmwi27+ky
         vNU/Zi6hDKQw4QDz/Biaf3OU/4Mm0STKmJTC3nqeKhoufJJ7ujB+RkgFRGz+Fk+5mevd
         9gxBuMQ1WPf3vDGcq6KtgS2ELOkSGYDXxgNIrxbRuDMUogchex0ZCPMgKzQbLVsxfrUm
         N+I5Iq3sU0i96/iJGor+a0VB99rlrajrwQv+Gvd6CHm4aK9DekBJ6wIEOSfKY8nymt55
         TylnXSTu17hJq4D0cBcLTAuWx/3gOoNp+wfEXnayvy1SXFLHE8YEiR6IHnTacoYnxeES
         Nklg==
X-Gm-Message-State: ALoCoQn4qH2JoY9xCyxwg6CtLDAkB9Mrp3ulhvUpP7ko4xkHW4uwUGZ+fAbkaEKoNuEks853vZYP
X-Received: by 10.140.235.147 with SMTP id g141mr25319792qhc.22.1443477809808;
        Mon, 28 Sep 2015 15:03:29 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278781>

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
index f0b095c..504a2dc 100644
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
@@ -207,11 +201,11 @@ static int create_default_files(const char *template_path)
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
index ea91afd..0a76c8e 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3738,10 +3738,27 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
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
index 530edcf..930c85c 100644
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
index bd46d0f..64dba64 100644
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
@@ -666,6 +669,7 @@ struct ref_be {
 	struct ref_be *next;
 	const char *name;
 	ref_backend_init_fn init_backend;
+	ref_backend_initdb_fn initdb;
 	ref_transaction_begin_fn transaction_begin;
 	ref_transaction_update_fn transaction_update;
 	ref_transaction_create_fn transaction_create;
-- 
2.4.2.644.g97b850b-twtrsrc
