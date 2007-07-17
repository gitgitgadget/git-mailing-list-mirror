From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Tue, 17 Jul 2007 20:28:28 +0200
Message-ID: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 20:28:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IArmm-0003My-Tj
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 20:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbXGQS2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 14:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbXGQS2c
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 14:28:32 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:56717 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbXGQS2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 14:28:31 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JLC00ABL5ZGSR@psmtp12.wxs.nl> for git@vger.kernel.org; Tue,
 17 Jul 2007 20:28:29 +0200 (MEST)
Received: (qmail 6271 invoked by uid 500); Tue, 17 Jul 2007 18:28:28 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52786>

In particular, when moving back to a commit without a given submodule
and then moving back forward to a commit with the given submodule,
we shouldn't complain that updating would lose untracked file in
the submodule, because git currently does not checkout subprojects
during superproject check-out.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---

I'm not sure if t7400-submodule-basic is the best place
for the test, but it has the right context for the test.

skimo

 t/t7400-submodule-basic.sh |    9 +++++
 unpack-trees.c             |   75 +++++++++++++++++++++++++++++--------------
 2 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5e91db6..e8ce7cd 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -21,6 +21,10 @@ subcommands of git-submodule.
 #  -add an entry to .gitmodules for submodule 'example'
 #
 test_expect_success 'Prepare submodule testing' '
+	: > t &&
+	git-add t &&
+	git-commit -m "initial commit" &&
+	git branch initial HEAD &&
 	mkdir lib &&
 	cd lib &&
 	git init &&
@@ -166,4 +170,9 @@ test_expect_success 'status should be "up-to-date" after update' '
 	git-submodule status | grep "^ $rev1"
 '
 
+test_expect_success 'checkout superproject with subproject already present' '
+	git-checkout initial &&
+	git-checkout master
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 89dd279..7cc029e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -5,6 +5,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "progress.h"
+#include "refs.h"
 
 #define DBRT_DEBUG 1
 
@@ -425,11 +426,24 @@ static void invalidate_ce_path(struct cache_entry *ce)
 		cache_tree_invalidate_path(active_cache_tree, ce->name);
 }
 
-static int verify_clean_subdirectory(const char *path, const char *action,
+/*
+ * Check that checking out ce->sha1 in subdir ce->name is not
+ * going to overwrite any working files.
+ *
+ * Currently, git does not checkout subprojects during a superproject
+ * checkout, so it is not going to overwrite anything.
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
@@ -437,13 +451,24 @@ static int verify_clean_subdirectory(const char *path, const char *action,
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
+		return verify_clean_submodule(ce, action, o);
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
@@ -451,7 +476,7 @@ static int verify_clean_subdirectory(const char *path, const char *action,
 		struct cache_entry *ce = active_cache[i];
 		int len = ce_namelen(ce);
 		if (len < namelen ||
-		    strncmp(path, ce->name, namelen) ||
+		    strncmp(ce->name, ce->name, namelen) ||
 		    ce->name[namelen] != '/')
 			break;
 		/*
@@ -469,16 +494,16 @@ static int verify_clean_subdirectory(const char *path, const char *action,
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
@@ -487,7 +512,7 @@ static int verify_clean_subdirectory(const char *path, const char *action,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static void verify_absent(const char *path, const char *action,
+static void verify_absent(struct cache_entry *ce, const char *action,
 		struct unpack_trees_options *o)
 {
 	struct stat st;
@@ -495,15 +520,15 @@ static void verify_absent(const char *path, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return;
 
-	if (has_symlink_leading_path(path, NULL))
+	if (has_symlink_leading_path(ce->name, NULL))
 		return;
 
-	if (!lstat(path, &st)) {
+	if (!lstat(ce->name, &st)) {
 		int cnt;
 
-		if (o->dir && excluded(o->dir, path))
+		if (o->dir && excluded(o->dir, ce->name))
 			/*
-			 * path is explicitly excluded, so it is Ok to
+			 * ce->name is explicitly excluded, so it is Ok to
 			 * overwrite it.
 			 */
 			return;
@@ -515,7 +540,7 @@ static void verify_absent(const char *path, const char *action,
 			 * files that are in "foo/" we would lose
 			 * it.
 			 */
-			cnt = verify_clean_subdirectory(path, action, o);
+			cnt = verify_clean_subdirectory(ce, action, o);
 
 			/*
 			 * If this removed entries from the index,
@@ -543,7 +568,7 @@ static void verify_absent(const char *path, const char *action,
 		 * delete this path, which is in a subdirectory that
 		 * is being replaced with a blob.
 		 */
-		cnt = cache_name_pos(path, strlen(path));
+		cnt = cache_name_pos(ce->name, strlen(ce->name));
 		if (0 <= cnt) {
 			struct cache_entry *ce = active_cache[cnt];
 			if (!ce_stage(ce) && !ce->ce_mode)
@@ -551,7 +576,7 @@ static void verify_absent(const char *path, const char *action,
 		}
 
 		die("Untracked working tree file '%s' "
-		    "would be %s by merge.", path, action);
+		    "would be %s by merge.", ce->name, action);
 	}
 }
 
@@ -575,7 +600,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		}
 	}
 	else {
-		verify_absent(merge->name, "overwritten", o);
+		verify_absent(merge, "overwritten", o);
 		invalidate_ce_path(merge);
 	}
 
@@ -590,7 +615,7 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 	if (old)
 		verify_uptodate(old, o);
 	else
-		verify_absent(ce->name, "removed", o);
+		verify_absent(ce, "removed", o);
 	ce->ce_mode = 0;
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	invalidate_ce_path(ce);
@@ -707,18 +732,18 @@ int threeway_merge(struct cache_entry **stages,
 	if (o->aggressive) {
 		int head_deleted = !head && !df_conflict_head;
 		int remote_deleted = !remote && !df_conflict_remote;
-		const char *path = NULL;
+		struct cache_entry *ce = NULL;
 
 		if (index)
-			path = index->name;
+			ce = index;
 		else if (head)
-			path = head->name;
+			ce = head;
 		else if (remote)
-			path = remote->name;
+			ce = remote;
 		else {
 			for (i = 1; i < o->head_idx; i++) {
 				if (stages[i] && stages[i] != o->df_conflict_entry) {
-					path = stages[i]->name;
+					ce = stages[i];
 					break;
 				}
 			}
@@ -733,8 +758,8 @@ int threeway_merge(struct cache_entry **stages,
 		    (remote_deleted && head && head_match)) {
 			if (index)
 				return deleted_entry(index, index, o);
-			else if (path && !head_deleted)
-				verify_absent(path, "removed", o);
+			else if (ce && !head_deleted)
+				verify_absent(ce, "removed", o);
 			return 0;
 		}
 		/*
-- 
1.5.3.rc2.10.g148b
