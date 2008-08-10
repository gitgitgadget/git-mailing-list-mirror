From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/2] merge-recursive: prepare merge_recursive() to be called from builtins
Date: Sun, 10 Aug 2008 15:20:23 +0200
Message-ID: <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org>
References: <cover.1218374062.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 15:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSArC-0007UW-Kz
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 15:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbYHJNUC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 09:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYHJNUB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 09:20:01 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36833 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbYHJNT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 09:19:59 -0400
Received: from vmobile.example.net (dsl5401CE89.pool.t-online.hu [84.1.206.137])
	by yugo.frugalware.org (Postfix) with ESMTP id DF2611DDC5B
	for <git@vger.kernel.org>; Sun, 10 Aug 2008 15:19:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 157011A5FBE; Sun, 10 Aug 2008 15:20:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <cover.1218374062.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1218374062.git.vmiklos@frugalware.org>
References: <cover.1218374062.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91836>

When other builtins call merge_recursive(), they would have to handle
the GIT_MERGE_VERBOSITY environment variable, causing a code
duplication. Same story for the git_config() call. It's better to do it
when merge_recursive() is called the first time.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-merge-recursive.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 43e55bf..09aa830 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -1218,6 +1218,8 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
 	return next;
 }
 
+static int merge_config(const char *var, const char *value, void *cb);
+
 /*
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleanness of the merge.
@@ -1233,6 +1235,17 @@ int merge_recursive(struct commit *h1,
 	struct commit *merged_common_ancestors;
 	struct tree *mrtree = mrtree;
 	int clean;
+	static int initial = 1;
+
+	if (initial) {
+		git_config(merge_config, NULL);
+		if (getenv("GIT_MERGE_VERBOSITY"))
+			verbosity = strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
+		if (verbosity >= 5)
+			buffer_output = 0;
+
+		initial = 0;
+	}
 
 	if (show(4)) {
 		output(4, "Merging:");
@@ -1369,10 +1382,6 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 			subtree_merge = 1;
 	}
 
-	git_config(merge_config, NULL);
-	if (getenv("GIT_MERGE_VERBOSITY"))
-		verbosity = strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
-
 	if (argc < 4)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
 
@@ -1384,8 +1393,6 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	}
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
-	if (verbosity >= 5)
-		buffer_output = 0;
 
 	branch1 = argv[++i];
 	branch2 = argv[++i];
-- 
1.6.0.rc0.14.g95f8.dirty
