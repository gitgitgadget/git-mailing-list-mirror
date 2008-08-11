From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] builtin-revert: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 23:44:56 +0200
Message-ID: <1218491096-28756-1-git-send-email-s-beyer@gmx.net>
References: <20080811190924.GR18960@genesis.frugalware.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 23:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSfDL-0006W2-W3
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 23:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbYHKVpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 17:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbYHKVpE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 17:45:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:36331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751977AbYHKVpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 17:45:01 -0400
Received: (qmail invoked by alias); 11 Aug 2008 21:44:59 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp008) with SMTP; 11 Aug 2008 23:44:59 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/qzNc0tnDq2B0sOtsIFvWen7hLiL+CWgccSOXR2y
	4V9BkGPmlvdZ9X
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSfCC-0007UQ-LD; Mon, 11 Aug 2008 23:44:56 +0200
X-Mailer: git-send-email 1.6.0.rc2.267.g02e66a
In-Reply-To: <20080811190924.GR18960@genesis.frugalware.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92006>

Cherry-pick and revert always ran the merging in a separate process.
This patch makes cherry-pick/revert call merge_recursive() instead
of running git-merge-recursive.

To be able to cherry-pick/revert -n (without committing) on a dirty
index, make_virtual_commit() is needed and thus declared non-static.

Also the GITHEAD_* environment definitions are not needed anymore,
since the names are direct arguments to make_virtual_commit() and
merge_recursive().

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
	Hi,
	so I give it a new try.

 builtin-merge-recursive.c |    2 +-
 builtin-revert.c          |   56 +++++++++++++++++++++++++-------------------
 merge-recursive.h         |    2 +
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 09aa830..395bdf8 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -42,7 +42,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two)
  * - *(int *)commit->object.sha1 set to the virtual id.
  */
 
-static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
+struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
 	struct commit *commit = xcalloc(1, sizeof(struct commit));
 	static unsigned virtual_id = 1;
diff --git a/builtin-revert.c b/builtin-revert.c
index 27881e9..dcee181 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -11,6 +11,7 @@
 #include "cache-tree.h"
 #include "diff.h"
 #include "revision.h"
+#include "merge-recursive.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -200,18 +201,27 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
-static int merge_recursive(const char *base_sha1,
-		const char *head_sha1, const char *head_name,
-		const char *next_sha1, const char *next_name)
+static int merge_recursive_helper(const unsigned char *base_sha1,
+		const unsigned char *head_sha1, const char *head_name,
+		const unsigned char *next_sha1, const char *next_name)
 {
-	char buffer[256];
-	const char *argv[6];
-	int i = 0;
-
-	sprintf(buffer, "GITHEAD_%s", head_sha1);
-	setenv(buffer, head_name, 1);
-	sprintf(buffer, "GITHEAD_%s", next_sha1);
-	setenv(buffer, next_name, 1);
+	int clean, index_fd;
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	struct commit *result;
+	struct commit *head_commit, *next_commit;
+	struct object *head_object = parse_object(head_sha1);
+	struct commit_list *ca = NULL;
+
+	if (base_sha1) {
+		struct commit *base = lookup_commit_reference(base_sha1);
+		commit_list_insert(base, &ca);
+	}
+	if (head_object->type == OBJ_TREE)
+		head_commit = make_virtual_commit((struct tree *)head_object,
+						  head_name);
+	else
+		head_commit = (struct commit *)head_object;
+	next_commit = lookup_commit_reference(next_sha1);
 
 	/*
 	 * This three way merge is an interesting one.  We are at
@@ -219,15 +229,15 @@ static int merge_recursive(const char *base_sha1,
 	 * and $prev on top of us (when reverting), or the change between
 	 * $prev and $commit on top of us (when cherry-picking or replaying).
 	 */
-	argv[i++] = "merge-recursive";
-	if (base_sha1)
-		argv[i++] = base_sha1;
-	argv[i++] = "--";
-	argv[i++] = head_sha1;
-	argv[i++] = next_sha1;
-	argv[i++] = NULL;
-
-	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
+	index_fd = hold_locked_index(lock, 1);
+	clean = merge_recursive(head_commit, next_commit,
+				head_name, next_name, ca, &result);
+	if (active_cache_changed &&
+			(write_cache(index_fd, active_cache, active_nr) ||
+			 commit_locked_index(lock)))
+		die("Unable to write index.");
+
+	return clean ? 0 : 1;
 }
 
 static char *help_msg(const unsigned char *sha1)
@@ -373,10 +383,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	if (merge_recursive(base == NULL ?
-				NULL : sha1_to_hex(base->object.sha1),
-				sha1_to_hex(head), "HEAD",
-				sha1_to_hex(next->object.sha1), oneline) ||
+	if (merge_recursive_helper(base == NULL ? NULL : base->object.sha1,
+				   head, "HEAD", next->object.sha1, oneline) ||
 			write_cache_as_tree(head, 0, NULL)) {
 		add_to_msg("\nConflicts:\n\n");
 		read_cache();
diff --git a/merge-recursive.h b/merge-recursive.h
index f37630a..a9eead3 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,6 +1,8 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
 
+extern struct commit *make_virtual_commit(struct tree *tree,
+					  const char *comment);
 int merge_recursive(struct commit *h1,
 		    struct commit *h2,
 		    const char *branch1,
-- 
1.6.0.rc2.267.g02e66a
