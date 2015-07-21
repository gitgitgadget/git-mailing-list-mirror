From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 5/7] refs: add REF_FORCE_CREATE_REFLOG flag
Date: Tue, 21 Jul 2015 17:04:54 -0400
Message-ID: <1437512696-14672-5-git-send-email-dturner@twopensource.com>
References: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhaggerty@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 23:05:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHej5-0001X4-OM
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933539AbbGUVFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:05:17 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33617 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933511AbbGUVFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:05:13 -0400
Received: by qkdl129 with SMTP id l129so141638654qkd.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dZgPkMYKFfngG7yApnzASb5wosH98YQe7LuDiNjYXrg=;
        b=Q/47xk+u8cVgTlzH9jx2vRAFIU0uA505T2oF0l91PJQptHAKAYRJe202NLFLERnMC9
         ggLn7bVy+f/76eAl/ypGE9bzenkIlkgeOG446w6vnmF5wGj1hZ3YJ8j9nw3urv8Udht0
         FZZBkmGUFlXuLpYLkO/XN3QqnUUcIakEJ1mDQjgp2iW/rSUOPteV9EAqZLCmr4058i94
         3DTSzrbbY0iF8Horn7EmNShAyFFFxTlL6WiGAAKxqgdx4JrW0gRHr3qEplS6iRzRlmIC
         e8ZFhbGohjrDBVDv3w/seJylnuZeKaCJvIsWvuVbQLh+PLlayP83hO+igkYwvZ2GPfuB
         3WvQ==
X-Gm-Message-State: ALoCoQl2FXjQgtGcv1BEvIuABCEPKkdHrfm9CaBxjeZMy7k4UB/xWaVpT5XKNkn6P2O22yyQ7seB
X-Received: by 10.55.22.5 with SMTP id g5mr56335463qkh.45.1437512712988;
        Tue, 21 Jul 2015 14:05:12 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id x137sm13430413qkx.28.2015.07.21.14.05.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 14:05:12 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274421>

Add a flag to allow forcing the creation of a reflog even if the ref
name and core.logAllRefUpdates setting would not ordinarily cause ref
creation.

In a moment, we will use this to add options to git tag and git
update-ref to force reflog creation.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 34 +++++++++++++++++++++-------------
 refs.h |  1 +
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 1abfe64..cd207c2 100644
--- a/refs.c
+++ b/refs.c
@@ -63,6 +63,11 @@ static unsigned char refname_disposition[256] = {
 #define REF_NEEDS_COMMIT 0x20
 
 /*
+ * 0x40 is REF_FORCE_CREATE_REFLOG, so skip it if you're adding a
+ * value to ref_update::flags
+ */
+
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -2979,7 +2984,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
-			     struct strbuf *err);
+			     int flags, struct strbuf *err);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
@@ -3041,7 +3046,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	hashcpy(lock->old_oid.hash, orig_sha1);
 
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, logmsg, &err)) {
+	    commit_ref_update(lock, orig_sha1, logmsg, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -3060,7 +3065,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, NULL, &err)) {
+	    commit_ref_update(lock, orig_sha1, NULL, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
@@ -3217,7 +3222,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 
 static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 			   const unsigned char *new_sha1, const char *msg,
-			   struct strbuf *sb_log_file, struct strbuf *err)
+			   struct strbuf *sb_log_file, int flags,
+			   struct strbuf *err)
 {
 	int logfd, result, oflags = O_APPEND | O_WRONLY;
 	char *log_file;
@@ -3225,7 +3231,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, sb_log_file, err, 0);
+	result = log_ref_setup(refname, sb_log_file, err, flags & REF_FORCE_CREATE_REFLOG);
 
 	if (result)
 		return result;
@@ -3254,10 +3260,11 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg,
-			 struct strbuf *err)
+			 int flags, struct strbuf *err)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, err);
+	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, flags,
+				  err);
 	strbuf_release(&sb);
 	return ret;
 }
@@ -3311,12 +3318,12 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
  */
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
-			     struct strbuf *err)
+			     int flags, struct strbuf *err)
 {
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
+	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0)) {
+	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "Cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -3346,7 +3353,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
 			if (log_ref_write("HEAD", lock->old_oid.hash, sha1,
-					  logmsg, &log_err)) {
+					  logmsg, 0, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
 			}
@@ -3420,7 +3427,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	done:
 #endif
 	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
-		log_ref_write(ref_target, old_sha1, new_sha1, logmsg, &err)) {
+		log_ref_write(ref_target, old_sha1, new_sha1, logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
@@ -4097,7 +4104,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->flags & REF_NEEDS_COMMIT) {
 			if (commit_ref_update(update->lock,
-					      update->new_sha1, update->msg, err)) {
+					      update->new_sha1, update->msg,
+					      update->flags, err)) {
 				/* freed by commit_ref_update(): */
 				update->lock = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
diff --git a/refs.h b/refs.h
index f82fc51..e4e46c3 100644
--- a/refs.h
+++ b/refs.h
@@ -224,6 +224,7 @@ int pack_refs(unsigned int flags);
  * Other flags are reserved for internal use.
  */
 #define REF_NODEREF	0x01
+#define REF_FORCE_CREATE_REFLOG 0x40
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
-- 
2.0.4.315.gad8727a-twtrsrc
