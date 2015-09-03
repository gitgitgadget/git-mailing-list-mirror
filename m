From: David Turner <dturner@twopensource.com>
Subject: [PATCH 01/43] refs.c: create a public version of verify_refname_available
Date: Wed,  2 Sep 2015 21:54:31 -0400
Message-ID: <1441245313-11907-2-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkZ-00060T-6h
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbbICBz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:29 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35835 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbbICBz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:27 -0400
Received: by qkcj187 with SMTP id j187so15696681qkc.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2xPiD/g+NKYoMSiPjijRNCnWjrgbt2yJyLjw3AkoCt0=;
        b=GQ6nwY3qHDSg2JTS/mk7poT/JCRYIrpAEnfQuZgHNrG84qefTn54C5Xe7m8/xifyND
         0em/TcSU/CZmuZsE+OG6usJQqPPj6gSxaRZddZV3wKnlmvRuXUQ00URdodXaDMNK+tsH
         a3lHzZqhrN6noCymFPFtatxmbXK9uyBrZybqO/X4cdwqAwm/0gesyHCrDLODLb0t5Z+2
         vCO/nJaKM2Mcf82tqSPxAsJB/1Wac+/jRg8RS+zaAtoLSY6/rmUfgAWYHz7W9anZaDlT
         tVzpqpXWSDrdf2rLa3gL8s0oTcj8dy/r8B50bYbjt0qVeAs/CR+qjFFYdnmhrc7jtah0
         uMNA==
X-Gm-Message-State: ALoCoQn2A2dGdIrD81/lBiHppGCR/HJ4mnIs/Bgf8e6BnE6izp9DafMR50qx7sgTRLAMsDa/aPnm
X-Received: by 10.55.221.199 with SMTP id u68mr32608473qku.83.1441245326717;
        Wed, 02 Sep 2015 18:55:26 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277139>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a public version of verify_refname_available that backends can
provide.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs.c | 53 ++++++++++++++++++++++++++++++-----------------------
 refs.h | 17 +++++++++++++++++
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index 8857c02..76b05f1 100644
--- a/refs.c
+++ b/refs.c
@@ -279,7 +279,7 @@ struct ref_dir {
  * presence of an empty subdirectory does not block the creation of a
  * similarly-named reference.  (The fact that reference names with the
  * same leading components can conflict *with each other* is a
- * separate issue that is regulated by verify_refname_available().)
+ * separate issue that is regulated by verify_refname_available_dir().)
  *
  * Please note that the name field contains the fully-qualified
  * reference (or subdirectory) name.  Space could be saved by only
@@ -911,11 +911,11 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
  *
  * extras and skip must be sorted.
  */
-static int verify_refname_available(const char *refname,
-				    const struct string_list *extras,
-				    const struct string_list *skip,
-				    struct ref_dir *dir,
-				    struct strbuf *err)
+static int verify_refname_available_dir(const char *refname,
+					const struct string_list *extras,
+					const struct string_list *skip,
+					struct ref_dir *dir,
+					struct strbuf *err)
 {
 	const char *slash;
 	int pos;
@@ -2462,9 +2462,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		 */
 		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
 		if (remove_empty_directories(&orig_ref_file)) {
+			struct ref_dir *loose_refs;
+			loose_refs = get_loose_refs(&ref_cache);
 			last_errno = errno;
-			if (!verify_refname_available(orig_refname, extras, skip,
-						      get_loose_refs(&ref_cache), err))
+			if (!verify_refname_available_dir(orig_refname, extras,
+							  skip, loose_refs,
+							  err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    orig_refname);
 			goto error_return;
@@ -2477,8 +2480,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if (!refname) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-		    !verify_refname_available(orig_refname, extras, skip,
-					      get_loose_refs(&ref_cache), err))
+		    !verify_refname_available_dir(orig_refname, extras, skip,
+						  get_loose_refs(&ref_cache),
+						  err))
 			strbuf_addf(err, "unable to resolve reference %s: %s",
 				    orig_refname, strerror(last_errno));
 
@@ -2491,8 +2495,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_oid(&lock->old_oid) &&
-	    verify_refname_available(refname, extras, skip,
-				     get_packed_refs(&ref_cache), err)) {
+	    verify_refname_available_dir(refname, extras, skip,
+					 get_packed_refs(&ref_cache), err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2827,7 +2831,7 @@ int pack_refs(unsigned int flags)
  *
  * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
  */
-static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
+int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list_item *refname;
@@ -3125,10 +3129,7 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip,
-					get_packed_refs(&ref_cache), &err)
-		&& !verify_refname_available(newname, NULL, &skip,
-					     get_loose_refs(&ref_cache), &err);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
 	if (!ret)
 		error("%s", err.buf);
 
@@ -3297,6 +3298,17 @@ static int should_autocreate_reflog(const char *refname)
 		!strcmp(refname, "HEAD");
 }
 
+int verify_refname_available(const char *newname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err)
+{
+	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
+	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
+	return verify_refname_available_dir(newname, extra, skip,
+					    packed_refs, err) ||
+		verify_refname_available_dir(newname, extra, skip,
+					     loose_refs, err);
+}
+
 /*
  * Create a reflog for a ref.  If force_create = 0, the reflog will
  * only be created for certain refs (those for which
@@ -4332,8 +4344,6 @@ static int ref_present(const char *refname,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
-	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -4376,10 +4386,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
 					     &affected_refnames, NULL,
-					     loose_refs, err) ||
-		    verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
-					     packed_refs, err)) {
+					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index 6e913ee..140aa8b 100644
--- a/refs.h
+++ b/refs.h
@@ -218,6 +218,23 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
 int pack_refs(unsigned int flags);
 
 /*
+ * Return true iff a reference named refname could be created without
+ * conflicting with the name of an existing reference.  If
+ * skip is non-NULL, ignore potential conflicts with refs in skip
+ * (e.g., because they are scheduled for deletion in the same
+ * operation).
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ *
+ * skip must be sorted.
+ */
+int verify_refname_available(const char *newname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err);
+
+/*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
-- 
2.0.4.315.gad8727a-twtrsrc
