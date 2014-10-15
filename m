From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/25] refs.c: pass the ref log message to
 _create/delete/update instead of _commit
Date: Tue, 14 Oct 2014 17:48:22 -0700
Message-ID: <20141015004822.GJ32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:48:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeClS-0000Mg-LR
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbaJOAs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:48:27 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51772 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbaJOAs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:48:26 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so216194pab.40
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q6bd+qUD+KOnboI2SIRTmOE8qQ/BNvyK8kJ70yvULR0=;
        b=MXlGAXn39h9Y8O5oT3OPmXBV21fqSNOQVNFjmBVv/Xibrc/GadMhpBFXleeQuMt96H
         hhlXFneXHknmqtzrMZutPjsg8Zc7BKd47bOeC9okUgIwTr1yI0XaLTrWlQc83A+sXiTT
         OolkAHGtVzKjfEbsG837dGNOgQAvvXiifLx8/w1xq8cfjY/FWawlP5/NZT6hVqVI8P2K
         km+ZRyWDH94ICO9jnqcl/1PHWhDI9C/dFY0QdiatwyNigBjZL+tjg5Y0X9I8vfEO2t6L
         5F/B3ShVC348xkUSQngcckykhQLI9ukNFUV797EVy2rKSxubs+MHSD+1MY6AEXTailIN
         ybAg==
X-Received: by 10.66.251.194 with SMTP id zm2mr8630144pac.33.1413334105676;
        Tue, 14 Oct 2014 17:48:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id td4sm15315750pbc.36.2014.10.14.17.48.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:48:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 30 Apr 2014 12:22:42 -0700

Change the ref transaction API so that we pass the reflog message to the
create/delete/update functions instead of to ref_transaction_commit.
This allows different reflog messages for each ref update in a multi-ref
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
 refs.h                 | 12 ++++++------
 sequencer.c            |  4 ++--
 walker.c               |  5 ++---
 11 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/branch.c b/branch.c
index 9a2228e..884c62c 100644
--- a/branch.c
+++ b/branch.c
@@ -285,8 +285,8 @@ void create_branch(const char *head,
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
index 81dc622..a7857ab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1811,8 +1811,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
index f2f6c67..df6c337 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -842,8 +842,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
index 8020db8..85d39b5 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -171,8 +171,9 @@ static int replace_object_sha1(const char *object_ref,
 
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
index a81b9e4..e633f4e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -733,8 +733,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
index fee7906..d0bd285 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1716,8 +1716,8 @@ static int update_branch(struct branch *b)
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
@@ -1757,12 +1757,12 @@ static void dump_tags(void)
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
index 430857b..f5d7bd7 100644
--- a/refs.c
+++ b/refs.c
@@ -2445,8 +2445,8 @@ static void prune_ref(struct ref_to_prune *r)
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
@@ -2621,8 +2621,8 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
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
@@ -3404,6 +3404,7 @@ struct ref_update {
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
+	char *msg;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3446,9 +3447,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
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
@@ -3469,7 +3471,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3486,13 +3488,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
@@ -3509,13 +3513,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
@@ -3533,6 +3539,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	if (msg)
+		update->msg = xstrdup(msg);
 	return 0;
 }
 
@@ -3546,8 +3554,8 @@ int update_ref(const char *action, const char *refname,
 	t = ref_transaction_begin(&err);
 	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, &err) ||
-	    ref_transaction_commit(t, action, &err)) {
+				   !!oldval, action, &err) ||
+	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_free(t);
@@ -3593,7 +3601,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err)
+			   struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3642,7 +3650,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (!is_null_sha1(update->new_sha1)) {
 			ret = write_ref_sha1(update->lock, update->new_sha1,
-					     msg);
+					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
 				if (err)
diff --git a/refs.h b/refs.h
index 2328f06..1a55cab 100644
--- a/refs.h
+++ b/refs.h
@@ -274,8 +274,8 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  * The following functions add a reference check or update to a
  * ref_transaction.  In all of them, refname is the name of the
  * reference to be affected.  The functions make internal copies of
- * refname, so the caller retains ownership of the parameter.  flags
- * can be REF_NODEREF; it is passed to update_ref_lock().
+ * refname and msg, so the caller retains ownership of these parameters.
+ * flags can be REF_NODEREF; it is passed to update_ref_lock().
  */
 
 /*
@@ -292,7 +292,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -307,7 +307,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags,
+			   int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -321,7 +321,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old,
+			   int flags, int have_old, const char *msg,
 			   struct strbuf *err);
 
 /*
@@ -330,7 +330,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err);
+			   struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
diff --git a/sequencer.c b/sequencer.c
index 1b9a35e..47aac75 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -252,8 +252,8 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
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
index 18a67d3..f149371 100644
--- a/walker.c
+++ b/walker.c
@@ -300,14 +300,13 @@ int walker_fetch(struct walker *walker, int targets, char **target,
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
