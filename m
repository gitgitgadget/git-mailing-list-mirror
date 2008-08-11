From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] builtin-revert.c: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 17:03:23 +0200
Message-ID: <1218467003-14591-1-git-send-email-s-beyer@gmx.net>
References: <cover.1218374062.git.vmiklos@frugalware.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 17:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSYwf-0004SC-6E
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbYHKPD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbYHKPD1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:03:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:43111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751532AbYHKPD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:03:26 -0400
Received: (qmail invoked by alias); 11 Aug 2008 15:03:24 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp029) with SMTP; 11 Aug 2008 17:03:24 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19mPt43yyBmHuCTaAkVgRpOIz3c07gqTRXy4sutpQ
	FQwPXTcJnfWSYM
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSYvb-0003nj-3q; Mon, 11 Aug 2008 17:03:23 +0200
X-Mailer: git-send-email 1.6.0.rc2.264.g563b6
In-Reply-To: <cover.1218374062.git.vmiklos@frugalware.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91942>

Cherry-pick and revert always ran the merging in a separate process.
This patch makes cherry-pick/revert call merge_recursive() instead
of running git-merge-recursive.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
	Hi,
	I wonder if this patch fits in line.

 builtin-merge-recursive.c |    2 +-
 builtin-revert.c          |   41 ++++++++++++++++++++++-------------------
 merge-recursive.h         |    1 +
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 09aa830..d8bd21f 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -1327,7 +1327,7 @@ static const char *better_branch_name(const char *branch)
 	return name ? name : branch;
 }
 
-static struct commit *get_ref(const char *ref)
+struct commit *get_ref(const char *ref)
 {
 	unsigned char sha1[20];
 	struct object *object;
diff --git a/builtin-revert.c b/builtin-revert.c
index 27881e9..c54cf8a 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -11,6 +11,7 @@
 #include "cache-tree.h"
 #include "diff.h"
 #include "revision.h"
+#include "merge-recursive.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -200,18 +201,14 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
-static int merge_recursive(const char *base_sha1,
+static int merge_recursive_helper(const char *base_sha1,
 		const char *head_sha1, const char *head_name,
 		const char *next_sha1, const char *next_name)
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
+	struct commit *result, *h1, *h2;
+	struct commit_list *ca = NULL;
 
 	/*
 	 * This three way merge is an interesting one.  We are at
@@ -219,15 +216,21 @@ static int merge_recursive(const char *base_sha1,
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
+	if (base_sha1) {
+		struct commit *base = get_ref(base_sha1);
+		commit_list_insert(base, &ca);
+	}
+	h1 = get_ref(head_sha1);
+	h2 = get_ref(next_sha1);
+
+	index_fd = hold_locked_index(lock, 1);
+	clean = merge_recursive(h1, h2, head_name, next_name, ca, &result);
+	if (active_cache_changed &&
+			(write_cache(index_fd, active_cache, active_nr) ||
+			 commit_locked_index(lock)))
+		die("Unable to write index.");
+
+	return clean ? 0 : 1;
 }
 
 static char *help_msg(const unsigned char *sha1)
@@ -373,7 +376,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	if (merge_recursive(base == NULL ?
+	if (merge_recursive_helper(base == NULL ?
 				NULL : sha1_to_hex(base->object.sha1),
 				sha1_to_hex(head), "HEAD",
 				sha1_to_hex(next->object.sha1), oneline) ||
diff --git a/merge-recursive.h b/merge-recursive.h
index f37630a..40f329b 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,6 +1,7 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
 
+struct commit *get_ref(const char *ref);
 int merge_recursive(struct commit *h1,
 		    struct commit *h2,
 		    const char *branch1,
-- 
1.6.0.rc2.264.g563b6
