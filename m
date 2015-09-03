From: David Turner <dturner@twopensource.com>
Subject: [PATCH 18/43] refs-be-files.c: add a backend method structure with transaction functions
Date: Wed,  2 Sep 2015 21:54:48 -0400
Message-ID: <1441245313-11907-19-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:55:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkm-0006Bo-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbbICBzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:45 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33513 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbbICBzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:44 -0400
Received: by qgev79 with SMTP id v79so18594681qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CXiPaPTgTBpYI/95+1P8iPb/eXFCjCSD408Y+M/ePCg=;
        b=QXZ4m8fV6YOZbSUL/WLivQWt99m8Dh91IE/8ma44cixEOh2iCSYUmkiHaWJmUGQ6Cs
         dt6oGhnfsZXuqRC1fvou86jXgyuRsW8a9amxEgylnvcvNW7lutA7ZLCbGnobq8fzrf2F
         KMQQqxAdnLKxFLtQP6OVtIv6Nt2pcxXOwsh1P6L02+/lIsW4QgxwRtoAVzYCwR4gTa/D
         VlZHRkljVlaUipRDzQFtjm5kAhNPQTQkJxN66Y7/SSuQPPa2A14Csuv4fDHFSolbACuo
         Ma2kq4yfm40kwuSjjsls4E95FZqBf/iM1Dec3g2V8eaUD5nd2vIebP8ZcfiqdpdG4U+D
         a9Ag==
X-Gm-Message-State: ALoCoQl0SBu+TxTIUBU7bMZ7ulrHdDC9NJ0D/0MYaK+zGsVzcYsIT3Az8efbP7YZCfzMEUD5ffvB
X-Received: by 10.140.93.53 with SMTP id c50mr2297796qge.59.1441245342918;
        Wed, 02 Sep 2015 18:55:42 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277144>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for backend methods. Start by adding method pointers
for the transaction functions.

Add a function set_refs_backend to switch between backends. The files
based backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 62 ++++++++++++++++++++++++++++-------------------
 refs.c          | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h          | 36 +++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 25 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 21b38cf..e86f1d9 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3307,14 +3307,14 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
-struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+static struct ref_transaction *files_transaction_begin(struct strbuf *err)
 {
 	assert(err);
 
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-void ref_transaction_free(struct ref_transaction *transaction)
+static void files_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3341,12 +3341,12 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   const unsigned char *old_sha1,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+static int files_transaction_update(struct ref_transaction *transaction,
+				  const char *refname,
+				  const unsigned char *new_sha1,
+				  const unsigned char *old_sha1,
+				  unsigned int flags, const char *msg,
+				  struct strbuf *err)
 {
 	struct ref_update *update;
 
@@ -3377,11 +3377,11 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-int ref_transaction_create(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+static int files_transaction_create(struct ref_transaction *transaction,
+				  const char *refname,
+				  const unsigned char *new_sha1,
+				  unsigned int flags, const char *msg,
+				  struct strbuf *err)
 {
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create called without valid new_sha1");
@@ -3389,11 +3389,11 @@ int ref_transaction_create(struct ref_transaction *transaction,
 				      null_sha1, flags, msg, err);
 }
 
-int ref_transaction_delete(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *old_sha1,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+static int files_transaction_delete(struct ref_transaction *transaction,
+				  const char *refname,
+				  const unsigned char *old_sha1,
+				  unsigned int flags, const char *msg,
+				  struct strbuf *err)
 {
 	if (old_sha1 && is_null_sha1(old_sha1))
 		die("BUG: delete called with old_sha1 set to zeros");
@@ -3402,11 +3402,11 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 				      flags, msg, err);
 }
 
-int ref_transaction_verify(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *old_sha1,
-			   unsigned int flags,
-			   struct strbuf *err)
+int files_transaction_verify(struct ref_transaction *transaction,
+			     const char *refname,
+			     const unsigned char *old_sha1,
+			     unsigned int flags,
+			     struct strbuf *err)
 {
 	if (!old_sha1)
 		die("BUG: verify called with old_sha1 set to NULL");
@@ -3432,8 +3432,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				  struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3819,3 +3819,15 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+struct ref_be refs_be_files = {
+	NULL,
+	"files",
+	files_transaction_begin,
+	files_transaction_update,
+	files_transaction_create,
+	files_transaction_delete,
+	files_transaction_verify,
+	files_transaction_commit,
+	files_transaction_free,
+};
diff --git a/refs.c b/refs.c
index 0f4e19a..63cd001 100644
--- a/refs.c
+++ b/refs.c
@@ -4,6 +4,29 @@
 #include "cache.h"
 #include "refs.h"
 #include "lockfile.h"
+/*
+ * We always have a files backend and it is the default.
+ */
+struct ref_be *the_refs_backend = &refs_be_files;
+/*
+ * List of all available backends
+ */
+struct ref_be *refs_backends = &refs_be_files;
+
+/*
+ * This function is used to switch to an alternate backend.
+ */
+int set_refs_backend(const char *name)
+{
+	struct ref_be *be;
+
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name)) {
+			the_refs_backend = be;
+			return 0;
+		}
+	return 1;
+}
 
 static int is_per_worktree_ref(const char *refname)
 {
@@ -877,3 +900,55 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 
 	return ret;
 }
+
+
+/* backend functions */
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+{
+	return the_refs_backend->transaction_begin(err);
+}
+
+
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname, const unsigned char *new_sha1,
+			   const unsigned char *old_sha1, unsigned int flags,
+			   const char *msg, struct strbuf *err)
+{
+	return the_refs_backend->transaction_update(transaction,
+			refname, new_sha1, old_sha1, flags, msg, err);
+}
+
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname, const unsigned char *new_sha1,
+			   unsigned int flags, const char *msg, struct strbuf *err)
+{
+	return the_refs_backend->transaction_create(transaction,
+			refname, new_sha1, flags, msg, err);
+}
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname, const unsigned char *old_sha1,
+			   unsigned int flags, const char *msg,
+			   struct strbuf *err)
+{
+	return the_refs_backend->transaction_delete(transaction,
+			refname, old_sha1, flags, msg, err);
+}
+
+int ref_transaction_verify(struct ref_transaction *transaction,
+			   const char *refname, const unsigned char *old_sha1,
+			   unsigned int flags,
+			   struct strbuf *err)
+{
+	return the_refs_backend->transaction_verify(transaction,
+			refname, old_sha1, flags, err);
+}
+
+int ref_transaction_commit(struct ref_transaction *transaction, struct strbuf *err)
+{
+	return the_refs_backend->transaction_commit(transaction, err);
+}
+
+void ref_transaction_free(struct ref_transaction *transaction)
+{
+	return the_refs_backend->transaction_free(transaction);
+}
diff --git a/refs.h b/refs.h
index e0c6ea1..ba52c8e 100644
--- a/refs.h
+++ b/refs.h
@@ -530,4 +530,40 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+/* refs backends */
+typedef struct ref_transaction *(*ref_transaction_begin_fn)(struct strbuf *err);
+typedef int (*ref_transaction_update_fn)(struct ref_transaction *transaction,
+		const char *refname, const unsigned char *new_sha1,
+		const unsigned char *old_sha1, unsigned int flags,
+		const char *msg, struct strbuf *err);
+typedef int (*ref_transaction_create_fn)(
+		struct ref_transaction *transaction,
+		const char *refname, const unsigned char *new_sha1,
+		unsigned int flags, const char *msg, struct strbuf *err);
+typedef int (*ref_transaction_delete_fn)(struct ref_transaction *transaction,
+		const char *refname, const unsigned char *old_sha1,
+		unsigned int flags, const char *msg, struct strbuf *err);
+typedef int (*ref_transaction_verify_fn)(struct ref_transaction *transaction,
+		const char *refname, const unsigned char *old_sha1,
+		unsigned int flags, struct strbuf *err);
+typedef int (*ref_transaction_commit_fn)(struct ref_transaction *transaction,
+				     struct strbuf *err);
+typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
+
+struct ref_be {
+	struct ref_be *next;
+	const char *name;
+	ref_transaction_begin_fn transaction_begin;
+	ref_transaction_update_fn transaction_update;
+	ref_transaction_create_fn transaction_create;
+	ref_transaction_delete_fn transaction_delete;
+	ref_transaction_verify_fn transaction_verify;
+	ref_transaction_commit_fn transaction_commit;
+	ref_transaction_free_fn transaction_free;
+};
+
+
+extern struct ref_be refs_be_files;
+int set_refs_backend(const char *name);
+
 #endif /* REFS_H */
-- 
2.0.4.315.gad8727a-twtrsrc
