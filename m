From: David Turner <dturner@twopensource.com>
Subject: [PATCH 38/43] refs: make some files backend functions public
Date: Wed,  2 Sep 2015 21:55:08 -0400
Message-ID: <1441245313-11907-39-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlm-0006qa-NF
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbbICB4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:46 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36335 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391AbbICB4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:22 -0400
Received: by qgx61 with SMTP id 61so18644126qgx.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nzNwwQ4+IIUUdMEXwwQ16LRMXHDv2b4BNGBvxe5vEVc=;
        b=W7kGjaCE+RPx7RF4Xw78D9krtrdixjceM6CveLOiCDQgA15PEB5UCbLi9493zEsjM2
         dgqpjdREWWeCxI1SDF2XHvEHZkg+pW9Nl2Hl67OrahMElw+7fvC6RYkp6Wmmxj9bEvVA
         mHv3jXKNU1zbh93/lcRV3gg2q9nzo4Rhmos7u45XM6CbFLHsjfkwFvMo3FfG1z/YHAwi
         Xb90hQ8q2qvYQInd+T3r/+8KyU/Jg9W3DgZBEpo37g/1TQI3u5iSWQJC5wtLUxfo0FnD
         ZnGPr5qu2CPsYbWkBEL6Xsqxfdzd5OZWJmgncyiQv+xlLNUPjU/U2P7BCZFtIm5dvlF0
         qSwg==
X-Gm-Message-State: ALoCoQnSIGpzPpA5gJVaWGM4r2V9TSjQAgVySa1hDY0lprr6wANgVUC3md6sI/7B/DdgLiDSjV1D
X-Received: by 10.140.94.66 with SMTP id f60mr2308779qge.29.1441245381415;
        Wed, 02 Sep 2015 18:56:21 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277162>

Because HEAD and stash are per-worktree, other backends need to
go through the files backend to manage these refs and their reflogs.

To enable this, we make some files backend functions public.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 34 +++++++++++++++++++++-------------
 refs.h          | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index ec7ec8d..7c9473f 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2710,6 +2710,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg,
 			 int flags, struct strbuf *err)
 {
+	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
+				   err);
+}
+
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err)
+{
 	struct strbuf sb = STRBUF_INIT;
 	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, flags,
 				  err);
@@ -2885,7 +2893,7 @@ static int files_create_symref(struct ref_transaction *trans,
 	return 0;
 }
 
-static int files_reflog_exists(const char *refname)
+int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2893,7 +2901,7 @@ static int files_reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-static int files_delete_reflog(const char *refname)
+int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2937,9 +2945,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-static int files_for_each_reflog_ent_reverse(const char *refname,
-					     each_reflog_ent_fn fn,
-					     void *cb_data)
+int files_for_each_reflog_ent_reverse(const char *refname,
+				      each_reflog_ent_fn fn,
+				      void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -3041,8 +3049,8 @@ static int files_for_each_reflog_ent_reverse(const char *refname,
 	return ret;
 }
 
-static int files_for_each_reflog_ent(const char *refname,
-				     each_reflog_ent_fn fn, void *cb_data)
+int files_for_each_reflog_ent(const char *refname,
+			      each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -3583,12 +3591,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int files_reflog_expire(const char *refname, const unsigned char *sha1,
-		 unsigned int flags,
-		 reflog_expiry_prepare_fn prepare_fn,
-		 reflog_expiry_should_prune_fn should_prune_fn,
-		 reflog_expiry_cleanup_fn cleanup_fn,
-		 void *policy_cb_data)
+int files_reflog_expire(const char *refname, const unsigned char *sha1,
+			unsigned int flags,
+			reflog_expiry_prepare_fn prepare_fn,
+			reflog_expiry_should_prune_fn should_prune_fn,
+			reflog_expiry_cleanup_fn cleanup_fn,
+			void *policy_cb_data)
 {
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
diff --git a/refs.h b/refs.h
index e5ef8a3..91d30b5 100644
--- a/refs.h
+++ b/refs.h
@@ -570,6 +570,10 @@ enum ref_type ref_type(const char *refname);
 
 int copy_reflog_msg(char *buf, const char *msg);
 
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
@@ -603,6 +607,22 @@ typedef int reflog_expiry_should_prune_fn(unsigned char *osha1,
 					  const char *message, void *cb_data);
 typedef void reflog_expiry_cleanup_fn(void *cb_data);
 
+int files_reflog_expire(const char *refname, const unsigned char *sha1,
+			unsigned int flags,
+			reflog_expiry_prepare_fn prepare_fn,
+			reflog_expiry_should_prune_fn should_prune_fn,
+			reflog_expiry_cleanup_fn cleanup_fn,
+			void *policy_cb_data);
+
+int files_for_each_reflog_ent(const char *refname,
+			      each_reflog_ent_fn fn, void *cb_data);
+
+int files_for_each_reflog_ent_reverse(const char *refname,
+				      each_reflog_ent_fn fn, void *cb_data);
+
+int files_delete_reflog(const char *refname);
+int files_reflog_exists(const char *refname);
+
 /*
  * Expire reflog entries for the specified reference. sha1 is the old
  * value of the reference. flags is a combination of the constants in
-- 
2.0.4.315.gad8727a-twtrsrc
