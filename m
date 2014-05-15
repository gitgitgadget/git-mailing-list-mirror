From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 21/44] refs.c: ref_transaction_commit should not free the transaction
Date: Thu, 15 May 2014 16:15:18 -0700
Message-ID: <1400195741-22996-22-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sk-0004YP-Qb
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbaEOXPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:54 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:52844 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so390637obc.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHej46VUS5f8dF1vNdpH7sWmD+n977Vdu3ToaDJyC7g=;
        b=kxoav59ECgP3R2YMp7Z5ETskzb7yMqrE0qeqClZjzGx/Ipgq/x2c4YQa84i4qAgdgb
         vH7L2fAiAfj/NY3J1IJbUZl+XArdQsSuFdxH0h5pAkrgPIsabKL5rjX63Q9XlRfQqLTv
         MHrYeWujkC11J0QbwiSnVDJiik1Gcbt53vg2xM0OTTs1VuurrL0qiYK8zPM1DB9BWkq0
         wzQqt00uVRIPMOPbKhn+K1zz5qC69VUKhivJdr9/5WdDqAYGI9osewPoN/ARp/J+ljTq
         2UGhZrVPQy75vesctlKPxnOSdMqv5V0u95YyspmdNxrLDbR0HF7rfQIODgtsiIsU3lu2
         ZHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pHej46VUS5f8dF1vNdpH7sWmD+n977Vdu3ToaDJyC7g=;
        b=dj+MlMDg/tDEPdiDAdmnLsxDJsuxMoEHU2vA2L4BIFelvZuczla1b1gqVjqqVk2Qgc
         JhviH2IkEwG29CPHtRMYtgUrc2JLN2smvcZM1Ny0dLqM/MJvvn+46aTocjH+jx8y3Uy7
         4rY0YcmdkkoM/vbWOz7gkNhrhm9h9ahpI4BOM/FQoCOiJz7f/icP080+yJ4l+O5nObvv
         gN0M8oX9g9vNdhsWLYHyKr3hJJ6TEEH17qwyeOMUIaKebHfbD+augFclOrgp+pfMBGSZ
         lxpxpNPQBpjEe7bkjijJ+QhdrzSZ3Th56zYB5kydnuEgCVHAM2APNxRbHOwujj8vQb6l
         vY4A==
X-Gm-Message-State: ALoCoQnY0cclyIGHJAMzqpf6FHkjreiMB1Vn2ax2VaMCtQg5pWCl4lCaDtnGIgzIr4/37oIDaGIT
X-Received: by 10.42.185.1 with SMTP id cm1mr5941060icb.10.1400195745494;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si319191yhj.2.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 47E4F31C259;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 23CB1E0475; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249226>

Change ref_transaction_commit so that it does not free the transaction.
Instead require that a caller will end a transaction by either calling
ref_transaction_rollback or ref_transaction_free.

By having the transaction object remaining valid after _commit returns allows
us to write much nicer code and still be able to call ref_transaction_rollback
safely. Instead of this horribleness
	t = ref_transaction_begin();
	if ((!t ||
	    ref_transaction_update(t, refname, sha1, oldval, flags,
				   !!oldval)) ||
	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
		ref_transaction_rollback(t);

we can now just do the much nicer
	t = ref_transaction_begin();
	if (!t ||
	    ref_transaction_update(t, refname, sha1, oldval, flags,
				   !!oldval) ||
	    ref_transaction_commit(&t, action, &err)) {
		ref_transaction_rollback(t);
		... die/return ...

	ref_transaction_free(transaction);

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c             |  1 +
 builtin/commit.c     |  1 +
 builtin/replace.c    |  1 +
 builtin/tag.c        |  1 +
 builtin/update-ref.c |  1 +
 fast-import.c        |  4 ++--
 refs.c               | 14 ++++++--------
 refs.h               | 14 +++++++++-----
 sequencer.c          |  4 ++--
 9 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/branch.c b/branch.c
index 8bf7588..f78a28b 100644
--- a/branch.c
+++ b/branch.c
@@ -304,6 +304,7 @@ void create_branch(const char *head,
 					   null_sha1, 0, !forcing, &err) ||
 		    ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
+		ref_transaction_free(transaction);
 	}
 
 	if (real_ref && track)
diff --git a/builtin/commit.c b/builtin/commit.c
index c429216..6b888f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1726,6 +1726,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		rollback_index_files();
 		die("%s", err.buf);
 	}
+	ref_transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
diff --git a/builtin/replace.c b/builtin/replace.c
index e8932cd..af7f72d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -164,6 +164,7 @@ static int replace_object_sha1(const char *object_ref,
 	    ref_transaction_commit(transaction, NULL, &err))
 		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/builtin/tag.c b/builtin/tag.c
index b05f9a5..30b471c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -708,6 +708,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 				   0, !is_null_sha1(prev), &err) ||
 	    ref_transaction_commit(transaction, NULL, &err))
 		die("%s", err.buf);
+	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index cdb71a8..4c2145e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -373,6 +373,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
+		ref_transaction_free(transaction);
 		return 0;
 	}
 
diff --git a/fast-import.c b/fast-import.c
index bac799c..6b186ce 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1710,13 +1710,13 @@ static int update_branch(struct branch *b)
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
 				   0, 1, &err) ||
-	    (ref_transaction_commit(transaction, msg, &err) &&
-	     !(transaction = NULL))) {
+	    ref_transaction_commit(transaction, msg, &err)) {
 		ref_transaction_rollback(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index b4c7d04..016206b 100644
--- a/refs.c
+++ b/refs.c
@@ -3350,7 +3350,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3451,10 +3451,10 @@ int update_ref(const char *action, const char *refname,
 	struct strbuf err = STRBUF_INIT;
 
 	t = ref_transaction_begin();
-	if ((!t ||
+	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, &err)) ||
-	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+				   !!oldval, &err) ||
+	    ref_transaction_commit(t, action, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_rollback(t);
@@ -3468,6 +3468,7 @@ int update_ref(const char *action, const char *refname,
 		strbuf_release(&err);
 		return 1;
 	}
+	ref_transaction_free(t);
 	return 0;
 }
 
@@ -3502,10 +3503,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n) {
-		ref_transaction_free(transaction);
+	if (!n)
 		return 0;
-	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3572,7 +3571,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 2c2e694..608ca10 100644
--- a/refs.h
+++ b/refs.h
@@ -216,8 +216,8 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or rolled
- * back using ref_transaction_rollback().
+ * eventually be freed by either calling ref_transaction_rollback()
+ * or ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -285,13 +285,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
- * If err is non-NULL we will add an error string to it to explain why
- * the transaction failed. The string does not end in newline.
+ * problem. If err is non-NULL we will add an error string to it to explain
+ * why the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, struct strbuf *err);
 
+/*
+ * Free an existing transaction.
+ */
+void ref_transaction_free(struct ref_transaction *transaction);
+
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
diff --git a/sequencer.c b/sequencer.c
index e6b3bbc..f6f1536 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -286,14 +286,14 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", to, from,
 				   0, !unborn, &err) ||
-	    (ref_transaction_commit(transaction, sb.buf, &err) &&
-	     !(transaction = NULL))) {
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		ref_transaction_rollback(transaction);
 		error("%s", err.buf);
 		strbuf_release(&sb);
 		strbuf_release(&err);
 		return -1;
 	}
+	ref_transaction_free(transaction);
 
 	strbuf_release(&sb);
 	return 0;
-- 
2.0.0.rc3.477.gffe78a2
