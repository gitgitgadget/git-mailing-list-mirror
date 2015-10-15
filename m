From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 01/26] refs.c: create a public version of verify_refname_available
Date: Thu, 15 Oct 2015 15:46:25 -0400
Message-ID: <1444938410-2345-2-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVo-0007pG-Bk
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbbJOTrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:08 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35948 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbJOTrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:06 -0400
Received: by qkht68 with SMTP id t68so44756802qkh.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ZL1E9DrAo6xoVSSdbMd9VLRidu2+st0W7/shJ13nFM=;
        b=PuA0raFIDQu2+hzS8ycun9+zIUTX0ShAfuboa7TSb8RKcZT6fT6w86scE8d2Go+ALT
         nbniZPQM448STDGbmui0kV2JkEtaLcr0DWBw3ChqOozGF54N/3U76R+GONkwWzEOyuFP
         rT7ZS1McFqOUrpoKYLCK+84r93UdmiSAw/SC7+w4FeAl6mAukm+pfaEci4G3+/c/v9mZ
         QkDT2LpsVSpzMNtxaywoJT3ca22fkeIbr5xvWG1Yu8EnzqdnunCvCV6Q7s2gyhioWQoG
         aiIGmLHdKrM1oGvvm8KKxKxpNqAosU2dYXG0urN8E143sn5tazF39Y9G+NJj4WxAXloi
         Xz6Q==
X-Gm-Message-State: ALoCoQlWd5mprK2enpKPgsRvgB2KToyADmtOuNe1ifQIGaBHp5o4VOKfWNYdVNYLM/XKBAfMmM4g
X-Received: by 10.55.43.37 with SMTP id r37mr14405832qkh.57.1444938425402;
        Thu, 15 Oct 2015 12:47:05 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:04 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279704>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a public version of verify_refname_available that backends can
provide.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 65 ++++++++++++++++++++++++++++++-----------------------------------
 refs.h | 20 ++++++++++++++++++++
 2 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/refs.c b/refs.c
index 132eff5..fe71ea0 100644
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
@@ -897,25 +897,13 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 /*
  * Return 0 if a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.
- * Otherwise, return a negative value and write an explanation to err.
- * If extras is non-NULL, it is a list of additional refnames with
- * which refname is not allowed to conflict. If skip is non-NULL,
- * ignore potential conflicts with refs in skip (e.g., because they
- * are scheduled for deletion in the same operation). Behavior is
- * undefined if the same name is listed in both extras and skip.
- *
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "refs/foo/bar" conflicts
- * with both "refs/foo" and with "refs/foo/bar/baz" but not with
- * "refs/foo/bar" or "refs/foo/barbados".
- *
- * extras and skip must be sorted.
+ * See verify_refname_available for details.
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
@@ -2464,9 +2452,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2479,8 +2470,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
 
@@ -2493,8 +2485,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -3127,10 +3119,7 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip,
-					get_packed_refs(&ref_cache), &err)
-		&& !verify_refname_available(newname, NULL, &skip,
-					     get_loose_refs(&ref_cache), &err);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
 	if (!ret)
 		error("%s", err.buf);
 
@@ -3299,6 +3288,17 @@ static int should_autocreate_reflog(const char *refname)
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
@@ -4334,8 +4334,6 @@ static int ref_present(const char *refname,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
-	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -4378,10 +4376,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
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
index 6d30c98..7367a7f 100644
--- a/refs.h
+++ b/refs.h
@@ -218,6 +218,26 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
 int pack_refs(unsigned int flags);
 
 /*
+ * Return 0 if a reference named refname could be created without
+ * conflicting with the name of an existing reference.
+ * Otherwise, return a negative value and write an explanation to err.
+ * If extras is non-NULL, it is a list of additional refnames with
+ * which refname is not allowed to conflict. If skip is non-NULL,
+ * ignore potential conflicts with refs in skip (e.g., because they
+ * are scheduled for deletion in the same operation). Behavior is
+ * undefined if the same name is listed in both extras and skip.
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
