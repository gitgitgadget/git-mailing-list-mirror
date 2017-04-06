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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6953020966
	for <e@80x24.org>; Thu,  6 Apr 2017 01:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756620AbdDFBju (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 21:39:50 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35325 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756619AbdDFBjt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 21:39:49 -0400
Received: by mail-qk0-f193.google.com with SMTP id k139so4063513qke.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 18:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uz2QLQeETF3E9uI2Zm/g50To1U0UGrke+Eidi2fbbss=;
        b=Jl0qffRqqsHXNvMcPBXOAqEwnpXmFdHeVcmu9cHLmcqip+37whOQ5dICNT51FjaA8i
         G5XPANHkYF31+kr079oxKlDe/6hhAFIrjAO6jVT961u46iBFQy6LLNb1X4qcRGDjgVOx
         9uesXWOGEbWPlP4+n+jqxnGJIRiKktw1Bw9U18JPXJSsfDPMJWsIyWbNv6cs8T0Z4H+B
         y8Y//aYWOFVCEWBE/fYW7FkdkTM1C5DWs2K8s7GhXsTPQ+5SonhA9pJK9on14ev0AINN
         1Bc/rm6r93TZzbJhvhPjbs1TYiaAZkNX0R5cn6A7mJIldypB0pGBgpzX74ULsimgsyyo
         Tpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uz2QLQeETF3E9uI2Zm/g50To1U0UGrke+Eidi2fbbss=;
        b=ZSLV0W0bcTLGr2SgmanxrQorJzTyXx7zKAIH9UqM+IgODQajNDeWaLCdiJ0wlLHbvI
         dZC8jWmfWFLcXe+fiNKnIE6hCxUKZSlDq/cUdEnl8WUWAS430uIWGjcL0DtPpNTuXb5D
         5H3IliF5hkELy+lLZM7myJ2w1HqBu3xFgvHJTKWRcLlO22Ct4mmMIbI77gbOFgz3+adj
         FFWqfO2KN93wpWotefPqctWfs7IJ2YSrjTchayJ5QiLDDkp2vjqC5302GLOsYZlg1N2/
         1+UH4tESGHScvhi3iFJSpb+Vfj7f2kNWlEjhdRQU0tcN2292frbIKK5E7/8wbE6HFoF/
         V+0A==
X-Gm-Message-State: AFeK/H2jRagrYyvVD44+08XtY/HpJPlPQvDToHbQLtu2N+91tWwQunBeSeAgpRTeVRonRg==
X-Received: by 10.55.151.199 with SMTP id z190mr33337580qkd.138.1491442787964;
        Wed, 05 Apr 2017 18:39:47 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id b78sm58718qkc.50.2017.04.05.18.39.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 18:39:46 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v8 4/5] dir_iterator: refactor state machine model
Date:   Wed,  5 Apr 2017 22:39:26 -0300
Message-Id: <1491442767-54068-5-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
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
 dir-iterator.c               | 216 ++++++++++++++++++++++++++++++-------------
 dir-iterator.h               |  35 +++++--
 refs/files-backend.c         |   2 +-
 t/helper/test-dir-iterator.c |  27 +++++-
 t/t0065-dir-iterator.sh      |  44 ++++++++-
 5 files changed, 245 insertions(+), 79 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 9e073a0..4c919d1 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -4,8 +4,6 @@
 #include "dir-iterator.h"
 
 struct dir_iterator_level {
-	int initialized;
-
 	DIR *dir;
 
 	/*
@@ -20,9 +18,20 @@ struct dir_iterator_level {
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
+
+	/*
+	 * The stat structure for the directory this level represents.
+	 * It comes with a st_is_set flag which indicates whether it is,
+	 * in fact, set.
+	 */
+	unsigned st_is_set : 1;
+	struct stat st;
 };
 
 /*
@@ -48,15 +57,23 @@ struct dir_iterator_int {
 	 * that will be included in this iteration.
 	 */
 	struct dir_iterator_level *levels;
+
+	/* Holds the flags passed to dir_iterator_begin(). */
+	unsigned flags;
 };
 
-static void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+static void push_dir_level(struct dir_iterator_int *iter,
+		struct dir_iterator_level *level, struct stat *st)
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
+	level->st_is_set = 1;
+	level->st = *st;
 }
 
 static int pop_dir_level(struct dir_iterator_int *iter)
@@ -64,29 +81,73 @@ static int pop_dir_level(struct dir_iterator_int *iter)
 	return --iter->levels_nr;
 }
 
-static int set_iterator_data(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+static int set_iterator_data(struct dir_iterator_int *iter,
+		struct dir_iterator_level *level)
 {
-	if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
+	char *last_path_component;
+
+	if (level->dir_state != DIR_STATE_ITERATING && level->st_is_set) {
+		iter->base.st = level->st;
+	} else if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
 		if (errno != ENOENT)
 			warning("error reading path '%s': %s",
 				iter->base.path.buf,
 				strerror(errno));
+		else if (!level->st_is_set) {
+			/*
+			 * When we are iterating over the root directory, we
+			 * are forced to initialize the level stat here, since
+			 * we cannot lstat() on dir_iterator_begin() before pushing
+			 * the root level.
+			 */
+			level->st = iter->base.st;
+			level->st_is_set = 1;
+		}
+
 		return -1;
 	}
 
 	/*
-	 * We have to set these each time because
-	 * the path strbuf might have been realloc()ed.
+	 * Check if we are dealing with the root directory as an
+	 * item that's being iterated through.
 	 */
-	iter->base.relative_path =
-		iter->base.path.buf + iter->levels[0].prefix_len;
-	iter->base.basename =
-		iter->base.path.buf + level->prefix_len;
-	level->dir_state = DIR_STATE_ITER;
+	if (level->dir_state != DIR_STATE_ITERATING &&
+		iter->levels_nr == 1) {
+		iter->base.relative_path = ".";
+
+		/* If we have a path like './dir', we'll get everything
+		 * after the last slash a basename. If we don't find a
+		 * slash (e.g. 'dir'), we return the whole path. */
+		last_path_component = strrchr(iter->base.path.buf, '/');
+		iter->base.basename = last_path_component ?
+			last_path_component + 1 : iter->base.path.buf;
+	} else {
+		iter->base.relative_path =
+			iter->base.path.buf + iter->levels[0].prefix_len;
+
+		if (S_ISDIR(iter->base.st.st_mode))
+			iter->base.basename =
+				iter->base.path.buf + iter->levels[iter->levels_nr - 2].prefix_len;
+		else
+			iter->base.basename =
+				iter->base.path.buf + level->prefix_len;
+	}
 
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
@@ -97,7 +158,26 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
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
+					/*
+					 * This will only error if we fail to lstat() the
+					 * root directory. In this case, we bail.
+					 */
+					if (set_iterator_data(iter, level)) {
+						level->dir_state = DIR_STATE_EXHAUSTED;
+						continue;
+					}
+
+					return ITER_OK;
+				}
+			}
+		} else if (level->dir_state == DIR_STATE_PRE_ITERATION) {
 			/*
 			 * Note: dir_iterator_begin() ensures that
 			 * path is not the empty string.
@@ -107,64 +187,35 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			level->prefix_len = iter->base.path.len;
 
 			level->dir = opendir(iter->base.path.buf);
-			if (!level->dir && errno != ENOENT) {
-				warning("error opening directory %s: %s",
-					iter->base.path.buf, strerror(errno));
-				/* Popping the level is handled below */
-			}
-
-			level->initialized = 1;
-		} else if (S_ISDIR(iter->base.st.st_mode)) {
-			if (level->dir_state == DIR_STATE_ITER) {
+			if (!level->dir) {
 				/*
-				 * The directory was just iterated
-				 * over; now prepare to iterate into
-				 * it.
+				 * This level wasn't opened sucessfully; pretend we
+				 * iterated through it already.
 				 */
-				push_dir_level(iter, level);
+				if (errno != ENOENT) {
+					warning("error opening directory %s: %s",
+						iter->base.path.buf, strerror(errno));
+				}
+
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
@@ -175,7 +226,42 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			if (set_iterator_data(iter, level))
 				continue;
 
+			if (S_ISDIR(iter->base.st.st_mode)) {
+				push_dir_level(iter, level, &iter->base.st);
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
+					/*
+					 * In this state, set_iterator_data() should never return
+					 * an error.
+					 */
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
@@ -201,7 +287,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 	return ITER_DONE;
 }
 
-struct dir_iterator *dir_iterator_begin(const char *path)
+struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
 {
 	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
 	struct dir_iterator *dir_iterator = &iter->base;
@@ -209,13 +295,17 @@ struct dir_iterator *dir_iterator_begin(const char *path)
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
+	iter->levels[0].st_is_set = 0;
 
 	return dir_iterator;
 }
diff --git a/dir-iterator.h b/dir-iterator.h
index 27739e6..4d8ab75 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -5,19 +5,17 @@
  * Iterate over a directory tree.
  *
  * Iterate over a directory tree, recursively, including paths of all
- * types and hidden paths. Skip "." and ".." entries and don't follow
- * symlinks except for the original path.
+ * types and hidden paths. Skip "." and ".." entries.
  *
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
@@ -38,6 +36,26 @@
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
+ * of the root directory it is iterating through if either
+ * DIR_ITERATOR_PRE_ORDER_TRAVERSAL or DIR_ITERATOR_POST_ORDER_TRAVERSAL
+ * is set.
+ *
+ * All flags can be used in any combination.
+ */
+#define DIR_ITERATOR_PRE_ORDER_TRAVERSAL (1 << 0)
+#define DIR_ITERATOR_POST_ORDER_TRAVERSAL (1 << 1)
+#define DIR_ITERATOR_LIST_ROOT_DIR (1 << 2)
+
 struct dir_iterator {
 	/* The current path: */
 	struct strbuf path;
@@ -57,15 +75,16 @@ struct dir_iterator {
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
index 50188e9..c29dc68 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3346,7 +3346,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	files_downcast(ref_store, 0, "reflog_iterator_begin");
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
+	iter->dir_iterator = dir_iterator_begin(git_path("logs"), DIR_ITERATOR_PRE_ORDER_TRAVERSAL);
 	return ref_iterator;
 }
 
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index 0394a13..9ac3fa7 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -4,15 +4,34 @@
 #include "dir-iterator.h"
 
 int cmd_main(int argc, const char **argv) {
+	const char **myargv = argv;
+	int myargc = argc;
+
 	struct strbuf path = STRBUF_INIT;
 	struct dir_iterator *diter;
 
-	if (argc < 2)
-		die("BUG: test-dir-iterator needs one argument");
+	unsigned flag = 0;
+
+	while (--myargc && starts_with(*++myargv, "--")) {
+		if (!strcmp(*myargv, "--pre-order"))
+			flag |= DIR_ITERATOR_PRE_ORDER_TRAVERSAL;
+		else if (!strcmp(*myargv, "--post-order"))
+			flag |= DIR_ITERATOR_POST_ORDER_TRAVERSAL;
+		else if (!strcmp(*myargv, "--list-root-dir"))
+			flag |= DIR_ITERATOR_LIST_ROOT_DIR;
+		else if (!strcmp(*myargv, "--")) {
+			myargc--;
+			myargv++;
+			break;
+		} else
+		   die("Unrecognized option: %s", *myargv);
+	}
 
-	strbuf_add(&path, argv[1], strlen(argv[1]));
+	if (myargc != 1)
+		die("expected exactly one non-option argument");
+	strbuf_addstr(&path, *myargv);
 
-	diter = dir_iterator_begin(path.buf);
+	diter = dir_iterator_begin(path.buf, flag);
 
 	while (dir_iterator_advance(diter) == ITER_OK) {
 		if (S_ISDIR(diter->st.st_mode))
diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
index b6d76dd..458c57e 100755
--- a/t/t0065-dir-iterator.sh
+++ b/t/t0065-dir-iterator.sh
@@ -33,12 +33,19 @@ cat >expect-sorted-output <<-\EOF &&
 EOF
 
 test_expect_success 'dir-iterator should iterate through all files' '
-	test-dir-iterator ./dir >out &&
+	test-dir-iterator --pre-order ./dir >out &&
 	sort <out >./actual-pre-order-sorted-output &&
 
 	test_cmp expect-sorted-output actual-pre-order-sorted-output
 '
 
+test_expect_success 'dir-iterator should iterate through all files on post-order mode' '
+	test-dir-iterator --post-order ./dir >out &&
+	sort <out >actual-post-order-sorted-output &&
+
+	test_cmp expect-sorted-output actual-post-order-sorted-output
+'
+
 cat >expect-pre-order-output <<-\EOF &&
 [d] (a) [a] ./dir2/a
 [d] (a/b) [b] ./dir2/a/b
@@ -46,10 +53,41 @@ cat >expect-pre-order-output <<-\EOF &&
 [f] (a/b/c/d) [d] ./dir2/a/b/c/d
 EOF
 
-test_expect_success 'dir-iterator should list files in the correct order' '
-	test-dir-iterator ./dir2 >actual-pre-order-output &&
+test_expect_success 'dir-iterator should list files properly on pre-order mode' '
+	test-dir-iterator --pre-order ./dir2 >actual-pre-order-output &&
 
 	test_cmp expect-pre-order-output actual-pre-order-output
 '
 
+cat >expect-post-order-output <<-\EOF &&
+[f] (a/b/c/d) [d] ./dir2/a/b/c/d
+[d] (a/b/c) [c] ./dir2/a/b/c
+[d] (a/b) [b] ./dir2/a/b
+[d] (a) [a] ./dir2/a
+EOF
+
+test_expect_success 'dir-iterator should list files properly on post-order mode' '
+	test-dir-iterator --post-order ./dir2 >actual-post-order-output &&
+
+	test_cmp expect-post-order-output actual-post-order-output
+'
+
+cat >expect-pre-order-post-order-root-dir-output <<-\EOF &&
+[d] (.) [dir2] ./dir2
+[d] (a) [a] ./dir2/a
+[d] (a/b) [b] ./dir2/a/b
+[d] (a/b/c) [c] ./dir2/a/b/c
+[f] (a/b/c/d) [d] ./dir2/a/b/c/d
+[d] (a/b/c) [c] ./dir2/a/b/c
+[d] (a/b) [b] ./dir2/a/b
+[d] (a) [a] ./dir2/a
+[d] (.) [dir2] ./dir2
+EOF
+
+test_expect_success 'dir-iterator should list files properly on pre-order + post-order + root-dir mode' '
+	test-dir-iterator --pre-order --post-order --list-root-dir ./dir2 >actual-pre-order-post-order-root-dir-output &&
+
+	test_cmp expect-pre-order-post-order-root-dir-output actual-pre-order-post-order-root-dir-output
+'
+
 test_done
-- 
2.7.4 (Apple Git-66)

