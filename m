From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 1/8] refs.c: add err arguments to reflog functions
Date: Tue,  7 Jul 2015 20:55:56 -0400
Message-ID: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 08 02:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdfC-0007Ba-2N
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbbGHA4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:56:30 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33237 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393AbbGHA4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:56:18 -0400
Received: by qkhu186 with SMTP id u186so153053857qkh.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=11VXuDUds6Zkr0fKl5RApacMuAKPDGfEv8n1npVSqXw=;
        b=e9+UjRCoJNfDyjOp0M9heKIND6v0WPpIe2kyn+WiYDQra/aJJPNlNfW/xK/uNsna3y
         AYm7U4rfOAIEFd4bWiQu9pjLgTmkSazzriw7VhDH8ZspllZ1reZZMAbRDSPP2nBrF+1T
         IhcMjhPbE7YTYerQwDAgm7fm/Mae6OSxSVf6FkJez7gJ2pYelbiQQpm70SmeexImvYfW
         Fr8V2AFmBUhLUdjhSKkP878FzXtHY/jPV/0xkK+4B4iIS2OMPIYlCT/NpdLWIPkZvrrF
         igKCUWXM6v2NJm8IL089+4Ch5bdapaxcSKBP/J6nBI2+GhxKNOwn5j6jS3yBrtr/lsFt
         PyTw==
X-Gm-Message-State: ALoCoQmHvyK0CcaaZnxL6dcc5T6x1vl0jO7hW6oI2gJx8bxR+gaDD8rnjEZJ1v0V0MfWPGZ3t5h/
X-Received: by 10.140.232.131 with SMTP id d125mr12274320qhc.80.1436316977258;
        Tue, 07 Jul 2015 17:56:17 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z135sm278447qhd.29.2015.07.07.17.56.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 17:56:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273622>

Add an err argument to log_ref_setup that can explain the reason
for a failure. This then eliminates the need to manage errno through
this function since we can just add strerror(errno) to the err string
when meaningful. No callers relied on errno from this function for
anything else than the error message.

Also add err arguments to private functions write_ref_to_lockfile,
log_ref_write_1, commit_ref_update. This again eliminates the need to
manage errno in these functions.

Some error messages change slightly.  For instance, we sometimes lose
"cannot update ref" and instead only show the specific cause of ref
update failure.

Update of a patch by Ronnie Sahlberg.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/checkout.c |   8 ++--
 refs.c             | 130 +++++++++++++++++++++++++++++------------------------
 refs.h             |   4 +-
 3 files changed, 79 insertions(+), 63 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c018ab3..93f63d3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -624,16 +624,18 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				struct strbuf log_file = STRBUF_INIT;
 				int ret;
 				const char *ref_name;
+				struct strbuf err = STRBUF_INIT;
 
 				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 				temp = log_all_ref_updates;
 				log_all_ref_updates = 1;
-				ret = log_ref_setup(ref_name, &log_file);
+				ret = log_ref_setup(ref_name, &log_file, &err);
 				log_all_ref_updates = temp;
 				strbuf_release(&log_file);
 				if (ret) {
-					fprintf(stderr, _("Can not do reflog for '%s'\n"),
-					    opts->new_orphan_branch);
+					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
+						opts->new_orphan_branch, err.buf);
+					strbuf_release(&err);
 					return;
 				}
 			}
diff --git a/refs.c b/refs.c
index fb568d7..e891bed 100644
--- a/refs.c
+++ b/refs.c
@@ -2975,9 +2975,11 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	return ret;
 }
 
-static int write_ref_to_lockfile(struct ref_lock *lock, const unsigned char *sha1);
+static int write_ref_to_lockfile(struct ref_lock *lock,
+				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
-			     const unsigned char *sha1, const char *logmsg);
+			     const unsigned char *sha1, const char *logmsg,
+			     struct strbuf *err);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
@@ -3038,9 +3040,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	}
 	hashcpy(lock->old_oid.hash, orig_sha1);
 
-	if (write_ref_to_lockfile(lock, orig_sha1) ||
-	    commit_ref_update(lock, orig_sha1, logmsg)) {
-		error("unable to write current sha1 into %s", newrefname);
+	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
+	    commit_ref_update(lock, orig_sha1, logmsg, &err)) {
+		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
+		strbuf_release(&err);
 		goto rollback;
 	}
 
@@ -3056,9 +3059,11 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
-	if (write_ref_to_lockfile(lock, orig_sha1) ||
-	    commit_ref_update(lock, orig_sha1, NULL))
-		error("unable to write current sha1 into %s", oldrefname);
+	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
+	    commit_ref_update(lock, orig_sha1, NULL, &err)) {
+		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
+		strbuf_release(&err);
+	}
 	log_all_ref_updates = flag;
 
  rollbacklog:
@@ -3113,8 +3118,8 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-/* This function must set a meaningful errno on failure */
-int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
+/* This function will fill in *err and return -1 on failure */
+int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char *logfile;
@@ -3129,9 +3134,8 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
 		if (safe_create_leading_directories(logfile) < 0) {
-			int save_errno = errno;
-			error("unable to create directory for %s", logfile);
-			errno = save_errno;
+			strbuf_addf(err, "unable to create directory for %s. "
+				    "%s", logfile, strerror(errno));
 			return -1;
 		}
 		oflags |= O_CREAT;
@@ -3144,20 +3148,16 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
 
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
@@ -3195,7 +3195,7 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 
 static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 			   const unsigned char *new_sha1, const char *msg,
-			   struct strbuf *sb_log_file)
+			   struct strbuf *sb_log_file, struct strbuf *err)
 {
 	int logfd, result, oflags = O_APPEND | O_WRONLY;
 	char *log_file;
@@ -3203,7 +3203,8 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, sb_log_file);
+	result = log_ref_setup(refname, sb_log_file, err);
+
 	if (result)
 		return result;
 	log_file = sb_log_file->buf;
@@ -3216,26 +3217,25 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		int save_errno = errno;
+		strbuf_addf(err, "Unable to append to %s. %s", log_file,
+			    strerror(errno));
 		close(logfd);
-		error("Unable to append to %s", log_file);
-		errno = save_errno;
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
 }
 
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg)
+			 const unsigned char *new_sha1, const char *msg,
+			 struct strbuf *err)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb);
+	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, err);
 	strbuf_release(&sb);
 	return ret;
 }
@@ -3247,25 +3247,28 @@ int is_branch(const char *refname)
 
 /*
  * Write sha1 into the open lockfile, then close the lockfile. On
- * errors, rollback the lockfile and set errno to reflect the problem.
+ * errors, rollback the lockfile, fill in *err and
+ * return -1.
  */
 static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const unsigned char *sha1)
+				 const unsigned char *sha1, struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
 
 	o = parse_object(sha1);
 	if (!o) {
-		error("Trying to write ref %s with nonexistent object %s",
-			lock->ref_name, sha1_to_hex(sha1));
+		strbuf_addf(err,
+			    "Trying to write ref %s with nonexistent object %s",
+			    lock->ref_name, sha1_to_hex(sha1));
 		unlock_ref(lock);
 		errno = EINVAL;
 		return -1;
 	}
 	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
-		error("Trying to write non-commit object %s to branch %s",
-			sha1_to_hex(sha1), lock->ref_name);
+		strbuf_addf(err,
+			    "Trying to write non-commit object %s to branch %s",
+			    sha1_to_hex(sha1), lock->ref_name);
 		unlock_ref(lock);
 		errno = EINVAL;
 		return -1;
@@ -3273,10 +3276,9 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
-		int save_errno = errno;
-		error("Couldn't write %s", lock->lk->filename.buf);
+		strbuf_addf(err,
+			    "Couldn't write %s", lock->lk->filename.buf);
 		unlock_ref(lock);
-		errno = save_errno;
 		return -1;
 	}
 	return 0;
@@ -3288,14 +3290,20 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
  * necessary, using the specified lockmsg (which can be NULL).
  */
 static int commit_ref_update(struct ref_lock *lock,
-			     const unsigned char *sha1, const char *logmsg)
+			     const unsigned char *sha1, const char *logmsg,
+			     struct strbuf *err)
 {
+	int result = 0;
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg) < 0 ||
+	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg) < 0)) {
-		unlock_ref(lock);
-		return -1;
+	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0)) {
+		char *old_msg = strbuf_detach(err, NULL);
+		strbuf_addf(err, "Cannot update the ref '%s': '%s'",
+			    lock->ref_name, old_msg);
+		free(old_msg);
+		result = -1;
+		goto done;
 	}
 	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
 		/*
@@ -3316,16 +3324,21 @@ static int commit_ref_update(struct ref_lock *lock,
 		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
-		    !strcmp(head_ref, lock->ref_name))
-			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg);
+		    !strcmp(head_ref, lock->ref_name)) {
+			if (log_ref_write("HEAD", lock->old_oid.hash, sha1,
+					  logmsg, err)) {
+				result = -1;
+				goto done;
+			}
+		}
 	}
 	if (commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
-		unlock_ref(lock);
-		return -1;
+		result = -1;
 	}
+done:
 	unlock_ref(lock);
-	return 0;
+	return result;
 }
 
 int create_symref(const char *ref_target, const char *refs_heads_master,
@@ -3336,6 +3349,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
 	unsigned char old_sha1[20], new_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (logmsg && read_ref(ref_target, old_sha1))
 		hashclr(old_sha1);
@@ -3384,8 +3398,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 #ifndef NO_SYMLINK_HEAD
 	done:
 #endif
-	if (logmsg && !read_ref(refs_heads_master, new_sha1))
-		log_ref_write(ref_target, old_sha1, new_sha1, logmsg);
+	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
+		log_ref_write(ref_target, old_sha1, new_sha1, logmsg, &err)) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+	}
 
 	free(git_HEAD);
 	return 0;
@@ -4021,14 +4038,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				 * value, so we don't need to write it.
 				 */
 			} else if (write_ref_to_lockfile(update->lock,
-							 update->new_sha1)) {
+							 update->new_sha1,
+							 err)) {
 				/*
 				 * The lock was freed upon failure of
 				 * write_ref_to_lockfile():
 				 */
 				update->lock = NULL;
-				strbuf_addf(err, "cannot update the ref '%s'.",
-					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			} else {
@@ -4054,11 +4070,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->flags & REF_NEEDS_COMMIT) {
 			if (commit_ref_update(update->lock,
-					      update->new_sha1, update->msg)) {
+					      update->new_sha1, update->msg, err)) {
 				/* freed by commit_ref_update(): */
 				update->lock = NULL;
-				strbuf_addf(err, "Cannot update the ref '%s'.",
-					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			} else {
diff --git a/refs.h b/refs.h
index e82fca5..debdefc 100644
--- a/refs.h
+++ b/refs.h
@@ -226,9 +226,9 @@ int pack_refs(unsigned int flags);
 #define REF_NODEREF	0x01
 
 /*
- * Setup reflog before using. Set errno to something meaningful on failure.
+ * Setup reflog before using. Fill in err and return -1 on failure.
  */
-int log_ref_setup(const char *refname, struct strbuf *logfile);
+int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-- 
2.0.5.499.g01f6352.dirty-twtrsrc
