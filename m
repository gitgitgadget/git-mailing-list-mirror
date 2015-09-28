From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 18/43] refs-be-files.c: add a backend method structure with transaction functions
Date: Mon, 28 Sep 2015 18:01:53 -0400
Message-ID: <1443477738-32023-19-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggW5-0000rV-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbbI1WDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:18 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33766 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbbI1WDP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:15 -0400
Received: by qgev79 with SMTP id v79so133376242qge.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o4r7wZs61OfIS/lp787+QFbW7KlqR+sQ4NariN2mg+A=;
        b=h1PNsGpZlgGNE0An/HzK5IdstSOTy8LCAGMdxkApWk0wsXnVizRbYwzSC4hwKmsHU1
         4dKiU40noYeHfqhayftwLY8oSIPELX7q7MrpPM94fhnsglOKTQXzVipBQuDVKjoZZyAe
         uxbcbCdEhemyjaNtoUZYD/XYmEoMCAVVYEL2jp8piDed1l0ZO7YJJpcKDrKlaLf0Hzw2
         pu/0tmk5rVd001ksHhHZnNubebe2ey+K+9SV+gQKY9nTaolcPzvW8YQ77YM2YbhCIIdq
         HLiSVYqsLHOlKELjYM3Y9GBwPa6nmXC1cpuurAhMQ6k1ONICJthdZ8+yvs30Uo6By606
         PeTg==
X-Gm-Message-State: ALoCoQkeUVYg83DrqZ0AFhWMZJaFMqCtnk8Ocp/ccTxyzBrXA9gMHCPfcyLGEPn6zST3aUKUZlk/
X-Received: by 10.140.33.201 with SMTP id j67mr25762888qgj.49.1443477794920;
        Mon, 28 Sep 2015 15:03:14 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278763>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for backend methods. Start by adding method pointers
for the transaction functions.

Add a function set_refs_backend to switch between backends. The files
based backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 62 +++++++++++++++++++++++++++-------------------
 refs.c          | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h          | 36 +++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 25 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 05a4b88..6e6f092 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3310,14 +3310,14 @@ struct ref_transaction {
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
 
@@ -3344,12 +3344,12 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
 
@@ -3380,11 +3380,11 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
@@ -3392,11 +3392,11 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
@@ -3405,11 +3405,11 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
@@ -3435,8 +3435,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				  struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3822,3 +3822,15 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index 0f4e19a..98aa357 100644
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
@@ -877,3 +900,57 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 
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
+			   unsigned int flags, const char *msg,
+			   struct strbuf *err)
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
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	return the_refs_backend->transaction_commit(transaction, err);
+}
+
+void ref_transaction_free(struct ref_transaction *transaction)
+{
+	return the_refs_backend->transaction_free(transaction);
+}
diff --git a/refs.h b/refs.h
index 729bc3c..a1db3ef 100644
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
2.4.2.644.g97b850b-twtrsrc
