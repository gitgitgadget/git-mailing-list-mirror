From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v13 00/41] Use ref transactions
Date: Tue, 3 Jun 2014 15:22:18 -0700
Message-ID: <20140603222218.GF30019@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx6D-0000GP-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934046AbaFCWWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:22:23 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:55584 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933038AbaFCWWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:22:22 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so6086494pbc.28
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9VMsIr9a4y/w2+Wppljy3LPtHtATiroZLPZ4hz5uRCQ=;
        b=UstCTLMlr4xdeqJYhkUCrNJX1lB03z/0yQmcPmerdjwjcT+FnjHJJmRuV0UBen9GGJ
         CGXjy+ZcXMxXHVhYM/30+s2N0bjwvbJ5K0RZmyECQv1yo2qBSda/MYRdf7VRw8EOCDGr
         4eXzZcvNYuXST4pto6f3XrEmnSFqaLoaWC98cmc2kvdc1QMebu8QihQvYiZ7yEjqGfdO
         rZnqXBqSvDMdmTnFNpCkCbIVlBNYv6o3mxfC5HyYoY3TW0dmIQf9zVobLU339Ftt7niX
         rAAn8WcY2gfuScJiANEA1GB3hZXQCLqEQ05hZS/4S/M0sq6h+5mIDNgaGO/adIxbnBvl
         LGAg==
X-Received: by 10.68.249.2 with SMTP id yq2mr55243292pbc.70.1401834141709;
        Tue, 03 Jun 2014 15:22:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qf10sm1704705pbc.23.2014.06.03.15.22.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 15:22:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250705>

Ronnie Sahlberg wrote:

> This patch series can also be found at
> https://github.com/rsahlberg/git/tree/ref-transactions

Applies with two minor conflicts on top of a merge of
mh/ref-transaction, rs/ref-update-check-errors-early, and
rs/reflog-exists.  Previously:

  motivation: http://thread.gmane.org/gmane.comp.version-control.git/246255
  v2 http://thread.gmane.org/gmane.comp.version-control.git/246662,
     http://thread.gmane.org/gmane.comp.version-control.git/246763
  v3 http://thread.gmane.org/gmane.comp.version-control.git/247056
  v6 http://thread.gmane.org/gmane.comp.version-control.git/247876
  v8 http://thread.gmane.org/gmane.comp.version-control.git/249159
 v10 http://thread.gmane.org/gmane.comp.version-control.git/249356
 v11 http://thread.gmane.org/gmane.comp.version-control.git/250197
 v12 http://thread.gmane.org/gmane.comp.version-control.git/250377
 
Interdiff against v8:

 branch.c               |   7 +-
 builtin/commit.c       |   4 +-
 builtin/fetch.c        |  41 ++---
 builtin/receive-pack.c |  34 +++--
 builtin/replace.c      |   6 +-
 builtin/tag.c          |   6 +-
 builtin/update-ref.c   |  20 +--
 cache.h                |   2 +
 fast-import.c          |  37 +++--
 lockfile.c             |  37 +++--
 refs.c                 | 396 ++++++++++++++++++++++++++++++-------------------
 refs.h                 |  82 +++++++---
 sequencer.c            |  10 +-
 t/t3200-branch.sh      |   6 +-
 walker.c               |  41 +++--
 15 files changed, 458 insertions(+), 271 deletions(-)

diff --git a/branch.c b/branch.c
index 74d55e7..e0439af 100644
--- a/branch.c
+++ b/branch.c
@@ -298,13 +298,12 @@ void create_branch(const char *head,
 		struct ref_transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
 
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, ref.buf, sha1,
-					   null_sha1, 0, !forcing, msg) ||
+					   null_sha1, 0, !forcing, msg, &err) ||
 		    ref_transaction_commit(transaction, &err))
-				die_errno(_("%s: failed to write ref: %s"),
-					  ref.buf, err.buf);
+			die("%s", err.buf);
 		ref_transaction_free(transaction);
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 07ccc97..e35877c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1676,12 +1676,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	transaction = ref_transaction_begin();
+	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head ?
 				   current_head->object.sha1 : NULL,
-				   0, !!current_head, sb.buf) ||
+				   0, !!current_head, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3a849b0..52f1ebc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -44,8 +44,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
-static int shown_url;
-struct ref_transaction *transaction;
+static int shown_url = 0;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -376,6 +375,9 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret, df_conflict = 0;
 
 	if (dry_run)
 		return 0;
@@ -383,11 +385,26 @@ static int s_update_ref(const char *action,
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
-	if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
-				   ref->old_sha1, 0, check_old, msg))
-		return STORE_REF_ERROR_OTHER;
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, msg, &err))
+		goto fail;
 
+	ret = ref_transaction_commit(transaction, &err);
+	if (ret == UPDATE_REFS_NAME_CONFLICT)
+		df_conflict = 1;
+	if (ret)
+		goto fail;
+
+	ref_transaction_free(transaction);
 	return 0;
+fail:
+	ref_transaction_free(transaction);
+	error("%s", err.buf);
+	strbuf_release(&err);
+	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
+			   : STORE_REF_ERROR_OTHER;
 }
 
 #define REFCOL_WIDTH  10
@@ -558,13 +575,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		goto abort;
 	}
 
-	errno = 0;
-	transaction = ref_transaction_begin();
-	if (!transaction) {
-		rc = error(_("cannot start ref transaction\n"));
-		goto abort;
-	}
-
 	/*
 	 * We do a pass for each fetch_head_status type in their enum order, so
 	 * merged entries are written before not-for-merge. That lets readers
@@ -676,14 +686,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
-	if (ref_transaction_commit(transaction, NULL))
-		rc |= errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-		  STORE_REF_ERROR_OTHER;
-	ref_transaction_free(transaction);
-
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
-		      " 'git remote prune %s' to remove any old, conflicting "
+		      "'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
 
  abort:
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 991c659..5653fa2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,8 +46,7 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
-struct strbuf err = STRBUF_INIT;
-struct ref_transaction *transaction;
+static struct string_list error_strings = STRING_LIST_INIT_DUP;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -577,13 +576,32 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
+
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		if (ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, "push"))
-			return "failed to update";
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1, "push",
+					   &err) ||
+		    ref_transaction_commit(transaction, &err)) {
+			const char *str;
+
+			string_list_append(&error_strings, err.buf);
+			str = error_strings.items[error_strings.nr - 1].string;
+			strbuf_release(&err);
+
+			ref_transaction_free(transaction);
+			rp_error("%s", str);
+			return str;
+		}
+
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return NULL; /* good */
 	}
 }
@@ -807,7 +825,6 @@ static void execute_commands(struct command *commands,
 	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
 
 	checked_connectivity = 1;
-	transaction = ref_transaction_begin();
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -823,10 +840,6 @@ static void execute_commands(struct command *commands,
 			checked_connectivity = 0;
 		}
 	}
-	if (ref_transaction_commit(transaction, &err))
-		error("%s", err.buf);
-	ref_transaction_free(transaction);
-	strbuf_release(&err);
 
 	if (shallow_update && !checked_connectivity)
 		error("BUG: run 'git fsck' for safety.\n"
@@ -1215,5 +1228,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
+	string_list_clear(&error_strings, 0);
 	return 0;
 }
diff --git a/builtin/replace.c b/builtin/replace.c
index 952b589..3455843 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -158,12 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	transaction = ref_transaction_begin();
+	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, !is_null_sha1(prev), NULL) ||
+				   0, !is_null_sha1(prev), NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
-		die("%s: failed to replace ref: %s", ref, err.buf);
+		die("%s", err.buf);
 
 	ref_transaction_free(transaction);
 	return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index 5b193b9..7492682 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -642,12 +642,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	transaction = ref_transaction_begin();
+	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, !is_null_sha1(prev), NULL) ||
+				   0, !is_null_sha1(prev), NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
-		die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);
+		die("%s", err.buf);
 	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index bd7e96f..28b478a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -17,6 +17,7 @@ static struct ref_transaction *transaction;
 static char line_termination = '\n';
 static int update_flags;
 static const char *msg;
+static struct strbuf err = STRBUF_INIT;
 
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
@@ -199,8 +200,8 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 		die("update %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg))
-		die("update %s: failed", refname);
+				   update_flags, have_old, msg, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -227,8 +228,8 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 		die("create %s: extra input: %s", refname, next);
 
 	if (ref_transaction_create(transaction, refname, new_sha1,
-				   update_flags, msg))
-		die("cannot create ref '%s'", refname);
+				   update_flags, msg, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -259,8 +260,8 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 		die("delete %s: extra input: %s", refname, next);
 
 	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old, msg))
-		die("failed transaction delete for %s", refname);
+				   update_flags, have_old, msg, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -292,8 +293,8 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg))
-		die("failed transaction update for %s", refname);
+				   update_flags, have_old, msg, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -348,7 +349,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
-	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -366,7 +366,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
diff --git a/cache.h b/cache.h
index 107ac61..72b59b2 100644
--- a/cache.h
+++ b/cache.h
@@ -543,6 +543,8 @@ struct lock_file {
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
 extern int unable_to_lock_error(const char *path, int err);
+extern void unable_to_lock_message(const char *path, int err,
+				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
diff --git a/fast-import.c b/fast-import.c
index 5166267..c05fd81 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1691,9 +1691,8 @@ static int update_branch(struct branch *b)
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
-		if (!old_cmit || !new_cmit) {
+		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
-		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
 			warning("Not updating %s"
@@ -1702,13 +1701,13 @@ static int update_branch(struct branch *b)
 			return -1;
 		}
 	}
-	transaction = ref_transaction_begin();
+	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1, msg) ||
+				   0, 1, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_rollback(transaction);
-		error("Unable to update branch %s: %s", b->name, err.buf);
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
@@ -1731,21 +1730,31 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
-	transaction = ref_transaction_begin();
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		failure |= error("%s", err.buf);
+		goto cleanup;
+	}
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "refs/tags/%s", t->name);
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
-		if (ref_transaction_update(transaction, ref_name, t->sha1,
-					   NULL, 0, 0, msg))
-			failure |= error("Unable to update %s", err.buf);
+		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+					   NULL, 0, 0, msg, &err)) {
+			failure |= error("%s", err.buf);
+			goto cleanup;
+		}
 	}
-	if (failure || ref_transaction_commit(transaction, &err))
-		failure |= error("Unable to update %s", err.buf);
+	if (ref_transaction_commit(transaction, &err))
+		failure |= error("%s", err.buf);
+
+ cleanup:
 	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
 	strbuf_release(&err);
 }
 
diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..f5da18c 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -121,7 +121,7 @@ static char *resolve_symlink(char *p, size_t s)
 	return p;
 }
 
-
+/* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
 	/*
@@ -130,8 +130,10 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	 */
 	static const size_t max_path_len = sizeof(lk->filename) - 5;
 
-	if (strlen(path) >= max_path_len)
+	if (strlen(path) >= max_path_len) {
+		errno = ENAMETOOLONG;
 		return -1;
+	}
 	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, max_path_len);
@@ -148,42 +150,49 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			lock_file_list = lk;
 			lk->on_list = 1;
 		}
-		if (adjust_shared_perm(lk->filename))
-			return error("cannot fix permission bits on %s",
-				     lk->filename);
+		if (adjust_shared_perm(lk->filename)) {
+			int save_errno = errno;
+			error("cannot fix permission bits on %s",
+			      lk->filename);
+			errno = save_errno;
+			return -1;
+		}
 	}
 	else
 		lk->filename[0] = 0;
 	return lk->fd;
 }
 
-static char *unable_to_lock_message(const char *path, int err)
+void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
-	struct strbuf buf = STRBUF_INIT;
 
 	if (err == EEXIST) {
-		strbuf_addf(&buf, "Unable to create '%s.lock': %s.\n\n"
+		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
 			    absolute_path(path), strerror(err));
 	} else
-		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
+		strbuf_addf(buf, "Unable to create '%s.lock': %s",
 			    absolute_path(path), strerror(err));
-	return strbuf_detach(&buf, NULL);
 }
 
 int unable_to_lock_error(const char *path, int err)
 {
-	char *msg = unable_to_lock_message(path, err);
-	error("%s", msg);
-	free(msg);
+	struct strbuf buf = STRBUF_INIT;
+
+	unable_to_lock_message(path, err, &buf);
+	error("%s", buf.buf);
+	strbuf_release(&buf);
 	return -1;
 }
 
 NORETURN void unable_to_lock_index_die(const char *path, int err)
 {
-	die("%s", unable_to_lock_message(path, err));
+	struct strbuf buf = STRBUF_INIT;
+
+	unable_to_lock_message(path, err, &buf);
+	die("%s", buf.buf);
 }
 
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
diff --git a/refs.c b/refs.c
index ed93b75..f8a6c9a 100644
--- a/refs.c
+++ b/refs.c
@@ -29,14 +29,11 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
-/** Used as a flag to ref_transaction_delete when a loose ref is beeing
- *  pruned.
+/*
+ * Used as a flag to ref_transaction_delete when a loose ref is being
+ * pruned.
  */
 #define REF_ISPRUNING	0x0100
-/** Deletion of a ref that only exists as a packed ref in which case we do not
- *  need to lock the loose ref during the transaction.
- */
-#define REF_ISPACKONLY	0x0200
 
 /*
  * Try to read one refname component from the front of refname.  Return
@@ -794,7 +791,6 @@ static int names_conflict(const char *refname1, const char *refname2)
 
 struct name_conflict_cb {
 	const char *refname;
-	const char *oldrefname;
 	const char *conflicting_refname;
 	const char **skip;
 	int skipnum;
@@ -804,13 +800,9 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
 	int i;
-	for(i = 0; i < data->skipnum; i++) {
-		if (!strcmp(entry->name, data->skip[i])) {
+	for (i = 0; i < data->skipnum; i++)
+		if (!strcmp(entry->name, data->skip[i]))
 			return 0;
-		}
-	}
-	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
-		return 0;
 	if (names_conflict(data->refname, entry->name)) {
 		data->conflicting_refname = entry->name;
 		return 1;
@@ -824,17 +816,14 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
  * operation). skip contains a list of refs we want to skip checking for
- * conflicts with. Refs may be skipped due to us knowing that it will
- * be deleted later during a transaction that deletes one reference and then
- * creates a new conflicting reference. For example a rename from m to m/m.
+ * conflicts with.
  */
-static int is_refname_available(const char *refname, const char *oldrefname,
+static int is_refname_available(const char *refname,
 				struct ref_dir *dir,
 				const char **skip, int skipnum)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
-	data.oldrefname = oldrefname;
 	data.conflicting_refname = NULL;
 	data.skip = skip;
 	data.skipnum = skipnum;
@@ -1356,8 +1345,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	if (flag)
 		*flag = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
 		return NULL;
+	}
 
 	for (;;) {
 		char path[PATH_MAX];
@@ -1365,8 +1356,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		char *buf;
 		int fd;
 
-		if (--depth < 0)
+		if (--depth < 0) {
+			errno = ELOOP;
 			return NULL;
+		}
 
 		git_snpath(path, sizeof(path), "%s", refname);
 
@@ -1428,9 +1421,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 				return NULL;
 		}
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
+		if (len < 0) {
+			int save_errno = errno;
+			close(fd);
+			errno = save_errno;
+ 			return NULL;
+		}
 		close(fd);
-		if (len < 0)
-			return NULL;
 		while (len && isspace(buffer[len-1]))
 			len--;
 		buffer[len] = '\0';
@@ -1447,6 +1444,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
 				if (flag)
 					*flag |= REF_ISBROKEN;
+				errno = EINVAL;
 				return NULL;
 			}
 			return refname;
@@ -1459,6 +1457,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flag)
 				*flag |= REF_ISBROKEN;
+			errno = EINVAL;
 			return NULL;
 		}
 		refname = strcpy(refname_buffer, buf);
@@ -1931,14 +1930,17 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
 	if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
+		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
+		errno = save_errno;
 		return NULL;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_name,
 			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
+		errno = EBUSY;
 		return NULL;
 	}
 	return lock;
@@ -1951,13 +1953,15 @@ static int remove_empty_directories(const char *file)
 	 * only empty directories), remove them.
 	 */
 	struct strbuf path;
-	int result;
+	int result, save_errno;
 
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
 	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
+	save_errno = errno;
 
+	errno = save_errno;
 	strbuf_release(&path);
 
 	return result;
@@ -2061,8 +2065,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
 		return NULL;
+	}
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
@@ -2097,8 +2103,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, NULL,
-				   get_packed_refs(&ref_cache),
+	     !is_refname_available(refname, get_packed_refs(&ref_cache),
 				   skip, skipnum)) {
 		last_errno = ENOTDIR;
 		goto error_return;
@@ -2221,11 +2226,16 @@ int lock_packed_refs(int flags)
 	return 0;
 }
 
+/*
+ * Commit the packed refs changes.
+ * On error we must make sure that errno contains a meaningful value.
+ */
 int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
+	int save_errno = 0;
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
@@ -2235,10 +2245,13 @@ int commit_packed_refs(void)
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
 				 0, write_packed_entry_fn,
 				 &packed_ref_cache->lock->fd);
-	if (commit_lock_file(packed_ref_cache->lock))
+	if (commit_lock_file(packed_ref_cache->lock)) {
+		save_errno = errno;
 		error = -1;
+	}
 	packed_ref_cache->lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
+	errno = save_errno;
 	return error;
 }
 
@@ -2357,13 +2370,13 @@ static void prune_ref(struct ref_to_prune *r)
 	if (check_refname_format(r->name + 5, 0))
 		return;
 
-	transaction = ref_transaction_begin();
+	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, NULL) ||
+				   REF_ISPRUNING, 1, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_rollback(transaction);
-		warning("prune_ref: %s", err.buf);
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
 		strbuf_release(&err);
 		return;
 	}
@@ -2473,10 +2486,12 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
+		if (err) {
+			unable_to_lock_message(git_path("packed-refs"), errno,
+					       err);
+			return -1;
+		}
 		unable_to_lock_error(git_path("packed-refs"), errno);
-		if (err)
-			strbuf_addf(err, "cannot delete '%s' from packed refs",
-				    refnames[i]);
 		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
 	packed = get_packed_refs(&ref_cache);
@@ -2504,10 +2519,33 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	/* Write what remains */
 	ret = commit_packed_refs();
 	if (ret && err)
-		strbuf_addf(err, "unable to overwrite old ref-pack file");
+		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
+			    strerror(errno));
 	return ret;
 }
 
+static int add_err_if_unremovable(const char *op, const char *file,
+				  struct strbuf *e, int rc)
+{
+	int err = errno;
+	if (rc < 0  && errno != ENOENT) {
+		strbuf_addf(e, "unable to %s %s: %s",
+			    op, file, strerror(errno));
+		errno = err;
+		return -1;
+	}
+	return 0;
+}
+
+static int unlink_or_err(const char *file, struct strbuf *err)
+{
+	if (err)
+		return add_err_if_unremovable("unlink", file, err,
+					      unlink(file));
+	else
+		return unlink_or_warn(file);
+}
+
 static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
@@ -2515,15 +2553,10 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
 
 		lock->lk->filename[i] = 0;
-		res = unlink_or_warn(lock->lk->filename);
+		res = unlink_or_err(lock->lk->filename, err);
 		lock->lk->filename[i] = '.';
-		if (res && errno != ENOENT) {
-			if (err)
-				strbuf_addf(err,
-					    "failed to delete loose ref '%s'",
-					    lock->lk->filename);
+		if (res && errno != ENOENT)
 			return 1;
-		}
 	}
 	return 0;
 }
@@ -2531,13 +2564,16 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
 	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
-	transaction = ref_transaction_begin();
+	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1), NULL) ||
-	    ref_transaction_commit(transaction, NULL)) {
-		ref_transaction_rollback(transaction);
+				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return 1;
 	}
 	ref_transaction_free(transaction);
@@ -2598,35 +2634,34 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
-	unsigned char sha1[20];
-	int flag = 0;
-	struct ref_transaction *transaction;
-	struct strbuf err = STRBUF_INIT;
+	unsigned char sha1[20], orig_sha1[20];
+	int flag = 0, logmoved = 0;
+	struct ref_lock *lock;
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
 
-	if (!strcmp(oldrefname, newrefname))
-		return 0;
-
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, sha1, 1, &flag);
+	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	if (!is_refname_available(newrefname, oldrefname,
-				  get_packed_refs(&ref_cache), NULL, 0))
+	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
+				  &oldrefname, 1))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname,
-				  get_loose_refs(&ref_cache), NULL, 0))
+	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
+				  &oldrefname, 1))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
@@ -2636,28 +2671,62 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
 		return error("unable to pack refs");
 
-	transaction = ref_transaction_begin();
-	if (!transaction ||
-	    ref_transaction_delete(transaction, oldrefname, sha1,
-				   REF_NODEREF | REF_ISPACKONLY,
-				   1, NULL) ||
-	    ref_transaction_update(transaction, newrefname, sha1,
-				   NULL, 0, 0, logmsg) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_rollback(transaction);
-		error("rename_ref failed: %s", err.buf);
-		strbuf_release(&err);
-		goto rollbacklog;
+	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
+		error("unable to delete old %s", oldrefname);
+		goto rollback;
+	}
+
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
+	    delete_ref(newrefname, sha1, REF_NODEREF)) {
+		if (errno==EISDIR) {
+			if (remove_empty_directories(git_path("%s", newrefname))) {
+				error("Directory not empty: %s", newrefname);
+				goto rollback;
+			}
+		} else {
+			error("unable to delete existing %s", newrefname);
+			goto rollback;
+		}
 	}
-	ref_transaction_free(transaction);
 
 	if (log && rename_tmp_log(newrefname))
-		goto rollbacklog;
+		goto rollback;
+
+	logmoved = log;
+
+	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
+	if (!lock) {
+		error("unable to lock %s for update", newrefname);
+		goto rollback;
+	}
+	lock->force_write = 1;
+	hashcpy(lock->old_sha1, orig_sha1);
+	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
+		error("unable to write current sha1 into %s", newrefname);
+		goto rollback;
+	}
 
 	return 0;
 
+ rollback:
+	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
+	if (!lock) {
+		error("unable to lock %s for rollback", oldrefname);
+		goto rollbacklog;
+	}
+
+	lock->force_write = 1;
+	flag = log_all_ref_updates;
+	log_all_ref_updates = 0;
+	if (write_ref_sha1(lock, orig_sha1, NULL))
+		error("unable to write current sha1 into %s", oldrefname);
+	log_all_ref_updates = flag;
+
  rollbacklog:
-	if (log &&
+	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
+		error("unable to restore logfile %s from %s: %s",
+			oldrefname, newrefname, strerror(errno));
+	if (!logmoved && log &&
 	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
@@ -2727,9 +2796,12 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(logfile) < 0)
-			return error("unable to create directory for %s",
-				     logfile);
+		if (safe_create_leading_directories(logfile) < 0) {
+			int save_errno = errno;
+			error("unable to create directory for %s", logfile);
+			errno = save_errno;
+			return -1;
+		}
 		oflags |= O_CREAT;
 	}
 
@@ -2740,15 +2812,22 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				return error("There are still logs under '%s'",
-					     logfile);
-			}
+				int save_errno = errno;
+				error("There are still logs under '%s'",
+				      logfile);
+				errno = save_errno;
+				return -1;
+ 			}
 			logfd = open(logfile, oflags, 0666);
 		}
 
-		if (logfd < 0)
-			return error("Unable to append to %s: %s",
-				     logfile, strerror(errno));
+		if (logfd < 0) {
+			int save_errno = errno;
+			error("Unable to append to %s: %s", logfile,
+			      strerror(errno));
+			errno = save_errno;
+			return -1;
+		}
 	}
 
 	adjust_shared_perm(logfile);
@@ -2788,8 +2867,19 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 		len += copy_msg(logrec + len - 1, msg) - 1;
 	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
-	if (close(logfd) != 0 || written != len)
-		return error("Unable to append to %s", log_file);
+	if (written != len) {
+		int save_errno = errno;
+		close(logfd);
+		error("Unable to append to %s", log_file);
+		errno = save_errno;
+		return -1;
+	}
+	if (close(logfd)) {
+		int save_errno = errno;
+		error("Unable to append to %s", log_file);
+		errno = save_errno;
+		return -1;
+	}
 	return 0;
 }
 
@@ -2798,14 +2888,17 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
+/** Writes sha1 into the ref specified by the lock. **/
 static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
 	struct object *o;
 
-	if (!lock)
+	if (!lock) {
+		errno = EINVAL;
 		return -1;
+	}
 	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
 		unlock_ref(lock);
 		return 0;
@@ -2815,19 +2908,23 @@ static int write_ref_sha1(struct ref_lock *lock,
 		error("Trying to write ref %s with nonexistent object %s",
 			lock->ref_name, sha1_to_hex(sha1));
 		unlock_ref(lock);
-		return -1;
+		errno = EINVAL;
+       		return -1;
 	}
 	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 		error("Trying to write non-commit object %s to branch %s",
 			sha1_to_hex(sha1), lock->ref_name);
 		unlock_ref(lock);
+		errno = EINVAL;
 		return -1;
 	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full(lock->lock_fd, &term, 1) != 1
-		|| close_ref(lock) < 0) {
+	    write_in_full(lock->lock_fd, &term, 1) != 1 ||
+	    close_ref(lock) < 0) {
+		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename);
 		unlock_ref(lock);
+		errno = save_errno;
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
@@ -3259,11 +3356,24 @@ struct ref_update {
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
 	int type;
-	const char *msg;
+	char *msg;
 	const char refname[FLEX_ARRAY];
 };
 
-enum ref_transaction_status {
+/*
+ * Transaction states.
+ * OPEN:   The transaction is in a valid state and can accept new updates.
+ *         An OPEN transaction can be committed.
+ * CLOSED: If an open transaction is successfully committed the state will
+ *         change to CLOSED. No further changes can be made to a CLOSED
+ *         transaction.
+ *         CLOSED means that all updates have been successfully committed and
+ *         the only thing that remains is to free the completed transaction.
+ * ERROR:  The transaction has failed and is no longer committable.
+ *         No further changes can be made to a CLOSED transaction and it must
+ *         be rolled back using transaction_free.
+ */
+enum ref_transaction_state {
 	REF_TRANSACTION_OPEN   = 0,
 	REF_TRANSACTION_CLOSED = 1,
 	REF_TRANSACTION_ERROR  = 2,
@@ -3278,10 +3388,11 @@ struct ref_transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
-	enum ref_transaction_status status;
+	enum ref_transaction_state state;
+	int status;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
@@ -3294,23 +3405,13 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		return;
 
 	for (i = 0; i < transaction->nr; i++) {
-	  free((char *)transaction->updates[i]->msg);
+		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
 	free(transaction);
 }
 
-void ref_transaction_rollback(struct ref_transaction *transaction)
-{
-	if (!transaction)
-		return;
-
-	transaction->status = REF_TRANSACTION_ERROR;
-
-	ref_transaction_free(transaction);
-}
-
 static struct ref_update *add_update(struct ref_transaction *transaction,
 				     const char *refname)
 {
@@ -3324,22 +3425,20 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 }
 
 int ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg)
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old, const char *msg,
+			   struct strbuf *err)
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: update called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
-	if (transaction->status != REF_TRANSACTION_OPEN)
-		die("BUG: update on transaction that is not open");
-
-	if (flags & REF_ISPACKONLY)
-		die("BUG: REF_ISPACKONLY can not be used with updates");
-
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3354,19 +3453,17 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags, const char *msg)
+			   int flags, const char *msg,
+			   struct strbuf *err)
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: create called for transaction that is not open");
+
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
-	if (transaction->status != REF_TRANSACTION_OPEN)
-		die("BUG: create on transaction that is not open");
-
-	if (flags & REF_ISPACKONLY)
-		die("BUG: REF_ISPACKONLY can not be used with creates");
-
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
@@ -3381,16 +3478,17 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg)
+			   int flags, int have_old, const char *msg,
+			   struct strbuf *err)
 {
 	struct ref_update *update;
 
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: delete called for transaction that is not open");
+
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
-	if (transaction->status != REF_TRANSACTION_OPEN)
-		die("BUG: delete on transaction that is not open");
-
 	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3410,14 +3508,14 @@ int update_ref(const char *action, const char *refname,
 	struct ref_transaction *t;
 	struct strbuf err = STRBUF_INIT;
 
-	t = ref_transaction_begin();
+	t = ref_transaction_begin(&err);
 	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, action) ||
+				   !!oldval, action, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
-		ref_transaction_rollback(t);
+		ref_transaction_free(t);
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR:
 			error(str, refname, err.buf); break;
@@ -3428,7 +3526,6 @@ int update_ref(const char *action, const char *refname,
 		strbuf_release(&err);
 		return 1;
 	}
-	ref_transaction_free(t);
 	return 0;
 }
 
@@ -3458,16 +3555,16 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (transaction->status != REF_TRANSACTION_OPEN)
-		die("BUG: commit on transaction that is not open");
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		die("BUG: commit called for transaction that is not open");
 
 	if (!n) {
-		transaction->status = REF_TRANSACTION_CLOSED;
+		transaction->state = REF_TRANSACTION_CLOSED;
 		return 0;
 	}
 
@@ -3476,24 +3573,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err);
-	if (ret)
+	if (ref_update_reject_duplicates(updates, n, err)) {
+		ret = -1;
 		goto cleanup;
-
-	for (i = 0; i < n; i++) {
-		struct ref_update *update = updates[i];
-
-		if (update->flags & REF_ISPACKONLY)
-			delnames[delnum++] = update->refname;
 	}
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_ISPACKONLY)
-			continue;
-
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
@@ -3502,10 +3590,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   &update->type,
 						   delnames, delnum);
 		if (!update->lock) {
+			if (errno == ENOTDIR)
+				df_conflict = 1;
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
-			ret = 1;
+			ret = -1;
 			goto cleanup;
 		}
 	}
@@ -3523,6 +3613,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3532,30 +3623,31 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_ISPACKONLY)
-			continue;
-
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type,
-						err);
+			if (delete_ref_loose(update->lock, update->type, err))
+				ret = -1;
+
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum, err);
+	if (repack_without_refs(delnames, delnum, err))
+		ret = -1;
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
-	transaction->status = ret ? REF_TRANSACTION_ERROR
-	  : REF_TRANSACTION_CLOSED;
+	transaction->state = ret ? REF_TRANSACTION_ERROR
+		: REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
+	if (df_conflict)
+		ret = -2;
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 0e6d416..8177052 100644
--- a/refs.h
+++ b/refs.h
@@ -10,6 +10,45 @@ struct ref_lock {
 	int force_write;
 };
 
+/*
+ * A ref_transaction represents a collection of ref updates
+ * that should succeed or fail together.
+ *
+ * Calling sequence
+ * ----------------
+ * - Allocate and initialize a `struct ref_transaction` by calling
+ *   `ref_transaction_begin()`.
+ *
+ * - List intended ref updates by calling functions like
+ *   `ref_transaction_update()` and `ref_transaction_create()`.
+ *
+ * - Call `ref_transaction_commit()` to execute the transaction.
+ *   If this succeeds, the ref updates will have taken place and
+ *   the transaction cannot be rolled back.
+ *
+ * - At any time call `ref_transaction_free()` to discard the
+ *   transaction and free associated resources.  In particular,
+ *   this rolls back the transaction if it has not been
+ *   successfully committed.
+ *
+ * Error handling
+ * --------------
+ *
+ * On error, transaction functions append a message about what
+ * went wrong to the 'err' argument.  The message mentions what
+ * ref was being updated (if any) when the error occurred so it
+ * can be passed to 'die' or 'error' as-is.
+ *
+ * The message is appended to err without first clearing err.
+ * This allows the caller to prepare preamble text to the generated
+ * error message:
+ *
+ *     strbuf_addf(&err, "Error while doing foo-bar: ");
+ *     if (ref_transaction_update(..., &err)) {
+ *         ret = error("%s", err.buf);
+ *         goto cleanup;
+ *     }
+ */
 struct ref_transaction;
 
 /*
@@ -132,8 +171,17 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks any ref (for 'HEAD' type refs). */
+/*
+ * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
+ * ref_transaction_create(), etc.
+ * REF_NODEREF: act on the ref directly, instead of dereferencing
+ *              symbolic references.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
 #define REF_NODEREF	0x01
+
+/** Locks any ref (for 'HEAD' type refs). */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
@@ -210,16 +258,9 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be freed by either calling ref_transaction_rollback()
- * or ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
-
-/*
- * Roll back a ref_transaction and free all associated data.
- */
-void ref_transaction_rollback(struct ref_transaction *transaction);
-
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
@@ -229,7 +270,6 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * can be REF_NODEREF; it is passed to update_ref_lock().
  */
 
-
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
@@ -244,7 +284,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg);
+			   int flags, int have_old, const char *msg,
+			   struct strbuf *err);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
@@ -258,7 +299,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
-			   int flags, const char *msg);
+			   int flags, const char *msg,
+			   struct strbuf *err);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
@@ -271,19 +313,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg);
+			   int flags, int have_old, const char *msg,
+			   struct strbuf *err);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem. If err is non-NULL we will add an error string to it to explain
- * why the transaction failed. The string does not end in newline.
+ * problem.
+ * If the transaction is already in failed state this function will return
+ * an error.
+ * Function returns 0 on success, -1 for generic failures and
+ * UPDATE_REFS_NAME_CONFLICT (-2) if the failure was due to a name
+ * collision (ENOTDIR).
  */
+#define UPDATE_REFS_NAME_CONFLICT -2
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
 /*
- * Free an existing transaction.
+ * Free an existing transaction and all associated data.
  */
 void ref_transaction_free(struct ref_transaction *transaction);
 
diff --git a/sequencer.c b/sequencer.c
index 3a0ee09..f9906ef 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -282,20 +282,20 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
-	transaction = ref_transaction_begin();
+	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", to, from,
-				   0, !unborn, sb.buf) ||
+				   0, !unborn, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_rollback(transaction);
-		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
 		strbuf_release(&sb);
 		strbuf_release(&err);
 		return -1;
 	}
-	ref_transaction_free(transaction);
 
 	strbuf_release(&sb);
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fafd38a..de0c2b9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -288,9 +288,9 @@ test_expect_success 'deleting a dangling symref' '
 test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
-	git symbolic-ref refs/heads/master2 &&
-	test_path_is_missing .git/refs/heads/master &&
-	test_path_is_missing .git/refs/heads/master3
+	git rev-parse --verify refs/heads/master &&
+	test_must_fail git symbolic-ref refs/heads/master3 &&
+	test_must_fail git rev-parse refs/heads/master3
 '
 
 test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
diff --git a/walker.c b/walker.c
index c2a1266..fd9ef87 100644
--- a/walker.c
+++ b/walker.c
@@ -251,19 +251,22 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
-	struct ref_transaction *transaction;
+	struct ref_transaction *transaction = NULL;
 	unsigned char *sha1 = xmalloc(targets * 20);
 	char *msg = NULL;
 	int i;
 
 	save_commit_buffer = 0;
 
-	transaction = ref_transaction_begin();
-	if (!transaction)
-		return -1;
-
+	if (write_ref) {
+		transaction = ref_transaction_begin(&err);
+		if (!transaction) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
+		}
+	}
 	if (!walker->get_recover)
 		for_each_ref(mark_complete, NULL);
 
@@ -288,26 +291,32 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (!write_ref || !write_ref[i])
 			continue;
-		sprintf(ref_name, "refs/%s", write_ref[i]);
-		if (ref_transaction_update(transaction, ref_name,
-					   &sha1[20 * i], NULL,
-					   0, 0,
-					   msg ? msg : "fetch (unknown)"))
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
+		if (ref_transaction_update(transaction, ref_name.buf,
+					   &sha1[20 * i], NULL, 0, 0,
+					   msg ? msg : "fetch (unknown)",
+					   &err)) {
+			error("%s", err.buf);
 			goto rollback_and_fail;
+		}
 	}
-
-	if (ref_transaction_commit(transaction, &err)) {
-		error("%s", err.buf);
-		goto rollback_and_fail;
+	if (write_ref) {
+		if (ref_transaction_commit(transaction, &err)) {
+			error("%s", err.buf);
+			goto rollback_and_fail;
+		}
+		ref_transaction_free(transaction);
 	}
 
 	free(msg);
 	return 0;
 
 rollback_and_fail:
+	ref_transaction_free(transaction);
 	free(msg);
 	strbuf_release(&err);
-	ref_transaction_free(transaction);
+	strbuf_release(&ref_name);
 
 	return -1;
 }
