Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48FDD208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdIEMP1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:15:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:57218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751604AbdIEMPX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:15:23 -0400
Received: (qmail 31419 invoked by uid 109); 5 Sep 2017 12:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:15:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12411 invoked by uid 111); 5 Sep 2017 12:15:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:15:21 -0400
Date:   Tue, 5 Sep 2017 08:15:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 20/20] stop leaking lock structs in some simple cases
Message-ID: <20170905121521.67kehubcat5klvix@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that it's safe to declare a "struct lock_file" on the
stack, we can do so (and avoid an intentional leak). These
leaks were found by running t0000 and t0001 under valgrind
(though certainly other similar leaks exist and just don't
happen to be exercised by those tests).

Initializing the lock_file's inner tempfile with NULL is not
strictly necessary in these cases, but it's a good practice
to model.  It means that if we were to call a function like
rollback_lock_file() on a lock that was never taken in the
first place, it becomes a quiet noop (rather than undefined
behavior).

Likewise, it's always safe to rollback_lock_file() on a file
that has already been committed or deleted, since that
operation is a noop on an inactive lockfile (and that's why
the case in config.c can drop the "if (lock)" check as we
move away from using a pointer).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/reset.c        |  6 +++---
 builtin/update-index.c | 11 ++++-------
 cache-tree.c           | 14 ++++----------
 config.c               | 24 +++++++-----------------
 4 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index d72c7d1c96..f1af9345e4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -367,8 +367,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die_if_unmerged_cache(reset_type);
 
 	if (reset_type != SOFT) {
-		struct lock_file *lock = xcalloc(1, sizeof(*lock));
-		hold_locked_index(lock, LOCK_DIE_ON_ERROR);
+		struct lock_file lock = LOCK_INIT;
+		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
@@ -384,7 +384,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
 
-		if (write_locked_index(&the_index, lock, COMMIT_LOCK))
+		if (write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die(_("Could not write new index file."));
 	}
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d562f2ec69..655e6d60d3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -915,7 +915,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
@@ -1014,11 +1014,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
 	/* we will diagnose later if it turns out that we need to update it */
-	newfd = hold_locked_index(lock_file, 0);
+	newfd = hold_locked_index(&lock_file, 0);
 	if (newfd < 0)
 		lock_error = errno;
 
@@ -1153,11 +1150,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				exit(128);
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
-		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
 	}
 
-	rollback_lock_file(lock_file);
+	rollback_lock_file(&lock_file);
 
 	return has_errors ? 1 : 0;
 }
diff --git a/cache-tree.c b/cache-tree.c
index 2690113a6a..71d092ed51 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -603,16 +603,10 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid, newfd;
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 	int ret = 0;
 
-	/*
-	 * We can't free this memory, it becomes part of a linked list
-	 * parsed atexit()
-	 */
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
-	newfd = hold_lock_file_for_update(lock_file, index_path, LOCK_DIE_ON_ERROR);
+	newfd = hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	entries = read_index_from(index_state, index_path);
 	if (entries < 0) {
@@ -632,7 +626,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 			goto out;
 		}
 		if (0 <= newfd) {
-			if (!write_locked_index(index_state, lock_file, COMMIT_LOCK))
+			if (!write_locked_index(index_state, &lock_file, COMMIT_LOCK))
 				newfd = -1;
 		}
 		/* Not being able to write is fine -- we are only interested
@@ -657,7 +651,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 
 out:
 	if (0 <= newfd)
-		rollback_lock_file(lock_file);
+		rollback_lock_file(&lock_file);
 	return ret;
 }
 
diff --git a/config.c b/config.c
index d0d8ce823a..7931182a54 100644
--- a/config.c
+++ b/config.c
@@ -2450,7 +2450,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 {
 	int fd = -1, in_fd = -1;
 	int ret;
-	struct lock_file *lock = NULL;
+	struct lock_file lock = LOCK_INIT;
 	char *filename_buf = NULL;
 	char *contents = NULL;
 	size_t contents_sz;
@@ -2469,8 +2469,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	lock = xcalloc(1, sizeof(struct lock_file));
-	fd = hold_lock_file_for_update(lock, config_filename, 0);
+	fd = hold_lock_file_for_update(&lock, config_filename, 0);
 	if (fd < 0) {
 		error_errno("could not lock config file %s", config_filename);
 		free(store.key);
@@ -2583,8 +2582,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		close(in_fd);
 		in_fd = -1;
 
-		if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
-			error_errno("chmod on %s failed", get_lock_file_path(lock));
+		if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
+			error_errno("chmod on %s failed", get_lock_file_path(&lock));
 			ret = CONFIG_NO_WRITE;
 			goto out_free;
 		}
@@ -2639,28 +2638,19 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		contents = NULL;
 	}
 
-	if (commit_lock_file(lock) < 0) {
+	if (commit_lock_file(&lock) < 0) {
 		error_errno("could not write config file %s", config_filename);
 		ret = CONFIG_NO_WRITE;
-		lock = NULL;
 		goto out_free;
 	}
 
-	/*
-	 * lock is committed, so don't try to roll it back below.
-	 * NOTE: Since lockfile.c keeps a linked list of all created
-	 * lock_file structures, it isn't safe to free(lock).  It's
-	 * better to just leave it hanging around.
-	 */
-	lock = NULL;
 	ret = 0;
 
 	/* Invalidate the config cache */
 	git_config_clear();
 
 out_free:
-	if (lock)
-		rollback_lock_file(lock);
+	rollback_lock_file(&lock);
 	free(filename_buf);
 	if (contents)
 		munmap(contents, contents_sz);
@@ -2669,7 +2659,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	return ret;
 
 write_err_out:
-	ret = write_error(get_lock_file_path(lock));
+	ret = write_error(get_lock_file_path(&lock));
 	goto out_free;
 
 }
-- 
2.14.1.721.gc5bc1565f1
