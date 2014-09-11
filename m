From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/19] refs.c: pass the ref log message to
 _create/delete/update instead of _commit
Date: Wed, 10 Sep 2014 20:06:30 -0700
Message-ID: <20140911030630.GI18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:06:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRuiU-0000r4-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbaIKDGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:06:35 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47694 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaIKDGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:06:34 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so8253584pad.16
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MiXrUN5cUthKB6/irrmicY6TXwfl6v8MR5feaQRtsmM=;
        b=jUzGZ85MgJgl6PrPpwf8SyR+B4JZ89uvryNfyljYyrRSZuKRjrmXGpydTPMzhzhpU2
         VjA0hBXCHjbeAf3Uo2vUKHt3W/Ix4pFWZoTg+b+x9zaCIotiOLs3rK0uaX5CbUxm3CYR
         1ZVQf18zTd1zJXkOcwEVeZsUBtmb67chulcUJjXOBQS8RjHQ8iPeVnxToRH4fQGtdOtJ
         Gz4fZZqtONmAtASobzK4H2CGAtqvwUQDwR69NJKqkHlmLw58NOtpv+blVVxUDlwzM1S5
         mX99uiCBcPg5ueMcY3H/Xp192e5Ot8UmZFvma7cbsl1EjtH53y4SoEQy8SIdbNraKCi7
         vuug==
X-Received: by 10.66.66.193 with SMTP id h1mr38060374pat.93.1410404793831;
        Wed, 10 Sep 2014 20:06:33 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id we5sm16678729pab.28.2014.09.10.20.06.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:06:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256817>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 30 Apr 2014 12:22:42 -0700

Change the reference transactions so that we pass the reflog message
through to the create/delete/update function instead of the commit message.
This allows for individual messages for each change in a multi ref
transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 branch.c               |  4 ++--
 builtin/commit.c       |  4 ++--
 builtin/receive-pack.c |  5 +++--
 builtin/replace.c      |  5 +++--
 builtin/tag.c          |  4 ++--
 builtin/update-ref.c   | 13 +++++++------
 fast-import.c          |  8 ++++----
 refs.c                 | 34 +++++++++++++++++++++-------------
 refs.h                 |  8 ++++----
 sequencer.c            |  4 ++--
 walker.c               |  5 ++---
 11 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/branch.c b/branch.c
index 37ac555..76a8ec9 100644
--- a/branch.c
+++ b/branch.c
@@ -301,8 +301,8 @@ void create_branch(const char *head,
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, ref.buf, sha1,
-					   null_sha1, 0, !forcing, &err) ||
-		    ref_transaction_commit(transaction, msg, &err))
+					   null_sha1, 0, !forcing, msg, &err) ||
+		    ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 		strbuf_release(&err);
diff --git a/builtin/commit.c b/builtin/commit.c
index 9bf1003..d23e876 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1767,8 +1767,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head
 				   ? current_head->object.sha1 : NULL,
-				   0, !!current_head, &err) ||
-	    ref_transaction_commit(transaction, sb.buf, &err)) {
+				   0, !!current_head, sb.buf, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 224fadc..d1f4cf7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -585,8 +585,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, &err) ||
-		    ref_transaction_commit(transaction, "push", &err)) {
+					   new_sha1, old_sha1, 0, 1, "push",
+					   &err) ||
+		    ref_transaction_commit(transaction, &err)) {
 			ref_transaction_free(transaction);
 
 			rp_error("%s", err.buf);
diff --git a/builtin/replace.c b/builtin/replace.c
index 1fcd06d..9d03b84 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -169,8 +169,9 @@ static int replace_object_sha1(const char *object_ref,
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, repl, prev, 0, 1, &err) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, 1, NULL, &err) ||
+	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
 	ref_transaction_free(transaction);
diff --git a/builtin/tag.c b/builtin/tag.c
index f3f172f..70d28c5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -705,8 +705,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, 1, &err) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+				   0, 1, NULL, &err) ||
+	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 54a48c0..6c9be05 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -14,6 +14,7 @@ static const char * const git_update_ref_usage[] = {
 
 static char line_termination = '\n';
 static int update_flags;
+static const char *msg;
 
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
@@ -198,7 +199,7 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 		die("update %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, &err))
+				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -229,7 +230,7 @@ static const char *parse_cmd_create(struct ref_transaction *transaction,
 		die("create %s: extra input: %s", refname, next);
 
 	if (ref_transaction_create(transaction, refname, new_sha1,
-				   update_flags, &err))
+				   update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -264,7 +265,7 @@ static const char *parse_cmd_delete(struct ref_transaction *transaction,
 		die("delete %s: extra input: %s", refname, next);
 
 	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old, &err))
+				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -300,7 +301,7 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, &err))
+				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -354,7 +355,7 @@ static void update_refs_stdin(struct ref_transaction *transaction)
 
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
-	const char *refname, *oldval, *msg = NULL;
+	const char *refname, *oldval;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
 	struct option options[] = {
@@ -385,7 +386,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin(transaction);
-		if (ref_transaction_commit(transaction, msg, &err))
+		if (ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 		strbuf_release(&err);
diff --git a/fast-import.c b/fast-import.c
index e7f6e37..51dfaad 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1708,8 +1708,8 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1, &err) ||
-	    ref_transaction_commit(transaction, msg, &err)) {
+				   0, 1, msg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -1749,12 +1749,12 @@ static void dump_tags(void)
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
 		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
-					   NULL, 0, 0, &err)) {
+					   NULL, 0, 0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
 	}
-	if (ref_transaction_commit(transaction, msg, &err))
+	if (ref_transaction_commit(transaction, &err))
 		failure |= error("%s", err.buf);
 
  cleanup:
diff --git a/refs.c b/refs.c
index 5609622..99a9b86 100644
--- a/refs.c
+++ b/refs.c
@@ -2396,8 +2396,8 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, &err) ||
-	    ref_transaction_commit(transaction, NULL, &err)) {
+				   REF_ISPRUNING, 1, NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -2571,8 +2571,8 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1), &err) ||
-	    ref_transaction_commit(transaction, NULL, &err)) {
+				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
 		strbuf_release(&err);
@@ -3350,6 +3350,7 @@ struct ref_update {
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
+	char *msg;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3392,9 +3393,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	if (!transaction)
 		return;
 
-	for (i = 0; i < transaction->nr; i++)
+	for (i = 0; i < transaction->nr; i++) {
+		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]);
-
+	}
 	free(transaction->updates);
 	free(transaction);
 }
@@ -3415,7 +3417,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3432,13 +3434,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags,
+			   int flags, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3455,13 +3459,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3479,6 +3485,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
@@ -3492,8 +3500,8 @@ int update_ref(const char *action, const char *refname,
 	t = ref_transaction_begin(&err);
 	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, &err) ||
-	    ref_transaction_commit(t, action, &err)) {
+				   !!oldval, action, &err) ||
+	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_free(t);
@@ -3539,7 +3547,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err)
+			   struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3588,7 +3596,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     msg);
+					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
 				if (err)
diff --git a/refs.h b/refs.h
index 69ef28c..7c1bf95 100644
--- a/refs.h
+++ b/refs.h
@@ -289,7 +289,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -304,7 +304,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags,
+			   int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -318,7 +318,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -327,7 +327,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err);
+			   struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
diff --git a/sequencer.c b/sequencer.c
index 5e93b6a..c5b7b8a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -286,8 +286,8 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn ? null_sha1 : from,
-				   0, 1, &err) ||
-	    ref_transaction_commit(transaction, sb.buf, &err)) {
+				   0, 1, sb.buf, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&sb);
diff --git a/walker.c b/walker.c
index b8a5441..3c6fb8a 100644
--- a/walker.c
+++ b/walker.c
@@ -298,14 +298,13 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		strbuf_addf(&refname, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, refname.buf,
 					   &sha1[20 * i], NULL, 0, 0,
+					   msg ? msg : "fetch (unknown)",
 					   &err)) {
 			error("%s", err.buf);
 			goto done;
 		}
 	}
-	if (ref_transaction_commit(transaction,
-				   msg ? msg : "fetch (unknown)",
-				   &err)) {
+	if (ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		goto done;
 	}
-- 
2.1.0.rc2.206.gedb03e5
