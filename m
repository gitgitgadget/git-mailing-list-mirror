From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 21/44] refs-be-files.c: add methods for the ref iterators
Date: Mon, 12 Oct 2015 17:51:42 -0400
Message-ID: <1444686725-27660-23-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2i-0005nc-AQ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbbJLVx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:58 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34017 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbbJLVwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:37 -0400
Received: by qkdo1 with SMTP id o1so53971389qkd.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYCO8pMZujFTGdGyYfwJj2GquaqlYabBCtJ3FQIKRvE=;
        b=NYWUJ9f/m/98UHQrYtCcW71tJxtoXoezs1dTckWQ75FSnVWOa5OuK5I/Qn+YrO3SR0
         C1CWeVukfDVXC/AJkcmywwLdPPnR5PhPtN6C/hSvOdIVBUwWzgnItnNAuIhhftmFAveu
         8cfdOPz7xa2N4iUuF4ivSW+D47/jZP+CaXISf5l8pgrz24EoBg5tHgqr8DB4TLWr7B+a
         7TG1XCf/CEH1mDUyo9zbxpPMljaaba737DKf3sClexaGZOrJYWmHzHWyULhUTcVB/K2v
         G5RzmCzFQIK6+8FTziCgZztFCpQ6o/uN82L07jeW/GzegA83i7oqSA+wWmuLp0xNl5MS
         qAJg==
X-Gm-Message-State: ALoCoQmUHIWsDnQ90pjSHgOsGh9RbqrsdD1g/cRmvCZjzGQF0J52RWqzZfAP4hv6QAgYKy+gaMRp
X-Received: by 10.55.212.157 with SMTP id s29mr35092564qks.100.1444686756487;
        Mon, 12 Oct 2015 14:52:36 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279457>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 41 ++++++++++++++++++++++++----------
 refs.c          | 69 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 refs.h          | 34 +++++++++++++++++++++++++---
 3 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 116d72d..2e2399e 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1862,32 +1862,36 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+static int files_head_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(NULL, fn, cb_data);
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_head_ref_submodule(const char *submodule, each_ref_fn fn,
+				    void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
 }
 
-int for_each_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_submodule(const char *submodule, each_ref_fn fn,
+					void *cb_data)
 {
 	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_in(const char *prefix, each_ref_fn fn,
+				 void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+static int files_for_each_fullref_in(const char *prefix, each_ref_fn fn,
+				     void *cb_data, unsigned int broken)
 {
 	unsigned int flag = 0;
 
@@ -1896,18 +1900,21 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 	return do_for_each_ref(&ref_cache, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_in_submodule(const char *submodule,
+					   const char *prefix,
+					   each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule), prefix, fn,
+			       strlen(prefix), 0, cb_data);
 }
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+
+static int files_for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -1917,7 +1924,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+static int files_for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3635,4 +3642,14 @@ struct ref_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_resolve_gitlink_ref,
+	files_head_ref,
+	files_head_ref_submodule,
+	files_for_each_ref,
+	files_for_each_ref_submodule,
+	files_for_each_ref_in,
+	files_for_each_fullref_in,
+	files_for_each_ref_in_submodule,
+	files_for_each_rawref,
+	files_for_each_namespaced_ref,
+	files_for_each_replace_ref,
 };
diff --git a/refs.c b/refs.c
index 61d90f5..657ab73 100644
--- a/refs.c
+++ b/refs.c
@@ -1042,19 +1042,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	struct strbuf err = STRBUF_INIT;
-	struct ref_transaction *transaction = ref_transaction_begin(&err);
-	if (!transaction)
-		return -1;
-
-	if (the_refs_backend->create_symref(transaction, ref_target,
-					    refs_heads_master, logmsg))
-		return -1;
-
-	if (ref_transaction_commit(transaction, &err))
-		return -1;
-
-	return 0;
+	return the_refs_backend->create_symref(ref_target, refs_heads_master,
+					       logmsg);
 }
 
 int resolve_gitlink_ref(const char *path, const char *refname,
@@ -1062,3 +1051,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
+
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->head_ref(fn, cb_data);
+}
+
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->head_ref_submodule(submodule, fn, cb_data);
+}
+
+int for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref(fn, cb_data);
+}
+
+int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_submodule(submodule, fn, cb_data);
+}
+
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_in(prefix, fn, cb_data);
+}
+
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
+			unsigned int broken)
+{
+	return the_refs_backend->for_each_fullref_in(prefix, fn, cb_data,
+						     broken);
+}
+
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+			      each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_ref_in_submodule(submodule, prefix,
+							   fn, cb_data);
+}
+
+int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_rawref(fn, cb_data);
+}
+
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_namespaced_ref(fn, cb_data);
+}
+
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return the_refs_backend->for_each_replace_ref(fn, cb_data);
+}
diff --git a/refs.h b/refs.h
index ee06a20..6dec0da 100644
--- a/refs.h
+++ b/refs.h
@@ -626,15 +626,33 @@ typedef void ref_transaction_free_fn(struct ref_transaction *transaction);
 typedef const char *resolve_ref_unsafe_fn(const char *ref,
 					  int resolve_flags,
 					  unsigned char *sha1, int *flags);
-typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
+typedef int verify_refname_available_fn(const char *refname,
+					struct string_list *extra,
+					struct string_list *skip,
+					struct strbuf *err);
 typedef int pack_refs_fn(unsigned int flags);
 typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
-typedef int create_symref_fn(struct ref_transaction *transaction,
-			     const char *ref_target,
+typedef int create_symref_fn(const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
 typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
 				   unsigned char *sha1);
+typedef int head_ref_fn(each_ref_fn fn, void *cb_data);
+typedef int head_ref_submodule_fn(const char *submodule, each_ref_fn fn,
+				  void *cb_data);
+typedef int for_each_ref_fn(each_ref_fn fn, void *cb_data);
+typedef int for_each_ref_submodule_fn(const char *submodule, each_ref_fn fn,
+				      void *cb_data);
+typedef int for_each_ref_in_fn(const char *prefix, each_ref_fn fn,
+			       void *cb_data);
+typedef int for_each_fullref_in_fn(const char *prefix, each_ref_fn fn,
+				   void *cb_data, unsigned int broken);
+typedef int for_each_ref_in_submodule_fn(const char *submodule,
+					 const char *prefix,
+					 each_ref_fn fn, void *cb_data);
+typedef int for_each_rawref_fn(each_ref_fn fn, void *cb_data);
+typedef int for_each_namespaced_ref_fn(each_ref_fn fn, void *cb_data);
+typedef int for_each_replace_ref_fn(each_ref_fn fn, void *cb_data);
 
 struct ref_be {
 	struct ref_be *next;
@@ -646,6 +664,16 @@ struct ref_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	resolve_gitlink_ref_fn *resolve_gitlink_ref;
+	head_ref_fn *head_ref;
+	head_ref_submodule_fn *head_ref_submodule;
+	for_each_ref_fn *for_each_ref;
+	for_each_ref_submodule_fn *for_each_ref_submodule;
+	for_each_ref_in_fn *for_each_ref_in;
+	for_each_fullref_in_fn *for_each_fullref_in;
+	for_each_ref_in_submodule_fn *for_each_ref_in_submodule;
+	for_each_rawref_fn *for_each_rawref;
+	for_each_namespaced_ref_fn *for_each_namespaced_ref;
+	for_each_replace_ref_fn *for_each_replace_ref;
 };
 
 
-- 
2.4.2.644.g97b850b-twtrsrc
