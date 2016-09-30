Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C56207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbcI3TgS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:36:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50602 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbcI3TgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:36:16 -0400
Received: (qmail 31180 invoked by uid 109); 30 Sep 2016 19:36:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 19:36:16 +0000
Received: (qmail 13471 invoked by uid 111); 30 Sep 2016 19:36:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 15:36:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 15:36:13 -0400
Date:   Fri, 30 Sep 2016 15:36:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 3/6] tmp-objdir: introduce API for temporary object
 directories
Message-ID: <20160930193613.dwpjiw5xps6a3wgj@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once objects are added to the object database by a process,
they cannot easily be deleted, as we don't know what other
processes may have started referencing them. We have to
clean them up with git-gc, which will apply the usual
reachability and grace-period checks.

This patch provides an alternative: it helps callers create
a temporary directory inside the object directory, and a
temporary environment which can be passed to sub-programs to
ask them to write there (the original object directory
remains accessible as an alternate of the temporary one).

See tmp-objdir.h for details on the API.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile     |   1 +
 cache.h      |   1 +
 sha1_file.c  |   6 ++
 tmp-objdir.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tmp-objdir.h |  53 ++++++++++++
 5 files changed, 327 insertions(+)
 create mode 100644 tmp-objdir.c
 create mode 100644 tmp-objdir.h

diff --git a/Makefile b/Makefile
index 1aad150..4e3becb 100644
--- a/Makefile
+++ b/Makefile
@@ -831,6 +831,7 @@ LIB_OBJS += submodule-config.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
+LIB_OBJS += tmp-objdir.o
 LIB_OBJS += trace.o
 LIB_OBJS += trailer.o
 LIB_OBJS += transport.o
diff --git a/cache.h b/cache.h
index ed3d5df..607c9b5 100644
--- a/cache.h
+++ b/cache.h
@@ -1389,6 +1389,7 @@ extern void prepare_alt_odb(void);
 extern void read_info_alternates(const char * relative_base, int depth);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 extern void add_to_alternates_file(const char *reference);
+extern void add_to_alternates_internal(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
 
diff --git a/sha1_file.c b/sha1_file.c
index 9a79c19..65deaf9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -421,6 +421,12 @@ void add_to_alternates_file(const char *reference)
 	free(alts);
 }
 
+void add_to_alternates_internal(const char *reference)
+{
+	prepare_alt_odb();
+	link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+}
+
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`
diff --git a/tmp-objdir.c b/tmp-objdir.c
new file mode 100644
index 0000000..c92e6cc
--- /dev/null
+++ b/tmp-objdir.c
@@ -0,0 +1,266 @@
+#include "cache.h"
+#include "tmp-objdir.h"
+#include "dir.h"
+#include "sigchain.h"
+#include "string-list.h"
+#include "strbuf.h"
+#include "argv-array.h"
+
+struct tmp_objdir {
+	struct strbuf path;
+	struct argv_array env;
+};
+
+/*
+ * Allow only one tmp_objdir at a time in a running process, which simplifies
+ * our signal/atexit cleanup routines.  It's doubtful callers will ever need
+ * more than one, and we can expand later if so.  You can have many such
+ * tmp_objdirs simultaneously in many processes, of course.
+ */
+struct tmp_objdir *the_tmp_objdir;
+
+static void tmp_objdir_free(struct tmp_objdir *t)
+{
+	strbuf_release(&t->path);
+	argv_array_clear(&t->env);
+	free(t);
+}
+
+static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
+{
+	int err;
+
+	if (!t)
+		return 0;
+
+	if (t == the_tmp_objdir)
+		the_tmp_objdir = NULL;
+
+	/*
+	 * This may use malloc via strbuf_grow(), but we should
+	 * have pre-grown t->path sufficiently so that this
+	 * doesn't happen in practice.
+	 */
+	err = remove_dir_recursively(&t->path, 0);
+
+	/*
+	 * When we are cleaning up due to a signal, we won't bother
+	 * freeing memory; it may cause a deadlock if the signal
+	 * arrived while libc's allocator lock is held.
+	 */
+	if (!on_signal)
+		tmp_objdir_free(t);
+	return err;
+}
+
+int tmp_objdir_destroy(struct tmp_objdir *t)
+{
+	return tmp_objdir_destroy_1(t, 0);
+}
+
+static void remove_tmp_objdir(void)
+{
+	tmp_objdir_destroy(the_tmp_objdir);
+}
+
+static void remove_tmp_objdir_on_signal(int signo)
+{
+	tmp_objdir_destroy_1(the_tmp_objdir, 1);
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+static void env_append(struct argv_array *env, const char *key, const char *val)
+{
+	const char *old = getenv(key);
+
+	if (!old)
+		argv_array_pushf(env, "%s=%s", key, val);
+	else
+		argv_array_pushf(env, "%s=%s%c%s", key, old, PATH_SEP, val);
+}
+
+static void env_replace(struct argv_array *env, const char *key, const char *val)
+{
+	argv_array_pushf(env, "%s=%s", key, val);
+}
+
+static int setup_tmp_objdir(const char *root)
+{
+	char *path;
+	int ret = 0;
+
+	path = xstrfmt("%s/pack", root);
+	ret = mkdir(path, 0777);
+	free(path);
+
+	return ret;
+}
+
+struct tmp_objdir *tmp_objdir_create(void)
+{
+	static int installed_handlers;
+	struct tmp_objdir *t;
+
+	if (the_tmp_objdir)
+		die("BUG: only one tmp_objdir can be used at a time");
+
+	t = xmalloc(sizeof(*t));
+	strbuf_init(&t->path, 0);
+	argv_array_init(&t->env);
+
+	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
+
+	/*
+	 * Grow the strbuf beyond any filename we expect to be placed in it.
+	 * If tmp_objdir_destroy() is called by a signal handler, then
+	 * we should be able to use the strbuf to remove files without
+	 * having to call malloc.
+	 */
+	strbuf_grow(&t->path, 1024);
+
+	if (!mkdtemp(t->path.buf)) {
+		/* free, not destroy, as we never touched the filesystem */
+		tmp_objdir_free(t);
+		return NULL;
+	}
+
+	the_tmp_objdir = t;
+	if (!installed_handlers) {
+		atexit(remove_tmp_objdir);
+		sigchain_push_common(remove_tmp_objdir_on_signal);
+		installed_handlers++;
+	}
+
+	if (setup_tmp_objdir(t->path.buf)) {
+		tmp_objdir_destroy(t);
+		return NULL;
+	}
+
+	env_append(&t->env, ALTERNATE_DB_ENVIRONMENT,
+		   absolute_path(get_object_directory()));
+	env_replace(&t->env, DB_ENVIRONMENT, absolute_path(t->path.buf));
+
+	return t;
+}
+
+/*
+ * Make sure we copy packfiles and their associated metafiles in the correct
+ * order. All of these ends_with checks are slightly expensive to do in
+ * the midst of a sorting routine, but in practice it shouldn't matter.
+ * We will have a relatively small number of packfiles to order, and loose
+ * objects exit early in the first line.
+ */
+static int pack_copy_priority(const char *name)
+{
+	if (!starts_with(name, "pack"))
+		return 0;
+	if (ends_with(name, ".keep"))
+		return 1;
+	if (ends_with(name, ".pack"))
+		return 2;
+	if (ends_with(name, ".idx"))
+		return 3;
+	return 4;
+}
+
+static int pack_copy_cmp(const char *a, const char *b)
+{
+	return pack_copy_priority(a) - pack_copy_priority(b);
+}
+
+static int read_dir_paths(struct string_list *out, const char *path)
+{
+	DIR *dh;
+	struct dirent *de;
+
+	dh = opendir(path);
+	if (!dh)
+		return -1;
+
+	while ((de = readdir(dh)))
+		if (!is_dot_or_dotdot(de->d_name))
+			string_list_append(out, de->d_name);
+
+	closedir(dh);
+	return 0;
+}
+
+static int migrate_paths(struct strbuf *src, struct strbuf *dst);
+
+static int migrate_one(struct strbuf *src, struct strbuf *dst)
+{
+	struct stat st;
+
+	if (stat(src->buf, &st) < 0)
+		return -1;
+	if (S_ISDIR(st.st_mode)) {
+		if (!mkdir(dst->buf, 0777)) {
+			if (adjust_shared_perm(dst->buf))
+				return -1;
+		} else if (errno != EEXIST)
+			return -1;
+		return migrate_paths(src, dst);
+	}
+	return finalize_object_file(src->buf, dst->buf);
+}
+
+static int migrate_paths(struct strbuf *src, struct strbuf *dst)
+{
+	size_t src_len = src->len, dst_len = dst->len;
+	struct string_list paths = STRING_LIST_INIT_DUP;
+	int i;
+	int ret = 0;
+
+	if (read_dir_paths(&paths, src->buf) < 0)
+		return -1;
+	paths.cmp = pack_copy_cmp;
+	string_list_sort(&paths);
+
+	for (i = 0; i < paths.nr; i++) {
+		const char *name = paths.items[i].string;
+
+		strbuf_addf(src, "/%s", name);
+		strbuf_addf(dst, "/%s", name);
+
+		ret |= migrate_one(src, dst);
+
+		strbuf_setlen(src, src_len);
+		strbuf_setlen(dst, dst_len);
+	}
+
+	string_list_clear(&paths, 0);
+	return ret;
+}
+
+int tmp_objdir_migrate(struct tmp_objdir *t)
+{
+	struct strbuf src = STRBUF_INIT, dst = STRBUF_INIT;
+	int ret;
+
+	if (!t)
+		return 0;
+
+	strbuf_addbuf(&src, &t->path);
+	strbuf_addstr(&dst, get_object_directory());
+
+	ret = migrate_paths(&src, &dst);
+
+	strbuf_release(&src);
+	strbuf_release(&dst);
+
+	tmp_objdir_destroy(t);
+	return ret;
+}
+
+const char **tmp_objdir_env(const struct tmp_objdir *t)
+{
+	if (!t)
+		return NULL;
+	return t->env.argv;
+}
+
+void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
+{
+	add_to_alternates_internal(t->path.buf);
+}
diff --git a/tmp-objdir.h b/tmp-objdir.h
new file mode 100644
index 0000000..aa47aa9
--- /dev/null
+++ b/tmp-objdir.h
@@ -0,0 +1,53 @@
+#ifndef TMP_OBJDIR_H
+#define TMP_OBJDIR_H
+
+/*
+ * This API allows you to create a temporary object directory, advertise it to
+ * sub-processes via GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES,
+ * and then either migrate its object into the main object directory, or remove
+ * it. The library handles unexpected signal/exit death by cleaning up the
+ * temporary directory.
+ *
+ * Example:
+ *
+ *	struct tmp_objdir *t = tmp_objdir_create();
+ *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
+ *	    !tmp_objdir_migrate(t))
+ *		printf("success!\n");
+ *	else
+ *		die("failed...tmp_objdir will clean up for us");
+ *
+ */
+
+struct tmp_objdir;
+
+/*
+ * Create a new temporary object directory; returns NULL on failure.
+ */
+struct tmp_objdir *tmp_objdir_create(void);
+
+/*
+ * Return a list of environment strings, suitable for use with
+ * child_process.env, that can be passed to child programs to make use of the
+ * temporary object directory.
+ */
+const char **tmp_objdir_env(const struct tmp_objdir *);
+
+/*
+ * Finalize a temporary object directory by migrating its objects into the main
+ * object database.
+ */
+int tmp_objdir_migrate(struct tmp_objdir *);
+
+/*
+ * Destroy a temporary object directory, discarding any objects it contains.
+ */
+int tmp_objdir_destroy(struct tmp_objdir *);
+
+/*
+ * Add the temporary object directory as an alternate object store in the
+ * current process.
+ */
+void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
+
+#endif /* TMP_OBJDIR_H */
-- 
2.10.0.618.g82cc264

