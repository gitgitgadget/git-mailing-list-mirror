From: David Turner <dturner@twopensource.com>
Subject: [PATCH 19/43] refs-be-files.c: add methods for misc ref operations
Date: Wed,  2 Sep 2015 21:54:49 -0400
Message-ID: <1441245313-11907-20-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkw-0006JW-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbbICBz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:58 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33519 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbbICBzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:44 -0400
Received: by qgev79 with SMTP id v79so18594875qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WpPr2gvYepIwnZFTD0G8mDPDP4yvo4tJCL9bP7eFKlA=;
        b=h2Nk0YOy5DFNsr1yY8ezSNACaFOHN9RzN7QML+Qdn7CzEKieRRuUb2hRJ5lckqG884
         SHUz21SwvwuzxZI3/U61RMAZIvWhuDPq50lQd0bjR1wUBlb1oHH/xn8eeNIYhWgEYtVi
         7+zgIICBTmO47FoCRo1FugLgEUXhbvoZNYHkV9zqlqmeYbK5USyTfrBJeA0i0eMNTYPh
         29EpIP3iDrYiJTf9xQdfUez9Xc1U9Ui8LjjH1oi122xTsj1a+N9atEVdoS/PGf20Wdu0
         W2NyATnjMS6LTmzhrbp6cRGiiRJBPNJXFo2zF+chv9k5urdhOqIb4w1utt/3MpdQsMSN
         iZHw==
X-Gm-Message-State: ALoCoQmCB+l+yideSKBUYXxKCffawpFKtX94FUbickBj/8mFK2pZcPvOR3wurJd8VtnMQf05Q69F
X-Received: by 10.140.109.36 with SMTP id k33mr2316591qgf.12.1441245343973;
        Wed, 02 Sep 2015 18:55:43 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277146>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/init-db.c |  1 +
 cache.h           |  7 +++++++
 refs-be-files.c   | 31 ++++++++++++++++++++++---------
 refs.c            | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.h            | 18 ++++++++++++++++++
 5 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 69323e1..04caee1 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "refs.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
diff --git a/cache.h b/cache.h
index f0a35ca..98b13a8 100644
--- a/cache.h
+++ b/cache.h
@@ -1072,6 +1072,13 @@ extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as s
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
+/*
+ * Return true iff abbrev_name is a possible abbreviation for
+ * full_name according to the rules defined by ref_rev_parse_rules in
+ * refs.c.
+ */
+extern int refname_match(const char *abbrev_name, const char *full_name);
+
 extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
diff --git a/refs-be-files.c b/refs-be-files.c
index e86f1d9..15212bd 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1433,7 +1433,8 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname,
+				     unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	char *submodule;
@@ -1667,8 +1668,10 @@ static const char *resolve_ref_unsafe_1(const char *refname,
 	}
 }
 
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
+static const char *files_resolve_ref_unsafe(const char *refname,
+					    int resolve_flags,
+					    unsigned char *sha1,
+					    int *flags)
 {
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *ret = resolve_ref_unsafe_1(refname, resolve_flags,
@@ -1765,7 +1768,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2399,7 +2402,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2721,8 +2724,10 @@ static int should_autocreate_reflog(const char *refname)
 		!strcmp(refname, "HEAD");
 }
 
-int verify_refname_available(const char *newname, struct string_list *extra,
-			     struct string_list *skip, struct strbuf *err)
+static int files_verify_refname_available(const char *newname,
+					  struct string_list *extra,
+					  struct string_list *skip,
+					  struct strbuf *err)
 {
 	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
@@ -2957,8 +2962,10 @@ static int commit_ref_update(struct ref_lock *lock,
 	return 0;
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master,
-		  const char *logmsg)
+static int files_create_symref(struct ref_transaction *trans,
+			       const char *ref_target,
+			       const char *refs_heads_master,
+			       const char *logmsg)
 {
 	char *lockpath = NULL;
 	char ref[1000];
@@ -3830,4 +3837,10 @@ struct ref_be refs_be_files = {
 	files_transaction_verify,
 	files_transaction_commit,
 	files_transaction_free,
+	files_resolve_ref_unsafe,
+	files_verify_refname_available,
+	files_pack_refs,
+	files_peel_ref,
+	files_create_symref,
+	files_resolve_gitlink_ref,
 };
diff --git a/refs.c b/refs.c
index 63cd001..c1154e0 100644
--- a/refs.c
+++ b/refs.c
@@ -952,3 +952,50 @@ void ref_transaction_free(struct ref_transaction *transaction)
 {
 	return the_refs_backend->transaction_free(transaction);
 }
+
+const char *resolve_ref_unsafe(const char *ref, int resolve_flags,
+			       unsigned char *sha1, int *flags)
+{
+	return the_refs_backend->resolve_ref_unsafe(ref, resolve_flags, sha1,
+						    flags);
+}
+
+int verify_refname_available(const char *refname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err)
+{
+	return the_refs_backend->verify_refname_available(refname, extra, skip, err);
+}
+
+int pack_refs(unsigned int flags)
+{
+	return the_refs_backend->pack_refs(flags);
+}
+
+int peel_ref(const char *refname, unsigned char *sha1)
+{
+	return the_refs_backend->peel_ref(refname, sha1);
+}
+
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
+{
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = ref_transaction_begin(&err);
+	if (!transaction)
+		return -1;
+
+	if (the_refs_backend->create_symref(transaction, ref_target,
+					    refs_heads_master, logmsg))
+		return -1;
+
+	if (ref_transaction_commit(transaction, &err))
+		return -1;
+
+	return 0;
+}
+
+int resolve_gitlink_ref(const char *path, const char *refname,
+			unsigned char *sha1)
+{
+	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
+}
diff --git a/refs.h b/refs.h
index ba52c8e..0c16aad 100644
--- a/refs.h
+++ b/refs.h
@@ -549,6 +549,18 @@ typedef int (*ref_transaction_verify_fn)(struct ref_transaction *transaction,
 typedef int (*ref_transaction_commit_fn)(struct ref_transaction *transaction,
 				     struct strbuf *err);
 typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
+typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
+					     int resolve_flags,
+					     unsigned char *sha1, int *flags);
+typedef int (*verify_refname_available_fn)(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
+typedef int (*pack_refs_fn)(unsigned int flags);
+typedef int (*peel_ref_fn)(const char *refname, unsigned char *sha1);
+typedef int (*create_symref_fn)(struct ref_transaction *transaction,
+				const char *ref_target,
+				const char *refs_heads_master,
+				const char *logmsg);
+typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
+				      unsigned char *sha1);
 
 struct ref_be {
 	struct ref_be *next;
@@ -560,6 +572,12 @@ struct ref_be {
 	ref_transaction_verify_fn transaction_verify;
 	ref_transaction_commit_fn transaction_commit;
 	ref_transaction_free_fn transaction_free;
+	resolve_ref_unsafe_fn resolve_ref_unsafe;
+	verify_refname_available_fn verify_refname_available;
+	pack_refs_fn pack_refs;
+	peel_ref_fn peel_ref;
+	create_symref_fn create_symref;
+	resolve_gitlink_ref_fn resolve_gitlink_ref;
 };
 
 
-- 
2.0.4.315.gad8727a-twtrsrc
