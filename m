From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-merge: avoid run_command_v_opt() for recursive and subtree
Date: Thu, 28 Aug 2008 15:43:00 +0200
Message-ID: <1219930980-29114-1-git-send-email-vmiklos@frugalware.org>
References: <7vtzdbuqb6.fsf@gitster.siamese.dyndns.org>
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 15:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYhmk-0007BC-Bd
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbYH1Nmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 09:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbYH1Nmc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:42:32 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:58807 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbYH1Nmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:42:31 -0400
Received: from vmobile.example.net (dsl5401CCE0.pool.t-online.hu [84.1.204.224])
	by yugo.frugalware.org (Postfix) with ESMTP id 74E1C1DDC5B;
	Thu, 28 Aug 2008 15:42:28 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6DD2184CA; Thu, 28 Aug 2008 15:43:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <7vtzdbuqb6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94053>

The try_merge_strategy() function always ran the strategy in a separate
process, though this is not always necessary. The recursive and subtree
strategy can be called without a fork(). This patch adds a check, and
calls recursive in the same process without wasting resources.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Aug 23, 2008 at 06:58:37PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> By the way, in the medium term, if we are serious about making an
> internal call to merge_recursive() from cmd_merge(), I think we may be
> better off making it the responsibility for try_merge_strategy() to
> leave an committable state in the in-core index (aka "the_index") when
> they return with 0 (success) status.  After calling external ones via
> the run_command interface, it should do a read_cache() (after calling
> discard_cache() if needed); if it calls merge_recursive(), hopefully
> you already have the committable state in the in-core index.
>
> That way, when automerge succeeds, write_tree_trivial() can write that
> in-core index out and create the tree object to be committed. The
> callchain to use merge_recursive() can avoid having to write to the
> on-disk index, read it again and write out the tree from it.

This is mostly the same patch I submitted earlier, but this is now on
top of mv/merge-recursive, and now it does what you suggested above.

 builtin-merge.c |   92 +++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 63 insertions(+), 29 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 0bff26e..3a38089 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -22,6 +22,7 @@
 #include "log-tree.h"
 #include "color.h"
 #include "rerere.h"
+#include "merge-recursive.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -511,28 +512,64 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	struct commit_list *j;
 	struct strbuf buf;
 
-	args = xmalloc((4 + commit_list_count(common) +
-			commit_list_count(remoteheads)) * sizeof(char *));
-	strbuf_init(&buf, 0);
-	strbuf_addf(&buf, "merge-%s", strategy);
-	args[i++] = buf.buf;
-	for (j = common; j; j = j->next)
-		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
-	args[i++] = "--";
-	args[i++] = head_arg;
-	for (j = remoteheads; j; j = j->next)
-		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
-	args[i] = NULL;
-	ret = run_command_v_opt(args, RUN_GIT_CMD);
-	strbuf_release(&buf);
-	i = 1;
-	for (j = common; j; j = j->next)
-		free((void *)args[i++]);
-	i += 2;
-	for (j = remoteheads; j; j = j->next)
-		free((void *)args[i++]);
-	free(args);
-	return -ret;
+	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
+		int clean;
+		struct commit *result;
+		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+		int index_fd;
+		struct commit_list *reversed = NULL;
+		struct merge_options o;
+
+		if (remoteheads->next) {
+			error("Not handling anything other than two heads merge.");
+			return 2;
+		}
+
+		init_merge_options(&o);
+		if (!strcmp(strategy, "subtree"))
+			o.subtree_merge = 1;
+
+		o.branch1 = head_arg;
+		o.branch2 = remoteheads->item->util;
+
+		for (j = common; j; j = j->next)
+			commit_list_insert(j->item, &reversed);
+
+		index_fd = hold_locked_index(lock, 1);
+		clean = merge_recursive(&o, lookup_commit(head),
+				remoteheads->item, reversed, &result);
+		if (active_cache_changed &&
+				(write_cache(index_fd, active_cache, active_nr) ||
+				 commit_locked_index(lock)))
+			die ("unable to write %s", get_index_file());
+		return clean ? 0 : 1;
+	} else {
+		args = xmalloc((4 + commit_list_count(common) +
+					commit_list_count(remoteheads)) * sizeof(char *));
+		strbuf_init(&buf, 0);
+		strbuf_addf(&buf, "merge-%s", strategy);
+		args[i++] = buf.buf;
+		for (j = common; j; j = j->next)
+			args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+		args[i++] = "--";
+		args[i++] = head_arg;
+		for (j = remoteheads; j; j = j->next)
+			args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+		args[i] = NULL;
+		ret = run_command_v_opt(args, RUN_GIT_CMD);
+		strbuf_release(&buf);
+		i = 1;
+		for (j = common; j; j = j->next)
+			free((void *)args[i++]);
+		i += 2;
+		for (j = remoteheads; j; j = j->next)
+			free((void *)args[i++]);
+		free(args);
+		discard_cache();
+		if (read_cache() < 0)
+			die("failed to read the cache");
+		return -ret;
+	}
 }
 
 static void count_diff_files(struct diff_queue_struct *q,
@@ -743,10 +780,6 @@ static int evaluate_result(void)
 	int cnt = 0;
 	struct rev_info rev;
 
-	discard_cache();
-	if (read_cache() < 0)
-		die("failed to read the cache");
-
 	/* Check how many files differ. */
 	init_revisions(&rev, "");
 	setup_revisions(0, NULL, &rev, NULL);
@@ -880,12 +913,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < argc; i++) {
 		struct object *o;
+		struct commit *commit;
 
 		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
 		if (!o)
 			die("%s - not something we can merge", argv[i]);
-		remotes = &commit_list_insert(lookup_commit(o->sha1),
-			remotes)->next;
+		commit = lookup_commit(o->sha1);
+		commit->util = (void *)argv[i];
+		remotes = &commit_list_insert(commit, remotes)->next;
 
 		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
 		setenv(buf.buf, argv[i], 1);
@@ -1079,7 +1114,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 
 		/* Automerge succeeded. */
-		discard_cache();
 		write_tree_trivial(result_tree);
 		automerge_was_ok = 1;
 		break;
-- 
1.6.0
