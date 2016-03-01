From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 11/33] refs: add methods for reflog
Date: Mon, 29 Feb 2016 19:52:44 -0500
Message-ID: <1456793586-22082-12-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:55:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYaY-0007iF-R7
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbcCAAyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:45 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34474 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcCAAxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:39 -0500
Received: by mail-qg0-f54.google.com with SMTP id b67so130616340qgb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PXtdbNS+Vz4tx7+gZFvUXSozxO4TCUbO3wgjM6VmmHQ=;
        b=hIv75KPy1FAO+Z9I/fYocVgCB4vPj82XDu0zvcF4NPEkALFWz87k0tcvvQ3+ai/Q8t
         BtyEWJ1w11h1NlN7UB38uSOKJ4ytZAVogciw1do7UE0Qihxzbu2qFssjn+Zt+VIUFebd
         7OJvvRNenY+9KudoBmOWz+BEMFoQXVHndY4YP76Zti3TRw1PiLiEkPbxnzPAZAzf3GM/
         V1uJpG5A/kPj3OGRtKWxWSZGErfNXP2tmHT3oWFrU7k0ZccdG9ZAHnNevvDPpkwcT8Vk
         k7uxtkZbiZnkyDNE7uhaUq6oSKEBzGSLHDFsrCEFFZKU9RfnzW/9sWNw9fVyN6RNzaFw
         HolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PXtdbNS+Vz4tx7+gZFvUXSozxO4TCUbO3wgjM6VmmHQ=;
        b=G3/GYZpMb0xnzDZqqRs9t4fBSeS31gDsmx30C0F6mtid5cRuqeKYqxcLOgG/yzLxcS
         tC9RnB0qEriJKYfxlOy4hFERSnNoQ8k2TeuU1qorYUtrw5GZ92f543ph3JxkzRbyTUGo
         mvVEW+tI4WkZ70RLjzBWR4JxjfsDfEK3/p6e8fbGQbzsSTVrLWYH2VvOKY4/FUccMqHo
         /7OIu9Di2KIXOZTUS3Afj7pmPd+1hNNRsvgsw9y3AN1s/xSRzzlEQ9ArqiLNACK28YXQ
         2ptAEgbXVbQdUJpe1N2FI840cwZsGpABAej+lQYK/1SSmY7RJ/bVHv64dWuznjV/gAh6
         cVcQ==
X-Gm-Message-State: AD7BkJKvLLBr2qOtg24K1E4fMbl8Rd/X9NtrPOO0a2v7Nnx3H/MOoczypx6HzK3pGcmE9g==
X-Received: by 10.140.180.17 with SMTP id b17mr24026333qha.41.1456793618404;
        Mon, 29 Feb 2016 16:53:38 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:37 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287975>

In the file-based backend, the reflog piggybacks on the ref lock.
Since other backends won't have the same sort of ref lock, ref backends
must also handle reflogs.

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 36 ++++++++++++++++++++++++------------
 refs/refs-internal.h | 27 +++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index cea5997..637df71 100644
--- a/refs.c
+++ b/refs.c
@@ -1353,3 +1353,49 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
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
index 31f38d0..a25fda4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2524,7 +2524,8 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 }
 
 
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
+static int files_create_reflog(const char *refname, int force_create,
+			       struct strbuf *err)
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
@@ -2780,7 +2781,7 @@ static int files_create_symref(const char *refname,
 	return ret;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2788,7 +2789,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2832,7 +2833,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -2934,7 +2937,8 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -2996,7 +3000,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3306,12 +3310,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
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
@@ -3416,6 +3420,14 @@ struct ref_storage_be refs_be_files = {
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
index bb0d588..c92e0c3 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -214,6 +214,25 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
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
@@ -237,6 +256,14 @@ struct ref_storage_be {
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
2.4.2.767.g62658d5-twtrsrc
