From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 01/43] refs.c: create a public version of verify_refname_available
Date: Mon, 28 Sep 2015 18:01:36 -0400
Message-ID: <1443477738-32023-2-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:05:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggY2-0003FJ-Je
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbbI1WC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:02:59 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33649 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbI1WC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:02:57 -0400
Received: by qkas79 with SMTP id s79so9401174qka.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7bxPkkPG0vKB+6GWDzRrOpI6SYpUmtWA3HKsF/SHb3A=;
        b=J562NqrLKdlrZtRYmxG/J8p3OS03DNyg1itcE98mL8D2HS+KRLMIDWQ84E/CF5fsBF
         Lefj88imj0Y5nWFhfRcZhAuoJGcYMlPFHE8rlk+cMOa3GRkSqDztqWvYJnDZpH/AVclN
         giMAaJaI98AxTCot53pJ/r3tXbvd+8mtlKUnPQMVt9q5TjLAy4ytrUmkV/h38p8A0QpR
         fvHyezOdUvwjFsiP7wk8yjzz/LESk7PZS+VpxvgoN5bsLJUncSycLoJHA1pyJfssiTjM
         MZg1w1qzVtKuHESn6PPOhUQKIKO11oacWPAfdoC5lpsmHTW4lcSlY87MsOyyZzFBZeaA
         9dKg==
X-Gm-Message-State: ALoCoQna4Imi2Np8vtglXQSZiGNAXMp4l9goGmlb6XTivqYCu2VFR4179TCFRABoJghBy+MyIOZp
X-Received: by 10.55.198.77 with SMTP id b74mr15685706qkj.8.1443477777043;
        Mon, 28 Sep 2015 15:02:57 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.02.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:02:56 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278798>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a public version of verify_refname_available that backends can
provide.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 51 +++++++++++++++++++++++++++++----------------------
 refs.h | 17 +++++++++++++++++
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 132eff5..ce551e9 100644
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
@@ -2464,9 +2464,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2479,8 +2482,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
 
@@ -2493,8 +2497,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -3127,10 +3131,7 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip,
-					get_packed_refs(&ref_cache), &err)
-		&& !verify_refname_available(newname, NULL, &skip,
-					     get_loose_refs(&ref_cache), &err);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
 	if (!ret)
 		error("%s", err.buf);
 
@@ -3299,6 +3300,17 @@ static int should_autocreate_reflog(const char *refname)
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
@@ -4334,8 +4346,6 @@ static int ref_present(const char *refname,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
-	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -4378,10 +4388,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
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
index 6d30c98..79ea220 100644
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
2.4.2.644.g97b850b-twtrsrc
