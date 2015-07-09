From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 5/7] refs: add REF_FORCE_CREATE_REFLOG flag
Date: Thu,  9 Jul 2015 18:50:58 -0400
Message-ID: <1436482260-28088-6-git-send-email-dturner@twopensource.com>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Fri Jul 10 00:51:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKfL-00075y-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbbGIWvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:51:36 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33760 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbGIWvb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:51:31 -0400
Received: by pdbqm3 with SMTP id qm3so28853601pdb.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jzc2Oj7jKUw9bYnBe6otuiWdiip84tX510UDCJROOqk=;
        b=RszV022GgT/nJsbFcQ7/+XwdpsnR0wuHQWfGdvGTi7pvHbE0VklXtOR7J94qjxvfzi
         9RgvC8+vDLYucgrF0F/pVFTMHawVTuVj3IgRaeoubf1KsdUiKK6qIXRrS2UTzB0U5usG
         eYSblgNyQO5xMacAPngNzklw4frnEraKotRMV6sB3cTO0u2qLdjdJBtdue1JrQo4tWzG
         QA3ipOi5xHTgE6laX7RzU+2t7CQOSjfuTplFzqRaDXyItGI1/qT9Nk1Bg3GwZceOBnNG
         CzsfIkXGJpY/12r8WYsbkTT1Vg7a+dJCDWKWCnNMJw2xRk6J6mdrExgdwW18MQBpc6rm
         L0Yw==
X-Gm-Message-State: ALoCoQnDM4FJXKHXp5EW03FUoHxKEJb4TQEwa7siRjKLqUYvHWbOIhaDFxHZHUZPjDlqk6Gifqc3
X-Received: by 10.70.95.198 with SMTP id dm6mr35591009pdb.53.1436482290885;
        Thu, 09 Jul 2015 15:51:30 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id fr2sm7129684pdb.22.2015.07.09.15.51.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 15:51:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273790>

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
index 4857f0b..06c62c8 100644
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
@@ -3313,12 +3320,12 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
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
 		strbuf_addf(err, "Cannot update the ref '%s': '%s'",
 			    lock->ref_name, old_msg);
@@ -3348,7 +3355,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
 			if (log_ref_write("HEAD", lock->old_oid.hash, sha1,
-					  logmsg, &log_err)) {
+					  logmsg, 0, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
 			}
@@ -3422,7 +3429,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	done:
 #endif
 	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
-		log_ref_write(ref_target, old_sha1, new_sha1, logmsg, &err)) {
+		log_ref_write(ref_target, old_sha1, new_sha1, logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
@@ -4099,7 +4106,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->flags & REF_NEEDS_COMMIT) {
 			if (commit_ref_update(update->lock,
-					      update->new_sha1, update->msg, err)) {
+					      update->new_sha1, update->msg,
+					      update->flags, err)) {
 				/* freed by commit_ref_update(): */
 				update->lock = NULL;
 				ret = TRANSACTION_GENERIC_ERROR;
diff --git a/refs.h b/refs.h
index 3b90e16..297ec45 100644
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
2.0.5.499.g01f6352.dirty-twtrsrc
