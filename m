From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 21/44] refs.c: ref_transaction_commit should not free the transaction
Date: Thu, 15 May 2014 10:29:36 -0700
Message-ID: <1400174999-26786-22-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUY-0007eU-JA
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbaEORaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:30 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:47321 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so290234iec.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3GAot3wzzKy1wDDUPQ2zwSGLx6vpn5kgdc1n/57JGoI=;
        b=fhE+zunXVfCOLA+TLgPfJnZQ96HQT1EF1QH+Rm9IHGYnPq+L0axmUlfW958Xe9NSTs
         K7xDD9MLKrBiaRziesLtq0ZUBU0b/LdOgMYhf8EfVaAT3ZwpDwH7J/pG/SeyIDwt2oGC
         IZZPzFemAn32dcFnm1RNKNPXDpeOEIHONGMfdWQ7RsQqaX58eZV/OXiLcklEZuewK9bh
         ZjWBEYzqZBd9qNp9rAax+v06BTQGeX72fam8lumI3kwACekkkeOgD1+gP2vUeRuwuJYT
         XoMlGA20G+S+jwl06pue1aXVPiIuROJUdaBKjOhglQV1CSwJAgy9PDRiy/tsD9iZzKJu
         rJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3GAot3wzzKy1wDDUPQ2zwSGLx6vpn5kgdc1n/57JGoI=;
        b=Um3aOjWBxCenWBczTgYtoA8WD5/ZmE24GO7tqbCGl4mqlzPZs5sc/LwFkdYGf2f/p3
         Reim2wCodJtdgPib963Dtl9WX1CvGbbTNu3PLJDnmAJWjOE4pxLV8mxlXpmkxGhxx9PY
         uzw90KFo5DX1/SUvuEvjwajbfdoYrU2vzlz+2AIjhnnBFSQDRLSFOkJiCc3/h1KG4mvR
         efiTaCBK0Dkq/hQuoipcKz5Anwhp2tXQjYiVfu3soHB9oyI0qFWmStHomvtqyhM8ItTM
         swpoYV2E3pQ6Cd2/vCB+CzfDKDhP7Jn8PsPlRJW22lZILW2KilnrZ3RUq4rk2jnIapqx
         5jbw==
X-Gm-Message-State: ALoCoQm2QANqheRYzqEoyePEmUElQVzhpFKkACvXId0RyRCUs1UZ0PP8joJEeBf3ORkJr3getUTz
X-Received: by 10.42.62.11 with SMTP id w11mr4984230ich.29.1400175006636;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si272580yhb.6.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6AF0431C1CD;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4AB8DE038E; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249130>

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
index 592f019..16fadbb 100644
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
index ee34d5d..91354a7 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -164,6 +164,7 @@ static int replace_object_sha1(const char *object_ref,
 	    ref_transaction_commit(transaction, NULL, &err))
 		die("%s: failed to replace ref: %s", ref, err.buf);
 
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
index 2a51df1..b5f4731 100644
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
index 4a37f87..82a8d4e 100644
--- a/refs.c
+++ b/refs.c
@@ -3322,7 +3322,7 @@ struct ref_transaction *ref_transaction_begin(void)
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-static void ref_transaction_free(struct ref_transaction *transaction)
+void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3420,10 +3420,10 @@ int update_ref(const char *action, const char *refname,
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
@@ -3437,6 +3437,7 @@ int update_ref(const char *action, const char *refname,
 		strbuf_release(&err);
 		return 1;
 	}
+	ref_transaction_free(t);
 	return 0;
 }
 
@@ -3471,10 +3472,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n) {
-		ref_transaction_free(transaction);
+	if (!n)
 		return 0;
-	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3541,7 +3540,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index cba2f3d..b94e1ac 100644
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
 
@@ -282,13 +282,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
2.0.0.rc3.477.g0f8edf7
