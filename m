From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 29/43] refs.c: add methods for reflog
Date: Mon, 28 Sep 2015 18:02:04 -0400
Message-ID: <1443477738-32023-30-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWn-0001ih-Nt
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbbI1WDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:34 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36086 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbbI1WD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:26 -0400
Received: by qgx61 with SMTP id 61so133699933qgx.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7eHw0Xqfq6AIn6WnMy0kcykXUbS0fYTVtRQyht3btrs=;
        b=ZKRhBsqu343sUrqc/lY84I/8kUOkJ3PQOi7Opflk/5DjNiWV+e7pfnTnmfTn7Fs9dQ
         WRT08h2U9wBF8c5G4k75nUC8uGeWO9wNFsHELLw3QJxiToeLF4Beo+zjCRswS477V/VM
         BsgOXIkL4dQKSaByBhoGtKojSSArFoVu7aZ5pGEkj28zVL1yG0IM+cJHmdQ8qxOAbiF2
         TZGRLOa9CATMcv1/t7+dGOSYKlDuslZZlxeoB+cLGh+ogcwovAU5pZi+QHOpy54wI8ib
         oXwSB9irvBWz5oc5R+gcb5fGmgeAguaIIDiE0GBoUKm4bWp/yG/d/ZV0DjpbqOcIFn+u
         dNuQ==
X-Gm-Message-State: ALoCoQkMo5p5wz1c6cWAKUbQoaR8+ZsI6QP8L/hq7DZaNgcBAJLHDcak4TPSHt94yBSVBCWLOi92
X-Received: by 10.140.22.133 with SMTP id 5mr25328440qgn.12.1443477806195;
        Mon, 28 Sep 2015 15:03:26 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278777>

In the file-based backend, the reflog piggybacks on the ref lock.
Since other backends won't have the same sort of ref lock, ref backends
must also handle reflogs.

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 32 +++++++++++++++++++++-----------
 refs.c          | 34 ++++++++++++++++++++++++++++++++++
 refs.h          | 23 +++++++++++++++++++++++
 3 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index eaa74b6..fdb47e0 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2691,7 +2691,8 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 }
 
 
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
+static int files_create_reflog(const char *refname, int force_create,
+			       struct strbuf *err)
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
@@ -2940,7 +2941,7 @@ static int files_create_symref(struct ref_transaction *trans,
 	return 0;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2948,7 +2949,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2992,7 +2993,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -3094,7 +3097,8 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -3156,7 +3160,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3630,11 +3634,11 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 }
 
 int reflog_expire(const char *refname, const unsigned char *sha1,
-		 unsigned int flags,
-		 reflog_expiry_prepare_fn prepare_fn,
-		 reflog_expiry_should_prune_fn should_prune_fn,
-		 reflog_expiry_cleanup_fn cleanup_fn,
-		 void *policy_cb_data)
+		  unsigned int flags,
+		  reflog_expiry_prepare_fn prepare_fn,
+		  reflog_expiry_should_prune_fn should_prune_fn,
+		  reflog_expiry_cleanup_fn cleanup_fn,
+		  void *policy_cb_data)
 {
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
@@ -3745,6 +3749,12 @@ struct ref_be refs_be_files = {
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
index 9ce10b7..7b2a47b 100644
--- a/refs.c
+++ b/refs.c
@@ -1155,3 +1155,37 @@ int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken,
 	return the_refs_backend->for_each_reftype_fullpath(fn, type, broken,
 							   cb_data);
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
diff --git a/refs.h b/refs.h
index 0dc626e..494f8c8 100644
--- a/refs.h
+++ b/refs.h
@@ -605,6 +605,21 @@ typedef int (*ref_transaction_verify_fn)(struct ref_transaction *transaction,
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
+typedef int (*create_reflog_fn)(const char *refname, int force_create,
+				struct strbuf *err);
+typedef int (*delete_reflog_fn)(const char *refname);
+
+/* resolution functions */
 typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
 					     int resolve_flags,
 					     unsigned char *sha1, int *flags);
@@ -620,6 +635,8 @@ typedef int (*create_symref_fn)(struct ref_transaction *transaction,
 				const char *logmsg);
 typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
 				      unsigned char *sha1);
+
+/* iteration functions */
 typedef int (*head_ref_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*head_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
 				     void *cb_data);
@@ -650,6 +667,12 @@ struct ref_be {
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
2.4.2.644.g97b850b-twtrsrc
