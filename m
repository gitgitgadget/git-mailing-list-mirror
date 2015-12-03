From: David Turner <dturner@twopensource.com>
Subject: [PATCH 05/16] refs: add methods for reflog
Date: Wed,  2 Dec 2015 19:35:10 -0500
Message-ID: <1449102921-7707-6-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HtJ-00084v-2O
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbbLCAgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:14 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38777 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbbLCAfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:44 -0500
Received: by igbxm8 with SMTP id xm8so836703igb.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=agPBlopJNOVms/BnEJQBYhzvr86RNoocsrsmM/Zm67o=;
        b=oLq7gOFUnkD7kVL8OQ1OEW2EKtFyOPKU5NicJ7YeciOO4hZi1Q06cxmzWjK7Pt328a
         a2UtD6V8VlwXZbWHSv3XH7OgvuWFDG/pUCvRM3JgxzzXxfEQf2zF+QPUVMaD+aF34046
         ZU1QGfcMi7MChbx1E7BKha23DzrUAYOwp9vqjU5ZJfZpkkIlzdSdMM9TFQvt2shIPgc+
         8ZhF5WRkzttO7yW5LQ8jOLCq0gtlpNMZMWc/ev++YsYD+5u5XxybIXH4VPEknQMcD7hy
         ImmaoHRZNPOf6rOxfUjUx4Jph0qjRexeXIxldx8RrGKP45C4wyJtSVZQKAdGvEURx0b2
         IxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=agPBlopJNOVms/BnEJQBYhzvr86RNoocsrsmM/Zm67o=;
        b=nM3CkXGF3Xb4TKSVR1ueQmoCcGj9EwJxZlTg6Mz+8T86bIfQIS3yT8lP5DkchaAmEJ
         c/vm8rZY749V1Ahda4iQ7HU4H9qdG/9hMfXh5NIg/9cyovdbLTJkAP4fp777G6JGFp2g
         vddleRz9WxW3okq/XHEooXQ8wNBYD3Of3S9d2Xk2q7mhoU8woJyTrb2rn9n88Hk0aUhy
         uv/jv3vXGwwi5PDOInYjHSWEu6UTtKC8DhGJq/mogaI7gIHZmmZJVXMjvRUHnw43AHUU
         RUqKOyEAMG+Tp/TCR8bdeoqTa6hSOE22UU/dw3oLLrlPLfOCm/jP7qgtRl44ru7hMbGd
         2DfQ==
X-Gm-Message-State: ALoCoQk/mx+VJmTjhYfpSsyeYYbJfqqOABgCqznVlgP2EWDvRL9yxUjojHa+RT3lKxB1jcTk3Xds
X-Received: by 10.50.225.38 with SMTP id rh6mr35303029igc.13.1449102943595;
        Wed, 02 Dec 2015 16:35:43 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:42 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281941>

In the file-based backend, the reflog piggybacks on the ref lock.
Since other backends won't have the same sort of ref lock, ref backends
must also handle reflogs.

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 36 ++++++++++++++++++++++++------------
 refs/refs-internal.h | 27 +++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index b9b0244..a8ed77d 100644
--- a/refs.c
+++ b/refs.c
@@ -1204,3 +1204,49 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return the_refs_backend->for_each_replace_ref(fn, cb_data);
 }
+
+int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
+				void *cb_data)
+{
+	return the_refs_backend->for_each_reflog_ent_reverse(refname, fn,
+							     cb_data);
+}
+
+int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
+			void *cb_data)
+{
+	return the_refs_backend->for_each_reflog_ent(refname, fn, cb_data);
+}
+
+int for_each_reflog(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_reflog(fn, cb_data);
+}
+
+int reflog_exists(const char *refname)
+{
+	return the_refs_backend->reflog_exists(refname);
+}
+
+int safe_create_reflog(const char *refname, int force_create,
+		       struct strbuf *err)
+{
+	return the_refs_backend->create_reflog(refname, force_create, err);
+}
+
+int delete_reflog(const char *refname)
+{
+	return the_refs_backend->delete_reflog(refname);
+}
+
+int reflog_expire(const char *refname, const unsigned char *sha1,
+		  unsigned int flags,
+		  reflog_expiry_prepare_fn prepare_fn,
+		  reflog_expiry_should_prune_fn should_prune_fn,
+		  reflog_expiry_cleanup_fn cleanup_fn,
+		  void *policy_cb_data)
+{
+	return the_refs_backend->reflog_expire(refname, sha1, flags,
+					       prepare_fn, should_prune_fn,
+					       cleanup_fn, policy_cb_data);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bde4892..1f76e34 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2643,7 +2643,8 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 }
 
 
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
+static int files_create_reflog(const char *refname, int force_create,
+			       struct strbuf *err)
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
@@ -2899,7 +2900,7 @@ static int files_create_symref(const char *ref_target,
 	return 0;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2907,7 +2908,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2951,7 +2952,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -3053,7 +3056,8 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -3115,7 +3119,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3425,12 +3429,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-int reflog_expire(const char *refname, const unsigned char *sha1,
-		 unsigned int flags,
-		 reflog_expiry_prepare_fn prepare_fn,
-		 reflog_expiry_should_prune_fn should_prune_fn,
-		 reflog_expiry_cleanup_fn cleanup_fn,
-		 void *policy_cb_data)
+static int files_reflog_expire(const char *refname, const unsigned char *sha1,
+			       unsigned int flags,
+			       reflog_expiry_prepare_fn prepare_fn,
+			       reflog_expiry_should_prune_fn should_prune_fn,
+			       reflog_expiry_cleanup_fn cleanup_fn,
+			       void *policy_cb_data)
 {
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
@@ -3535,6 +3539,14 @@ struct ref_be refs_be_files = {
 	"files",
 	files_transaction_commit,
 
+	files_for_each_reflog_ent,
+	files_for_each_reflog_ent_reverse,
+	files_for_each_reflog,
+	files_reflog_exists,
+	files_create_reflog,
+	files_delete_reflog,
+	files_reflog_expire,
+
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 433d0fe..798dee9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -211,6 +211,25 @@ int rename_ref_available(const char *oldname, const char *newname);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 
+/* reflog functions */
+typedef int for_each_reflog_ent_fn(const char *refname,
+				   each_reflog_ent_fn fn,
+				   void *cb_data);
+typedef int for_each_reflog_ent_reverse_fn(const char *refname,
+					   each_reflog_ent_fn fn,
+					   void *cb_data);
+typedef int for_each_reflog_fn(each_ref_fn fn, void *cb_data);
+typedef int reflog_exists_fn(const char *refname);
+typedef int create_reflog_fn(const char *refname, int force_create,
+			     struct strbuf *err);
+typedef int delete_reflog_fn(const char *refname);
+typedef int reflog_expire_fn(const char *refname, const unsigned char *sha1,
+			     unsigned int flags,
+			     reflog_expiry_prepare_fn prepare_fn,
+			     reflog_expiry_should_prune_fn should_prune_fn,
+			     reflog_expiry_cleanup_fn cleanup_fn,
+			     void *policy_cb_data);
+
 /* misc methods */
 typedef int pack_refs_fn(unsigned int flags);
 typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
@@ -249,6 +268,14 @@ struct ref_be {
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
 
+	for_each_reflog_ent_fn *for_each_reflog_ent;
+	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
+	for_each_reflog_fn *for_each_reflog;
+	reflog_exists_fn *reflog_exists;
+	create_reflog_fn *create_reflog;
+	delete_reflog_fn *delete_reflog;
+	reflog_expire_fn *reflog_expire;
+
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
-- 
2.4.2.749.g0ed01d8-twtrsrc
