From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/24] reflog_expire(): new function in the reference API
Date: Fri, 12 Dec 2014 09:56:59 +0100
Message-ID: <1418374623-5566-21-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2p-0004eU-Ki
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbaLLI5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:42 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43826 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934691AbaLLI5j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:39 -0500
X-AuditID: 1207440f-f792a6d000001284-0c-548aae03c8b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id EE.47.04740.30EAA845; Fri, 12 Dec 2014 03:57:39 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nU023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:37 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqMu8rivE4MxBdouuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xuQDd5kKrqRVnH/Sw97A+Dmwi5GTQ0LAROLV+1XMELaYxIV769m6GLk4hAQu
	M0rs6L7KDuEcY5LYsnM7G0gVm4CuxKKeZiYQW0RATWJi2yEWEJtZ4ASjxOyGEBBbWMBH4v7H
	6YwgNouAqsTSZ5fANvAKuEise/UZaA4H0DY5ia3rvEHCnEDhiy1PwMYICThLbF3RyTqBkXcB
	I8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJDQ4t/B2LVe5hCjAAejEg/v
	i9SuECHWxLLiytxDjJIcTEqivN8nA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8P6NAsrxpiRW
	VqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR449YANQoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL1sa0H2Fhck5gJFIVpPMSpKifO2gswVAElk
	lObBjYUljFeM4kBfCvPWgVTxAJMNXPcroMFMQIOXb+kAGVySiJCSamC0YZS7eKNR4ITOR4/p
	y+0e7H/YLqU/M8L+u21D/8qLdspGtWeb78/8dmr1RWWTxG8a/bz3P5hwWM/6lvauwkT25sll
	9w/xKczb/jWx4dxEBpcpnr1BCSXSYTe/fSqc/WmCZ/72D+rtLP0SPucW2kg6Scqu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261327>

Move expire_reflog() into refs.c and rename it to reflog_expire().
Turn the three policy functions into function pointers that are passed
into reflog_expire(). Add function prototypes and documentation to
refs.h.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 148 ++++++-------------------------------------------------
 refs.c           | 129 ++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h           |  46 +++++++++++++++++
 3 files changed, 190 insertions(+), 133 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 0df5721..49c64f9 100644
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
@@ -428,90 +382,6 @@ static void reflog_expiry_cleanup(void *cb_data)
 	}
 }
 
-static int expire_reflog(const char *refname, const unsigned char *sha1,
-			 unsigned int flags, void *policy_cb_data)
-{
-	static struct lock_file reflog_lock;
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
-	 * The reflog file is locked by holding the lock on the
-	 * reference itself, plus we might need to update the
-	 * reference if --updateref was specified:
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
-		/*
-		 * Even though holding $GIT_DIR/logs/$reflog.lock has
-		 * no locking implications, we use the lock_file
-		 * machinery here anyway because it does a lot of the
-		 * work we need, including cleaning up if the program
-		 * exits unexpectedly.
-		 */
-		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
-			struct strbuf err = STRBUF_INIT;
-			unable_to_lock_message(log_file, errno, &err);
-			error("%s", err.buf);
-			strbuf_release(&err);
-			goto failure;
-		}
-		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
-		if (!cb.newlog) {
-			error("cannot fdopen %s (%s)",
-			      reflog_lock.filename.buf, strerror(errno));
-			goto failure;
-		}
-	}
-
-	reflog_expiry_prepare(refname, sha1, cb.policy_cb);
-	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
-	reflog_expiry_cleanup(cb.policy_cb);
-
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
-		if (close_lock_file(&reflog_lock)) {
-			status |= error("couldn't write %s: %s", log_file,
-					strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			(write_in_full(lock->lock_fd,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
-			 close_ref(lock) < 0)) {
-			status |= error("couldn't write %s",
-					lock->lk->filename.buf);
-			rollback_lock_file(&reflog_lock);
-		} else if (commit_lock_file(&reflog_lock)) {
-			status |= error("unable to commit reflog '%s' (%s)",
-					log_file, strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
-			status |= error("couldn't set %s", lock->ref_name);
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
@@ -727,7 +597,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
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
@@ -741,7 +615,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
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
@@ -813,7 +691,11 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
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
index 150c980..0252fcc 100644
--- a/refs.c
+++ b/refs.c
@@ -3943,3 +3943,132 @@ int ref_is_hidden(const char *refname)
 	}
 	return 0;
 }
+
+struct expire_reflog_cb {
+	unsigned int flags;
+	reflog_expiry_should_prune_fn *should_prune_fn;
+	void *policy_cb;
+	FILE *newlog;
+	unsigned char last_kept_sha1[20];
+};
+
+static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     const char *email, unsigned long timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
+
+	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
+		osha1 = cb->last_kept_sha1;
+
+	if ((*cb->should_prune_fn)(osha1, nsha1, email, timestamp, tz,
+				   message, policy_cb)) {
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
+extern int reflog_expire(const char *refname, const unsigned char *sha1,
+			 unsigned int flags,
+			 reflog_expiry_prepare_fn prepare_fn,
+			 reflog_expiry_should_prune_fn should_prune_fn,
+			 reflog_expiry_cleanup_fn cleanup_fn,
+			 void *policy_cb_data)
+{
+	static struct lock_file reflog_lock;
+	struct expire_reflog_cb cb;
+	struct ref_lock *lock;
+	char *log_file;
+	int status = 0;
+
+	memset(&cb, 0, sizeof(cb));
+	cb.flags = flags;
+	cb.policy_cb = policy_cb_data;
+	cb.should_prune_fn = should_prune_fn;
+
+	/*
+	 * The reflog file is locked by holding the lock on the
+	 * reference itself, plus we might need to update the
+	 * reference if --updateref was specified:
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
+		/*
+		 * Even though holding $GIT_DIR/logs/$reflog.lock has
+		 * no locking implications, we use the lock_file
+		 * machinery here anyway because it does a lot of the
+		 * work we need, including cleaning up if the program
+		 * exits unexpectedly.
+		 */
+		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
+			struct strbuf err = STRBUF_INIT;
+			unable_to_lock_message(log_file, errno, &err);
+			error("%s", err.buf);
+			strbuf_release(&err);
+			goto failure;
+		}
+		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		if (!cb.newlog) {
+			error("cannot fdopen %s (%s)",
+			      reflog_lock.filename.buf, strerror(errno));
+			goto failure;
+		}
+	}
+
+	(*prepare_fn)(refname, sha1, cb.policy_cb);
+	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
+	(*cleanup_fn)(cb.policy_cb);
+
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		if (close_lock_file(&reflog_lock)) {
+			status |= error("couldn't write %s: %s", log_file,
+					strerror(errno));
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+			(write_in_full(lock->lock_fd,
+				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
+			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
+			 close_ref(lock) < 0)) {
+			status |= error("couldn't write %s",
+					lock->lk->filename.buf);
+			rollback_lock_file(&reflog_lock);
+		} else if (commit_lock_file(&reflog_lock)) {
+			status |= error("unable to commit reflog '%s' (%s)",
+					log_file, strerror(errno));
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
+			status |= error("couldn't set %s", lock->ref_name);
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
index 7d675b7..99e707b 100644
--- a/refs.h
+++ b/refs.h
@@ -353,4 +353,50 @@ int update_ref(const char *action, const char *refname,
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
+ * reflog_expiry_should_prune_fn -- Called once for each entry in the
+ *     existing reflog. It should return true iff that entry should be
+ *     pruned.
+ *
+ * reflog_expiry_cleanup_fn -- Called once before the reference is
+ *     unlocked again.
+ */
+typedef void reflog_expiry_prepare_fn(const char *refname,
+				      const unsigned char *sha1,
+				      void *cb_data);
+typedef int reflog_expiry_should_prune_fn(unsigned char *osha1,
+					  unsigned char *nsha1,
+					  const char *email,
+					  unsigned long timestamp, int tz,
+					  const char *message, void *cb_data);
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
+			 reflog_expiry_should_prune_fn should_prune_fn,
+			 reflog_expiry_cleanup_fn cleanup_fn,
+			 void *policy_cb_data);
+
 #endif /* REFS_H */
-- 
2.1.3
