From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 19/43] refs-be-files.c: add methods for misc ref operations
Date: Mon, 28 Sep 2015 18:01:54 -0400
Message-ID: <1443477738-32023-20-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXS-0002Y7-2t
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbbI1WEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:43 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35027 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbbI1WDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:17 -0400
Received: by qkap81 with SMTP id p81so74442002qka.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QK8jDWiPb3mwv79NVpiC8IkWjpyqr9bhQ8W3UqCEOk4=;
        b=UZLWhovlrAA6MYvF2vCEHFigBn1N2BDYSYOPTWvPHeT0TMd8mP8aWHYKJZbHYDJecW
         mgVSpBGXPUCJpeE3RzzZZphhZjhenW9Vy/kgZ3wGxGnysCgU+VID+4HVIiHR/xLGMVIc
         lvozKEHV0sXr4GcnGsqzOWEQsYiUptEi4hhYRtHkh2vUpdiMqHykyQZq7GxIoyK6lukI
         pnYJsjPAXmEfWsKBR2K/nH7QgLIu/fxL8t7bH1w00HrSIFEQOw3W/TalP0ID8SYRItp1
         dFw+CLOyFdmvxKz60Fa5sQtdJwrOsWv0/m4gZHUdWi7+5oFON9jbvT9Vq0/j+lFDgR05
         Grbw==
X-Gm-Message-State: ALoCoQlC391yEnX+CBfojEDCtLqmyIhGQvZyTqrHX/TEtzXL8CHH59YS9kPKOPKT2amcD4CQ7Hwt
X-Received: by 10.55.209.210 with SMTP id o79mr25109769qkl.43.1443477796218;
        Mon, 28 Sep 2015 15:03:16 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278789>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 cache.h         |  7 +++++++
 refs-be-files.c | 31 ++++++++++++++++++++++---------
 refs.c          | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h          | 21 +++++++++++++++++++++
 4 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 497d296..1c45b62 100644
--- a/cache.h
+++ b/cache.h
@@ -1104,6 +1104,13 @@ extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as s
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
index 6e6f092..7101e31 100644
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
@@ -1665,8 +1666,10 @@ static const char *resolve_ref_1(const char *refname,
 	}
 }
 
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
+static const char *files_resolve_ref_unsafe(const char *refname,
+					    int resolve_flags,
+					    unsigned char *sha1,
+					    int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct strbuf sb_contents = STRBUF_INIT;
@@ -1768,7 +1771,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2402,7 +2405,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2724,8 +2727,10 @@ static int should_autocreate_reflog(const char *refname)
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
@@ -2960,8 +2965,10 @@ static int commit_ref_update(struct ref_lock *lock,
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
@@ -3833,4 +3840,10 @@ struct ref_be refs_be_files = {
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
index 98aa357..a9901f3 100644
--- a/refs.c
+++ b/refs.c
@@ -954,3 +954,51 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
+	return the_refs_backend->verify_refname_available(refname, extra, skip,
+							  err);
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
index a1db3ef..6e88909 100644
--- a/refs.h
+++ b/refs.h
@@ -549,6 +549,21 @@ typedef int (*ref_transaction_verify_fn)(struct ref_transaction *transaction,
 typedef int (*ref_transaction_commit_fn)(struct ref_transaction *transaction,
 				     struct strbuf *err);
 typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
+typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
+					     int resolve_flags,
+					     unsigned char *sha1, int *flags);
+typedef int (*verify_refname_available_fn)(const char *refname,
+					   struct string_list *extra,
+					   struct string_list *skip,
+					   struct strbuf *err);
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
@@ -560,6 +575,12 @@ struct ref_be {
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
2.4.2.644.g97b850b-twtrsrc
