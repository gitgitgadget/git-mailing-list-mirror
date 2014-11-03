From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 14/17] refs.c: replace the onerr argument in update_ref with a strbuf err
Date: Mon,  3 Nov 2014 11:02:16 -0800
Message-ID: <1415041339-18450-15-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:08:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMzl-0004S9-7w
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbaKCTIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:08:41 -0500
Received: from mail-ie0-f201.google.com ([209.85.223.201]:35023 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbaKCTIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:08:36 -0500
Received: by mail-ie0-f201.google.com with SMTP id rd18so828979iec.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bdzhxHdLDjsR9M1+uwCAmtGA7qUhA3d0hsGjOikEzOE=;
        b=CAuJaYX8RbstXo8UCPlKES9/weAU/4xSmF3nCbdE7B+udNsk76wFTlNp3WBaUni9NY
         WarDM2Q5BuCeedu3RstArD/wqEXdCP7i/QZi6yXyJfimCX15fGqwhkPoJATtI/BgWMwe
         8fgvPyuDTzW+M7dx2JWHC8MvdPJwIYHLzu92ONe3+hkdHzNrIG7ojjE5/loaF7b4Lgqz
         SsVGkD9BwWv3aiWvPjCXcwi1zz8IBRUteLFtyeEVgI7YxI4Xi35QrILyd1YmO89tjcN1
         LmyPhoetEIwbeQEQAS3awVi1R0RjBjK9C7dmZIP85NWkB+N6EULyqzql4de3S48yE2Rt
         kcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bdzhxHdLDjsR9M1+uwCAmtGA7qUhA3d0hsGjOikEzOE=;
        b=eUKYnzR79VsQ5YYtrDE4UkADGOjRRvNSSl0Q1ttjZ5X/85z4mfxZe8FrcxalVROANm
         VG51rXoCLwhXti2WfTSVUfL7kXibv2gbc4krdA9qTNYIwjk9mWRwIEUiUliYthrwrzVY
         Yk2xE2R6AgoHItRqTJktbZlf8bz6JiNUXzeWh07tv6jAYih9bRrbVgiereHyn8J27cDQ
         szrPXY2FJTWi2LW93o/k0sLwUvrdXWAaBRpZLdYC9eqQiH54+Z5oIGQDns2l46+ukqsT
         qBsHocDKKGCIuli3h8T1nkG7g47H04Lamh7KlqwxaMJEKKP+j2Ge6BIb9MLpi3p/HTG5
         Q6tA==
X-Gm-Message-State: ALoCoQn06/PS8LQ0A279fntFqGW9v7TD/uudy8kmVuJuKXCYze1fUKiUxwtdWW9IvojK+PWoeMa/
X-Received: by 10.182.38.135 with SMTP id g7mr32693951obk.10.1415041715905;
        Mon, 03 Nov 2014 11:08:35 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si975774yhb.4.2014.11.03.11.08.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:08:35 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id xYq5PAjS.1; Mon, 03 Nov 2014 11:08:35 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 23059E102E; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of the action_on_err enum and replace the action argument to
update_ref with a strbuf *err for error reporting.

Update all callers to the new api including two callers in transport*.c
which used the literal 0 instead of an enum.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/checkout.c   |  7 +++++--
 builtin/clone.c      | 20 ++++++++++++--------
 builtin/merge.c      | 20 +++++++++++++-------
 builtin/notes.c      | 24 ++++++++++++++----------
 builtin/reset.c      | 12 ++++++++----
 builtin/update-ref.c |  7 +++++--
 notes-cache.c        |  2 +-
 notes-utils.c        |  5 +++--
 refs.c               | 14 +++-----------
 refs.h               | 10 ++--------
 transport-helper.c   |  7 ++++++-
 transport.c          |  9 ++++++---
 12 files changed, 78 insertions(+), 59 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8550b6d..60a68f7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -584,6 +584,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
+	struct strbuf err = STRBUF_INIT;
+
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
@@ -621,8 +623,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
-		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
+			       REF_NODEREF, &err))
+			die("%s", err.buf);
 		if (!opts->quiet) {
 			if (old->path && advice_detached_head)
 				detach_advice(new->name);
diff --git a/builtin/clone.c b/builtin/clone.c
index bb2c058..5577b5b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -522,6 +522,7 @@ static void write_remote_refs(const struct ref *local_refs)
 static void write_followtags(const struct ref *refs, const char *msg)
 {
 	const struct ref *ref;
+	struct strbuf err = STRBUF_INIT;
 	for (ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
@@ -529,8 +530,9 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (!has_sha1_file(ref->old_sha1))
 			continue;
-		update_ref(msg, ref->name, ref->old_sha1,
-			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg, ref->name, ref->old_sha1,
+			       NULL, 0, &err))
+			die("%s", err.buf);
 	}
 }
 
@@ -593,28 +595,30 @@ static void update_remote_refs(const struct ref *refs,
 static void update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
+	struct strbuf err = STRBUF_INIT;
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
-			update_ref(msg, "HEAD", our->old_sha1, NULL, 0,
-				   UPDATE_REFS_DIE_ON_ERR);
+			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, &err);
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(our->old_sha1);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		update_ref(msg, "HEAD", c->object.sha1,
-			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg, "HEAD", c->object.sha1,
+			       NULL, REF_NODEREF, &err))
+			die("%s", err.buf);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
 		 * HEAD points to a branch but we don't know which one.
 		 * Detach HEAD in all these cases.
 		 */
-		update_ref(msg, "HEAD", remote->old_sha1,
-			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+	  if (update_ref(msg, "HEAD", remote->old_sha1,
+			 NULL, REF_NODEREF, &err))
+		die("%s", err.buf);
 	}
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index bebbe5b..a787b6a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -396,9 +396,11 @@ static void finish(struct commit *head_commit,
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
-			update_ref(reflog_message.buf, "HEAD",
-				new_head, head, 0,
-				UPDATE_REFS_DIE_ON_ERR);
+			struct strbuf err = STRBUF_INIT;
+			if (update_ref(reflog_message.buf, "HEAD",
+				       new_head, head, 0,
+				       &err))
+				die("%s", err.buf);
 			/*
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
@@ -1086,6 +1088,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	unsigned char head_sha1[20];
 	struct commit *head_commit;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	const char *head_arg;
 	int flag, i, ret = 0, head_subsumed;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
@@ -1214,8 +1217,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
 		read_empty(remote_head->object.sha1, 0);
-		update_ref("initial pull", "HEAD", remote_head->object.sha1,
-			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref("initial pull", "HEAD", remote_head->object.sha1,
+			       NULL, 0, &err))
+			die("%s", err.buf);
 		goto done;
 	} else {
 		struct strbuf merge_names = STRBUF_INIT;
@@ -1328,8 +1332,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		free(list);
 	}
 
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.sha1,
-		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	if (update_ref("updating ORIG_HEAD", "ORIG_HEAD",
+		       head_commit->object.sha1,
+		       NULL, 0, &err))
+		die("%s", err.buf);
 
 	if (remoteheads && !common)
 		; /* No common ancestors found. We need a real merge. */
diff --git a/builtin/notes.c b/builtin/notes.c
index 68b6cd8..b9fec39 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -674,6 +674,7 @@ static int merge_abort(struct notes_merge_options *o)
 static int merge_commit(struct notes_merge_options *o)
 {
 	struct strbuf msg = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	unsigned char sha1[20], parent_sha1[20];
 	struct notes_tree *t;
 	struct commit *partial;
@@ -714,10 +715,10 @@ static int merge_commit(struct notes_merge_options *o)
 	format_commit_message(partial, "%s", &msg, &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insert(&msg, 0, "notes: ", 7);
-	update_ref(msg.buf, o->local_ref, sha1,
-		   is_null_sha1(parent_sha1) ? NULL : parent_sha1,
-		   0, UPDATE_REFS_DIE_ON_ERR);
-
+	if (update_ref(msg.buf, o->local_ref, sha1,
+		       is_null_sha1(parent_sha1) ? NULL : parent_sha1,
+		       0, &err))
+		die("%s", err.buf);
 	free_notes(t);
 	strbuf_release(&msg);
 	ret = merge_abort(o);
@@ -728,6 +729,7 @@ static int merge_commit(struct notes_merge_options *o)
 static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	unsigned char result_sha1[20];
 	struct notes_tree *t;
 	struct notes_merge_options o;
@@ -808,14 +810,16 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	result = notes_merge(&o, t, result_sha1);
 
-	if (result >= 0) /* Merge resulted (trivially) in result_sha1 */
+	if (result >= 0) {/* Merge resulted (trivially) in result_sha1 */
 		/* Update default notes ref with new commit */
-		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
-			   0, UPDATE_REFS_DIE_ON_ERR);
-	else { /* Merge has unresolved conflicts */
+		if (update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
+			       0, &err))
+			die("%s", err.buf);
+	} else { /* Merge has unresolved conflicts */
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
-		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
-			   0, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
+			       0, &err))
+			die("%s", err.buf);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die("Failed to store link to current notes ref (%s)",
diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..8ebf4ca 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -245,6 +245,7 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 {
 	int update_ref_status;
 	struct strbuf msg = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	unsigned char *orig = NULL, sha1_orig[20],
 		*old_orig = NULL, sha1_old_orig[20];
 
@@ -253,13 +254,16 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 	if (!get_sha1("HEAD", sha1_orig)) {
 		orig = sha1_orig;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
+		if (update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, &err))
+			error("%s", err.buf);
+		strbuf_release(&err);
 	} else if (old_orig)
 		delete_ref("ORIG_HEAD", old_orig, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0,
-				       UPDATE_REFS_MSG_ON_ERR);
+	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0, &err);
+	if (update_ref_status)
+		error("%s", err.buf);
+	strbuf_release(&err);
 	strbuf_release(&msg);
 	return update_ref_status;
 }
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index af08dd9..f650647 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -358,6 +358,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -421,6 +422,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_ref(refname, oldval ? oldsha1 : NULL, flags);
 	else
-		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
-				  flags, UPDATE_REFS_DIE_ON_ERR);
+		if (update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
+			       flags, &err))
+			die("%s", err.buf);
+	return 0;
 }
diff --git a/notes-cache.c b/notes-cache.c
index c4e9bb7..386e6d6 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -60,7 +60,7 @@ int notes_cache_write(struct notes_cache *c)
 			commit_sha1, NULL, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
-		       0, UPDATE_REFS_QUIET_ON_ERR) < 0)
+		       0, NULL) < 0)
 		return -1;
 
 	return 0;
diff --git a/notes-utils.c b/notes-utils.c
index b64dc1b..bcfe61e 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -34,6 +34,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char commit_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (!t)
 		t = &default_notes_tree;
@@ -49,8 +50,8 @@ void commit_notes(struct notes_tree *t, const char *msg)
 
 	create_notes_commit(t, NULL, buf.buf, buf.len, commit_sha1);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
-	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0,
-		   UPDATE_REFS_DIE_ON_ERR);
+	if (update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, &err))
+		die("%s", err.buf);
 
 	strbuf_release(&buf);
 }
diff --git a/refs.c b/refs.c
index c9c03f2..aefbce4 100644
--- a/refs.c
+++ b/refs.c
@@ -3709,7 +3709,7 @@ int transaction_delete_ref(struct transaction *transaction,
 
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
-	       int flags, enum action_on_err onerr)
+	       int flags, struct strbuf *e)
 {
 	struct transaction *t;
 	struct strbuf err = STRBUF_INIT;
@@ -3722,16 +3722,8 @@ int update_ref(const char *action, const char *refname,
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		transaction_free(t);
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR:
-			error(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_DIE_ON_ERR:
-			die(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_QUIET_ON_ERR:
-			break;
-		}
+		if (e)
+			strbuf_addf(e, str, refname, err.buf);
 		strbuf_release(&err);
 		return 1;
 	}
diff --git a/refs.h b/refs.h
index 1747d5f..af20bd7 100644
--- a/refs.h
+++ b/refs.h
@@ -212,12 +212,6 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
  */
 extern int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1);
 
-enum action_on_err {
-	UPDATE_REFS_MSG_ON_ERR,
-	UPDATE_REFS_DIE_ON_ERR,
-	UPDATE_REFS_QUIET_ON_ERR
-};
-
 /*
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling transaction_free().
@@ -356,8 +350,8 @@ void transaction_free(struct transaction *transaction);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-		const unsigned char *sha1, const unsigned char *oldval,
-		int flags, enum action_on_err onerr);
+	       const unsigned char *sha1, const unsigned char *oldval,
+	       int flags, struct strbuf *err);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
diff --git a/transport-helper.c b/transport-helper.c
index 6cd9dd1..ed72ecc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -729,6 +729,7 @@ static int push_update_refs_status(struct helper_data *data,
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
+	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
 	for (;;) {
@@ -752,7 +753,11 @@ static int push_update_refs_status(struct helper_data *data,
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (!private)
 			continue;
-		update_ref("update by helper", private, ref->new_sha1, NULL, 0, 0);
+		if (update_ref("update by helper", private, ref->new_sha1,
+			       NULL, 0, &err))
+			error("%s", err.buf);
+		strbuf_release(&err);
+
 		free(private);
 	}
 	strbuf_release(&buf);
diff --git a/transport.c b/transport.c
index 70d38e4..f70d62f 100644
--- a/transport.c
+++ b/transport.c
@@ -597,6 +597,7 @@ int transport_refs_pushed(struct ref *ref)
 void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
 {
 	struct refspec rs;
+	struct strbuf err = STRBUF_INIT;
 
 	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
 		return;
@@ -609,9 +610,11 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (ref->deletion) {
 			delete_ref(rs.dst, NULL, 0);
-		} else
-			update_ref("update by push", rs.dst,
-					ref->new_sha1, NULL, 0, 0);
+		} else if (update_ref("update by push", rs.dst,
+				      ref->new_sha1, NULL, 0, &err))
+			error("%s", err.buf);
+
+		strbuf_release(&err);
 		free(rs.dst);
 	}
 }
-- 
2.1.0.rc2.206.gedb03e5
