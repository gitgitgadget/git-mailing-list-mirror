From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 05/21] refs: add methods for reflog
Date: Fri,  5 Feb 2016 14:44:06 -0500
Message-ID: <1454701462-3817-6-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJN-00012d-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbcBETow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:44:52 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36273 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbcBETot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:49 -0500
Received: by mail-qk0-f175.google.com with SMTP id s68so38142560qkh.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NkhwdZKam7ZMj3bdx0q7Bk3k45ivSLM89ZFsgpkrMDY=;
        b=yGvbYTX8QiojSMJ7nB9OtGs/jPu0wpqvC8/L4HUa101noUFQUOHdUvMk4AxIdM7vOb
         uAByAGCMER9rh4/9Y8eFuaGldTh3tUi0TW3tdaFZ+OUZ3+JMNJyHNlWPCxyj+TgsrKAd
         kh7gch6IQEPUrGezg6X8sWdXTEf91m1GBFqe6KJF9EDlw279+PA5DDotjQwPwuFVg6t1
         BLLu1ZMJgSn6/vlYqMnpI8NIkuY1XvXf4dri50JMKSFaqnnUPSOv3MaE5YdvXBsvTCEb
         0YgPUjnvpHFqcCcCsk9ZshE2H/ExxnSSr7wvK1yuF1M3Dx7+o98vmrUOG7a98aZ9ckN0
         tCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NkhwdZKam7ZMj3bdx0q7Bk3k45ivSLM89ZFsgpkrMDY=;
        b=KOO0x34Z7fZ8OXtor2e6xUmI4O7jLOPFpL02jTAGqFllgSIpyjmyARw9nAwyeaj0gL
         HrVURFbT6uVBwKC9hkkcBv1mfSz7LOxsWADnJwMfDLxndOdgCflNJLOWZlKL0xic3Kbq
         G82SV4DCXYIfzD6bk6bdd8ZTCgJIp5gnhMIJ8IxkR8Dsi06fJ5cmI8KHM3TjhK0hAhhO
         AZpNhggPG/v0PVaQIxuzq3tSs3sbpI5YckUYRonYm32ibo/6KflGie2JfRt1XW/QJo9W
         lrplrHhpnagCWWwWlWCeBoyxLqhd5o0XZXCyJjsaq6FpMJkZuN+AubSdeR80jqVE94oA
         3Swg==
X-Gm-Message-State: AG10YOR1JdfhgZfZc7pk2VSy61USo7U6j63c4POxKljIOpcvgzbzLTMHhFHJ2FiRUOQF/g==
X-Received: by 10.55.53.207 with SMTP id c198mr18573268qka.24.1454701488593;
        Fri, 05 Feb 2016 11:44:48 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:47 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285607>

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
index e598b73..3254378 100644
--- a/refs.c
+++ b/refs.c
@@ -1212,3 +1212,49 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
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
index 3d678ad..b3372e6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2667,7 +2667,8 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 }
 
 
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err)
+static int files_create_reflog(const char *refname, int force_create,
+			       struct strbuf *err)
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
@@ -2923,7 +2924,7 @@ static int files_create_symref(const char *refname,
 	return ret;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2931,7 +2932,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2975,7 +2976,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -3077,7 +3080,8 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -3139,7 +3143,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3449,12 +3453,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
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
@@ -3559,6 +3563,14 @@ struct ref_storage_be refs_be_files = {
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
index cb949c5..ee2bea6 100644
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
