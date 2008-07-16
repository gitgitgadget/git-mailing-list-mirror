From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 5/7] git mv: Support moving submodules
Date: Wed, 16 Jul 2008 21:11:29 +0200
Message-ID: <20080716191129.19772.41903.stgit@localhost>
References: <20080716190753.19772.93357.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCQX-00011Z-A9
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbYGPTLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbYGPTLf
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:11:35 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:64284 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754889AbYGPTLe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:11:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 6FCA32ACC76
	for <git@vger.kernel.org>; Wed, 16 Jul 2008 21:11:29 +0200 (CEST)
In-Reply-To: <20080716190753.19772.93357.stgit@localhost>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88726>

This patch adds support for moving submodules to 'git mv', including
rewriting of the .gitmodules file to reflect the movement.

The usage of struct path_list here is a bit abusive, but keeps the
code simple and hopefully still reasonably readable. The horrid
index_path_src_sha1 hack is unfortunately much worse, however the author
is currently unaware of any more reasonable solution of the problem.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 builtin-mv.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++------
 cache.h      |    2 ++
 sha1_file.c  |   10 ++++++++++
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 158a83d..30c4e7d 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "parse-options.h"
+#include "submodule.h"
 
 static const char * const builtin_mv_usage[] = {
 	"git-mv [options] <source>... <destination>",
@@ -60,6 +61,24 @@ static const char *add_slash(const char *path)
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
@@ -77,9 +96,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct stat st;
 	struct path_list overwritten = {NULL, 0, 0, 0};
 	struct path_list src_for_dst = {NULL, 0, 0, 0};
+	/* .util contains sha1 for submodules */
 	struct path_list added = {NULL, 0, 0, 0};
 	struct path_list deleted = {NULL, 0, 0, 0};
 	struct path_list changed = {NULL, 0, 0, 0};
+	/* .path is source path, .util is destination path */
+	struct path_list submodules = {NULL, 0, 0, 0};
 
 	git_config(git_default_config, NULL);
 
@@ -99,7 +121,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		/* special case: "." was normalized to "" */
 		destination = copy_pathspec(dest_path[0], argv, argc, 1);
 	else if (!lstat(dest_path[0], &st) &&
-			S_ISDIR(st.st_mode)) {
+			S_ISDIR(st.st_mode) &&
+			!ce_is_gitlink(cache_name_pos(dest_path[0], strlen(dest_path[0])))) {
 		dest_path[0] = add_slash(dest_path[0]);
 		destination = copy_pathspec(dest_path[0], argv, argc, 1);
 	} else {
@@ -111,7 +134,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	/* Checking */
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
-		int length, src_is_dir;
+		int length, src_is_dir, src_cache_pos;
 		const char *bad = NULL;
 
 		if (show_only)
@@ -126,7 +149,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		} else if ((src_is_dir = S_ISDIR(st.st_mode))
 				&& lstat(dst, &st) == 0)
 			bad = "cannot move directory over file";
-		else if (src_is_dir) {
+		else if ((src_cache_pos = cache_name_pos(src, length)) < 0 && src_is_dir) {
 			const char *src_w_slash = add_slash(src);
 			int len_w_slash = length + 1;
 			int first, last;
@@ -193,7 +216,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				} else
 					bad = "Cannot overwrite";
 			}
-		} else if (cache_name_pos(src, length) < 0)
+		} else if (src_cache_pos < 0)
 			bad = "not under version control";
 		else if (path_list_has_path(&src_for_dst, dst))
 			bad = "multiple sources for the same target";
@@ -218,6 +241,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
+		struct path_list_item *last = NULL;
+		int j;
 		if (show_only || verbose)
 			printf("Renaming %s to %s\n", src, dst);
 		if (!show_only && mode != INDEX &&
@@ -227,14 +252,24 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (mode == WORKING_DIRECTORY)
 			continue;
 
-		assert(cache_name_pos(src, strlen(src)) >= 0);
+		j = cache_name_pos(src, strlen(src));
+		assert(j >= 0);
 
 		path_list_insert(src, &deleted);
 		/* destination can be a directory with 1 file inside */
 		if (path_list_has_path(&overwritten, dst))
 			path_list_insert(dst, &changed);
 		else
-			path_list_insert(dst, &added);
+			last = path_list_insert(dst, &added);
+		if (ce_is_gitlink(j)) {
+			path_list_insert(src, &submodules)->util = (void *) dst;
+			/* We will note the original HEAD sha1; the submodule
+			 * may not be checked out, in which case we would have
+			 * no way to re-obtain it later when adding the new
+			 * entry. */
+			assert(last);
+			last->util = active_cache[j]->sha1;
+		}
 	}
 
 	if (show_only) {
@@ -254,13 +289,21 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < added.nr; i++) {
 			const char *path = added.items[i].path;
+			index_path_src_sha1 = added.items[i].util;
 			if (add_file_to_cache(path, verbose ? ADD_CACHE_VERBOSE : 0))
 				die("updating index entries failed");
+			index_path_src_sha1 = NULL;
 		}
 
 		for (i = 0; i < deleted.nr; i++)
 			remove_file_from_cache(deleted.items[i].path);
 
+		for (i = 0; i < submodules.nr; i++)
+			rename_submodule(&submodules.items[i]);
+
+		if (submodules.nr > 0 && add_file_to_cache(".gitmodules", 0))
+			die("cannot add new .gitmodules to the index");
+
 		if (active_cache_changed) {
 			if (write_cache(newfd, active_cache, active_nr) ||
 			    commit_locked_index(&lock_file))
diff --git a/cache.h b/cache.h
index a779d92..998b5fb 100644
--- a/cache.h
+++ b/cache.h
@@ -387,6 +387,8 @@ extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int ie_match_stat(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 
+extern unsigned char *index_path_src_sha1;
+
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path);
 extern int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object);
diff --git a/sha1_file.c b/sha1_file.c
index e281c14..4da6048 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2416,12 +2416,22 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	return ret;
 }
 
+unsigned char *index_path_src_sha1;
+
 int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object)
 {
 	int fd;
 	char *target;
 	size_t len;
 
+	if (index_path_src_sha1) {
+		/* SHA1 for this path was prepared by the caller specially;
+		 * e.g. comes from original cache entry in some cases of
+		 * a rename. */
+		memcpy(sha1, index_path_src_sha1, 20);
+		return 0;
+	}
+
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
 		fd = open(path, O_RDONLY);
