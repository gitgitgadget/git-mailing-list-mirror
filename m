Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F0B20964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdDBEgG (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:36:06 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36712 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdDBEgF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:36:05 -0400
Received: by mail-qk0-f195.google.com with SMTP id r140so4225152qke.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 21:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bX0lMWXa2wmhWE605UptS70J7b94gyknE9znwk3YF9Q=;
        b=FCIS69qPDKpQGAhalYn5M4r1CgUhE5J8tA4Iz+GX6PMcYzvHh9Ov8QNjMOnNBXM+6+
         rMRxFFjot0H3T8F0eU4xpv6dyCPYSwrbsjJAOQCiCMwKiMnWopPZN2Tsb1gODWu6naC5
         tWB4TcL2HMnTRr1UIk/D01yz+tHp064LVvVtCRPjBTxvvJlaURU+BU606CGbH0Lky16B
         49geVfQ6Q/jB1aTNDr417BkVs6i7f74YOOENa93Vz7uvFTQ1UY2gasOAJojshuRjxkYI
         3KQrUR3y/E29o2kwIbB9ydcFhIXfLL+RFSR1g1FYJZiTzenznRbiPTgKlXHoKUgfgLUD
         QQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bX0lMWXa2wmhWE605UptS70J7b94gyknE9znwk3YF9Q=;
        b=JiEH0FFMVPW//GUXP7uhqrn6DXNaR3Cm8wbyqR3kW5MKgW0VtlX1ysCtCPV9kDQsQB
         LlDrVdYC2tWZcE2SnDqQKLK3oQNxJYvAq8SJmU4aNRVxGmhfpinSL5/dNSzp06WxC7Jy
         yp3McQt2fXZ2En0+qbA+jOZ4Kg22kh6ACtLMxzkSOUxD6UG8/EqYh6w+DL24QFgCl0kH
         2Iavr24lAcBh8uA8cOqIIlr9/FhsNFLJrJsu4C6wQxOhOwl1jLTW7GHOaf6UpJ700VBX
         UymUzZzyBgAbr0lXi9SYVBYYm7Unu91ZXuBy0CLHgwJRZ6kyX/HXaqWjgBLJSh4q2zHC
         W+Cg==
X-Gm-Message-State: AFeK/H1V6BNqY4of+WAouRoRhrS+aMPT/kOka3gUMC9641EuYU+jGJMGrghZVXsePMDFog==
X-Received: by 10.55.15.144 with SMTP id 16mr5974198qkp.42.1491107764101;
        Sat, 01 Apr 2017 21:36:04 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id t23sm6907383qka.37.2017.04.01.21.35.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Apr 2017 21:36:03 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, peff@peff.net,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v6 4/5] dir_iterator: refactor state machine model
Date:   Sun,  2 Apr 2017 01:35:25 -0300
Message-Id: <1491107726-21504-5-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
References: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perform major refactor of dir_iterator_advance(). dir_iterator has
ceased to rely on a convoluted state machine mechanism of two loops and
two state variables (level.initialized and level.dir_state). This serves
to ease comprehension of the iterator mechanism and ease addition of new
features to the iterator.

Create an option for the dir_iterator API to iterate over subdirectories
only after having iterated through their contents. This feature was
predicted, although not implemented by 0fe5043 ("dir_iterator: new API
for iterating over a directory tree", 2016-06-18). This is useful for
recursively removing a directory and calling rmdir() on a directory only
after all of its contents have been wiped.

Add an option for the dir_iterator API to iterate over the root
directory (the one it was initialized with) as well.

Add the "flags" parameter to dir_iterator_create, allowing for the
aforementioned new features to be enabled. The new default behavior
(i.e. flags set to 0) does not iterate over directories. Flag
DIR_ITERATOR_PRE_ORDER_TRAVERSAL iterates over a directory before doing
so over its contents. DIR_ITERATOR_POST_ORDER_TRAVERSAL iterates over a
directory after doing so over its contents. DIR_ITERATOR_LIST_ROOT_DIR
iterates over the root directory. These flags do not conflict with each
other and may be used simultaneously.

Amend a call to dir_iterator_begin() in refs/files-backend.c to pass
the flags parameter introduced.

Improve t/t0065-dir-iterator.sh and t/helper/test-dir-iterator.c to
test "post-order" and "iterate-over-root" modes.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c               | 149 +++++++++++++++++++++++++++----------------
 dir-iterator.h               |  28 ++++++--
 refs/files-backend.c         |   2 +-
 t/helper/test-dir-iterator.c |   6 +-
 t/t0065-dir-iterator.sh      |  61 +++++++++++++++++-
 5 files changed, 179 insertions(+), 67 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index ce8bf81..4b23889 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -4,8 +4,6 @@
 #include "dir-iterator.h"
 
 struct dir_iterator_level {
-	int initialized;
-
 	DIR *dir;
 
 	/*
@@ -20,8 +18,11 @@ struct dir_iterator_level {
 	 * iteration and also iterated into):
 	 */
 	enum {
-		DIR_STATE_ITER,
-		DIR_STATE_RECURSE
+		DIR_STATE_PUSHED,
+		DIR_STATE_PRE_ITERATION,
+		DIR_STATE_ITERATING,
+		DIR_STATE_POST_ITERATION,
+		DIR_STATE_EXHAUSTED
 	} dir_state;
 };
 
@@ -48,15 +49,20 @@ struct dir_iterator_int {
 	 * that will be included in this iteration.
 	 */
 	struct dir_iterator_level *levels;
+
+	/* Holds the flags passed to dir_iterator_begin(). */
+	unsigned flags;
 };
 
 static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
 {
-	level->dir_state = DIR_STATE_RECURSE;
 	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
 		   iter->levels_alloc);
+
+	/* Push a new level */
 	level = &iter->levels[iter->levels_nr++];
-	level->initialized = 0;
+	level->dir = NULL;
+	level->dir_state = DIR_STATE_PUSHED;
 }
 
 static inline int pop_dir_level(struct dir_iterator_int *iter)
@@ -75,18 +81,35 @@ static inline int set_iterator_data(struct dir_iterator_int *iter, struct dir_it
 	}
 
 	/*
-	 * We have to set these each time because
-	 * the path strbuf might have been realloc()ed.
+	 * Check if we are dealing with the root directory as an
+	 * item that's being iterated through.
 	 */
-	iter->base.relative_path =
-		iter->base.path.buf + iter->levels[0].prefix_len;
+	if (level->dir_state != DIR_STATE_ITERATING &&
+		iter->levels_nr == 1) {
+		iter->base.relative_path = ".";
+	}
+	else {
+		iter->base.relative_path =
+			iter->base.path.buf + iter->levels[0].prefix_len;
+	}
 	iter->base.basename =
 		iter->base.path.buf + level->prefix_len;
-	level->dir_state = DIR_STATE_ITER;
 
 	return 0;
 }
 
+/*
+ * This function uses a state machine with the following states:
+ * -> DIR_STATE_PUSHED: the directory has been pushed to the
+ * iterator traversal tree.
+ * -> DIR_STATE_PRE_ITERATION: the directory is *NOT* initialized. The
+ * dirpath has already been returned if pre-order traversal is set.
+ * -> DIR_STATE_ITERATING: the directory is initialized. We are traversing
+ * through it.
+ * -> DIR_STATE_POST_ITERATION: the directory has been iterated through.
+ * We are ready to close it.
+ * -> DIR_STATE_EXHAUSTED: the directory is closed and ready to be popped.
+ */
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
 {
 	struct dir_iterator_int *iter =
@@ -97,7 +120,18 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			&iter->levels[iter->levels_nr - 1];
 		struct dirent *de;
 
-		if (!level->initialized) {
+		if (level->dir_state == DIR_STATE_PUSHED) {
+			level->dir_state = DIR_STATE_PRE_ITERATION;
+
+			if (iter->flags & DIR_ITERATOR_PRE_ORDER_TRAVERSAL) {
+				/* We may not want the root directory to be iterated over */
+				if (iter->levels_nr != 1 ||
+					(iter->flags & DIR_ITERATOR_LIST_ROOT_DIR)) {
+					set_iterator_data(iter, level);
+					return ITER_OK;
+				}
+			}
+		} else if (level->dir_state == DIR_STATE_PRE_ITERATION) {
 			/*
 			 * Note: dir_iterator_begin() ensures that
 			 * path is not the empty string.
@@ -108,63 +142,32 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 
 			level->dir = opendir(iter->base.path.buf);
 			if (!level->dir && errno != ENOENT) {
+				/*
+				 * This level wasn't opened sucessfully; pretend we
+				 * iterated through it already.
+				 */
 				warning("error opening directory %s: %s",
 					iter->base.path.buf, strerror(errno));
-				/* Popping the level is handled below */
-			}
 
-			level->initialized = 1;
-		} else if (S_ISDIR(iter->base.st.st_mode)) {
-			if (level->dir_state == DIR_STATE_ITER) {
-				/*
-				 * The directory was just iterated
-				 * over; now prepare to iterate into
-				 * it.
-				 */
-				push_dir_level(iter, level);
+				level->dir_state = DIR_STATE_POST_ITERATION;
 				continue;
-			} else {
-				/*
-				 * The directory has already been
-				 * iterated over and iterated into;
-				 * we're done with it.
-				 */
 			}
-		}
 
-		if (!level->dir) {
-			/*
-			 * This level is exhausted (or wasn't opened
-			 * successfully); pop up a level.
-			 */
-			if (pop_dir_level(iter) == 0)
-				return dir_iterator_abort(dir_iterator);
-
-			continue;
-		}
-
-		/*
-		 * Loop until we find an entry that we can give back
-		 * to the caller:
-		 */
-		while (1) {
+			level->dir_state = DIR_STATE_ITERATING;
+		} else if (level->dir_state == DIR_STATE_ITERATING) {
 			strbuf_setlen(&iter->base.path, level->prefix_len);
 			errno = 0;
 			de = readdir(level->dir);
 
 			if (!de) {
-				/* This level is exhausted; pop up a level. */
+				/* In case of readdir() error */
 				if (errno) {
 					warning("error reading directory %s: %s",
 						iter->base.path.buf, strerror(errno));
-				} else if (closedir(level->dir))
-					warning("error closing directory %s: %s",
-						iter->base.path.buf, strerror(errno));
+				}
 
-				level->dir = NULL;
-				if (pop_dir_level(iter) == 0)
-					return dir_iterator_abort(dir_iterator);
-				break;
+				level->dir_state = DIR_STATE_POST_ITERATION;
+				continue;
 			}
 
 			if (is_dot_or_dotdot(de->d_name))
@@ -175,7 +178,38 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			if (set_iterator_data(iter, level))
 				continue;
 
+			if (S_ISDIR(iter->base.st.st_mode)) {
+				push_dir_level(iter, level);
+				continue;
+			}
+
 			return ITER_OK;
+		} else if (level->dir_state == DIR_STATE_POST_ITERATION) {
+			if (level->dir != NULL && closedir(level->dir)) {
+				warning("error closing directory %s: %s",
+					iter->base.path.buf, strerror(errno));
+			}
+			level->dir_state = DIR_STATE_EXHAUSTED;
+
+			strbuf_setlen(&iter->base.path, level->prefix_len);
+			/*
+			 * Since we are iterating through the dirpath
+			 * after we have gone through it, we still need
+			 * to get rid of the trailing slash we appended.
+			 */
+			strbuf_strip_suffix(&iter->base.path, "/");
+
+			if (iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL) {
+				/* We may not want the root directory to be iterated over */
+				if (iter->levels_nr != 1 ||
+					(iter->flags & DIR_ITERATOR_LIST_ROOT_DIR)) {
+					set_iterator_data(iter, level);
+					return ITER_OK;
+				}
+			}
+		} else if (level->dir_state == DIR_STATE_EXHAUSTED) {
+			if (pop_dir_level(iter) == 0)
+				return dir_iterator_abort(dir_iterator);
 		}
 	}
 }
@@ -201,7 +235,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 	return ITER_DONE;
 }
 
-struct dir_iterator *dir_iterator_begin(const char *path)
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
 {
 	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
 	struct dir_iterator *dir_iterator = &iter->base;
@@ -209,13 +243,16 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 	if (!path || !*path)
 		die("BUG: empty path passed to dir_iterator_begin()");
 
+	iter->flags = flags;
+
 	strbuf_init(&iter->base.path, PATH_MAX);
 	strbuf_addstr(&iter->base.path, path);
 
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 
 	iter->levels_nr = 1;
-	iter->levels[0].initialized = 0;
+	iter->levels[0].dir = NULL;
+	iter->levels[0].dir_state = DIR_STATE_PUSHED;
 
 	return dir_iterator;
 }
diff --git a/dir-iterator.h b/dir-iterator.h
index 27739e6..0e82f36 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -11,13 +11,12 @@
  * Every time dir_iterator_advance() is called, update the members of
  * the dir_iterator structure to reflect the next path in the
  * iteration. The order that paths are iterated over within a
- * directory is undefined, but directory paths are always iterated
- * over before the subdirectory contents.
+ * directory is undefined.
  *
  * A typical iteration looks like this:
  *
  *     int ok;
- *     struct iterator *iter = dir_iterator_begin(path);
+ *     struct iterator *iter = dir_iterator_begin(path, flags);
  *
  *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
  *             if (want_to_stop_iteration()) {
@@ -38,6 +37,22 @@
  * dir_iterator_advance() again.
  */
 
+/*
+ * Possible flags for dir_iterator_begin().
+ *
+ * -> DIR_ITERATOR_PRE_ORDER_TRAVERSAL: the iterator shall return
+ * a dirpath it has found before iterating through that directory's
+ * contents.
+ * -> DIR_ITERATOR_POST_ORDER_TRAVERSAL: the iterator shall return
+ * a dirpath it has found after iterating through that directory's
+ * contents.
+ * -> DIR_ITERATOR_LIST_ROOT_DIR: the iterator shall return the dirpath
+ * of the root directory it is iterating through.
+ */
+#define DIR_ITERATOR_PRE_ORDER_TRAVERSAL (1 << 0)
+#define DIR_ITERATOR_POST_ORDER_TRAVERSAL (1 << 1)
+#define DIR_ITERATOR_LIST_ROOT_DIR (1 << 2)
+
 struct dir_iterator {
 	/* The current path: */
 	struct strbuf path;
@@ -57,15 +72,16 @@ struct dir_iterator {
 };
 
 /*
- * Start a directory iteration over path. Return a dir_iterator that
- * holds the internal state of the iteration.
+ * Start a directory iteration over path, with options specified in
+ * 'flags'. Return a dir_iterator that holds the internal state of
+ * the iteration.
  *
  * The iteration includes all paths under path, not including path
  * itself and not including "." or ".." entries.
  *
  * path is the starting directory. An internal copy will be made.
  */
-struct dir_iterator *dir_iterator_begin(const char *path);
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags);
 
 /*
  * Advance the iterator to the first or next item and return ITER_OK.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50188e9..b4bba74 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3346,7 +3346,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	files_downcast(ref_store, 0, "reflog_iterator_begin");
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
+	iter->dir_iterator = dir_iterator_begin(git_path("logs"), 0);
 	return ref_iterator;
 }
 
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index 06f03fc..a1b8c78 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -6,6 +6,7 @@
 int cmd_main(int argc, const char **argv) {
 	struct strbuf path = STRBUF_INIT;
 	struct dir_iterator *diter;
+	unsigned flag = DIR_ITERATOR_PRE_ORDER_TRAVERSAL;
 
 	if (argc < 2) {
 		return 1;
@@ -13,7 +14,10 @@ int cmd_main(int argc, const char **argv) {
 
 	strbuf_add(&path, argv[1], strlen(argv[1]));
 
-	diter = dir_iterator_begin(path.buf);
+	if (argc == 3)
+		flag = atoi(argv[2]);
+
+	diter = dir_iterator_begin(path.buf, flag);
 
 	while (dir_iterator_advance(diter) == ITER_OK) {
 		if (S_ISDIR(diter->st.st_mode))
diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
index b857c07..ade3ee0 100755
--- a/t/t0065-dir-iterator.sh
+++ b/t/t0065-dir-iterator.sh
@@ -28,12 +28,28 @@ test_expect_success 'dir-iterator should iterate through all files' '
 	>dir/a/e &&
 	>dir/d/e/d/a &&
 
-	test-dir-iterator ./dir | sort >./actual-pre-order-sorted-output &&
+	test-dir-iterator ./dir 1 | sort >./actual-pre-order-sorted-output &&
 	rm -rf dir &&
 
 	test_cmp expect-sorted-output actual-pre-order-sorted-output
 '
 
+test_expect_success 'dir-iterator should iterate through all files on post-order mode' '
+	mkdir -p dir &&
+	mkdir -p dir/a/b/c/ &&
+	>dir/b &&
+	>dir/c &&
+	mkdir -p dir/d/e/d/ &&
+	>dir/a/b/c/d &&
+	>dir/a/e &&
+	>dir/d/e/d/a &&
+
+	test-dir-iterator ./dir 2 | sort >actual-post-order-sorted-output &&
+	rm -rf dir &&
+
+	test_cmp expect-sorted-output actual-post-order-sorted-output
+'
+
 cat >expect-pre-order-output <<-\EOF &&
 [d] (a) ./dir/a
 [d] (a/b) ./dir/a/b
@@ -41,14 +57,53 @@ cat >expect-pre-order-output <<-\EOF &&
 [f] (a/b/c/d) ./dir/a/b/c/d
 EOF
 
-test_expect_success 'dir-iterator should list files in the correct order' '
+test_expect_success 'dir-iterator should list files properly on pre-order mode' '
 	mkdir -p dir/a/b/c/ &&
 	>dir/a/b/c/d &&
 
-	test-dir-iterator ./dir >actual-pre-order-output &&
+	test-dir-iterator ./dir 1 >actual-pre-order-output &&
 	rm -rf dir &&
 
 	test_cmp expect-pre-order-output actual-pre-order-output
 '
 
+cat >expect-post-order-output <<-\EOF &&
+[f] (a/b/c/d) ./dir/a/b/c/d
+[d] (a/b/c) ./dir/a/b/c
+[d] (a/b) ./dir/a/b
+[d] (a) ./dir/a
+EOF
+
+test_expect_success 'dir-iterator should list files properly on post-order mode' '
+	mkdir -p dir/a/b/c/ &&
+	>dir/a/b/c/d &&
+
+	test-dir-iterator ./dir 2 >actual-post-order-output &&
+	rm -rf dir &&
+
+	test_cmp expect-post-order-output actual-post-order-output
+'
+
+cat >expect-pre-order-post-order-root-dir-output <<-\EOF &&
+[d] (.) ./dir
+[d] (a) ./dir/a
+[d] (a/b) ./dir/a/b
+[d] (a/b/c) ./dir/a/b/c
+[f] (a/b/c/d) ./dir/a/b/c/d
+[d] (a/b/c) ./dir/a/b/c
+[d] (a/b) ./dir/a/b
+[d] (a) ./dir/a
+[d] (.) ./dir
+EOF
+
+test_expect_success 'dir-iterator should list files properly on pre-order + post-order + root-dir mode' '
+	mkdir -p dir/a/b/c/ &&
+	>dir/a/b/c/d &&
+
+	test-dir-iterator ./dir 7 >actual-pre-order-post-order-root-dir-output &&
+	rm -rf dir &&
+
+	test_cmp expect-pre-order-post-order-root-dir-output actual-pre-order-post-order-root-dir-output
+'
+
 test_done
-- 
2.7.4 (Apple Git-66)

