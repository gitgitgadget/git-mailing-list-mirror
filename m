Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636441FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 19:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbcLGTlP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 14:41:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63079 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752524AbcLGTlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 14:41:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6F155578C;
        Wed,  7 Dec 2016 14:41:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=IZSc
        1aR6FMjW2ELvp8I0irIDQNY=; b=iiyJdcenY5FvIDq/QMSA+AmgepOWorOO1QVd
        HdZ+p8Ezw32q5nALcWeuhCvfOTiYq5fSonNdkaECSp+UlAKP0FVnTZPOusfyKR7k
        ju3u6/rVrYbjxtepIwGzlCfMtjsmW3cvo4fBxTN5aOej9ah5sPdppK+khhvyMI/c
        hTXAtgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        SKZrHlGF0yoRlB9KDqQPv5Avlc6afF0QIcfDq1pxIW3XKKWgSBP21nn6y1aFJZeF
        29ThngrNyYWSPgVgs2++qggxNWsWlDaKabX5R8i2uE8ogLAZhDIM5SI9zvXMjppg
        IhihRqdJbHcYchgpmT4hl3jGW4H26V+VV9/L1vyUYBM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF3EB5578B;
        Wed,  7 Dec 2016 14:41:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16DE855789;
        Wed,  7 Dec 2016 14:41:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Robbie Iannucci <iannucci@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/3] hold_locked_index(): align error handling with hold_lockfile_for_update()
Date:   Wed,  7 Dec 2016 11:41:04 -0800
Message-Id: <20161207194105.25780-3-gitster@pobox.com>
X-Mailer: git-send-email 2.11.0-274-g0631465056
In-Reply-To: <20161207194105.25780-1-gitster@pobox.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
 <20161207194105.25780-1-gitster@pobox.com>
X-Pobox-Relay-ID: 1A802D88-BCB5-11E6-9652-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers of the hold_locked_index() function pass 0 when they want to
prepare to write a new version of the index file without wishing to
die or emit an error message when the request fails (e.g. somebody
else already held the lock), and pass 1 when they want the call to
die upon failure.

This option is called LOCK_DIE_ON_ERROR by the underlying lockfile
API, and the hold_locked_index() function translates the paramter to
LOCK_DIE_ON_ERROR when calling the hold_lock_file_for_update().

Replace these hardcoded '1' with LOCK_DIE_ON_ERROR and stop
translating.  Callers other than the ones that are replaced with
this change pass '0' to the function; no behaviour change is
intended with this patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Among the callers of hold_locked_index() that passes 0:

 - diff.c::refresh_index_quietly() at the end of "git diff" is an
   opportunistic update; it leaks the lockfile structure but it is
   just before the program exits and nobody should care.

 - builtin/describe.c::cmd_describe(),
   builtin/commit.c::cmd_status(),
   sequencer.c::read_and_refresh_cache() are all opportunistic
   updates and they are OK.

 - builtin/update-index.c::cmd_update_index() takes a lock upfront
   but we may end up not needing to update the index (i.e. the
   entries may be fully up-to-date), in which case we do not need to
   issue an error upon failure to acquire the lock.  We do diagnose
   and die if we indeed need to update, so it is OK.

 - wt-status.c::require_clean_work_tree() IS BUGGY.  It asks
   silence, does not check the returned value.  Compare with
   callsites like cmd_describe() and cmd_status() to notice that it
   is wrong to call update_index_if_able() unconditionally.
---
 apply.c                          | 2 +-
 builtin/add.c                    | 2 +-
 builtin/am.c                     | 6 +++---
 builtin/checkout-index.c         | 2 +-
 builtin/checkout.c               | 4 ++--
 builtin/clone.c                  | 2 +-
 builtin/commit.c                 | 8 ++++----
 builtin/merge.c                  | 6 +++---
 builtin/mv.c                     | 2 +-
 builtin/read-tree.c              | 2 +-
 builtin/reset.c                  | 2 +-
 builtin/rm.c                     | 2 +-
 builtin/update-index.c           | 1 +
 merge-recursive.c                | 2 +-
 read-cache.c                     | 7 ++-----
 rerere.c                         | 2 +-
 sequencer.c                      | 2 +-
 t/helper/test-scrap-cache-tree.c | 2 +-
 18 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/apply.c b/apply.c
index 705cf562f0..2ed808d429 100644
--- a/apply.c
+++ b/apply.c
@@ -4688,7 +4688,7 @@ static int apply_patch(struct apply_state *state,
 								 state->index_file,
 								 LOCK_DIE_ON_ERROR);
 		else
-			state->newfd = hold_locked_index(state->lock_file, 1);
+			state->newfd = hold_locked_index(state->lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
diff --git a/builtin/add.c b/builtin/add.c
index e8fb80b36e..9f53f020d0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -361,7 +361,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	add_new_files = !take_worktree_changes && !refresh_only;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
-	hold_locked_index(&lock_file, 1);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
 		 (show_only ? ADD_CACHE_PRETEND : 0) |
diff --git a/builtin/am.c b/builtin/am.c
index 6981f42ce9..bb5da422fc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1119,7 +1119,7 @@ static void refresh_and_write_cache(void)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write index file"));
@@ -1976,7 +1976,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 		return -1;
 
 	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
 
 	refresh_cache(REFRESH_QUIET);
 
@@ -2016,7 +2016,7 @@ static int merge_tree(struct tree *tree)
 		return -1;
 
 	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 30a49d9f42..07631d0c9c 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -205,7 +205,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
 		state.istate = &the_index;
-		newfd = hold_locked_index(&lock_file, 1);
+		newfd = hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	/* Check out named files first */
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 512492aad9..bfe685c198 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -274,7 +274,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(&opts->pathspec) < 0)
 		return error(_("index file corrupt"));
 
@@ -467,7 +467,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	int ret;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(NULL) < 0)
 		return error(_("index file corrupt"));
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 6c76a6ed66..892bdbfe3f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -711,7 +711,7 @@ static int checkout(int submodule_progress)
 	setup_work_tree();
 
 	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, 1);
+	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
diff --git a/builtin/commit.c b/builtin/commit.c
index 8976c3d29b..b910e76017 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -351,7 +351,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 	if (interactive) {
 		char *old_index_env = NULL;
-		hold_locked_index(&index_lock, 1);
+		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 
 		refresh_cache_or_die(refresh_flags);
 
@@ -396,7 +396,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
-		hold_locked_index(&index_lock, 1);
+		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
@@ -416,7 +416,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 * We still need to refresh the index here.
 	 */
 	if (!only && !pathspec.nr) {
-		hold_locked_index(&index_lock, 1);
+		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed
 		    || !cache_tree_fully_valid(active_cache_tree))
@@ -468,7 +468,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (read_cache() < 0)
 		die(_("cannot read the index"));
 
-	hold_locked_index(&index_lock, 1);
+	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 	update_main_cache_tree(WRITE_TREE_SILENT);
diff --git a/builtin/merge.c b/builtin/merge.c
index b65eeaa87d..0070bf2556 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -634,7 +634,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 {
 	static struct lock_file lock;
 
-	hold_locked_index(&lock, 1);
+	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
@@ -671,7 +671,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
 
-		hold_locked_index(&lock, 1);
+		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
 		if (clean < 0)
@@ -781,7 +781,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	struct commit_list *parents, **pptr = &parents;
 	static struct lock_file lock;
 
-	hold_locked_index(&lock, 1);
+	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
diff --git a/builtin/mv.c b/builtin/mv.c
index 2f43877bc9..43adf92ba6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -126,7 +126,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (--argc < 1)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
 
-	hold_locked_index(&lock_file, 1);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9bd1fd755e..fa6edb35b2 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -150,7 +150,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	hold_locked_index(&lock_file, 1);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
diff --git a/builtin/reset.c b/builtin/reset.c
index c04ac076dc..8ab915bfcb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -354,7 +354,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (reset_type != SOFT) {
 		struct lock_file *lock = xcalloc(1, sizeof(*lock));
-		hold_locked_index(lock, 1);
+		hold_locked_index(lock, LOCK_DIE_ON_ERROR);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
diff --git a/builtin/rm.c b/builtin/rm.c
index 3f3e24eb36..7f15a3d7f8 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -292,7 +292,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only)
 		setup_work_tree();
 
-	hold_locked_index(&lock_file, 1);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f3f07e7f1c..d530e89368 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1012,6 +1012,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
+	/* we will diagnose later if it turns out that we need to update it */
 	newfd = hold_locked_index(lock_file, 0);
 	if (newfd < 0)
 		lock_error = errno;
diff --git a/merge-recursive.c b/merge-recursive.c
index 9041c2f149..8442068716 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2124,7 +2124,7 @@ int merge_recursive_generic(struct merge_options *o,
 		}
 	}
 
-	hold_locked_index(lock, 1);
+	hold_locked_index(lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
 	if (clean < 0)
diff --git a/read-cache.c b/read-cache.c
index db5d910642..f92a912dcb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1425,12 +1425,9 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
-int hold_locked_index(struct lock_file *lk, int die_on_error)
+int hold_locked_index(struct lock_file *lk, int lock_flags)
 {
-	return hold_lock_file_for_update(lk, get_index_file(),
-					 die_on_error
-					 ? LOCK_DIE_ON_ERROR
-					 : 0);
+	return hold_lock_file_for_update(lk, get_index_file(), lock_flags);
 }
 
 int read_index(struct index_state *istate)
diff --git a/rerere.c b/rerere.c
index 5d083ca572..3bd55caf3b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -708,7 +708,7 @@ static void update_paths(struct string_list *update)
 {
 	int i;
 
-	hold_locked_index(&index_lock, 1);
+	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
diff --git a/sequencer.c b/sequencer.c
index 30b10ba143..7fc1e2a5df 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -370,7 +370,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	char **xopt;
 	static struct lock_file index_lock;
 
-	hold_locked_index(&index_lock, 1);
+	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 
 	read_cache();
 
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 27fe0405b8..d2a63bea43 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -8,7 +8,7 @@ static struct lock_file index_lock;
 int cmd_main(int ac, const char **av)
 {
 	setup_git_directory();
-	hold_locked_index(&index_lock, 1);
+	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	if (read_cache() < 0)
 		die("unable to read index file");
 	active_cache_tree = NULL;
-- 
2.11.0-274-g0631465056

