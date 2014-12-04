From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/23] reflog_expire(): new function in the reference API
Date: Fri,  5 Dec 2014 00:08:32 +0100
Message-ID: <1417734515-11812-21-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWS-00033l-OV
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933361AbaLDXJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:15 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52764 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933344AbaLDXJK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:10 -0500
X-AuditID: 12074411-f79fa6d000006b8a-e1-5480e9955c82
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id FA.60.27530.599E0845; Thu,  4 Dec 2014 18:09:09 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deH027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:08 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqDv1ZUOIwbcWQYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xuINncwFE2IqVm3sY2pgvOXZxcjBISFgIrHygF0XIyeQKSZx4d56ti5GLg4h
	gcuMEs2zZjJCOMeYJG68ecQIUsUmoCuxqKeZCcQWEVCTmLlqNlgHs8AJRolfk7sZQaYKC3hK
	rO+0BzFZBFQlNrdzg5i8Aq4SJxe7QayVk9i6zhtkCCdQdOrMVrDhQgIuEs82LWSfwMi7gJFh
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIUAnuYJxxUu4QowAHoxIPb8Hu
	+hAh1sSy4srcQ4ySHExKorxnnzaECPEl5adUZiQWZ8QXleakFh9ilOBgVhLhNT4ClONNSays
	Si3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfCWvgBqFCxKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAfFRHwxMCpAUjxAey1B2nmLCxJzgaIQracYFaXEeetBEgIgiYzS
	PLixsFTxilEc6EthiHYeYJqB634FNJgJaPDZhlqQwSWJCCmpBsZd7++fcXLZYr/qvd/0tHly
	Pgw3V5vEnLsff3vLA5Uog9gFa28lRN8/zqmVPYt31svDE+p3cVTte8G4Xt59K8sGmzMeeWtZ
	vppOXjFzsqVd7dRVaRXHove6bH2xbMbdru+P6sW+HA44drCJ8751In9Gy4bHO07K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260821>

Move expire_reflog() into refs.c and rename it to reflog_expire().
Turn the three policy functions into function pointers that are passed
into reflog_expire(). Add function prototypes and documentation to
refs.h.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 133 +++++++------------------------------------------------
 refs.c           | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.h           |  45 +++++++++++++++++++
 3 files changed, 174 insertions(+), 118 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c30936bb..49c64f9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -20,13 +20,6 @@ static const char reflog_delete_usage[] =
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
 
-enum expire_reflog_flags {
-	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
-	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
-	EXPIRE_REFLOGS_REWRITE = 1 << 3
-};
-
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
@@ -48,13 +41,6 @@ struct expire_reflog_policy_cb {
 	struct commit_list *tips;
 };
 
-struct expire_reflog_cb {
-	unsigned int flags;
-	void *policy_cb;
-	FILE *newlog;
-	unsigned char last_kept_sha1[20];
-};
-
 struct collected_reflog {
 	unsigned char sha1[20];
 	char reflog[FLEX_ARRAY];
@@ -330,38 +316,6 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
-		const char *message, void *cb_data)
-{
-	struct expire_reflog_cb *cb = cb_data;
-	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
-
-	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
-		osha1 = cb->last_kept_sha1;
-
-	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
-				     message, policy_cb)) {
-		if (!cb->newlog)
-			printf("would prune %s", message);
-		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("prune %s", message);
-	} else {
-		if (cb->newlog) {
-			char sign = (tz < 0) ? '-' : '+';
-			int zone = (tz < 0) ? (-tz) : tz;
-			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
-				sha1_to_hex(osha1), sha1_to_hex(nsha1),
-				email, timestamp, sign, zone,
-				message);
-			hashcpy(cb->last_kept_sha1, nsha1);
-		}
-		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("keep %s", message);
-	}
-	return 0;
-}
-
 static int push_tip_to_list(const char *refname, const unsigned char *sha1,
 			    int flags, void *cb_data)
 {
@@ -428,75 +382,6 @@ static void reflog_expiry_cleanup(void *cb_data)
 	}
 }
 
-static struct lock_file reflog_lock;
-
-static int expire_reflog(const char *refname, const unsigned char *sha1,
-			 unsigned int flags, void *policy_cb_data)
-{
-	struct expire_reflog_cb cb;
-	struct ref_lock *lock;
-	char *log_file;
-	int status = 0;
-
-	memset(&cb, 0, sizeof(cb));
-	cb.flags = flags;
-	cb.policy_cb = policy_cb_data;
-
-	/*
-	 * we take the lock for the ref itself to prevent it from
-	 * getting updated.
-	 */
-	lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
-	if (!lock)
-		return error("cannot lock ref '%s'", refname);
-	if (!reflog_exists(refname)) {
-		unlock_ref(lock);
-		return 0;
-	}
-
-	log_file = git_pathdup("logs/%s", refname);
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
-		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
-			goto failure;
-		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
-		if (!cb.newlog)
-			goto failure;
-	}
-
-	reflog_expiry_prepare(refname, sha1, cb.policy_cb);
-	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
-	reflog_expiry_cleanup(cb.policy_cb);
-
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
-		if (close_lock_file(&reflog_lock)) {
-			status |= error("Couldn't write %s: %s", log_file,
-					strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			(write_in_full(lock->lock_fd,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
-			 close_ref(lock) < 0)) {
-			status |= error("Couldn't write %s",
-					lock->lk->filename.buf);
-			rollback_lock_file(&reflog_lock);
-		} else if (commit_lock_file(&reflog_lock)) {
-			status |= error("cannot rename %s.lock to %s",
-					log_file, log_file);
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
-			status |= error("Couldn't set %s", lock->ref_name);
-		}
-	}
-	free(log_file);
-	unlock_ref(lock);
-	return status;
-
- failure:
-	rollback_lock_file(&reflog_lock);
-	free(log_file);
-	unlock_ref(lock);
-	return -1;
-}
-
 static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
 {
 	struct collected_reflog *e;
@@ -712,7 +597,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= expire_reflog(e->reflog, e->sha1, flags, &cb);
+			status |= reflog_expire(e->reflog, e->sha1, flags,
+						reflog_expiry_prepare,
+						should_expire_reflog_ent,
+						reflog_expiry_cleanup,
+						&cb);
 			free(e);
 		}
 		free(collected.e);
@@ -726,7 +615,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
-		status |= expire_reflog(ref, sha1, flags, &cb);
+		status |= reflog_expire(ref, sha1, flags,
+					reflog_expiry_prepare,
+					should_expire_reflog_ent,
+					reflog_expiry_cleanup,
+					&cb);
 	}
 	return status;
 }
@@ -798,7 +691,11 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.cmd.expire_total = 0;
 		}
 
-		status |= expire_reflog(ref, sha1, flags, &cb);
+		status |= reflog_expire(ref, sha1, flags,
+					reflog_expiry_prepare,
+					should_expire_reflog_ent,
+					reflog_expiry_cleanup,
+					&cb);
 		free(ref);
 	}
 	return status;
diff --git a/refs.c b/refs.c
index 150c980..5a12d37 100644
--- a/refs.c
+++ b/refs.c
@@ -3943,3 +3943,117 @@ int ref_is_hidden(const char *refname)
 	}
 	return 0;
 }
+
+struct expire_reflog_cb {
+	unsigned int flags;
+	reflog_expiry_select_fn *select_fn;
+	void *policy_cb;
+	FILE *newlog;
+	unsigned char last_kept_sha1[20];
+};
+
+static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
+
+	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
+		osha1 = cb->last_kept_sha1;
+
+	if ((*cb->select_fn)(osha1, nsha1, email, timestamp, tz,
+			     message, policy_cb)) {
+		if (!cb->newlog)
+			printf("would prune %s", message);
+		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
+			printf("prune %s", message);
+	} else {
+		if (cb->newlog) {
+			char sign = (tz < 0) ? '-' : '+';
+			int zone = (tz < 0) ? (-tz) : tz;
+			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
+				sha1_to_hex(osha1), sha1_to_hex(nsha1),
+				email, timestamp, sign, zone,
+				message);
+			hashcpy(cb->last_kept_sha1, nsha1);
+		}
+		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
+			printf("keep %s", message);
+	}
+	return 0;
+}
+
+static struct lock_file reflog_lock;
+
+extern int reflog_expire(const char *refname, const unsigned char *sha1,
+			 unsigned int flags,
+			 reflog_expiry_prepare_fn prepare_fn,
+			 reflog_expiry_select_fn select_fn,
+			 reflog_expiry_cleanup_fn cleanup_fn,
+			 void *policy_cb_data)
+{
+	struct expire_reflog_cb cb;
+	struct ref_lock *lock;
+	char *log_file;
+	int status = 0;
+
+	memset(&cb, 0, sizeof(cb));
+	cb.flags = flags;
+	cb.policy_cb = policy_cb_data;
+	cb.select_fn = select_fn;
+
+	/*
+	 * we take the lock for the ref itself to prevent it from
+	 * getting updated.
+	 */
+	lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
+	if (!lock)
+		return error("cannot lock ref '%s'", refname);
+	if (!reflog_exists(refname)) {
+		unlock_ref(lock);
+		return 0;
+	}
+
+	log_file = git_pathdup("logs/%s", refname);
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
+			goto failure;
+		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		if (!cb.newlog)
+			goto failure;
+	}
+
+	(*prepare_fn)(refname, sha1, cb.policy_cb);
+	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
+	(*cleanup_fn)(cb.policy_cb);
+
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		if (close_lock_file(&reflog_lock)) {
+			status |= error("Couldn't write %s: %s", log_file,
+					strerror(errno));
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+			(write_in_full(lock->lock_fd,
+				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
+			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
+			 close_ref(lock) < 0)) {
+			status |= error("Couldn't write %s",
+					lock->lk->filename.buf);
+			rollback_lock_file(&reflog_lock);
+		} else if (commit_lock_file(&reflog_lock)) {
+			status |= error("cannot rename %s.lock to %s",
+					log_file, log_file);
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
+			status |= error("Couldn't set %s", lock->ref_name);
+		}
+	}
+	free(log_file);
+	unlock_ref(lock);
+	return status;
+
+ failure:
+	rollback_lock_file(&reflog_lock);
+	free(log_file);
+	unlock_ref(lock);
+	return -1;
+}
diff --git a/refs.h b/refs.h
index 7d675b7..d777f76 100644
--- a/refs.h
+++ b/refs.h
@@ -353,4 +353,49 @@ int update_ref(const char *action, const char *refname,
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
 
+enum expire_reflog_flags {
+	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
+	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
+	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
+	EXPIRE_REFLOGS_REWRITE = 1 << 3
+};
+
+/*
+ * The following interface is used for reflog expiration. The caller
+ * calls reflog_expire(), supplying it with three callback functions,
+ * of the following types. The callback functions define the
+ * expiration policy that is desired.
+ *
+ * reflog_expiry_prepare_fn -- Called once after the reference is
+ *     locked.
+ *
+ * reflog_expiry_select_fn -- Called once for each entry in the
+ *     existing reflog. It should return true iff that entry should be
+ *     pruned.
+ *
+ * reflog_expiry_cleanup_fn -- Called once before the reference is
+ *     unlocked again.
+ */
+typedef void reflog_expiry_prepare_fn(const char *refname,
+				      const unsigned char *sha1,
+				      void *cb_data);
+typedef int reflog_expiry_select_fn(unsigned char *osha1, unsigned char *nsha1,
+				    const char *email,
+				    unsigned long timestamp, int tz,
+				    const char *message, void *cb_data);
+typedef void reflog_expiry_cleanup_fn(void *cb_data);
+
+/*
+ * Expire reflog entries for the specified reference. sha1 is the old
+ * value of the reference. flags is a combination of the constants in
+ * enum expire_reflog_flags. The three function pointers are described
+ * above. On success, return zero.
+ */
+extern int reflog_expire(const char *refname, const unsigned char *sha1,
+			 unsigned int flags,
+			 reflog_expiry_prepare_fn prepare_fn,
+			 reflog_expiry_select_fn select_fn,
+			 reflog_expiry_cleanup_fn cleanup_fn,
+			 void *policy_cb_data);
+
 #endif /* REFS_H */
-- 
2.1.3
