From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/3] Use struct commit in tar-tree
Date: Sun, 29 Jan 2006 14:05:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601291405030.25300@iabervon.org>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 29 20:03:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3HpP-0004EX-5s
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 20:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWA2TDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 14:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWA2TDJ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 14:03:09 -0500
Received: from iabervon.org ([66.92.72.58]:47629 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751115AbWA2TDI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 14:03:08 -0500
Received: (qmail 19695 invoked by uid 1000); 29 Jan 2006 14:05:20 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2006 14:05:20 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15231>

It was open-coding getting the commit date from a commit.

Signed-off-by: Daniel Barkalow <barkalow@iabervon>

---

 tar-tree.c |   41 ++++++-----------------------------------
 1 files changed, 6 insertions(+), 35 deletions(-)

ca523a725295fff6f1456cd7207f6b24f8c2e843
diff --git a/tar-tree.c b/tar-tree.c
index 6219754..d36baed 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -4,6 +4,7 @@
 #include <time.h>
 #include "cache.h"
 #include "tree.h"
+#include "commit.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
@@ -369,39 +370,10 @@ static void traverse_tree(struct tree *t
 	}
 }
 
-/* get commit time from committer line of commit object */
-static time_t commit_time(void * buffer, unsigned long size)
-{
-	time_t result = 0;
-	char *p = buffer;
-
-	while (size > 0) {
-		char *endp = memchr(p, '\n', size);
-		if (!endp || endp == p)
-			break;
-		*endp = '\0';
-		if (endp - p > 10 && !memcmp(p, "committer ", 10)) {
-			char *nump = strrchr(p, '>');
-			if (!nump)
-				break;
-			nump++;
-			result = strtoul(nump, &endp, 10);
-			if (*endp != ' ')
-				result = 0;
-			break;
-		}
-		size -= endp - p - 1;
-		p = endp + 1;
-	}
-	return result;
-}
-
 int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
-	unsigned char commit_sha1[20];
-	void *buffer;
-	unsigned long size;
+	struct commit *commit;
 	struct tree *tree;
 
 	setup_git_directory();
@@ -418,11 +390,10 @@ int main(int argc, char **argv)
 		usage(tar_tree_usage);
 	}
 
-	buffer = read_object_with_reference(sha1, "commit", &size, commit_sha1);
-	if (buffer) {
-		write_global_extended_header(commit_sha1);
-		archive_time = commit_time(buffer, size);
-		free(buffer);
+	commit = lookup_commit_reference(sha1);
+	if (commit) {
+		write_global_extended_header(commit->object.sha1);
+		archive_time = commit->date;
 	}
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
-- 
1.0.GIT
