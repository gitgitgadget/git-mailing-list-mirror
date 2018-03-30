Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691411F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeC3SfH (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:35:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:49062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751938AbeC3SfG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:35:06 -0400
Received: (qmail 24186 invoked by uid 109); 30 Mar 2018 18:35:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 18:35:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31104 invoked by uid 111); 30 Mar 2018 18:36:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 14:36:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 14:35:04 -0400
Date:   Fri, 30 Mar 2018 14:35:04 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 3/5] add chdir-notify API
Message-ID: <20180330183504.GC31135@sigill.intra.peff.net>
References: <20180330183425.GA30575@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180330183425.GA30575@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If one part of the code does a permanent chdir(), then this
invalidates any relative paths that may be held by other
parts of the code. For example, setup_work_tree() moves us
to the top of the working tree, which may invalidate a
previously stored relative gitdir.

We've hacked around this case by teaching setup_work_tree()
to re-run set_git_dir() with an adjusted path, but this
stomps all over the idea of module boundaries.
setup_work_tree() shouldn't have to know all of the places
that need to be fed an adjusted path. And indeed, there's at
least one other place (the refs code) which needs adjusting.

Let's provide an API to let code that stores relative paths
"subscribe" to updates to the current working directory.
This means that callers of chdir() don't need to know about
all subscribers ahead of time; they can simply consult a
dynamically built list.

Note that our helper function to reparent relative paths
uses the simple remove_leading_path(). We could in theory
use the much smarter relative_path(), but that led to some
problems as described in 41894ae3a3 (Use simpler
relative_path when set_git_dir, 2013-10-14). Since we're
aiming to replace the setup_work_tree() code here, let's
follow its lead.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile       |  1 +
 chdir-notify.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 chdir-notify.h | 73 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 chdir-notify.c
 create mode 100644 chdir-notify.h

diff --git a/Makefile b/Makefile
index a1d8775adb..0da98b9274 100644
--- a/Makefile
+++ b/Makefile
@@ -772,6 +772,7 @@ LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
+LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
diff --git a/chdir-notify.c b/chdir-notify.c
new file mode 100644
index 0000000000..5f7f2c2ac2
--- /dev/null
+++ b/chdir-notify.c
@@ -0,0 +1,93 @@
+#include "cache.h"
+#include "chdir-notify.h"
+#include "list.h"
+#include "strbuf.h"
+
+struct chdir_notify_entry {
+	const char *name;
+	chdir_notify_callback cb;
+	void *data;
+	struct list_head list;
+};
+static LIST_HEAD(chdir_notify_entries);
+
+void chdir_notify_register(const char *name,
+			   chdir_notify_callback cb,
+			   void *data)
+{
+	struct chdir_notify_entry *e = xmalloc(sizeof(*e));
+	e->name = name;
+	e->cb = cb;
+	e->data = data;
+	list_add_tail(&e->list, &chdir_notify_entries);
+}
+
+static void reparent_cb(const char *name,
+			const char *old_cwd,
+			const char *new_cwd,
+			void *data)
+{
+	char **path = data;
+	char *tmp = *path;
+
+	if (!tmp)
+		return;
+
+	*path = reparent_relative_path(old_cwd, new_cwd, tmp);
+	free(tmp);
+
+	if (name) {
+		trace_printf_key(&trace_setup_key,
+				 "setup: reparent %s to '%s'",
+				 name, *path);
+	}
+}
+
+void chdir_notify_reparent(const char *name, char **path)
+{
+	chdir_notify_register(name, reparent_cb, path);
+}
+
+int chdir_notify(const char *new_cwd)
+{
+	struct strbuf old_cwd = STRBUF_INIT;
+	struct list_head *pos;
+
+	if (strbuf_getcwd(&old_cwd) < 0)
+		return -1;
+	if (chdir(new_cwd) < 0) {
+		int saved_errno = errno;
+		strbuf_release(&old_cwd);
+		errno = saved_errno;
+		return -1;
+	}
+
+	trace_printf_key(&trace_setup_key,
+			 "setup: chdir from '%s' to '%s'",
+			 old_cwd.buf, new_cwd);
+
+	list_for_each(pos, &chdir_notify_entries) {
+		struct chdir_notify_entry *e =
+			list_entry(pos, struct chdir_notify_entry, list);
+		e->cb(e->name, old_cwd.buf, new_cwd, e->data);
+	}
+
+	strbuf_release(&old_cwd);
+	return 0;
+}
+
+char *reparent_relative_path(const char *old_cwd,
+			     const char *new_cwd,
+			     const char *path)
+{
+	char *ret, *full;
+
+	if (is_absolute_path(path))
+		return xstrdup(path);
+
+	full = xstrfmt("%s/%s", old_cwd, path);
+	ret = xstrdup(remove_leading_path(full, new_cwd));
+	free(full);
+
+	return ret;
+}
diff --git a/chdir-notify.h b/chdir-notify.h
new file mode 100644
index 0000000000..366e4c1ee9
--- /dev/null
+++ b/chdir-notify.h
@@ -0,0 +1,73 @@
+#ifndef CHDIR_NOTIFY_H
+#define CHDIR_NOTIFY_H
+
+/*
+ * An API to let code "subscribe" to changes to the current working directory.
+ * The general idea is that some code asks to be notified when the working
+ * directory changes, and other code that calls chdir uses a special wrapper
+ * that notifies everyone.
+ */
+
+/*
+ * Callers who need to know about changes can do:
+ *
+ *   void foo(const char *old_path, const char *new_path, void *data)
+ *   {
+ *	warning("switched from %s to %s!", old_path, new_path);
+ *   }
+ *   ...
+ *   chdir_notify_register("description", foo, data);
+ *
+ * In practice most callers will want to move a relative path to the new root;
+ * they can use the reparent_relative_path() helper for that. If that's all
+ * you're doing, you can also use the convenience function:
+ *
+ *   chdir_notify_reparent("description", &my_path);
+ *
+ * Whenever a chdir event occurs, that will update my_path (if it's relative)
+ * to adjust for the new cwd by freeing any existing string and allocating a
+ * new one.
+ *
+ * Registered functions are called in the order in which they were added. Note
+ * that there's currently no way to remove a function, so make sure that the
+ * data parameter remains valid for the rest of the program.
+ *
+ * The "name" argument is used only for printing trace output from
+ * $GIT_TRACE_SETUP. It may be NULL, but if non-NULL should point to
+ * storage which lasts as long as the registration is active.
+ */
+typedef void (*chdir_notify_callback)(const char *name,
+				      const char *old_cwd,
+				      const char *new_cwd,
+				      void *data);
+void chdir_notify_register(const char *name, chdir_notify_callback cb, void *data);
+void chdir_notify_reparent(const char *name, char **path);
+
+/*
+ *
+ * Callers that want to chdir:
+ *
+ *   chdir_notify(new_path);
+ *
+ * to switch to the new path and notify any callbacks.
+ *
+ * Note that you don't need to chdir_notify() if you're just temporarily moving
+ * to a directory and back, as long as you don't call any subscribed code in
+ * between (but it should be safe to do so if you're unsure).
+ */
+int chdir_notify(const char *new_cwd);
+
+/*
+ * Reparent a relative path from old_root to new_root. For example:
+ *
+ *   reparent_relative_path("/a", "/a/b", "b/rel");
+ *
+ * would return the (newly allocated) string "rel". Note that we may return an
+ * absolute path in some cases (e.g., if the resulting path is not inside
+ * new_cwd).
+ */
+char *reparent_relative_path(const char *old_cwd,
+			     const char *new_cwd,
+			     const char *path);
+
+#endif /* CHDIR_NOTIFY_H */
-- 
2.17.0.rc2.594.gdb94a0ce02

