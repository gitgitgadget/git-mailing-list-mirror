From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 05/21] refs: add methods for reflog
Date: Mon, 11 Jan 2016 20:22:04 -0500
Message-ID: <1452561740-8668-6-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIngS-0003lm-6e
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761728AbcALBWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:38 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35776 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761337AbcALBWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:35 -0500
Received: by mail-qk0-f171.google.com with SMTP id n135so233501550qka.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QJQfeKtCs8J+3v8GqoA/tAjZ3Mgm2WWMyr9O5pHTztA=;
        b=J7tOfWS67ICwIADrRdMlKvIgp6YvM/Ent1Hs26KONptB1agPU51sCdE9mV1Z5homS/
         aix0Mj2B9OWqwa5TZ6TDiPwWHE4B68YPKEGBH8GaAU+cAe0VsH8Jyx9SELT5gyoDn4O8
         0gN8o8asKqzMgu50PbUTHWM70RS5mgNN0OevnYa70/LkyyZ54PxBV+d7JsullNxVKSKx
         URR3kzDLwt066WuDEtyc6ta/180coqbdRHZd35s1Hr0CjOAF0vaaYMbVkG/Hyx+4yCgU
         mUYlrLksk7e75KINpDZgzBc6uSERShAHnBq9DZrCrVeSQGJ5coeBA09ZA1p+L9Bt6in+
         JgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QJQfeKtCs8J+3v8GqoA/tAjZ3Mgm2WWMyr9O5pHTztA=;
        b=ceEULiha2lTCWnrDceumRlO7QuYOfkqY6uJ/uawqQ+Y4aAlXcm709kwLotWVyO14R1
         6KsqUHXOBS/xWDruHbWNEyOO/zztZNa5JymKeyYXWyHkPhU7M72t29THFJLCNgW1aRVn
         5NaLGMy52WTr4lmp/blXsMbfjNUgneWBIU3SteDg1bb51MG5MVqiW3ASKpICxvESbTF0
         4ff0p04sKxa6Q/K1CpxYY54QqHR1MSrU8IBar+HH/G18fBmUnP4j05d6mHHd2MpN0W89
         HKmi2UyLKIQ/5QD3Sqz35MQpiVvIo+K0myA1ago8Y3wnup/B1aiun7p1BGyPoZgu8gHg
         ScQQ==
X-Gm-Message-State: ALoCoQmRj/P1/PlojqlslalpmWBv/+/Z4dhrk19TNzQXwQPxsE9fo3zgVzJ3wnOHIBcAaya7O12+ugKRU4RMTzCu3AMrq16DTA==
X-Received: by 10.55.73.68 with SMTP id w65mr42992834qka.68.1452561754153;
        Mon, 11 Jan 2016 17:22:34 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:33 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283757>

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
index 2deb2e0..f66484e 100644
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
index 1c9401f..520bf40 100644
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
@@ -3535,6 +3539,14 @@ struct ref_storage_be refs_be_files = {
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
index 2431579..7583f60 100644
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
