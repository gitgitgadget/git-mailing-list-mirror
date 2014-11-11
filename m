From: Duy Nguyen <pclouds@gmail.com>
Subject: [RFC] On watchman support
Date: Tue, 11 Nov 2014 19:49:01 +0700
Message-ID: <20141111124901.GA6011@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dturner@twopensource.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 13:48:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoAsO-0003XU-G7
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 13:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbaKKMss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 07:48:48 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:37592 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaKKMsq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 07:48:46 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so10575471pad.17
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 04:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=xdkOpfsa+YzBH+E8jlPJDCbYTw6sVLlI3dbHv/lXKbU=;
        b=nDxbxxnxVHIJDdscU2aIQHCYGKDp7T/xwOqqIxUEDsXrPjxBvc2NPHsHklLHrJ7eWJ
         SCy+eGQL7XuAB2fghhXHBTJPGf6Q2L71X8COcCLawoE3ClsbM356FKbeSXgPgzLxdTCv
         Bqc/qgWE50pogoky0VGBwa5IUH9GiWv0+J6yThxqP9QXUiIYtoQKYawiSC/ZTKve5J03
         va0lZ+goqPJKloxm7gaDkvbtDF9FhvJTYmjW7tQqiBMywsro1I2mXsUap9A032L+jXHG
         xQoSFrlp7zRlvyJx05lBSG86YN8SlinJagutphDqG0wYNoZNhX0g4SjrMVaByj5ts/0V
         zIPw==
X-Received: by 10.66.102.41 with SMTP id fl9mr23381428pab.7.1415710125947;
        Tue, 11 Nov 2014 04:48:45 -0800 (PST)
Received: from lanh ([115.73.206.243])
        by mx.google.com with ESMTPSA id ny9sm19404864pab.25.2014.11.11.04.48.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2014 04:48:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 11 Nov 2014 19:49:01 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've come to the last piece to speed up "git status", watchman
support. And I realized it's not as good as I thought.

Watchman could be used for two things: to avoid refreshing the index,
and to avoid searching for ignored files. The first one can be done
(with the patch below as demonstration). And it should keep refresh
cost to near zero in the best case, the cost is proportional to the
number of modified files.

For avoiding searching for ignored files. My intention was to build on
top of untracked cache. If watchman can tell me what files are added
or deleted since last observed time, then I can invalidate just
directories that contain them, or even better, calculate ignore status
for those files only.

This is important because in reality compilers and editors tend to
update files by creating a new version then rename them, updating
directory mtime and invalidating untracked cache as a consequence. As
you edit more files (or your rebuild touches more dirs), untracked
cache performance drops (until the next "git status"). The numbers I
posted so far are the best case.

The problem with watchman is it cannot tell me "new" files since the
last observed time (let's say 'T'). If a file exists at 'T', gets
deleted then recreated, then watchman tells me it's a new file. I want
to separate those from ones that do not exist before 'T'.

David's watchman approach does not have this problem because he keeps
track of all entries under $GIT_WORK_TREE and knows which files are
truely new. But I don't really want to keep the whole file list around,
especially when watchman already manages the same list.

So we got a few options:

1) Convince watchman devs to add something to make it work

2) Fork watchman

3) Make another daemon to keep file list around, or put it in a shared
   memory.

4) Move David's watchman series forward (and maybe make use of shared
   mem for fs_cache).

5) Go with something similar to the patch below and accept untracked
   cache performance degrades from time to time

6) ??

I'm working on 1). 2) is just bad taste, listed for completeness
only. If we go with 3) and watchman starts to support Windows (seems
to be in their plan), we'll need to rework some how. And I really
don't like 3)

If 1-3 does not work out, we're left without 4) and 5). We could
support both, but proobably not worth the code complexity and should
just go with one.

And if we go with 4) we should probably think of dropping untracked
cache if watchman will support Windows in the end. 4) also has another
advantage over untracked cache, that it could speed up listing ignored
files as well as untracked files.

Comments?

-- 8< --
diff --git a/Makefile b/Makefile
index fa58a53..a2be728 100644
--- a/Makefile
+++ b/Makefile
@@ -406,6 +406,7 @@ TCLTK_PATH = wish
 XGETTEXT = xgettext
 MSGFMT = msgfmt
 PTHREAD_LIBS = -lpthread
+WATCHMAN_LIBS = -lwatchman
 PTHREAD_CFLAGS =
 GCOV = gcov
 
@@ -1453,6 +1454,13 @@ else
 	LIB_OBJS += thread-utils.o
 endif
 
+ifdef USE_WATCHMAN
+	LIB_H += watchman-support.h
+	LIB_OBJS += watchman-support.o
+	EXTLIBS += $(WATCHMAN_LIBS)
+	BASIC_CFLAGS += -DUSE_WATCHMAN
+endif
+
 ifdef HAVE_PATHS_H
 	BASIC_CFLAGS += -DHAVE_PATHS_H
 endif
@@ -2222,6 +2230,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+	@echo USE_WATCHMAN=\''$(subst ','\'',$(subst ','\'',$(USE_WATCHMAN)))'\' >>$@
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@
 endif
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f23ec83..1da2b15 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -882,6 +882,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, line_termination = '\n';
 	int untracked_cache = -1;
+	int use_watchman = -1;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -977,6 +978,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("enable/disable untracked cache")),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), 2),
+		OPT_BOOL(0, "watchman", &use_watchman,
+			N_("use or not use watchman to reduce refresh cost")),
 		OPT_END()
 	};
 
@@ -1102,6 +1105,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	}
 
+	if (use_watchman > 0) {
+		the_index.last_update    = xstrdup("");
+		the_index.cache_changed |= WATCHMAN_CHANGED;
+	} else if (!use_watchman) {
+		the_index.last_update    = NULL;
+		the_index.cache_changed |= WATCHMAN_CHANGED;
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
diff --git a/cache.h b/cache.h
index 201b22e..e1d6e21 100644
--- a/cache.h
+++ b/cache.h
@@ -161,6 +161,8 @@ struct cache_entry {
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
+#define CE_NO_WATCH  (0x0001)
+
 /*
  * Range 0xFFFF0FFF in ce_flags is divided into
  * two parts: in-memory flags and on-disk ones.
@@ -296,6 +298,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
 #define UNTRACKED_CHANGED       (1 << 7)
+#define WATCHMAN_CHANGED	(1 << 8)
 
 struct split_index;
 struct untracked_cache;
@@ -314,6 +317,7 @@ struct index_state {
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
 	struct untracked_cache *untracked;
+	char *last_update;
 };
 
 extern struct index_state the_index;
@@ -637,6 +641,8 @@ extern int check_replace_refs;
 
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_use_watchman;
+extern int core_watchman_sync_timeout;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 
diff --git a/config.c b/config.c
index 9e42d38..72b9223 100644
--- a/config.c
+++ b/config.c
@@ -860,6 +860,16 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.usewatchman")) {
+		core_use_watchman = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.watchmansynctimeout")) {
+		core_watchman_sync_timeout = git_config_int(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
diff --git a/configure.ac b/configure.ac
index 4b1ae7c..2ee5356 100644
--- a/configure.ac
+++ b/configure.ac
@@ -970,6 +970,12 @@ GIT_CONF_SUBST([NO_INITGROUPS])
 #
 # Define NO_ICONV if your libc does not properly support iconv.
 
+# Check for watchman client library
+
+AC_CHECK_LIB([watchman], [watchman_connect],
+	[USE_WATCHMAN=YesPlease],
+	[USE_WATCHMAN=])
+GIT_CONF_SUBST([USE_WATCHMAN])
 
 ## Other checks.
 # Define USE_PIC if you need the main git objects to be built with -fPIC
diff --git a/environment.c b/environment.c
index 565f652..dfaea4e 100644
--- a/environment.c
+++ b/environment.c
@@ -74,6 +74,11 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index = 1;
 
+/* Use Watchman for faster status queries */
+int core_use_watchman = 0;
+int core_watchman_sync_timeout = 300;
+
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static char *work_tree;
diff --git a/read-cache.c b/read-cache.c
index 21ae963..46566f5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -16,6 +16,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "sigchain.h"
+#include "ewah/ewok.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -38,11 +39,13 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
+#define CACHE_EXT_WATCHMAN 0x57414D41	  /* "WAMA" */
 
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
-		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
+		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | \
+		 WATCHMAN_CHANGED)
 
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -1217,8 +1220,13 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 			continue;
 
 		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
-		if (new == ce)
+		if (new == ce) {
+			if (ce->ce_flags & CE_NO_WATCH) {
+				ce->ce_flags          &= ~CE_NO_WATCH;
+				istate->cache_changed |= WATCHMAN_CHANGED;
+			}
 			continue;
+		}
 		if (!new) {
 			const char *fmt;
 
@@ -1370,6 +1378,55 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	return 0;
 }
 
+static void mark_no_watchman(size_t pos, void *data)
+{
+	struct index_state *istate = data;
+	assert(pos < istate->cache_nr);
+	istate->cache[pos]->ce_flags |= CE_NO_WATCH;
+}
+
+static int read_watchman_ext(struct index_state *istate, const void *data,
+			      unsigned long sz)
+{
+	struct ewah_bitmap *bitmap;
+	int ret, len;
+
+	if (memchr(data, 0, sz) == NULL)
+		return error("invalid extension");
+	len = strlen(data) + 1;
+	bitmap = ewah_new();
+	ret = ewah_read_mmap(bitmap, (const char *)data + len, sz - len);
+	if (ret != sz - len) {
+		ewah_free(bitmap);
+		return error("fail to parse ewah bitmap");
+	}
+	istate->last_update = xstrdup(data);
+	ewah_each_bit(bitmap, mark_no_watchman, istate);
+	ewah_free(bitmap);
+	return 0;
+}
+
+static int write_strbuf(void *user_data, const void *data, size_t len)
+{
+	struct strbuf *sb = user_data;
+	strbuf_add(sb, data, len);
+	return len;
+}
+
+static void write_watchman_ext(struct strbuf *sb, struct index_state* istate)
+{
+	struct ewah_bitmap *bitmap;
+	int i;
+
+	strbuf_add(sb, istate->last_update, strlen(istate->last_update) + 1);
+	bitmap = ewah_new();
+	for (i = 0; i < istate->cache_nr; i++)
+		if (istate->cache[i]->ce_flags & CE_NO_WATCH)
+			ewah_set(bitmap, i);
+	ewah_serialize_to(bitmap, write_strbuf, sb);
+	ewah_free(bitmap);
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1387,6 +1444,11 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_UNTRACKED:
 		istate->untracked = read_untracked_extension(data, sz);
 		break;
+
+	case CACHE_EXT_WATCHMAN:
+		read_watchman_ext(istate, data, sz);
+		break;
+
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1600,10 +1662,10 @@ int read_index_from(struct index_state *istate, const char *path)
 	ret = do_read_index(istate, path, 0);
 	split_index = istate->split_index;
 	if (!split_index)
-		return ret;
+		goto done;
 
 	if (is_null_sha1(split_index->base_sha1))
-		return ret;
+		goto done;
 
 	if (split_index->base)
 		discard_index(split_index->base);
@@ -1619,6 +1681,12 @@ int read_index_from(struct index_state *istate, const char *path)
 				     sha1_to_hex(split_index->base_sha1)),
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
+
+done:
+#ifdef USE_WATCHMAN
+	if (istate->last_update && !getenv("GIT_NO_WATCHMAN"))
+		check_watchman(istate);
+#endif
 	return ret;
 }
 
@@ -1654,6 +1722,8 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked = NULL;
+	free(istate->last_update);
+	istate->last_update = NULL;
 	return 0;
 }
 
@@ -2051,6 +2121,16 @@ static int do_write_index(struct index_state *istate, int newfd,
 		if (err)
 			return -1;
 	}
+	if (istate->last_update) {
+		struct strbuf sb = STRBUF_INIT;
+
+		write_watchman_ext(&sb, istate);
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_WATCHMAN, sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
 
 	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
 		return -1;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b1bc65b..0080f47 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -897,6 +897,7 @@ test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -z "$USE_WATCHMAN" && test_set_prereq WATCHMAN
 
 # Can we rely on git's output in the C locale?
 if test -n "$GETTEXT_POISON"
diff --git a/watchman-support.c b/watchman-support.c
new file mode 100644
index 0000000..f608457
--- /dev/null
+++ b/watchman-support.c
@@ -0,0 +1,132 @@
+#include "cache.h"
+#include "watchman-support.h"
+#include "strbuf.h"
+#include <watchman.h>
+
+static struct watchman_query *make_query(const char *last_update)
+{
+	struct watchman_query *query = watchman_query();
+	watchman_query_set_fields(query, WATCHMAN_FIELD_NAME |
+					 WATCHMAN_FIELD_EXISTS |
+					 WATCHMAN_FIELD_NEWER);
+	/* watchman_query_set_fields(query, WATCHMAN_FIELD_CCLOCK); */
+	watchman_query_set_empty_on_fresh(query, 1);
+	query->sync_timeout = core_watchman_sync_timeout;
+	if (*last_update)
+		watchman_query_set_since_oclock(query, last_update);
+	return query;
+}
+
+static struct watchman_query_result* query_watchman(
+	struct index_state *istate, struct watchman_connection *connection,
+	const char *fs_path, const char *last_update)
+{
+	struct watchman_error wm_error;
+	struct watchman_query *query;
+	struct watchman_expression *expr;
+	struct watchman_query_result *result;
+	struct stat st;
+
+	if (lstat(get_git_dir(), &st)) {
+		/*
+		 * Watchman gets confused if we delete the .git
+		 * directory out from under it, since that's where it
+		 * stores its cookies.  So we'll need to delete the
+		 * watch and then recreate it. It's OK for this to
+		 * fail, as the watch might have already been deleted.
+		 */
+		watchman_watch_del(connection, fs_path, &wm_error);
+
+		if (watchman_watch(connection, fs_path, &wm_error)) {
+			warning("Watchman watch error: %s", wm_error.message);
+			return NULL;
+		}
+	}
+
+	query = make_query(last_update);
+	expr = watchman_true_expression();
+	result = watchman_do_query(connection, fs_path, query, expr, &wm_error);
+	watchman_free_query(query);
+	watchman_free_expression(expr);
+
+	if (!result)
+		warning("Watchman query error: %s (at %s)",
+			wm_error.message,
+			*last_update ? last_update : "the beginning");
+
+	return result;
+}
+
+static void update_index(struct index_state *istate,
+			 struct watchman_query_result *result)
+{
+	int i;
+
+	if (result->is_fresh_instance) {
+		/* let refresh clear them later */
+		for (i = 0; i < istate->cache_nr; i++)
+			istate->cache[i]->ce_flags |= CE_NO_WATCH;
+		goto done;
+	}
+
+	for (i = 0; i < result->nr; i++) {
+		struct watchman_stat *wm = result->stats + i;
+		int pos;
+
+		if (!strncmp(wm->name, ".git/", 5) ||
+		    strstr(wm->name, "/.git/"))
+			continue;
+
+		pos = index_name_pos(istate, wm->name, strlen(wm->name));
+		if (pos < 0)
+			continue;
+		/* FIXME: ignore staged entries and gitlinks too? */
+
+		istate->cache[pos]->ce_flags |= CE_NO_WATCH;
+	}
+
+	/*
+	 * we have marked all modified files with CE_NO_WATCH
+	 * according to watchman. All other files are supposed to be
+	 * uptodate. Those with CE_NO_WATCH will be refreshed
+	 * eventually and get that bit cleared.
+	 */
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (ce_stage(ce) || (ce->ce_flags & CE_NO_WATCH))
+			continue;
+		ce_mark_uptodate(ce);
+	}
+
+done:
+	free(istate->last_update);
+	istate->last_update    = xstrdup(result->clock);
+	istate->cache_changed |= WATCHMAN_CHANGED;
+}
+
+int check_watchman(struct index_state *istate)
+{
+	struct watchman_error wm_error;
+	struct watchman_connection *connection;
+	struct watchman_query_result *result;
+	const char *fs_path;
+
+	fs_path = get_git_work_tree();
+	if (!fs_path)
+		return -1;
+
+	connection = watchman_connect(&wm_error);
+
+	if (!connection) {
+		warning("Watchman watch error: %s", wm_error.message);
+		return -1;
+	}
+
+	result = query_watchman(istate, connection, fs_path, istate->last_update);
+	watchman_connection_close(connection);
+	if (!result)
+		return -1;
+	update_index(istate, result);
+	watchman_free_query_result(result);
+	return 0;
+}
diff --git a/watchman-support.h b/watchman-support.h
new file mode 100644
index 0000000..5610409
--- /dev/null
+++ b/watchman-support.h
@@ -0,0 +1,8 @@
+#ifndef WATCHMAN_SUPPORT_H
+#define WATCHMAN_SUPPORT_H
+
+struct index_state;
+int check_watchman(struct index_state *index);
+
+
+#endif /* WATCHMAN_SUPPORT_H */
-- 8< --
