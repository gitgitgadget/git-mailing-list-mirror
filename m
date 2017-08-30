Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6031F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 05:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750802AbdH3Fzm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 01:55:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:52594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750758AbdH3Fzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 01:55:41 -0400
Received: (qmail 2351 invoked by uid 109); 30 Aug 2017 05:55:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 05:55:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16063 invoked by uid 111); 30 Aug 2017 05:56:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 01:56:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Aug 2017 01:55:39 -0400
Date:   Wed, 30 Aug 2017 01:55:39 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170830055539.xpgxeu3flmxs55av@sigill.intra.peff.net>
References: <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 12:55:55AM -0400, Jeff King wrote:

> > I feel like right now we meet (1) and not (2). But I think if we keep to
> > that lower bar of (1), it might not be that bad. We're assuming now that
> > there's no race on the tempfile->active flag, for instance. We could
> > probably make a similar assumption about putting items onto or taking
> > them off of a linked list (it's not really atomic, but a single pointer
> > assignment is probably "atomic enough" for our purposes).
> 
> Something like this, which AFAICT is about as safe as the existing code
> in its list manipulation. It retains the "active" flag as an additional
> check which I think isn't strictly necessary, but potentially catches
> some logic errors.

The patch below demonstrates how this could be used to turn some
"xcalloc" lock_files into stack variables that are allowed to go out of
scope after we commit or rollback. This solves the three lock-related
leaks reported by valgrind when running t0000.

_But_ it also demonstrates an interesting downside of this approach.
Some functions are lazy in their error paths. For instance, look at
write_index_as_tree(). We take the lock early in the function, but may
return before a commit or rollback if we hit an error.  With the current
code this "leaks" the tempfile, which is wrong. But nobody notices
because in practice the program exits soon after and we clean up the
tempfile then.

But with a stack variable lock_file, that minor problem becomes a major
one: our stack variable got added to a global linked list and the
atexit() handler will try to read it. But now of course it will contain
garbage, since the variable went out of scope.

So it's probably safer to just let tempfile.c handle the whole lifetime,
and have it put all live tempfiles on the heap, and free them when
they're deactivated. That means our creation signature becomes more
like:

  struct tempfile *create_tempfile(const char *path);

and delete_tempfile() actually calls free() on it (though we'd probably
want to skip the free() from a signal handler for the usual reasons).

I don't have a patch for that, but just food for thought while exploring
the implications of my earlier suggestion.

---
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d955cd56b3..bf7420b808 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -917,7 +917,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
@@ -1016,11 +1016,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
 	/* we will diagnose later if it turns out that we need to update it */
-	newfd = hold_locked_index(lock_file, 0);
+	newfd = hold_locked_index(&lock_file, 0);
 	if (newfd < 0)
 		lock_error = errno;
 
@@ -1155,11 +1152,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
index 2440d1dc89..440f92aeca 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -603,19 +603,15 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid, newfd;
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 
-	/*
-	 * We can't free this memory, it becomes part of a linked list
-	 * parsed atexit()
-	 */
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
-	newfd = hold_lock_file_for_update(lock_file, index_path, LOCK_DIE_ON_ERROR);
+	newfd = hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	entries = read_index_from(index_state, index_path);
-	if (entries < 0)
+	if (entries < 0) {
+		rollback_lock_file(&lock_file);
 		return WRITE_TREE_UNREADABLE_INDEX;
+	}
 	if (flags & WRITE_TREE_IGNORE_CACHE_TREE)
 		cache_tree_free(&index_state->cache_tree);
 
@@ -624,10 +620,12 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 
 	was_valid = cache_tree_fully_valid(index_state->cache_tree);
 	if (!was_valid) {
-		if (cache_tree_update(index_state, flags) < 0)
+		if (cache_tree_update(index_state, flags) < 0) {
+			rollback_lock_file(&lock_file);
 			return WRITE_TREE_UNMERGED_INDEX;
+		}
 		if (0 <= newfd) {
-			if (!write_locked_index(index_state, lock_file, COMMIT_LOCK))
+			if (!write_locked_index(index_state, &lock_file, COMMIT_LOCK))
 				newfd = -1;
 		}
 		/* Not being able to write is fine -- we are only interested
@@ -641,15 +639,17 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 	if (prefix) {
 		struct cache_tree *subtree;
 		subtree = cache_tree_find(index_state->cache_tree, prefix);
-		if (!subtree)
+		if (!subtree) {
+			rollback_lock_file(&lock_file);
 			return WRITE_TREE_PREFIX_ERROR;
+		}
 		hashcpy(sha1, subtree->oid.hash);
 	}
 	else
 		hashcpy(sha1, index_state->cache_tree->oid.hash);
 
 	if (0 <= newfd)
-		rollback_lock_file(lock_file);
+		rollback_lock_file(&lock_file);
 
 	return 0;
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
diff --git a/lockfile.h b/lockfile.h
index 572064939c..a7ba42bdf2 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -114,6 +114,8 @@ struct lock_file {
 	struct tempfile tempfile;
 };
 
+#define LOCK_INIT { { NULL } }
+
 /* String appended to a filename to derive the lockfile name: */
 #define LOCK_SUFFIX ".lock"
 #define LOCK_SUFFIX_LEN 5
