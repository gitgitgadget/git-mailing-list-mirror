From: David Turner <dturner@twopensource.com>
Subject: [PATCH 29/43] refs.c: add methods for reflog
Date: Wed,  2 Sep 2015 21:54:59 -0400
Message-ID: <1441245313-11907-30-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlE-0006Td-Lh
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbbICB4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:15 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35051 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbbICB4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:12 -0400
Received: by qkcj187 with SMTP id j187so15702581qkc.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MhNYItrS5drtgp+bop/3M9jZqrrATujMa6rsmspfd6U=;
        b=hSh0c0r7y3tAsdWJ/0+OV5RtnGGSUHGfb8UVBLPu4Auk+wDy60npaeDbq+fSxmH/Yg
         GF7gOMHAuX1xct+Sarn5gaULO+D/thFFE2NgM4xWWkb76SP+Mt9yFJJvqWUdaFBIxmtK
         KgANelOjd3C4sxE89x+OFuMRxPFZdbNOP2cjvBmiX6YuFc/TjMnNDh2IBoHNEylcz1nZ
         K4usKOhAiWeBzoH+NjNuFrZha8r19uTARk2JOfP/1fYFWOeOvi71p5A3Jj+GrDAo0H/r
         ODMlrnhh2UXOEPD2ePCVxyCBW9JR9h9jJ9baXxmgDXt3atwK0sYYIKWSrGUpaIV6nk2o
         5rRw==
X-Gm-Message-State: ALoCoQmUMU+Xz7mMvIywvHUY9Y6x+osadRWONRMbF8EkVMWp/3pA3il31L+5IVfDiEwdxFfVMpyV
X-Received: by 10.55.195.80 with SMTP id a77mr33345083qkj.2.1441245371807;
        Wed, 02 Sep 2015 18:56:11 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277151>

In the file-based backend, the reflog piggybacks on the ref lock.
Since other backends won't have the same sort of ref lock, ref backends
must also handle reflogs.

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource>
---
 refs-be-files.c | 21 +++++++++++++++------
 refs.c          | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h          | 22 ++++++++++++++++++++++
 3 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 6a10d4b..1180799 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2676,7 +2676,7 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 }
 
 
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
+static int files_create_reflog(const char *refname, int force_create, struct strbuf *err)
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
@@ -2925,7 +2925,7 @@ static int files_create_symref(struct ref_transaction *trans,
 	return 0;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2933,7 +2933,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2977,7 +2977,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -3079,7 +3081,8 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -3141,7 +3144,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3730,6 +3733,12 @@ struct ref_be refs_be_files = {
 	files_transaction_verify,
 	files_transaction_commit,
 	files_transaction_free,
+	files_for_each_reflog_ent,
+	files_for_each_reflog_ent_reverse,
+	files_for_each_reflog,
+	files_reflog_exists,
+	files_create_reflog,
+	files_delete_reflog,
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
 	files_pack_refs,
diff --git a/refs.c b/refs.c
index 60f3503..002d24d 100644
--- a/refs.c
+++ b/refs.c
@@ -1143,3 +1143,54 @@ int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, v
 {
 	return the_refs_backend->for_each_reftype_fullpath(fn, type, broken, cb_data);
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
+int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
+{
+	return the_refs_backend->create_reflog(refname, force_create, err);
+}
+
+int delete_reflog(const char *refname)
+{
+	return the_refs_backend->delete_reflog(refname);
+}
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return the_refs_backend->initial_transaction_commit(transaction, err);
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
diff --git a/refs.h b/refs.h
index d594a12..09e7305 100644
--- a/refs.h
+++ b/refs.h
@@ -605,6 +605,20 @@ typedef int (*ref_transaction_verify_fn)(struct ref_transaction *transaction,
 typedef int (*ref_transaction_commit_fn)(struct ref_transaction *transaction,
 				     struct strbuf *err);
 typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
+
+/* reflog functions */
+typedef int (*for_each_reflog_ent_fn)(const char *refname,
+				      each_reflog_ent_fn fn,
+				      void *cb_data);
+typedef int (*for_each_reflog_ent_reverse_fn)(const char *refname,
+					      each_reflog_ent_fn fn,
+					      void *cb_data);
+typedef int (*for_each_reflog_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*reflog_exists_fn)(const char *refname);
+typedef int (*create_reflog_fn)(const char *refname, int force_create, struct strbuf *err);
+typedef int (*delete_reflog_fn)(const char *refname);
+
+/* resolution functions */
 typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
 					     int resolve_flags,
 					     unsigned char *sha1, int *flags);
@@ -617,6 +631,8 @@ typedef int (*create_symref_fn)(struct ref_transaction *transaction,
 				const char *logmsg);
 typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
 				      unsigned char *sha1);
+
+/* iteration functions */
 typedef int (*head_ref_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*head_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
 				     void *cb_data);
@@ -644,6 +660,12 @@ struct ref_be {
 	ref_transaction_verify_fn transaction_verify;
 	ref_transaction_commit_fn transaction_commit;
 	ref_transaction_free_fn transaction_free;
+	for_each_reflog_ent_fn for_each_reflog_ent;
+	for_each_reflog_ent_reverse_fn for_each_reflog_ent_reverse;
+	for_each_reflog_fn for_each_reflog;
+	reflog_exists_fn reflog_exists;
+	create_reflog_fn create_reflog;
+	delete_reflog_fn delete_reflog;
 	resolve_ref_unsafe_fn resolve_ref_unsafe;
 	verify_refname_available_fn verify_refname_available;
 	pack_refs_fn pack_refs;
-- 
2.0.4.315.gad8727a-twtrsrc
