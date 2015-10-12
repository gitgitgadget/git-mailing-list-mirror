From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 20/44] refs-be-files.c: add methods for misc ref operations
Date: Mon, 12 Oct 2015 17:51:41 -0400
Message-ID: <1444686725-27660-22-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2j-0005nc-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbbJLVyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:54:01 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:32960 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbbJLVwg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:36 -0400
Received: by qgeb31 with SMTP id b31so28259347qge.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oek7ww8vFlzPMu3NSGHVWxxmWtAW/xeF8Wf5zhLjy3M=;
        b=nBAFQB2eJjyGCxTvaZVoDwxKBNi5P0lpclcUa7ArdCsx5uoLdvQiv621MwrA5q5sTK
         f8lnEuackOg965QfYaIlmZ/60qstD2La0abP0habDFDqMEn1rZCtZ8ng/byvIIQaG0KI
         11gppwHe77lr3Uq20VBIb2WGcYMe4ACrgLl1d+rxuN6iZ0cd/cUQ+4BuTh7cJsL025mh
         weACU8iR3wy/Mq1ExOcby2pogSlj0oANZhBlEtXrrTaQfiU5VSV6YX6qsDSVPLTHVpeg
         5aq2xRtVZ1++dY+I1PsmVdrIvu6aysdnrkXLsaM6CRZtph0AvWTJUi47OwSfDJ9CStsq
         pHWw==
X-Gm-Message-State: ALoCoQmPx4jPqp5om6Opcp52wxU1Kg82ydBPZ7e7KAo/Htm3mITcGSBXNoC3OtCt2NCug1pL3G6n
X-Received: by 10.140.96.53 with SMTP id j50mr15448567qge.100.1444686755306;
        Mon, 12 Oct 2015 14:52:35 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279454>

From: Ronnie Sahlberg <sahlberg@google.com>

Add ref backend methods for:
resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
create_symref, resolve_gitlink_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/init-db.c |  1 +
 cache.h           |  7 +++++++
 refs-be-files.c   | 36 +++++++++++++++++++++++++++---------
 refs.c            | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.h            | 18 ++++++++++++++++++
 5 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index cf6a3c8..313d13f 100644
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
index 3050f1d..116d72d 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1386,7 +1386,8 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname,
+				     unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	char *submodule;
@@ -1618,8 +1619,10 @@ static const char *resolve_ref_1(const char *refname,
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
@@ -1721,7 +1724,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2355,7 +2358,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2677,8 +2680,16 @@ static int should_autocreate_reflog(const char *refname)
 		!strcmp(refname, "HEAD");
 }
 
-int verify_refname_available(const char *newname, struct string_list *extra,
-			     struct string_list *skip, struct strbuf *err)
+/*
+ * Create a reflog for a ref.  If force_create = 0, the reflog will
+ * only be created for certain refs (those for which
+ * should_autocreate_reflog returns non-zero.  Otherwise, create it
+ * regardless of the ref name.  Fill in *err and return -1 on failure.
+ */
+static int files_verify_refname_available(const char *newname,
+					  struct string_list *extra,
+					  struct string_list *skip,
+					  struct strbuf *err)
 {
 	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
@@ -2913,8 +2924,9 @@ static int commit_ref_update(struct ref_lock *lock,
 	return 0;
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master,
-		  const char *logmsg)
+static int files_create_symref(const char *ref_target,
+			       const char *refs_heads_master,
+			       const char *logmsg)
 {
 	char *lockpath = NULL;
 	char ref[1000];
@@ -3617,4 +3629,10 @@ struct ref_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+	files_resolve_ref_unsafe,
+	files_verify_refname_available,
+	files_pack_refs,
+	files_peel_ref,
+	files_create_symref,
+	files_resolve_gitlink_ref,
 };
diff --git a/refs.c b/refs.c
index f930fe0..61d90f5 100644
--- a/refs.c
+++ b/refs.c
@@ -1015,3 +1015,50 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	return the_refs_backend->transaction_commit(transaction, err);
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
index 419abf4..ee06a20 100644
--- a/refs.h
+++ b/refs.h
@@ -623,11 +623,29 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 typedef void ref_transaction_free_fn(struct ref_transaction *transaction);
+typedef const char *resolve_ref_unsafe_fn(const char *ref,
+					  int resolve_flags,
+					  unsigned char *sha1, int *flags);
+typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
+typedef int pack_refs_fn(unsigned int flags);
+typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
+typedef int create_symref_fn(struct ref_transaction *transaction,
+			     const char *ref_target,
+			     const char *refs_heads_master,
+			     const char *logmsg);
+typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
+				   unsigned char *sha1);
 
 struct ref_be {
 	struct ref_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+	resolve_ref_unsafe_fn *resolve_ref_unsafe;
+	verify_refname_available_fn *verify_refname_available;
+	pack_refs_fn *pack_refs;
+	peel_ref_fn *peel_ref;
+	create_symref_fn *create_symref;
+	resolve_gitlink_ref_fn *resolve_gitlink_ref;
 };
 
 
-- 
2.4.2.644.g97b850b-twtrsrc
