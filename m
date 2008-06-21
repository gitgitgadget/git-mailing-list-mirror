From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 11/13] Introduce reduce_heads()
Date: Sat, 21 Jun 2008 19:00:48 +0200
Message-ID: <5cae08d3bf2852a8bbd8dc8cdf741cb4bdfa237e.1214066799.git.vmiklos@frugalware.org>
References: <cover.1214066798.git.vmiklos@frugalware.org>
 <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org>
 <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 19:02:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA6TR-0000Zo-2V
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 19:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbYFURA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 13:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbYFURA4
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 13:00:56 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33723 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYFURAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 13:00:52 -0400
Received: from vmobile.example.net (dsl5402CEE1.pool.t-online.hu [84.2.206.225])
	by yugo.frugalware.org (Postfix) with ESMTP id 8FB011DDC5E;
	Sat, 21 Jun 2008 19:00:49 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 0E79618E0E7; Sat, 21 Jun 2008 19:00:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214066798.git.vmiklos@frugalware.org>
References: <cover.1214066798.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85717>

From: Junio C Hamano <gitster@pobox.com>

The new function reduce_heads() is given a list of commits, and removes
ones that can be reached from other commits in the list.  It is useful for
reducing the commits randomly thrown at the git-merge command and remove
redundant commits that the user shouldn't have given to it.

The implementation uses the get_merge_bases_many() introduced in the
previous commit.  If the merge base between one commit taken from the list
and the remaining commits is the commit itself, that means the commit is
reachable from some of the other commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile               |    1 +
 builtin-reduce-heads.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 builtin.h              |    1 +
 commit.c               |   45 +++++++++++++++++++++++++++++++++++++++++++++
 commit.h               |    2 ++
 git.c                  |    1 +
 6 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100644 builtin-reduce-heads.c

diff --git a/Makefile b/Makefile
index b003e3e..d660756 100644
--- a/Makefile
+++ b/Makefile
@@ -522,6 +522,7 @@ BUILTIN_OBJS += builtin-pack-refs.o
 BUILTIN_OBJS += builtin-prune-packed.o
 BUILTIN_OBJS += builtin-prune.o
 BUILTIN_OBJS += builtin-push.o
+BUILTIN_OBJS += builtin-reduce-heads.o
 BUILTIN_OBJS += builtin-read-tree.o
 BUILTIN_OBJS += builtin-reflog.o
 BUILTIN_OBJS += builtin-remote.o
diff --git a/builtin-reduce-heads.c b/builtin-reduce-heads.c
new file mode 100644
index 0000000..ff6178d
--- /dev/null
+++ b/builtin-reduce-heads.c
@@ -0,0 +1,44 @@
+#include "cache.h"
+#include "commit.h"
+#include "strbuf.h"
+
+static void show_commit_list(struct commit_list *list)
+{
+	while (list) {
+		struct strbuf it;
+		struct commit *commit = list->item;
+
+		list = list->next;
+		strbuf_init(&it, 128);
+		parse_commit(commit);
+		pretty_print_commit(CMIT_FMT_ONELINE, commit, &it,
+				    0, NULL, NULL, 0, 0);
+		puts(it.buf);
+		strbuf_release(&it);
+	}
+}
+
+int cmd_reduce_heads(int ac, const char **av, const char *prefix)
+{
+	struct commit_list *list = NULL, **tail = &list;
+	int i;
+
+	for (i = 1; i < ac; i++) {
+		struct commit *commit;
+		unsigned char sha1[20];
+
+		if (get_sha1(av[i], sha1))
+			die("'%s' is not a valid ref.", av[i]);
+		commit = lookup_commit_reference(sha1);
+		if (!commit)
+			die("cannot find commit %s", av[i]);
+		tail = &commit_list_insert(commit, tail)->next;
+	}
+
+	show_commit_list(list);
+	putchar('\n');
+
+	list = reduce_heads(list);
+	show_commit_list(list);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 2b01fea..f069ee7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -75,6 +75,7 @@ extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
+extern int cmd_reduce_heads(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
diff --git a/commit.c b/commit.c
index cafed26..d20b14e 100644
--- a/commit.c
+++ b/commit.c
@@ -725,3 +725,48 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	free_commit_list(bases);
 	return ret;
 }
+
+struct commit_list *reduce_heads(struct commit_list *heads)
+{
+	struct commit_list *p;
+	struct commit_list *result = NULL, **tail = &result;
+	struct commit **other;
+	size_t num_head, num_other;
+
+	if (!heads)
+		return NULL;
+
+	/* Avoid unnecessary reallocations */
+	for (p = heads, num_head = 0; p; p = p->next)
+		num_head++;
+	other = xcalloc(sizeof(*other), num_head);
+
+	/* For each commit, see if it can be reached by others */
+	for (p = heads; p; p = p->next) {
+		struct commit_list *q, *base;
+
+		num_other = 0;
+		for (q = heads; q; q = q->next) {
+			if (p == q)
+				continue;
+			other[num_other++] = q->item;
+		}
+		if (num_other) {
+			base = get_merge_bases_many(p->item, num_other, other, 1);
+		} else
+			base = NULL;
+		/*
+		 * If p->item does not have anything common with other
+		 * commits, there won't be any merge base.  If it is
+		 * reachable from some of the others, p->item will be
+		 * the merge base.  If its history is connected with
+		 * others, but p->item is not reachable by others, we
+		 * will get something other than p->item back.
+		 */
+		if (!base || (base->item != p->item))
+			tail = &(commit_list_insert(p->item, tail)->next);
+		free_commit_list(base);
+	}
+	free(other);
+	return result;
+}
diff --git a/commit.h b/commit.h
index dcec7fb..2acfc79 100644
--- a/commit.h
+++ b/commit.h
@@ -140,4 +140,6 @@ static inline int single_parent(struct commit *commit)
 	return commit->parents && !commit->parents->next;
 }
 
+struct commit_list *reduce_heads(struct commit_list *heads);
+
 #endif /* COMMIT_H */
diff --git a/git.c b/git.c
index 2fbe96b..80b16ce 100644
--- a/git.c
+++ b/git.c
@@ -285,6 +285,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
+		{ "reduce-heads", cmd_reduce_heads, RUN_SETUP },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "repo-config", cmd_config },
-- 
1.5.6
