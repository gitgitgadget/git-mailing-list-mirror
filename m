From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] merge: refactor code that calls "git merge-STRATEGY"
Date: Wed, 31 Mar 2010 21:22:06 +0200
Message-ID: <20100331192209.5827.47547.chriscool@tuxfamily.org>
References: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:45:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx6fO-0003AX-5s
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758313Ab0CaWph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 18:45:37 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53013 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757141Ab0CaWpf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 18:45:35 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D7450818098;
	Thu,  1 Apr 2010 00:45:27 +0200 (CEST)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 98E22818082;
	Thu,  1 Apr 2010 00:45:24 +0200 (CEST)
X-git-sha1: efa6d6cceb000c53e85d279483e3bf8ef420a902 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143700>

In the try_merge_strategy() function, when the strategy is "recursive"
or "subtree", the merge_recursive() function is called.
Otherwise we launch a "git merge-STRATEGY" process.

To make it possible to reuse code that launches a "git merge-STRATEGY"
process, this patch refactors this code into a new try_merge_command()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/merge.c |   81 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index c043066..f163d53 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -548,13 +548,53 @@ static void write_tree_trivial(unsigned char *sha1)
 		die("git write-tree failed to write a tree");
 }
 
-static int try_merge_strategy(const char *strategy, struct commit_list *common,
-			      const char *head_arg)
+static int try_merge_command(const char *strategy, struct commit_list *common,
+			     const char *head_arg, struct commit_list *remotes)
 {
 	const char **args;
 	int i = 0, x = 0, ret;
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
+
+	args = xmalloc((4 + xopts_nr + commit_list_count(common) +
+			commit_list_count(remotes)) * sizeof(char *));
+	strbuf_addf(&buf, "merge-%s", strategy);
+	args[i++] = buf.buf;
+	for (x = 0; x < xopts_nr; x++) {
+		char *s = xmalloc(strlen(xopts[x])+2+1);
+		strcpy(s, "--");
+		strcpy(s+2, xopts[x]);
+		args[i++] = s;
+	}
+	for (j = common; j; j = j->next)
+		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+	args[i++] = "--";
+	args[i++] = head_arg;
+	for (j = remotes; j; j = j->next)
+		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+	args[i] = NULL;
+	ret = run_command_v_opt(args, RUN_GIT_CMD);
+	strbuf_release(&buf);
+	i = 1;
+	for (x = 0; x < xopts_nr; x++)
+		free((void *)args[i++]);
+	for (j = common; j; j = j->next)
+		free((void *)args[i++]);
+	i += 2;
+	for (j = remotes; j; j = j->next)
+		free((void *)args[i++]);
+	free(args);
+	discard_cache();
+	if (read_cache() < 0)
+		die("failed to read the cache");
+	resolve_undo_clear();
+
+	return ret;
+}
+
+static int try_merge_strategy(const char *strategy, struct commit_list *common,
+			      const char *head_arg)
+{
 	int index_fd;
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 
@@ -567,12 +607,13 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	rollback_lock_file(lock);
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
-		int clean;
+		int clean, x = 0;
 		struct commit *result;
 		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int index_fd;
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
+		struct commit_list *j;
 
 		if (remoteheads->next) {
 			error("Not handling anything other than two heads merge.");
@@ -612,39 +653,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		rollback_lock_file(lock);
 		return clean ? 0 : 1;
 	} else {
-		args = xmalloc((4 + xopts_nr + commit_list_count(common) +
-					commit_list_count(remoteheads)) * sizeof(char *));
-		strbuf_addf(&buf, "merge-%s", strategy);
-		args[i++] = buf.buf;
-		for (x = 0; x < xopts_nr; x++) {
-			char *s = xmalloc(strlen(xopts[x])+2+1);
-			strcpy(s, "--");
-			strcpy(s+2, xopts[x]);
-			args[i++] = s;
-		}
-		for (j = common; j; j = j->next)
-			args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
-		args[i++] = "--";
-		args[i++] = head_arg;
-		for (j = remoteheads; j; j = j->next)
-			args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
-		args[i] = NULL;
-		ret = run_command_v_opt(args, RUN_GIT_CMD);
-		strbuf_release(&buf);
-		i = 1;
-		for (x = 0; x < xopts_nr; x++)
-			free((void *)args[i++]);
-		for (j = common; j; j = j->next)
-			free((void *)args[i++]);
-		i += 2;
-		for (j = remoteheads; j; j = j->next)
-			free((void *)args[i++]);
-		free(args);
-		discard_cache();
-		if (read_cache() < 0)
-			die("failed to read the cache");
-		resolve_undo_clear();
-		return ret;
+		return try_merge_command(strategy, common, head_arg, remoteheads);
 	}
 }
 
-- 
1.7.0.3.454.gd9aeb
