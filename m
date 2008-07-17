From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git mv: Support moving submodules
Date: Fri, 18 Jul 2008 00:34:28 +0200
Message-ID: <20080717223324.20900.42967.stgit@localhost>
References: <20080717223036.20680.9672.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 00:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJc4X-0001bp-5u
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 00:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbYGQWeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 18:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbYGQWeg
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 18:34:36 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:50573 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932226AbYGQWef (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 18:34:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id DE5AE2ACC9B;
	Fri, 18 Jul 2008 00:34:28 +0200 (CEST)
In-Reply-To: <20080717223036.20680.9672.stgit@localhost>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88934>

This patch adds support for moving submodules to 'git mv', including
rewriting of the .gitmodules file to reflect the movement.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  This is the updated version reflecting the recent rewrite. No other
  changes in my queue yet (except expanding the git rm explanation).

 builtin-mv.c |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 28ebc9c..62d0c95 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "parse-options.h"
+#include "submodule.h"
 
 static const char * const builtin_mv_usage[] = {
 	"git mv [options] <source>... <destination>",
@@ -49,6 +50,24 @@ static const char *add_slash(const char *path)
 	return path;
 }
 
+static int ce_is_gitlink(int i)
+{
+	return i < 0 ? 0 : S_ISGITLINK(active_cache[i]->ce_mode);
+}
+
+static void rename_submodule(struct path_list_item *i)
+{
+	char *key = submodule_by_path(i->path);
+
+	config_exclusive_filename = ".gitmodules";
+	if (git_config_set(key, (const char *) i->util))
+		die("cannot update .gitmodules");
+	config_exclusive_filename = NULL;
+
+	free(key);
+}
+
+
 static struct lock_file lock_file;
 
 int cmd_mv(int argc, const char **argv, const char *prefix)
@@ -65,6 +84,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
 	struct path_list src_for_dst = {NULL, 0, 0, 0};
+	/* .path is source path, .util is destination path */
+	struct path_list submodules = {NULL, 0, 0, 0};
 
 	git_config(git_default_config, NULL);
 
@@ -84,7 +105,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		/* special case: "." was normalized to "" */
 		destination = copy_pathspec(dest_path[0], argv, argc, 1);
 	else if (!lstat(dest_path[0], &st) &&
-			S_ISDIR(st.st_mode)) {
+			S_ISDIR(st.st_mode) &&
+			!ce_is_gitlink(cache_name_pos(dest_path[0], strlen(dest_path[0])))) {
 		dest_path[0] = add_slash(dest_path[0]);
 		destination = copy_pathspec(dest_path[0], argv, argc, 1);
 	} else {
@@ -96,7 +118,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	/* Checking */
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
-		int length, src_is_dir;
+		int length, src_is_dir, src_cache_pos;
 		const char *bad = NULL;
 
 		if (show_only)
@@ -111,7 +133,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		} else if ((src_is_dir = S_ISDIR(st.st_mode))
 				&& lstat(dst, &st) == 0)
 			bad = "cannot move directory over file";
-		else if (src_is_dir) {
+		else if ((src_cache_pos = cache_name_pos(src, length)) < 0 && src_is_dir) {
 			const char *src_w_slash = add_slash(src);
 			int len_w_slash = length + 1;
 			int first, last;
@@ -177,7 +199,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				} else
 					bad = "Cannot overwrite";
 			}
-		} else if (cache_name_pos(src, length) < 0)
+		} else if (src_cache_pos < 0)
 			bad = "not under version control";
 		else if (path_list_has_path(&src_for_dst, dst))
 			bad = "multiple sources for the same target";
@@ -214,10 +236,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
+		if (ce_is_gitlink(pos))
+			path_list_insert(src, &submodules)->util = (void *) dst;
 		if (!show_only)
 			rename_cache_entry_at(pos, dst);
 	}
 
+	for (i = 0; i < submodules.nr; i++)
+		rename_submodule(&submodules.items[i]);
+	if (submodules.nr > 0 && add_file_to_cache(".gitmodules", 0))
+		die("cannot add new .gitmodules to the index");
+
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
