From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 6/7] refs.c: add an err argument to create_reflog
Date: Mon, 17 Nov 2014 18:00:39 -0800
Message-ID: <1416276040-5303-7-git-send-email-sbeller@google.com>
References: <1416276040-5303-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 03:01:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqY6M-0000v6-KX
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbaKRCAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:00:55 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:50054 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbaKRCAv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:00:51 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so3281353igi.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YJAoBlM04Y0vn3+kstk31BaP6B1wcb/MZlAVlJcwT9g=;
        b=RFVjRM+8+rhzR0Gjisx5dmJg1qpYgSGfjWz3WYHtaHecMQ1rooH1Clb2L0HOhV53ec
         HPTPZ+aqZKN4UBIhNj0MxFoTbbQh0oBRKzjrJmsREY8BRglS4VzISYnlZ32kkFV64ibP
         soj4WodwZ02ZkouuvMSvChW/i7yvEkwVx80cm6FAUDkTMje9cJQ1RdzpnN7w18DYSgTP
         R293CxTp4Beny4/QGCkKHAbcNChIwUr8asYlTUc7vPygx2usWSbS3Ouf4pAeRnIOXOYo
         KJDdJnhqVdNrasLMCH0CfKg512kxFB392JqaUDjC+IUA1OWf88BCdsvQ7UahsPqEK9qS
         VGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YJAoBlM04Y0vn3+kstk31BaP6B1wcb/MZlAVlJcwT9g=;
        b=Kl79cMnpFQd3w03O1cPdrh1GdVJ5Kd3hR1Ux2TfxoYsdCPhsPt2RdvWcUsT1Tft0is
         citQx1ucfMfK8sp1lMIH0p6CTSSBxwEn+UbPoyY5dMgEgd2g+7Xy/1qyGVl61zli7b0y
         xJeNMOM2Rdjwn042kp8YVeulkOH/Q0RUhNaJn3f3otdWl+Qi42ZIMZlTjQ6GLhCVvCrO
         tgT9BX4RNzJuQzBisIQjBkhxGxBvFP+Qx8yFES9yZZkbRYwB6ElfPlsNbA0oKy7qmXgl
         j61ToOdOrgiFi6bDSeiDEVQL7YBcfjCI8zOC+lpTxFDFuHHZj6EMwXmq/P8SmiASLONd
         sltw==
X-Gm-Message-State: ALoCoQlFYx9ClD3pYiVbjpjg4GUKpHbHbHwg+DthGSdUn1rDoaR1zpeFCMbe/aIU2s7Wg6rg64/W
X-Received: by 10.107.149.203 with SMTP id x194mr33702297iod.22.1416276050894;
        Mon, 17 Nov 2014 18:00:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id 131sm19817359ioo.8.2014.11.17.18.00.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:00:50 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416276040-5303-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Add an err argument to create_reflog that can explain the reason for a
failure. This then eliminates the need to manage errno through this
function since we can just add strerror(errno) to the err string when
meaningful. No callers relied on errno from this function for anything
else than the error message.

log_ref_write is a private function that calls create_reflog. Update
this function to also take an err argument and pass it back to the caller.
This again eliminates the need to manage errno in this function.

Update the private function write_sha1_update_reflog to also take an
err argument.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout.c |  8 +++---
 refs.c             | 71 +++++++++++++++++++++++++++---------------------------
 refs.h             |  4 +--
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 60a68f7..d9cb9c3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -590,10 +590,12 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				char *ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
+				struct strbuf err = STRBUF_INIT;
 
-				if (create_reflog(ref_name)) {
-					fprintf(stderr, _("Can not do reflog for '%s'\n"),
-					    opts->new_orphan_branch);
+				if (create_reflog(ref_name, &err)) {
+					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
+					opts->new_orphan_branch, err.buf);
+					strbuf_release(&err);
 					return;
 				}
 			}
diff --git a/refs.c b/refs.c
index ddb5fc6..d2f7cea 100644
--- a/refs.c
+++ b/refs.c
@@ -2895,8 +2895,7 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-/* This function must set a meaningful errno on failure */
-int create_reflog(const char *refname)
+int create_reflog(const char *refname, struct strbuf *err)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char logfile[PATH_MAX];
@@ -2907,9 +2906,8 @@ int create_reflog(const char *refname)
 	    starts_with(refname, "refs/notes/") ||
 	    !strcmp(refname, "HEAD")) {
 		if (safe_create_leading_directories(logfile) < 0) {
-			int save_errno = errno;
-			error("unable to create directory for %s", logfile);
-			errno = save_errno;
+			strbuf_addf(err, "unable to create directory for %s. "
+				    "%s", logfile, strerror(errno));
 			return -1;
 		}
 		oflags |= O_CREAT;
@@ -2922,20 +2920,16 @@ int create_reflog(const char *refname)
 
 		if (errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				int save_errno = errno;
-				error("There are still logs under '%s'",
-				      logfile);
-				errno = save_errno;
+				strbuf_addf(err, "There are still logs under "
+					    "'%s'", logfile);
 				return -1;
 			}
 			logfd = open(logfile, oflags, 0666);
 		}
 
 		if (logfd < 0) {
-			int save_errno = errno;
-			error("Unable to append to %s: %s", logfile,
-			      strerror(errno));
-			errno = save_errno;
+			strbuf_addf(err, "Unable to append to %s: %s",
+				    logfile, strerror(errno));
 			return -1;
 		}
 	}
@@ -2972,7 +2966,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 }
 
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg)
+			 const unsigned char *new_sha1, const char *msg,
+			 struct strbuf *err)
 {
 	int logfd, result = 0, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
@@ -2981,7 +2976,7 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 		log_all_ref_updates = !is_bare_repository();
 
 	if (log_all_ref_updates && !reflog_exists(refname))
-		result = create_reflog(refname);
+		result = create_reflog(refname, err);
 
 	if (result)
 		return result;
@@ -2994,16 +2989,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		int save_errno = errno;
 		close(logfd);
-		error("Unable to append to %s", log_file);
-		errno = save_errno;
+		strbuf_addf(err, "Unable to append to %s. %s", log_file,
+			    strerror(errno));
 		return -1;
 	}
 	if (close(logfd)) {
-		int save_errno = errno;
-		error("Unable to append to %s", log_file);
-		errno = save_errno;
+		strbuf_addf(err, "Unable to append to %s. %s", log_file,
+			    strerror(errno));
 		return -1;
 	}
 	return 0;
@@ -3015,12 +3008,12 @@ int is_branch(const char *refname)
 }
 
 static int write_sha1_update_reflog(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
+				    const unsigned char *sha1,
+				    const char *logmsg, struct strbuf *err)
 {
-	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
+	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg, err) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-		unlock_ref(lock);
+	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg, err) < 0)) {
 		return -1;
 	}
 	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
@@ -3042,8 +3035,11 @@ static int write_sha1_update_reflog(struct ref_lock *lock,
 		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
-		    !strcmp(head_ref, lock->ref_name))
-			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
+		    !strcmp(head_ref, lock->ref_name) &&
+		    log_ref_write("HEAD", lock->old_sha1, sha1, logmsg, err)) {
+			error("%s", err->buf);
+			strbuf_release(err);
+		}
 	}
 	return 0;
 }
@@ -3057,6 +3053,7 @@ static int write_ref_sha1(struct ref_lock *lock,
 {
 	static char term = '\n';
 	struct object *o;
+	struct strbuf err = STRBUF_INIT;
 
 	if (!lock) {
 		errno = EINVAL;
@@ -3091,8 +3088,10 @@ static int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
-	if (write_sha1_update_reflog(lock, sha1, logmsg)) {
+	if (write_sha1_update_reflog(lock, sha1, logmsg, &err)) {
 		unlock_ref(lock);
+		error("%s", err.buf);
+		strbuf_release(&err);
 		return -1;
 	}
 	if (commit_ref(lock)) {
@@ -3112,6 +3111,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
 	unsigned char old_sha1[20], new_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (logmsg && read_ref(ref_target, old_sha1))
 		hashclr(old_sha1);
@@ -3160,9 +3160,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 #ifndef NO_SYMLINK_HEAD
 	done:
 #endif
-	if (logmsg && !read_ref(refs_heads_master, new_sha1))
-		log_ref_write(ref_target, old_sha1, new_sha1, logmsg);
-
+	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
+	    log_ref_write(ref_target, old_sha1, new_sha1, logmsg, &err))
+		error("%s", err.buf);
+	
+	strbuf_release(&err);
 	free(git_HEAD);
 	return 0;
 }
@@ -3936,10 +3938,7 @@ int transaction_commit(struct transaction *transaction,
 			goto cleanup;
 		}
 		if (write_sha1_update_reflog(update->lock, update->new_sha1,
-					     update->msg)) {
-			if (err)
-				strbuf_addf(err, "Failed to update log '%s'.",
-					    update->refname);
+					     update->msg, err)) {
 			ret = -1;
 			goto cleanup;
 		}
@@ -3976,7 +3975,7 @@ int transaction_commit(struct transaction *transaction,
 			continue;
 		}
 		if (log_all_ref_updates && !reflog_exists(update->refname) &&
-		    create_reflog(update->refname)) {
+		    create_reflog(update->refname, err)) {
 			ret = -1;
 			if (err)
 				strbuf_addf(err, "Failed to setup reflog for "
diff --git a/refs.h b/refs.h
index 489aa9d..930821e 100644
--- a/refs.h
+++ b/refs.h
@@ -170,8 +170,8 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
-/** Create reflog. Set errno to something meaningful on failure. */
-extern int create_reflog(const char *refname);
+/** Create reflog. Fill in err on failure. */
+extern int create_reflog(const char *refname, struct strbuf *err);
 
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
-- 
2.2.0.rc2.5.gf7b9fb2
