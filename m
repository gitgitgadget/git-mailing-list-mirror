From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 19/30] refs.c: ref_transaction_commit should not free the transaction
Date: Tue, 29 Apr 2014 15:19:04 -0700
Message-ID: <1398809955-32008-20-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:19:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGNL-0001rR-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbaD2WTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:33 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:59520 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965281AbaD2WT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:26 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so140260qcv.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fHPrSZjr+YJQIe3vTBX6WK8FJpVgVmpzXhgjkve5Yw8=;
        b=MPgnmMMcQlni2QJnISegzm6uM5veq5G7/F5Bbzrq3GhdXsTN0pMzYP3EdLijxweM0l
         vqC16p8ue2LE/tN/5s2h8/N3vjxKOFkluGbYq9aRfWDQOs1mUh4T84LaRlyUL9IAPKLJ
         j7vaT1uC6TSrrlczBtBgoDLj1ntLjavSdBtvTDUAbJHdE4F8KAT1LpjGHf+WJ5TSZKIt
         ncw002MvfJ4r0wfX16hTTITi6jgyaijLvUiZH3m9GLn40B6G/FbOkSyDfUss7fmDPpXj
         uNnUvf+XznI4wJFEbqloEzX+WX2iiMul5la0rfBVwlqHJfkqMw0jrj2m1NsBj3pqkIAJ
         X+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fHPrSZjr+YJQIe3vTBX6WK8FJpVgVmpzXhgjkve5Yw8=;
        b=ZmM9aYcJZINy5b0mjSeC2NaGIdwjtDNHimgi8wr4fwwEjCKpEMTBTKVz08/gX2C7Se
         yO2bfjbRGRcmpReKmPjAAAlgKbRXjHXtK1Ud3NEUwtNwua3p3BZiaAQ4AsBC5/El1pxt
         m6EvU3Q/6AokcHBGF6YOBcWonLZoz3cPHaJhSvCD41148VORb9gKAP6GpdlU0GNUmGNE
         FnZO89P/6VLY5KO9Emvlwn/s2nHkRrtmgMh9jRq9l5GTwXPyaSx08DV3Z0pF7IKPFK8Z
         tCpdNfIC2+mlfajxd/AnXMbqD1/bnHTFgPirdye9H2WudbzrNKbH3SL/kAVThRl0r+oZ
         5Hgw==
X-Gm-Message-State: ALoCoQlH6GtFMKZM9WDix4opoD5+/nNXIxjmy3N0tXd2XzZLFGQl/AWfJezf1hhmN7+lJjAZdE09lFUmoos1sN1ExRxDGJmFcNMGOZXqUcnkqWRum0VDI9VPQ0zP2jtKHrorJnL2A8JCTg2Rxh+Xoav7//fLJWr2IRYbQVEc8Iipc71S9ndrDOrKGXO6FpwQNr40fOlYAtvg
X-Received: by 10.224.147.72 with SMTP id k8mr348970qav.5.1398809965450;
        Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si1327992yho.1.2014.04.29.15.19.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4188A31C1D2;
	Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 06849E0A5B; Tue, 29 Apr 2014 15:19:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247631>

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
index a56f47a..b806c59 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1686,6 +1686,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		rollback_index_files();
 		die(_("HEAD: cannot update ref: %s"), err.buf);
 	}
+	ref_transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
diff --git a/builtin/replace.c b/builtin/replace.c
index b037b29..5999f7d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -165,6 +165,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	    ref_transaction_commit(transaction, NULL, &err))
 		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 31e32cb..4701bda 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -648,6 +648,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
index 35de36a..b3c6a04 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1703,16 +1703,16 @@ static int update_branch(struct branch *b)
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
index c6ee43c..fcbdf9b 100644
--- a/refs.c
+++ b/refs.c
@@ -3302,7 +3302,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3400,10 +3400,10 @@ int update_ref(const char *action, const char *refname,
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
@@ -3417,6 +3417,7 @@ int update_ref(const char *action, const char *refname,
 		strbuf_release(&err);
 		return 1;
 	}
+	ref_transaction_free(t);
 	return 0;
 }
 
@@ -3451,10 +3452,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n) {
-		ref_transaction_free(transaction);
+	if (!n)
 		return 0;
-	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3520,7 +3519,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 5eb500e..fcde43e 100644
--- a/refs.h
+++ b/refs.h
@@ -210,8 +210,8 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or rolled
- * back using ref_transaction_rollback().
+ * eventually be freed by either calling ref_transaction_rollback()
+ * or ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -267,13 +267,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
- * If err is non-NULL we will add an error string to it to explain why
- * the transaction failed.
+ * problem. If err is non-NULL we will add an error string to it to explain
+ * why the transaction failed.
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
1.9.1.532.gf8485a6
