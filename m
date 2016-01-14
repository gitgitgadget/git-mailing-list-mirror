From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 05/20] refs: add methods for reflog
Date: Thu, 14 Jan 2016 11:26:02 -0500
Message-ID: <1452788777-24954-6-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkkG-0002fi-2Q
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbcANQ11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:27:27 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33239 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596AbcANQ0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:37 -0500
Received: by mail-qg0-f41.google.com with SMTP id b35so356507009qge.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2gkSevnq5+kEhcdop9DGDoCNU066tkE/M+X/Fqi9TaI=;
        b=JLXhyaxhiy4FVhVdHBuQdBt7eyJKU4kTTgCzgnHEi6pl/RrLzr/1IYlu99afF3zptv
         6q5t+f1oA6AytjhVdFPwGNBCJAUJExkPer2xh5hkj1HiXW/TZpAN+NE62QAaR6lTL6NA
         V+V2wdZIw54tjPjEq/lOF10CjlYCiZ6XJJgXqbDfMB7oSW3epSBnlsTYSqP/fj0WA/R4
         XGnT21IKw9yN+VajS9uEuzotZiCAuwS5BIqHypmjaa6CU2ZcpCOtruDTOL63dgoDnahh
         kvZXX9mhR4x7cBawJOBqg3vRP7rAw2UwjibFJXj+1JtTIITg2dMsZYo4zEhMgladbLU3
         fmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2gkSevnq5+kEhcdop9DGDoCNU066tkE/M+X/Fqi9TaI=;
        b=iU4uQfd9Afbh+d3XUVsUr5EKHgQWbqrt2O0R+TlsEYFMeK043JJ/dsBvmtVkphV2zO
         /7wswUyHmlVVkmpw8YOpKN5EXDZkMw9RzNbvu+MP4zI0alpKsHpNBxsJcODVdUqkqljh
         iocnbapfcfiu7ICfh3qLyhx/HmxNwtHXD0CRzLoW2rs5tzaHjAtO2hsZf6j4RhxTCavL
         R/1fuHKS73iS2ElOoiAVTpCwkuCZttIWMudkIboqpPw0byYuEeNKsPmEU/NLAU+CHIag
         S9U/VsHQk01YkIHIiRKoZlvztnYkE4cM+Y5p1c3pBJMVnDgQcblbvpqZjHNVGOqhX0ez
         CUEA==
X-Gm-Message-State: ALoCoQngqse/Hd8X9QGHU/DrVv9u2nraYeanjOXgSbL98++Y8JwumEPLVTLQk7uJpvXT4NMwRVqk60PL9IekcGWCrnjsPAvKbg==
X-Received: by 10.140.139.71 with SMTP id 68mr7518416qhl.51.1452788796898;
        Thu, 14 Jan 2016 08:26:36 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:36 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284052>

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
index 9c2caa7..36b4666 100644
--- a/refs.c
+++ b/refs.c
@@ -1201,3 +1201,49 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
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
index 68f310e..f13b111 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2649,7 +2649,8 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 }
 
 
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
+static int files_create_reflog(const char *refname, int force_create,
+			       struct strbuf *err)
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
@@ -2905,7 +2906,7 @@ static int files_create_symref(const char *refname,
 	return ret;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2913,7 +2914,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2957,7 +2958,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -3059,7 +3062,8 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -3121,7 +3125,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3431,12 +3435,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
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
@@ -3541,6 +3545,14 @@ struct ref_storage_be refs_be_files = {
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
index d3cc8d0..87f2274 100644
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
@@ -249,6 +268,14 @@ struct ref_storage_be {
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
2.4.2.749.g730654d-twtrsrc
