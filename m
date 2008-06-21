From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Introduce reduce_heads()
Date: Sat, 21 Jun 2008 02:45:55 -0700
Message-ID: <7vfxr7azos.fsf@gitster.siamese.dyndns.org>
References: <7vabhgq02p.fsf@gitster.siamese.dyndns.org>
 <1214007784-4801-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 21 11:47:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9zga-0006Hk-TP
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 11:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYFUJqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 05:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYFUJqI
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 05:46:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbYFUJqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 05:46:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 026D1A70A;
	Sat, 21 Jun 2008 05:46:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CC141A709; Sat, 21 Jun 2008 05:45:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC8DEEBC-3F76-11DD-95E3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85698>

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
 * The important part of this patch is the addition to commit.c to show
   how I would write your filter_independent().  The new command is not
   essential, but is included as a demonstration.

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
index b460b2d..b6fb163 100644
--- a/builtin.h
+++ b/builtin.h
@@ -72,6 +72,7 @@ extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
+extern int cmd_reduce_heads(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
diff --git a/commit.c b/commit.c
index 4ee234d..0fc4acb 100644
--- a/commit.c
+++ b/commit.c
@@ -690,3 +690,48 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
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
index 2d94d41..ec95102 100644
--- a/commit.h
+++ b/commit.h
@@ -138,4 +138,6 @@ static inline int single_parent(struct commit *commit)
 	return commit->parents && !commit->parents->next;
 }
 
+struct commit_list *reduce_heads(struct commit_list *heads);
+
 #endif /* COMMIT_H */
diff --git a/git.c b/git.c
index 59f0fcc..23b690d 100644
--- a/git.c
+++ b/git.c
@@ -338,6 +338,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
+		{ "reduce-heads", cmd_reduce_heads, RUN_SETUP },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "repo-config", cmd_config },
-- 
1.5.6.6.gd3e97
