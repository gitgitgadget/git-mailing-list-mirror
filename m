From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/2] builtin-merge: avoid run_command_v_opt() for recursive
Date: Sun, 10 Aug 2008 15:20:24 +0200
Message-ID: <ea5b9868df7c17c55cd091b4408f08a310bed641.1218374062.git.vmiklos@frugalware.org>
References: <cover.1218374062.git.vmiklos@frugalware.org>
 <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 15:21:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSArD-0007UW-9y
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 15:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYHJNUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 09:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYHJNUG
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 09:20:06 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36835 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbYHJNT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 09:19:59 -0400
Received: from vmobile.example.net (dsl5401CE89.pool.t-online.hu [84.1.206.137])
	by yugo.frugalware.org (Postfix) with ESMTP id E7E1C1DDC5D;
	Sun, 10 Aug 2008 15:19:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2FDE71A5FBF; Sun, 10 Aug 2008 15:20:25 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1218374062.git.vmiklos@frugalware.org>
References: <cover.1218374062.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91837>

The try_merge_strategy() function always ran the strategy in a separate
process, though this is not always necessary. The recursive strategy can
be called without a fork(). This patch adds a check, and calls recursive
in the same process without wasting resources.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Adding the signoff of Dscho as well, as he wrote the last hunk.

 builtin-merge.c |   82 ++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 57 insertions(+), 25 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index dde0c7e..2789a78 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -22,6 +22,7 @@
 #include "log-tree.h"
 #include "color.h"
 #include "rerere.h"
+#include "merge-recursive.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -511,28 +512,55 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
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
+	if (!strcmp(strategy, "recursive")) {
+		int clean;
+		struct commit *result;
+		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+		int index_fd;
+		struct commit_list *reversed = NULL;
+
+		if (remoteheads->next) {
+			error("Not handling anything other than two heads merge.");
+			return 2;
+		}
+
+		for (j = common; j; j = j->next)
+			commit_list_insert(j->item, &reversed);
+
+		index_fd = hold_locked_index(lock, 1);
+		clean = merge_recursive(lookup_commit(head),
+				remoteheads->item, head_arg,
+				(const char *)remoteheads->item->util,
+				reversed, &result);
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
+		return -ret;
+	}
 }
 
 static void count_diff_files(struct diff_queue_struct *q,
@@ -670,7 +698,9 @@ static int finish_automerge(struct commit_list *common,
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char result_commit[20];
 
-	free_commit_list(common);
+	if (strcmp(wt_strategy, "recursive"))
+		/* recursive already freed it */
+		free_commit_list(common);
 	if (allow_fast_forward) {
 		parents = remoteheads;
 		commit_list_insert(lookup_commit(head), &parents);
@@ -873,12 +903,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
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
-- 
1.6.0.rc0.14.g95f8.dirty
