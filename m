From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/14] hold_locked_index: pass error message back through a
 strbuf
Date: Tue, 2 Dec 2014 21:25:19 -0800
Message-ID: <20141203052519.GU6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:25:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2RM-0001HJ-Iq
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbaLCFZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:25:24 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39672 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaLCFZW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:25:22 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so12664091iec.5
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QAXy/TarNWCqNM16N4/36OPOUqrg1+NBvTF44GumBbM=;
        b=pSl0N/D3f+STHkTOpGFlhAlvCOGJZf6iZ511/1+qhZ5fPtc+wjrncSaIiw07NjqdzZ
         hDbUe5iGPyIcxV8336ccbiMGhXFaVNRaPXvznXf7Q0ZwRJ9KqTSHu0yQSLi2Bv/BviYk
         Wxwnjh0Tpa6aO2+f9qym7yclQnPeqnf/IxokrQYPZH4tCj8LaE4A1vnKbclQf6xqBXBG
         ZfWfweVnZBDjT3eK1K1EObOf53T+YWLGrXa2J3IlCaftZEGiYF1Ea1KxC8BsSfjICMRk
         v9A7ySaFHOiwKYEr5T0lBzcinmOh7WCcpfm8WL7EkpNlruE7K01DanYJE6gSYRm7E7Xd
         xnGg==
X-Received: by 10.107.7.91 with SMTP id 88mr3067331ioh.70.1417584322171;
        Tue, 02 Dec 2014 21:25:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id qj6sm13736218igc.1.2014.12.02.21.25.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:25:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260635>

Today hold_locked_index takes a boolean parameter indicating whether
to die with a message or to return -1 with errno indicating the nature
of the problem on error.

Pass back an error message through an 'err' parameter instead.  This
method of error reporting was introduced in the ref transaction API
and makes it more obvious when callers are not reporting errors (for
example, this helped catch rerere.autoupdate skipping the autoupdate
when unable to lock the index).

It also makes it easier for callers to clean up before exiting instead
of having to die() right away and paves the way for simplifying
hold_lock_file_for_update error handling in a later patch.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c            | 12 ++++++++---
 builtin/apply.c          | 10 +++++++--
 builtin/checkout-index.c | 10 +++++++--
 builtin/checkout.c       | 55 ++++++++++++++++++++++++++++++++++--------------
 builtin/clone.c          |  6 +++++-
 builtin/commit.c         | 27 ++++++++++++++++++------
 builtin/describe.c       | 11 +++++++---
 builtin/diff.c           | 12 ++++++++---
 builtin/merge.c          | 14 +++++++++---
 builtin/mv.c             |  5 ++++-
 builtin/read-tree.c      |  9 ++++++--
 builtin/reset.c          | 10 +++++++--
 builtin/rm.c             |  9 ++++++--
 builtin/update-index.c   | 10 ++++-----
 cache-tree.c             | 18 ++++++++++++----
 cache.h                  |  2 +-
 merge-recursive.c        | 13 +++++++++---
 merge.c                  | 17 +++++++++++----
 read-cache.c             | 14 +++++++-----
 rerere.c                 |  5 ++++-
 sequencer.c              | 14 ++++++++++--
 test-scrap-cache-tree.c  |  5 ++++-
 22 files changed, 214 insertions(+), 74 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ae6d3e2..e912d77 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -299,6 +299,7 @@ static int add_files(struct dir_struct *dir, int flags)
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct pathspec pathspec;
 	struct dir_struct dir;
 	int flags;
@@ -315,8 +316,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (add_interactive)
 		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
 
-	if (edit_interactive)
-		return(edit_patch(argc, argv, prefix));
+	if (edit_interactive) {
+		strbuf_release(&err);
+		return edit_patch(argc, argv, prefix);
+	}
 	argc--;
 	argv++;
 
@@ -344,7 +347,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	add_new_files = !take_worktree_changes && !refresh_only;
 	require_pathspec = !take_worktree_changes;
 
-	hold_locked_index(&lock_file, 1);
+	if (hold_locked_index(&lock_file, &err) < 0)
+		die("%s", err.buf);
 
 	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
 		 (show_only ? ADD_CACHE_PRETEND : 0) |
@@ -356,6 +360,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (require_pathspec && argc == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
+		strbuf_release(&err);
 		return 0;
 	}
 
@@ -446,5 +451,6 @@ finish:
 			die(_("Unable to write new index file"));
 	}
 
+	strbuf_release(&err);
 	return exit_status;
 }
diff --git a/builtin/apply.c b/builtin/apply.c
index 6696ea4..cda438f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4200,6 +4200,7 @@ static int apply_patch(int fd, const char *filename, int options)
 {
 	size_t offset;
 	struct strbuf buf = STRBUF_INIT; /* owns the patch text */
+	struct strbuf err = STRBUF_INIT;
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
@@ -4237,8 +4238,11 @@ static int apply_patch(int fd, const char *filename, int options)
 		apply = 0;
 
 	update_index = check_index && apply;
-	if (update_index && newfd < 0)
-		newfd = hold_locked_index(&lock_file, 1);
+	if (update_index && newfd < 0) {
+		newfd = hold_locked_index(&lock_file, &err);
+		if (newfd < 0)
+			die("%s", err.buf);
+	}
 
 	if (check_index) {
 		if (read_cache() < 0)
@@ -4254,6 +4258,7 @@ static int apply_patch(int fd, const char *filename, int options)
 		if (apply_with_reject)
 			exit(1);
 		/* with --3way, we still need to write the index out */
+		strbuf_release(&err);
 		return 1;
 	}
 
@@ -4272,6 +4277,7 @@ static int apply_patch(int fd, const char *filename, int options)
 	free_patch_list(list);
 	strbuf_release(&buf);
 	string_list_clear(&fn_table, 0);
+	strbuf_release(&err);
 	return 0;
 }
 
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 383dccf..07164f5 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -133,11 +133,17 @@ static int option_parse_u(const struct option *opt,
 			      const char *arg, int unset)
 {
 	int *newfd = opt->value;
+	struct strbuf err = STRBUF_INIT;
 
 	state.refresh_cache = 1;
 	state.istate = &the_index;
-	if (*newfd < 0)
-		*newfd = hold_locked_index(&lock_file, 1);
+	if (*newfd < 0) {
+		int fd = hold_locked_index(&lock_file, &err);
+		if (fd < 0)
+			die("%s", err.buf);
+		*newfd = fd;
+	}
+	strbuf_release(&err);
 	return 0;
 }
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5410dac..d2699cd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -218,6 +218,7 @@ static int checkout_merged(int pos, struct checkout *state)
 static int checkout_paths(const struct checkout_opts *opts,
 			  const char *revision)
 {
+	struct strbuf err = STRBUF_INIT;
 	int pos;
 	struct checkout state;
 	static char *ps_matched;
@@ -249,15 +250,20 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
-	if (opts->patch_mode)
+	if (opts->patch_mode) {
+		strbuf_release(&err);
 		return run_add_interactive(revision, "--patch=checkout",
 					   &opts->pathspec);
+	}
 
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	hold_locked_index(lock_file, 1);
-	if (read_cache_preload(&opts->pathspec) < 0)
+	if (hold_locked_index(lock_file, &err) < 0)
+		die("%s", err.buf);
+	if (read_cache_preload(&opts->pathspec) < 0) {
+		strbuf_release(&err);
 		return error(_("corrupt index file"));
+	}
 
 	if (opts->source_tree)
 		read_tree_some(opts->source_tree, &opts->pathspec);
@@ -302,6 +308,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	if (report_path_error(ps_matched, &opts->pathspec, opts->prefix)) {
 		free(ps_matched);
+		strbuf_release(&err);
 		return 1;
 	}
 	free(ps_matched);
@@ -329,8 +336,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
-	if (errs)
+	if (errs) {
+		strbuf_release(&err);
 		return 1;
+	}
 
 	/* Now we are committed to check them out */
 	memset(&state, 0, sizeof(state));
@@ -359,6 +368,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	head = lookup_commit_reference_gently(rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
+	strbuf_release(&err);
 	return errs;
 }
 
@@ -442,17 +452,22 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			      int *writeout_error)
 {
 	int ret;
+	struct strbuf err = STRBUF_INIT;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	hold_locked_index(lock_file, 1);
-	if (read_cache_preload(NULL) < 0)
-		return error(_("corrupt index file"));
+	if (hold_locked_index(lock_file, &err) < 0)
+		die("%s", err.buf);
+
+	if (read_cache_preload(NULL) < 0) {
+		ret = error(_("corrupt index file"));
+		goto done;
+	}
 
 	resolve_undo_clear();
 	if (opts->force) {
 		ret = reset_tree(new->commit->tree, opts, 1, writeout_error);
 		if (ret)
-			return ret;
+			goto done;
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
@@ -469,7 +484,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 		if (unmerged_cache()) {
 			error(_("you need to resolve your current index first"));
-			return 1;
+			ret = 1;
+			goto done;
 		}
 
 		/* 2-way merge to the new branch */
@@ -501,15 +517,19 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			struct tree *result;
 			struct tree *work;
 			struct merge_options o;
-			if (!opts->merge)
-				return 1;
+			if (!opts->merge) {
+				ret = 1;
+				goto done;
+			}
 
 			/*
 			 * Without old->commit, the below is the same as
 			 * the two-tree unpack we already tried and failed.
 			 */
-			if (!old->commit)
-				return 1;
+			if (!old->commit) {
+				ret = 1;
+				goto done;
+			}
 
 			/* Do more real merge */
 
@@ -539,7 +559,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			ret = reset_tree(new->commit->tree, opts, 1,
 					 writeout_error);
 			if (ret)
-				return ret;
+				goto done;
 			o.ancestor = old->name;
 			o.branch1 = new->name;
 			o.branch2 = "local";
@@ -548,7 +568,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			ret = reset_tree(new->commit->tree, opts, 0,
 					 writeout_error);
 			if (ret)
-				return ret;
+				goto done;
 		}
 	}
 
@@ -564,7 +584,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (!opts->force && !opts->quiet)
 		show_local_changes(&new->commit->object, &opts->diff_options);
 
-	return 0;
+	ret = 0;
+done:
+	strbuf_release(&err);
+	return ret;
 }
 
 static void report_tracking(struct branch_info *new)
diff --git a/builtin/clone.c b/builtin/clone.c
index b07d740..911a6a4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -613,6 +613,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 
 static int checkout(void)
 {
+	struct strbuf msg = STRBUF_INIT;
 	unsigned char sha1[20];
 	char *head;
 	struct lock_file *lock_file;
@@ -628,6 +629,7 @@ static int checkout(void)
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
+		strbuf_release(&msg);
 		return 0;
 	}
 	if (!strcmp(head, "HEAD")) {
@@ -643,7 +645,8 @@ static int checkout(void)
 	setup_work_tree();
 
 	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, 1);
+	if (hold_locked_index(lock_file, &msg) < 0)
+		die("%s", msg.buf);
 
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
@@ -668,6 +671,7 @@ static int checkout(void)
 	if (!err && option_recursive)
 		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
 
+	strbuf_release(&msg);
 	return err;
 }
 
diff --git a/builtin/commit.c b/builtin/commit.c
index e108c53..edc4493 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -319,6 +319,7 @@ static void refresh_cache_or_die(int refresh_flags)
 static const char *prepare_index(int argc, const char **argv, const char *prefix,
 				 const struct commit *current_head, int is_status)
 {
+	struct strbuf err = STRBUF_INIT;
 	struct string_list partial;
 	struct pathspec pathspec;
 	int refresh_flags = REFRESH_QUIET;
@@ -334,8 +335,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 	if (interactive) {
 		char *old_index_env = NULL;
-		hold_locked_index(&index_lock, 1);
 
+		if (hold_locked_index(&index_lock, &err) < 0)
+			die("%s", err.buf);
 		refresh_cache_or_die(refresh_flags);
 
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
@@ -363,6 +365,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			warning(_("Failed to update main cache tree"));
 
 		commit_style = COMMIT_NORMAL;
+		strbuf_release(&err);
 		return index_lock.filename.buf;
 	}
 
@@ -379,13 +382,15 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
-		hold_locked_index(&index_lock, 1);
+		if (hold_locked_index(&index_lock, &err) < 0)
+			die("%s", err.buf);
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
+		strbuf_release(&err);
 		return index_lock.filename.buf;
 	}
 
@@ -399,7 +404,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 * We still need to refresh the index here.
 	 */
 	if (!only && !pathspec.nr) {
-		hold_locked_index(&index_lock, 1);
+		if (hold_locked_index(&index_lock, &err) < 0)
+			die("%s", err.buf);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed
 		    || !cache_tree_fully_valid(active_cache_tree)) {
@@ -414,6 +420,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			rollback_lock_file(&index_lock);
 		}
 		commit_style = COMMIT_AS_IS;
+		strbuf_release(&err);
 		return get_index_file();
 	}
 
@@ -453,7 +460,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (read_cache() < 0)
 		die(_("cannot read the index"));
 
-	hold_locked_index(&index_lock, 1);
+	if (hold_locked_index(&index_lock, &err) < 0)
+		die("%s", err.buf);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 	update_main_cache_tree(WRITE_TREE_SILENT);
@@ -475,6 +483,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	discard_cache();
 	read_cache_from(false_lock.filename.buf);
 
+	strbuf_release(&err);
 	return false_lock.filename.buf;
 }
 
@@ -1356,8 +1365,8 @@ static int git_status_config(const char *k, const char *v, void *cb)
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	static struct wt_status s;
-	int fd;
 	unsigned char sha1[20];
+	struct strbuf err = STRBUF_INIT;
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_SET_INT('s', "short", &status_format,
@@ -1405,8 +1414,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	read_cache_preload(&s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
 
-	fd = hold_locked_index(&index_lock, 0);
-	if (0 <= fd)
+	/* Refresh the index if possible. */
+	if (hold_locked_index(&index_lock, &err) < 0)
+		/* errors (e.g., read-only filesystem) are fine */
+		strbuf_reset(&err);
+	else
 		update_index_if_able(&the_index, &index_lock);
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
@@ -1433,6 +1445,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		wt_status_print(&s);
 		break;
 	}
+	strbuf_release(&err);
 	return 0;
 }
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 9103193..1e7e970 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -457,19 +457,24 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	if (argc == 0) {
 		if (dirty) {
+			struct strbuf err = STRBUF_INIT;
 			static struct lock_file index_lock;
-			int fd;
 
 			read_cache_preload(NULL);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
-			fd = hold_locked_index(&index_lock, 0);
-			if (0 <= fd)
+
+			/* Refresh the index if possible. */
+			if (hold_locked_index(&index_lock, &err) < 0)
+				/* Failure is ok (e.g, read-only filesystem). */
+				strbuf_reset(&err);
+			else
 				update_index_if_able(&the_index, &index_lock);
 
 			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
 					    diff_index_args, prefix))
 				dirty = NULL;
+			strbuf_release(&err);
 		}
 		describe("HEAD", 1);
 	} else if (dirty) {
diff --git a/builtin/diff.c b/builtin/diff.c
index 4326fa5..9dd7b93 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -206,16 +206,22 @@ static int builtin_diff_combined(struct rev_info *revs,
 static void refresh_index_quietly(void)
 {
 	struct lock_file *lock_file;
-	int fd;
+	struct strbuf err = STRBUF_INIT;
 
 	lock_file = xcalloc(1, sizeof(struct lock_file));
-	fd = hold_locked_index(lock_file, 0);
-	if (fd < 0)
+	if (hold_locked_index(lock_file, &err) < 0) {
+		/*
+		 * Locking the index failed (e.g., read-only filesystem).
+		 * That's okay.
+		 */
+		strbuf_release(&err);
 		return;
+	}
 	discard_cache();
 	read_cache();
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
 	update_index_if_able(&the_index, lock_file);
+	strbuf_release(&err);
 }
 
 static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv)
diff --git a/builtin/merge.c b/builtin/merge.c
index bebbe5b..1ecea33 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -658,12 +658,16 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			      struct commit *head, const char *head_arg)
 {
 	static struct lock_file lock;
+	struct strbuf err = STRBUF_INIT;
 
-	hold_locked_index(&lock, 1);
+	if (hold_locked_index(&lock, &err) < 0)
+		die("%s", err.buf);
 	refresh_cache(REFRESH_QUIET);
 	if (active_cache_changed &&
-	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
+	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
+		strbuf_release(&err);
 		return error(_("Unable to write index."));
+	}
 	rollback_lock_file(&lock);
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
@@ -675,6 +679,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		if (remoteheads->next) {
 			error(_("Not handling anything other than two heads merge."));
+			strbuf_release(&err);
 			return 2;
 		}
 
@@ -696,15 +701,18 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
 
-		hold_locked_index(&lock, 1);
+		if (hold_locked_index(&lock, &err) < 0)
+			die("%s", err.buf);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
 		if (active_cache_changed &&
 		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
 		rollback_lock_file(&lock);
+		strbuf_release(&err);
 		return clean ? 0 : 1;
 	} else {
+		strbuf_release(&err);
 		return try_merge_command(strategy, xopts_nr, xopts,
 						common, head_arg, remoteheads);
 	}
diff --git a/builtin/mv.c b/builtin/mv.c
index 563d05b..e87817f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -116,6 +116,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
+	struct strbuf err = STRBUF_INIT;
 
 	gitmodules_config();
 	git_config(git_default_config, NULL);
@@ -125,7 +126,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (--argc < 1)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
 
-	hold_locked_index(&lock_file, 1);
+	if (hold_locked_index(&lock_file, &err) < 0)
+		die("%s", err.buf);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
@@ -278,5 +280,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("Unable to write new index file"));
 
+	strbuf_release(&err);
 	return 0;
 }
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 43b47f7..2328b96 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -100,6 +100,7 @@ static struct lock_file lock_file;
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
+	struct strbuf err = STRBUF_INIT;
 	int i, stage = 0;
 	unsigned char sha1[20];
 	struct tree_desc t[MAX_UNPACK_TREES];
@@ -150,7 +151,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	hold_locked_index(&lock_file, 1);
+	if (hold_locked_index(&lock_file, &err) < 0)
+		die("%s", err.buf);
 
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
@@ -228,8 +230,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		parse_tree(tree);
 		init_tree_desc(t+i, tree->buffer, tree->size);
 	}
-	if (unpack_trees(nr_trees, t, &opts))
+	if (unpack_trees(nr_trees, t, &opts)) {
+		strbuf_release(&err);
 		return 128;
+	}
 
 	if (opts.debug_unpack || opts.dry_run)
 		return 0; /* do not write the index out */
@@ -245,5 +249,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("unable to write new index file");
+	strbuf_release(&err);
 	return 0;
 }
diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..f83df72 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -266,6 +266,7 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
+	struct strbuf msg = STRBUF_INIT;
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int patch_mode = 0, unborn;
 	const char *rev;
@@ -320,6 +321,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+		strbuf_release(&msg);
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
@@ -354,11 +356,14 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (reset_type != SOFT) {
 		struct lock_file *lock = xcalloc(1, sizeof(*lock));
-		hold_locked_index(lock, 1);
+		if (hold_locked_index(lock, &msg) < 0)
+			die("%s", msg.buf);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			if (read_from_tree(&pathspec, sha1, intent_to_add))
+			if (read_from_tree(&pathspec, sha1, intent_to_add)) {
+				strbuf_release(&msg);
 				return 1;
+			}
 			if (get_git_work_tree())
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
@@ -385,5 +390,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (!pathspec.nr)
 		remove_branch_state();
 
+	strbuf_release(&msg);
 	return update_ref_status;
 }
diff --git a/builtin/rm.c b/builtin/rm.c
index d8a9c86..d54538e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -281,6 +281,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pathspec pathspec;
 	char *seen;
+	struct strbuf err = STRBUF_INIT;
 
 	gitmodules_config();
 	git_config(git_default_config, NULL);
@@ -293,7 +294,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only)
 		setup_work_tree();
 
-	hold_locked_index(&lock_file, 1);
+	if (hold_locked_index(&lock_file, &err) < 0)
+		die("%s", err.buf);
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
@@ -375,8 +377,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			die(_("git rm: unable to remove %s"), path);
 	}
 
-	if (show_only)
+	if (show_only) {
+		strbuf_release(&err);
 		return 0;
+	}
 
 	/*
 	 * Then, unless we used "--cached", remove the filenames from
@@ -431,5 +435,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			die(_("Unable to write new index file"));
 	}
 
+	strbuf_release(&err);
 	return 0;
 }
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 56abd18..f3875db 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -746,7 +746,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int preferred_index_format = 0;
 	char set_executable_bit = 0;
 	struct refresh_params refresh_args = {0, &has_errors};
-	int lock_error = 0;
+	struct strbuf lock_error = STRBUF_INIT;
 	int split_index = -1;
 	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
@@ -843,9 +843,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	newfd = hold_locked_index(lock_file, 0);
-	if (newfd < 0)
-		lock_error = errno;
+	newfd = hold_locked_index(lock_file, &lock_error);
 
 	entries = read_cache();
 	if (entries < 0)
@@ -943,13 +941,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-			unable_to_lock_die(get_index_file(), 0, lock_error);
+			die("%s", lock_error.buf);
 		}
 		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
 	}
 
 	rollback_lock_file(lock_file);
-
+	strbuf_release(&lock_error);
 	return has_errors ? 1 : 0;
 }
diff --git a/cache-tree.c b/cache-tree.c
index 32772b9..b883b8f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -595,6 +595,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 {
 	int entries, was_valid, newfd;
+	struct strbuf err = STRBUF_INIT;
 	struct lock_file *lock_file;
 
 	/*
@@ -603,11 +604,15 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	 */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	newfd = hold_locked_index(lock_file, 1);
+	newfd = hold_locked_index(lock_file, &err);
+	if (newfd < 0)
+		die("%s", err.buf);
 
 	entries = read_cache();
-	if (entries < 0)
+	if (entries < 0) {
+		strbuf_release(&err);
 		return WRITE_TREE_UNREADABLE_INDEX;
+	}
 	if (flags & WRITE_TREE_IGNORE_CACHE_TREE)
 		cache_tree_free(&(active_cache_tree));
 
@@ -616,8 +621,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 
 	was_valid = cache_tree_fully_valid(active_cache_tree);
 	if (!was_valid) {
-		if (cache_tree_update(&the_index, flags) < 0)
+		if (cache_tree_update(&the_index, flags) < 0) {
+			strbuf_release(&err);
 			return WRITE_TREE_UNMERGED_INDEX;
+		}
 		if (0 <= newfd) {
 			if (!write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 				newfd = -1;
@@ -633,8 +640,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	if (prefix) {
 		struct cache_tree *subtree =
 			cache_tree_find(active_cache_tree, prefix);
-		if (!subtree)
+		if (!subtree) {
+			strbuf_release(&err);
 			return WRITE_TREE_PREFIX_ERROR;
+		}
 		hashcpy(sha1, subtree->sha1);
 	}
 	else
@@ -643,6 +652,7 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	if (0 <= newfd)
 		rollback_lock_file(lock_file);
 
+	strbuf_release(&err);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index ddaa30f..bfff653 100644
--- a/cache.h
+++ b/cache.h
@@ -572,7 +572,7 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
 
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
-extern int hold_locked_index(struct lock_file *, int);
+extern int hold_locked_index(struct lock_file *, struct strbuf *err);
 extern void set_alternate_index_output(const char *);
 
 extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
diff --git a/merge-recursive.c b/merge-recursive.c
index fdb7d0f..82a2330 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1995,6 +1995,7 @@ int merge_recursive_generic(struct merge_options *o,
 			    struct commit **result)
 {
 	int clean;
+	struct strbuf err = STRBUF_INIT;
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	struct commit *head_commit = get_ref(head, o->branch1);
 	struct commit *next_commit = get_ref(merge, o->branch2);
@@ -2004,20 +2005,26 @@ int merge_recursive_generic(struct merge_options *o,
 		int i;
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(base_list[i], sha1_to_hex(base_list[i]))))
+			if (!(base = get_ref(base_list[i], sha1_to_hex(base_list[i])))) {
+				strbuf_release(&err);
 				return error(_("Could not parse object '%s'"),
 					sha1_to_hex(base_list[i]));
+			}
 			commit_list_insert(base, &ca);
 		}
 	}
 
-	hold_locked_index(lock, 1);
+	if (hold_locked_index(lock, &err) < 0)
+		die("%s", err.buf);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
 	if (active_cache_changed &&
-	    write_locked_index(&the_index, lock, COMMIT_LOCK))
+	    write_locked_index(&the_index, lock, COMMIT_LOCK)) {
+		strbuf_release(&err);
 		return error(_("Unable to write index."));
+	}
 
+	strbuf_release(&err);
 	return clean ? 0 : 1;
 }
 
diff --git a/merge.c b/merge.c
index fcff632..b26b7f3 100644
--- a/merge.c
+++ b/merge.c
@@ -53,11 +53,13 @@ int checkout_fast_forward(const unsigned char *head,
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, nr_trees = 0;
 	struct dir_struct dir;
+	struct strbuf err = STRBUF_INIT;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	refresh_cache(REFRESH_QUIET);
 
-	hold_locked_index(lock_file, 1);
+	if (hold_locked_index(lock_file, &err) < 0)
+		die("%s", err.buf);
 
 	memset(&trees, 0, sizeof(trees));
 	memset(&opts, 0, sizeof(opts));
@@ -79,18 +81,25 @@ int checkout_fast_forward(const unsigned char *head,
 	setup_unpack_trees_porcelain(&opts, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
-	if (!trees[nr_trees++])
+	if (!trees[nr_trees++]) {
+		strbuf_release(&err);
 		return -1;
+	}
 	trees[nr_trees] = parse_tree_indirect(remote);
-	if (!trees[nr_trees++])
+	if (!trees[nr_trees++]) {
+		strbuf_release(&err);
 		return -1;
+	}
 	for (i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
-	if (unpack_trees(nr_trees, t, &opts))
+	if (unpack_trees(nr_trees, t, &opts)) {
+		strbuf_release(&err);
 		return -1;
+	}
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
+	strbuf_release(&err);
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
index 8f3e9eb..2ce1a76 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1368,12 +1368,16 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
-int hold_locked_index(struct lock_file *lk, int die_on_error)
+int hold_locked_index(struct lock_file *lk, struct strbuf *err)
 {
-	return hold_lock_file_for_update(lk, get_index_file(),
-					 die_on_error
-					 ? LOCK_DIE_ON_ERROR
-					 : 0);
+	const char *path;
+	int fd;
+
+	path = get_index_file();
+	fd = hold_lock_file_for_update(lk, path, 0);
+	if (fd < 0)
+		unable_to_lock_message(path, 0, errno, err);
+	return fd;
 }
 
 int read_index(struct index_state *istate)
diff --git a/rerere.c b/rerere.c
index 195f663..044e279 100644
--- a/rerere.c
+++ b/rerere.c
@@ -479,9 +479,11 @@ static struct lock_file index_lock;
 
 static void update_paths(struct string_list *update)
 {
+	struct strbuf err = STRBUF_INIT;
 	int i;
 
-	hold_locked_index(&index_lock, 1);
+	if (hold_locked_index(&index_lock, &err) < 0)
+		die("%s", err.buf);
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
@@ -494,6 +496,7 @@ static void update_paths(struct string_list *update)
 			die("Unable to write new index file");
 	} else
 		rollback_lock_file(&index_lock);
+	strbuf_release(&err);
 }
 
 static int do_plain_rerere(struct string_list *rr, int fd)
diff --git a/sequencer.c b/sequencer.c
index a03d4fa..3b3a869 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -276,9 +276,11 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	int clean;
 	const char **xopt;
+	struct strbuf err = STRBUF_INIT;
 	static struct lock_file index_lock;
 
-	hold_locked_index(&index_lock, 1);
+	if (hold_locked_index(&index_lock, &err) < 0)
+		die("%s", err.buf);
 
 	read_cache();
 
@@ -323,6 +325,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 		}
 	}
 
+	strbuf_release(&err);
 	return !clean;
 }
 
@@ -647,7 +650,13 @@ static void prepare_revs(struct replay_opts *opts)
 static void read_and_refresh_cache(struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
-	int index_fd = hold_locked_index(&index_lock, 0);
+	struct strbuf err = STRBUF_INIT;
+	int index_fd;
+
+	index_fd = hold_locked_index(&index_lock, &err);
+	if (index_fd < 0)
+		/* ignore the error */
+		strbuf_reset(&err);
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("git %s: failed to read the index"), action_name(opts));
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
@@ -656,6 +665,7 @@ static void read_and_refresh_cache(struct replay_opts *opts)
 			die(_("git %s: failed to refresh the index"), action_name(opts));
 	}
 	rollback_lock_file(&index_lock);
+	strbuf_release(&err);
 }
 
 static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
diff --git a/test-scrap-cache-tree.c b/test-scrap-cache-tree.c
index 6efee31..3e30e8d 100644
--- a/test-scrap-cache-tree.c
+++ b/test-scrap-cache-tree.c
@@ -7,11 +7,14 @@ static struct lock_file index_lock;
 
 int main(int ac, char **av)
 {
-	hold_locked_index(&index_lock, 1);
+	struct strbuf err = STRBUF_INIT;
+	if (hold_locked_index(&index_lock, &err) < 0)
+		die("%s", err.buf);
 	if (read_cache() < 0)
 		die("unable to read index file");
 	active_cache_tree = NULL;
 	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		die("unable to write index file");
+	strbuf_release(&err);
 	return 0;
 }
