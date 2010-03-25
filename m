From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 3/5] merge: refactor code that calls "git merge-STRATEGY"
Date: Thu, 25 Mar 2010 05:58:15 +0100
Message-ID: <20100325045818.14832.28912.chriscool@tuxfamily.org>
References: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufE9-0002BG-EA
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab0CYFDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:03:25 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49338 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab0CYFDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:03:23 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0E309818068;
	Thu, 25 Mar 2010 06:03:14 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C83B5818062;
	Thu, 25 Mar 2010 06:03:11 +0100 (CET)
X-git-sha1: bd184eb726ef0077da98284a7ab131d40ba086a5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100325045519.14832.65964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143154>

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
1.7.0.2.398.g89bc8ce
