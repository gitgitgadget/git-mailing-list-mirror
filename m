From: skimo@liacs.nl
Subject: [PATCH 08/22] unpack-trees.c: assume submodules are clean
Date: Thu, 24 May 2007 00:22:57 +0200
Message-ID: <11799589922975-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:24:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFt-0003VS-AD
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbXEWWYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756592AbXEWWYN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:24:13 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33785 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757168AbXEWWXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:45 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNGs2011563;
	Thu, 24 May 2007 00:23:21 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 352E17DDA6; Thu, 24 May 2007 00:23:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48197>

From: Sven Verdoolaege <skimo@kotnet.org>

If the submodules are not clean, then we will get an error
when we actally do the checkout.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 unpack-trees.c |   43 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5fa637a..2f2d9b9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -5,6 +5,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "progress.h"
+#include "refs.h"
 
 #define DBRT_DEBUG 1
 
@@ -426,11 +427,24 @@ static void invalidate_ce_path(struct cache_entry *ce)
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
@@ -438,13 +452,24 @@ static int verify_clean_subdirectory(const char *path, const char *action,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
+	unsigned char sha1[20];
+
+	if (S_ISGITLINK(ntohl(ce->ce_mode)) &&
+	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
+		/* If we are not going to update the submodule, then
+		 * we don't care.
+		 */
+		if (!hashcmp(sha1, ce->sha1))
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
@@ -452,7 +477,7 @@ static int verify_clean_subdirectory(const char *path, const char *action,
 		struct cache_entry *ce = active_cache[i];
 		int len = ce_namelen(ce);
 		if (len < namelen ||
-		    strncmp(path, ce->name, namelen) ||
+		    strncmp(ce->name, ce->name, namelen) ||
 		    ce->name[namelen] != '/')
 			break;
 		/*
@@ -470,16 +495,16 @@ static int verify_clean_subdirectory(const char *path, const char *action,
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
@@ -513,7 +538,7 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 			 * files that are in "foo/" we would lose
 			 * it.
 			 */
-			cnt = verify_clean_subdirectory(ce->name, action, o);
+			cnt = verify_clean_subdirectory(ce, action, o);
 
 			/*
 			 * If this removed entries from the index,
-- 
1.5.2.784.g5532e
