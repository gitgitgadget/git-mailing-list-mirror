From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 19/27] refs.c: ref_transaction_commit should not free the transaction
Date: Mon, 28 Apr 2014 15:54:34 -0700
Message-ID: <1398725682-30782-20-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuSp-0006nO-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbaD1WzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:20 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:40123 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057AbaD1Wyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:54 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so349933yhl.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IJ1aDbgVaFCjFNiqSYJCauHXVzZNzM8iupmDu6u8PvE=;
        b=Rqxn7T6B4hoPYr5Q3SZKck0w19+mZHf6GR4fzXupW9ueH0eNuF2oZC1zOskXhlxr6j
         njVD/P8DwCAKa7AB8V8NiFJyDjOb5q1AW1/PPLEf8iXKik3Jgnn6gXqvH7hfskZtgKgc
         O9lj6X0QqsDuf6Vflsk4lIiJbdakrE/fm7Nf1hsA9+wyYeIl1sJxeQgUCn3QqblrWvmY
         lGAgvW7EjIOyGSF4Z582fZscwSbgvCGptUEuskWifBNajI0sqSR9hfmDDmGtGAsE7gHE
         3L9X/9Y5Lv82EPGREqZ5MDuUD5EdyZ94gnEZeS65Y8ou6Z2HmSxyRDvLPSyVTWG7Ku6O
         QvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IJ1aDbgVaFCjFNiqSYJCauHXVzZNzM8iupmDu6u8PvE=;
        b=KOqSqGYkLdMOtgYVMuggdmG4zPlH2w3jlmUBSn+yqHN1pHgYZWiIhZtovMn0TCBIVS
         kVaJfHIjegg12ADWJYtsM+F5XSZtxhtR8bPEAEytFFWddZQxVTCOelToznIkC7vp6kid
         R580i3w0LEVHw4e5a1i03xweIvY0Bb7eNQqMlEBve8DiiIuVHS4eZ2LKJsI1En9hYYax
         lTueWfXjl3bNA48yasYzj2VANsrMyBo7X89ENQBbqU2jJstq9JCFd4DhYTHuQKFua63h
         uqKeDceXD+L9+pLfDt+o+UuCBFJVp3kIree4Oaq0vK+wl29XyvLgjURrNakY9tOfNli8
         kgeg==
X-Gm-Message-State: ALoCoQktRgjTZqjGhAL0zcfFzXwzRP5Vk11ntlpHah216Rl7hxTdl55PRiEe6MeiAQIoJE7M3jpV9uwD9XqCZMEebVyppFPg7hLG86yc8/1TO7oYt4bcJ3mlafXq6ALTDUjDiiht1FX7aKTvq47qUV4Sqg7mOraF0uNSdViUzvOhCkznseIVthRtNa0l9bV10VlcvfBR5B6h
X-Received: by 10.58.188.4 with SMTP id fw4mr1550795vec.9.1398725693952;
        Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si2350162yhd.5.2014.04.28.15.54.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B708B31C20B;
	Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 65AECE08C1; Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247475>

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
 refs.c               |  7 ++-----
 refs.h               | 14 +++++++++-----
 sequencer.c          |  8 ++++----
 9 files changed, 24 insertions(+), 18 deletions(-)

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
index 300c8dc..ab36de5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1703,15 +1703,15 @@ static int update_branch(struct branch *b)
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
 		return error("Unable to update branch %s: %s", b->name,
 			     strbuf_detach(&err, NULL));
 	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index c6ee43c..add95ba 100644
--- a/refs.c
+++ b/refs.c
@@ -3302,7 +3302,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3451,10 +3451,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n) {
-		ref_transaction_free(transaction);
+	if (!n)
 		return 0;
-	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3520,7 +3518,6 @@ cleanup:
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
index 449e093..5c424be 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -283,16 +283,16 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
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
 		strbuf_release(&sb);
 		return error(_("HEAD: Could not fast-forward: %s\n"),
 			     strbuf_detach(&err, NULL));
 	}
+	ref_transaction_free(transaction);
 
 	strbuf_release(&sb);
 	return 0;
-- 
1.9.1.528.g98b8868.dirty
