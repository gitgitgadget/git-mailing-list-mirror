From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 38/43] refs: make some files backend functions public
Date: Mon, 28 Sep 2015 18:02:13 -0400
Message-ID: <1443477738-32023-39-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWd-0001Ts-TU
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbbI1WD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:56 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36486 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbbI1WDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:35 -0400
Received: by qkcf65 with SMTP id f65so74210499qkc.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FSjWiwKMtYpZoznISYWKIdY/dqLHp3SBlB4V2Q63dx0=;
        b=RBXl8rYT4dxYM5bumi51fqLOahoAxkcYrh5doEo1GVKuLm0nD4ggyGjtiiAa4rBL4y
         iHrsJf8C9AI5rlAG+3zGt1M/dbHa9SAhvmRIVO4OGEKgvvAKTbrajdxFFsGu8u+4Z6Io
         gQB4ksOOoaWoQi49xibJUbQf0vizhRnUcjJnpXhYUbbU2ooM4urfIJdqHdC6wiMt6oR/
         dlN6GS9Urk/zgEjDwXvAlVseGs+moTVYg9T1bx2fechHfKQhHGkXiG0mjZprxArCyUA8
         PZtbl5CG0uYOJuMwHL/aqUIYYXjY9jqCLfCnetJOqWUOs+vlVHf4dsQJYUNrGA4ZJLHj
         xzow==
X-Gm-Message-State: ALoCoQm1Dgg9uHFFIUgli4madtWb8L2SsdF4DTvcDfPVw1/2ncOjYrPaBEIsVmxotmpj6rMzLjIC
X-Received: by 10.55.25.160 with SMTP id 32mr24163791qkz.40.1443477814357;
        Mon, 28 Sep 2015 15:03:34 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278775>

Because HEAD and stash are per-worktree, other backends need to
go through the files backend to manage these refs and their reflogs.

To enable this, we make some files backend functions public.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 34 +++++++++++++++++++++-------------
 refs.h          | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 2727943..943604c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2727,6 +2727,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
@@ -2902,7 +2910,7 @@ static int files_create_symref(struct ref_transaction *trans,
 	return 0;
 }
 
-static int files_reflog_exists(const char *refname)
+int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2910,7 +2918,7 @@ static int files_reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-static int files_delete_reflog(const char *refname)
+int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2954,9 +2962,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
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
@@ -3058,8 +3066,8 @@ static int files_for_each_reflog_ent_reverse(const char *refname,
 	return ret;
 }
 
-static int files_for_each_reflog_ent(const char *refname,
-				     each_reflog_ent_fn fn, void *cb_data)
+int files_for_each_reflog_ent(const char *refname,
+			      each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -3604,12 +3612,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int files_reflog_expire(const char *refname, const unsigned char *sha1,
-			       unsigned int flags,
-			       reflog_expiry_prepare_fn prepare_fn,
-			       reflog_expiry_should_prune_fn should_prune_fn,
-			       reflog_expiry_cleanup_fn cleanup_fn,
-			       void *policy_cb_data)
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
index d8ae9af..da29232 100644
--- a/refs.h
+++ b/refs.h
@@ -571,6 +571,10 @@ enum ref_type ref_type(const char *refname);
 
 int copy_reflog_msg(char *buf, const char *msg);
 
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
@@ -604,6 +608,22 @@ typedef int reflog_expiry_should_prune_fn(unsigned char *osha1,
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
2.4.2.644.g97b850b-twtrsrc
