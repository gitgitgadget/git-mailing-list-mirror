From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 19/42] refs.c: ref_transaction_commit should not free the transaction
Date: Wed, 14 May 2014 14:16:53 -0700
Message-ID: <1400102236-30082-20-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:17:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgYX-0002V2-HS
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbaENVRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:33 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:36424 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbaENVR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:27 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so40801obc.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0qRLgAOqPOk7vv56pcUJIDjCbY86wvmsvBinND39HNo=;
        b=lykTmMYwmXKUK3/9yeKagNb0v5+bLP3regExwz4DjbaoeGPzOzOJskCf2N5a6WFk0d
         yCp4WlcovgiuqRpwP/LW8xcfyxpHOnNsKTdtVUhqHRtoNifED/+ivCIqkImZHrCG34Yt
         ZgAorfV9eCfN1VsLqDoRMIlm9rfsm3fljWdOLvA04zK4BAGaYXrmHoKMAnaUB+m2rcKl
         iGu3nWj+IZ8pS/vG7gxCg7jjdtX8vR5jb4whsXIBkSvzYAbCjNiEJa1cFE51rkaksQS9
         SWa/mclmkLLVN+xhcax7+uS5ru7v84NbyBWEYMrgzAcfV49VOyZBmhZzYXybANrv34MN
         +oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0qRLgAOqPOk7vv56pcUJIDjCbY86wvmsvBinND39HNo=;
        b=ZzaeJlWKl86SfByoOhYg5HraqoMyouh4ToqvPsO0+S4LfPLhnYzXe1V3xd71Wijjh+
         qzOjCL7jXEwToOwEyDKTaQ1l7RfuP7HvvTQmS/IVRlFSy6wVDqEWQXNe5uZA9O6dt9Su
         6ydBKdCqNN5IY/pSu4lBYR4/UV4v/vkzMIua2vTkBgBSYbnU1mbU/Gwq1c1OzsWuyS5A
         /ucWrF8eSIpJ/hkjO5sPCx+oioSZdGwJdhqMvfPUFxNu/LjsNp6OXnMhn0aQ56m9YBcK
         RNCtn3o10QschBr/Mwihw1pIxpwkDqGFiGh/24rQllWz/FRMzWi6i+RxeWvEveTl/QkD
         +unw==
X-Gm-Message-State: ALoCoQmHWtKqwDf2MuW+FzJscau1uS3EGMlA9DeWCQiQyygYG2VNsKvVUTX9IFAOak1xkIGY4LMw
X-Received: by 10.42.206.77 with SMTP id ft13mr2595325icb.22.1400102246515;
        Wed, 14 May 2014 14:17:26 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si146339yhj.0.2014.05.14.14.17.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:26 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 414E45A42DA;
	Wed, 14 May 2014 14:17:26 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 06AB7E0CB6; Wed, 14 May 2014 14:17:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248960>

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
 fast-import.c        |  8 ++++----
 refs.c               | 14 ++++++--------
 refs.h               | 14 +++++++++-----
 sequencer.c          |  8 ++++----
 9 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/branch.c b/branch.c
index 2aa5c82..8e58908 100644
--- a/branch.c
+++ b/branch.c
@@ -305,6 +305,7 @@ void create_branch(const char *head,
 			ref_transaction_commit(transaction, msg, &err))
 				die_errno(_("%s: failed to write ref: %s"),
 					  ref.buf, err.buf);
+		ref_transaction_free(transaction);
 	}
 
 	if (real_ref && track)
diff --git a/builtin/commit.c b/builtin/commit.c
index ae1b081..4c577d3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1726,6 +1726,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		rollback_index_files();
 		die(_("HEAD: cannot update ref: %s"), err.buf);
 	}
+	ref_transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
diff --git a/builtin/replace.c b/builtin/replace.c
index 11dc2e1..14e8f2f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -164,6 +164,7 @@ static int replace_object_sha1(const char *object_ref,
 	    ref_transaction_commit(transaction, NULL, &err))
 		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/builtin/tag.c b/builtin/tag.c
index bf2a5c3..fbd2989 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -708,6 +708,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 				   0, !is_null_sha1(prev)) ||
 	    ref_transaction_commit(transaction, NULL, &err))
 		die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);
+	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index fc3512f..7fe9c11 100644
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
index 79d219b..3e356da 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1708,16 +1708,16 @@ static int update_branch(struct branch *b)
 		}
 	}
 	transaction = ref_transaction_begin();
-	if ((!transaction ||
+	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1)) ||
-	    (ref_transaction_commit(transaction, msg, &err) &&
-	     !(transaction = NULL))) {
+				   0, 1) ||
+	    ref_transaction_commit(transaction, msg, &err)) {
 		ref_transaction_rollback(transaction);
 		error("Unable to update branch %s: %s", b->name, err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index a48873c..4673cf4 100644
--- a/refs.c
+++ b/refs.c
@@ -3311,7 +3311,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3409,10 +3409,10 @@ int update_ref(const char *action, const char *refname,
 	struct strbuf err = STRBUF_INIT;
 
 	t = ref_transaction_begin();
-	if ((!t ||
+	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval)) ||
-	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+				   !!oldval) ||
+	    ref_transaction_commit(t, action, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_rollback(t);
@@ -3426,6 +3426,7 @@ int update_ref(const char *action, const char *refname,
 		strbuf_release(&err);
 		return 1;
 	}
+	ref_transaction_free(t);
 	return 0;
 }
 
@@ -3460,10 +3461,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n) {
-		ref_transaction_free(transaction);
+	if (!n)
 		return 0;
-	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3529,7 +3528,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 6026edf..b7535b5 100644
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
 
@@ -276,13 +276,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
index 9282a12..0cfdaf0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -283,17 +283,17 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
 	transaction = ref_transaction_begin();
-	if ((!transaction ||
+	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", to, from,
-				   0, !unborn)) ||
-	    (ref_transaction_commit(transaction, sb.buf, &err) &&
-	     !(transaction = NULL))) {
+				   0, !unborn) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		ref_transaction_rollback(transaction);
 		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
 		strbuf_release(&sb);
 		strbuf_release(&err);
 		return -1;
 	}
+	ref_transaction_free(transaction);
 
 	strbuf_release(&sb);
 	return 0;
-- 
2.0.0.rc3.471.g2055d11.dirty
