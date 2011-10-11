From: klinkert@webgods.de
Subject: [PATCH] Improving performance with pthreads in refresh_index().
Date: Tue, 11 Oct 2011 11:32:01 +0200
Message-ID: <1318325521-23262-1-git-send-email-klinkert@webgods.de>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 11 11:41:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDYq2-0000GQ-0P
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 11:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab1JKJlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 05:41:25 -0400
Received: from mort.rzone.de ([81.169.144.234]:39416 "EHLO mort.rzone.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043Ab1JKJlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 05:41:24 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Oct 2011 05:41:24 EDT
Received: from glipzo.store (glipzo.store [192.168.41.210])
	by mort.rzone.de (Postfix) with ESMTP id BE007E80;
	Tue, 11 Oct 2011 11:32:01 +0200 (MEST)
Received: by glipzo.store (Postfix, from userid 32626)
	id C22238516; Tue, 11 Oct 2011 11:32:01 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183289>

Git performs for every file in a repository at least one (with a cold cache)
lstat(). In larger repositories operations like git status take a
long time. In case your local repository is located on a remote server
(e. g. mounted via nfs) it ends up in an *incredible* slow git.

With this patch you're able to determine a number of threads (maxthreads)
in your config file to run these tons of lstats in threads. There
won't be created any pthreads if you haven't set maxthreads. In my
test cases a git status with this patch performs enormously faster (over
two minutes before and approximately 25 seconds now). Of course, it
has a positive impact on other git commands, too.

Signed-off-by: Simon Klinkert <klinkert@webgods.de>
---
 attr.c        |   22 +++++++++
 cache.h       |    1 +
 config.c      |    5 ++
 environment.c |    1 +
 read-cache.c  |  140 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 5 files changed, 151 insertions(+), 18 deletions(-)

diff --git a/attr.c b/attr.c
index 33cb4e4..d296fe8 100644
--- a/attr.c
+++ b/attr.c
@@ -8,10 +8,14 @@
  */
 
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
+#include <pthread.h>
+#undef _FILE_OFFSET_BITS
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
 
+pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
 static const char git_attr__unknown[] = "(builtin)unknown";
@@ -748,6 +752,9 @@ int git_check_attr(const char *path, int num, struct git_attr_check *check)
 {
 	int i;
 
+	if (max_threads)
+		pthread_mutex_lock(&mutex);
+
 	collect_all_attrs(path);
 
 	for (i = 0; i < num; i++) {
@@ -757,6 +764,9 @@ int git_check_attr(const char *path, int num, struct git_attr_check *check)
 		check[i].value = value;
 	}
 
+	if (max_threads)
+		pthread_mutex_unlock(&mutex);
+
 	return 0;
 }
 
@@ -764,6 +774,9 @@ int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
 {
 	int i, count, j;
 
+	if (max_threads)
+		pthread_mutex_lock(&mutex);
+
 	collect_all_attrs(path);
 
 	/* Count the number of attributes that are set. */
@@ -785,6 +798,9 @@ int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
 		}
 	}
 
+	if (max_threads)
+		pthread_mutex_unlock(&mutex);
+
 	return 0;
 }
 
@@ -795,8 +811,14 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	if (is_bare_repository() && new != GIT_ATTR_INDEX)
 		die("BUG: non-INDEX attr direction in a bare repo");
 
+	if (max_threads)
+		pthread_mutex_lock(&mutex);
+
 	direction = new;
 	if (new != old)
 		drop_attr_stack();
 	use_index = istate;
+
+	if (max_threads)
+		pthread_mutex_unlock(&mutex);
 }
diff --git a/cache.h b/cache.h
index 607c2ea..ab1b3e4 100644
--- a/cache.h
+++ b/cache.h
@@ -600,6 +600,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int max_threads;
 
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
diff --git a/config.c b/config.c
index 4183f80..24de139 100644
--- a/config.c
+++ b/config.c
@@ -466,6 +466,11 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 
 static int git_default_core_config(const char *var, const char *value)
 {
+	if (!strcmp(var, "core.maxthreads")) {
+		max_threads = git_config_int(var, value);
+		return 0;
+	}
+
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
 		trust_executable_bit = git_config_bool(var, value);
diff --git a/environment.c b/environment.c
index e96edcf..8bca4d5 100644
--- a/environment.c
+++ b/environment.c
@@ -59,6 +59,7 @@ char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 struct startup_info *startup_info;
+int max_threads = 1;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/read-cache.c b/read-cache.c
index 01a0e25..350bf4b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,8 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#undef _FILE_OFFSET_BITS
+#include <pthread.h>
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
@@ -13,6 +15,8 @@
 #include "blob.h"
 #include "resolve-undo.h"
 
+pthread_mutex_t mutex_refresh_index = PTHREAD_MUTEX_INITIALIZER;
+
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 
 /* Index extensions.
@@ -1080,7 +1084,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 }
 
 static void show_file(const char * fmt, const char * name, int in_porcelain,
-		      int * first, const char *header_msg)
+		      int * first, char *header_msg)
 {
 	if (in_porcelain && *first && header_msg) {
 		printf("%s\n", header_msg);
@@ -1089,45 +1093,96 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
 	printf(fmt, name);
 }
 
-int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec,
-		  char *seen, const char *header_msg)
+struct t_ctx {
+	int flags;
+	int has_errors;
+	struct index_state *istate;
+	const char **pathspec;
+	char *seen, header_msg;
+
+	int tasks_done;
+} ctx;
+
+int
+thread_manager(void)
+{
+	if (max_threads)
+		pthread_mutex_lock(&mutex_refresh_index);
+
+	if (ctx.tasks_done >= ctx.istate->cache_nr) {
+		if (max_threads)
+			pthread_mutex_unlock(&mutex_refresh_index);
+		return -1;
+	}
+
+	int task = ctx.tasks_done++;
+
+	if (max_threads)
+		pthread_mutex_unlock(&mutex_refresh_index);
+
+	return task;
+}
+
+void *
+thread_refresh_index(void *p)
 {
+	struct cache_entry *ce, *new;
+	int cache_errno = 0;
 	int i;
-	int has_errors = 0;
+
+	while ((i = thread_manager()) != -1) {
+		struct index_state *istate = ctx.istate;
+		int flags = ctx.flags;
+
 	int really = (flags & REFRESH_REALLY) != 0;
 	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
 	int quiet = (flags & REFRESH_QUIET) != 0;
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
-	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
+		int ignore_submodules =
+			 (flags & REFRESH_IGNORE_SUBMODULES) != 0;
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
 	const char *needs_update_fmt;
 	const char *needs_merge_fmt;
 
-	needs_update_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
-	needs_merge_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
-	for (i = 0; i < istate->cache_nr; i++) {
-		struct cache_entry *ce, *new;
-		int cache_errno = 0;
+		needs_update_fmt =
+			 (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
+		needs_merge_fmt =
+			 (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 
 		ce = istate->cache[i];
-		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
+		if (ignore_submodules && S_ISGITLINK(ce->ce_mode)) {
 			continue;
+		}
+
+		if (max_threads)
+			pthread_mutex_lock(&mutex_refresh_index);
 
 		if (ce_stage(ce)) {
 			while ((i < istate->cache_nr) &&
 			       ! strcmp(istate->cache[i]->name, ce->name))
 				i++;
 			i--;
-			if (allow_unmerged)
+			if (allow_unmerged) {
+				if (max_threads)
+					pthread_mutex_unlock(&mutex_refresh_index);
 				continue;
-			show_file(needs_merge_fmt, ce->name, in_porcelain, &first, header_msg);
-			has_errors = 1;
+			}
+			show_file(needs_merge_fmt, ce->name, in_porcelain,
+				 &first, &ctx.header_msg);
+			ctx.has_errors = 1;
+			if (max_threads)
+				pthread_mutex_unlock(&mutex_refresh_index);
 			continue;
 		}
 
-		if (pathspec && !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
+		if (max_threads)
+			pthread_mutex_unlock(&mutex_refresh_index);
+
+		if (ctx.pathspec && !match_pathspec(ctx.pathspec, ce->name,
+						    strlen(ce->name), 0,
+						    ctx.seen))
 			continue;
 
 		new = refresh_cache_ent(istate, ce, options, &cache_errno);
@@ -1145,14 +1200,63 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			show_file(needs_update_fmt, ce->name, in_porcelain, &first, header_msg);
-			has_errors = 1;
+
+			if (max_threads)
+				pthread_mutex_lock(&mutex_refresh_index);
+
+			show_file(needs_update_fmt, ce->name, in_porcelain,
+				  &first, &ctx.header_msg);
+
+			if (max_threads)
+				pthread_mutex_unlock(&mutex_refresh_index);
+
+			ctx.has_errors = 1;
 			continue;
 		}
 
 		replace_index_entry(istate, i, new);
 	}
-	return has_errors;
+	return NULL;
+}
+
+int refresh_index(struct index_state *istate, unsigned int flags,
+		  const char **pathspec, char *seen, const char *header_msg)
+{
+	int i;
+	int ret;
+	unsigned int created_threads = 0;
+
+	ctx.has_errors = 0;
+	ctx.tasks_done = 0;
+	ctx.istate = istate;
+	ctx.flags = flags;
+	ctx.pathspec = &pathspec[0];
+
+	if (istate->cache_nr < max_threads)
+		max_threads = istate->cache_nr;
+
+	if (max_threads > 1) {
+		pthread_t threads[max_threads];
+
+		/* create threads */
+		for (i = 0; i < max_threads; i++) {
+			ret = pthread_create(&threads[created_threads], NULL,
+					     thread_refresh_index, NULL);
+			if (ret) {
+				printf("pthread_create failed ret=%d\n", ret);
+				break;
+			}
+			++created_threads;
+		}
+
+		/* collect threads */
+		for (i = 0; i < created_threads; i++) {
+			ret = pthread_join(threads[i], NULL);
+		}
+	} else {
+		thread_refresh_index(NULL);
+	}
+	return ctx.has_errors;
 }
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
-- 
1.7.7
