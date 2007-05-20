From: skimo@liacs.nl
Subject: [PATCH 07/15] unpack-trees.c: assume submodules are clean
Date: Sun, 20 May 2007 20:04:40 +0200
Message-ID: <11796842892303-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmu-0007La-8l
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081AbXETSFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757383AbXETSFW
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:22 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37221 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757081AbXETSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:04 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4rxw007815;
	Sun, 20 May 2007 20:04:58 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 5BDE27DDA6; Sun, 20 May 2007 20:04:49 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47873>

From: Sven Verdoolaege <skimo@kotnet.org>

If the submodules are not clean, then we will get an error
when we actally do the checkout.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 unpack-trees.c |   43 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4497a46..f3fe2dd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -5,6 +5,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "progress.h"
+#include "refs.h"
 
 #define DBRT_DEBUG 1
 
@@ -430,11 +431,24 @@ static void invalidate_ce_path(struct cache_entry *ce)
 		cache_tree_invalidate_path(active_cache_tree, ce->name);
 }
 
-static int verify_clean_subdirectory(const char *path, const char *action,
+/* Check that checking out ce->sha1 in subdir ce->name is not
+ * going to overwrite any working files.
+ *
+ * FIXME: implement this function, so we can detect problems
+ *        early, rather than waiting until we actually try to checkout
+ *        the submodules.
+ */
+static int verify_clean_submodule(struct cache_entry *ce, const char *action,
+				      struct unpack_trees_options *o)
+{
+	return 0;
+}
+
+static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 				      struct unpack_trees_options *o)
 {
 	/*
-	 * we are about to extract "path"; we would not want to lose
+	 * we are about to extract "ce->name"; we would not want to lose
 	 * anything in the existing directory there.
 	 */
 	int namelen;
@@ -442,13 +456,24 @@ static int verify_clean_subdirectory(const char *path, const char *action,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
+	unsigned char sha1[20];
+
+	if (S_ISDIRLNK(ntohl(ce->ce_mode)) &&
+	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
+		/* If we are not going to update the submodule, then
+		 * we don't care.
+		 */
+		if (!o->submodules || !hashcmp(sha1, ce->sha1))
+			return 0;
+		verify_clean_submodule(ce, action, o);
+	}
 
 	/*
 	 * First let's make sure we do not have a local modification
 	 * in that directory.
 	 */
-	namelen = strlen(path);
-	pos = cache_name_pos(path, namelen);
+	namelen = strlen(ce->name);
+	pos = cache_name_pos(ce->name, namelen);
 	if (0 <= pos)
 		return cnt; /* we have it as nondirectory */
 	pos = -pos - 1;
@@ -456,7 +481,7 @@ static int verify_clean_subdirectory(const char *path, const char *action,
 		struct cache_entry *ce = active_cache[i];
 		int len = ce_namelen(ce);
 		if (len < namelen ||
-		    strncmp(path, ce->name, namelen) ||
+		    strncmp(ce->name, ce->name, namelen) ||
 		    ce->name[namelen] != '/')
 			break;
 		/*
@@ -474,16 +499,16 @@ static int verify_clean_subdirectory(const char *path, const char *action,
 	 * present file that is not ignored.
 	 */
 	pathbuf = xmalloc(namelen + 2);
-	memcpy(pathbuf, path, namelen);
+	memcpy(pathbuf, ce->name, namelen);
 	strcpy(pathbuf+namelen, "/");
 
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, path, pathbuf, namelen+1, NULL);
+	i = read_directory(&d, ce->name, pathbuf, namelen+1, NULL);
 	if (i)
 		die("Updating '%s' would lose untracked files in it",
-		    path);
+		    ce->name);
 	free(pathbuf);
 	return cnt;
 }
@@ -517,7 +542,7 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 			 * files that are in "foo/" we would lose
 			 * it.
 			 */
-			cnt = verify_clean_subdirectory(ce->name, action, o);
+			cnt = verify_clean_subdirectory(ce, action, o);
 
 			/*
 			 * If this removed entries from the index,
-- 
1.5.2.rc3.815.g8fc2
