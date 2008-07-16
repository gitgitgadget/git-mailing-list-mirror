From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 6/7] git rm: Support for removing submodules
Date: Wed, 16 Jul 2008 21:11:34 +0200
Message-ID: <20080716191134.19772.85003.stgit@localhost>
References: <20080716190753.19772.93357.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCQY-00011Z-3u
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918AbYGPTLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756667AbYGPTLl
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:11:41 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:64290 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755906AbYGPTLk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:11:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id B76152ACC76
	for <git@vger.kernel.org>; Wed, 16 Jul 2008 21:11:34 +0200 (CEST)
In-Reply-To: <20080716190753.19772.93357.stgit@localhost>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88725>

This patch adds support for removing submodules to 'git rm', including
removing the appropriate sections from the .gitmodules file to reflect this

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-rm.txt |    6 +++-
 builtin-rm.c             |   65 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 4d0c495..bfc3dfa 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -20,7 +20,8 @@ and no updates to their contents can be staged in the index,
 though that default behavior can be overridden with the `-f` option.
 When '--cached' is given, the staged content has to
 match either the tip of the branch or the file on disk,
-allowing the file to be removed from just the index.
+allowing the file to be removed from just the index;
+this is always the case when removing submodules.
 
 
 OPTIONS
@@ -56,7 +57,8 @@ OPTIONS
 --cached::
 	Use this option to unstage and remove paths only from the index.
 	Working tree files, whether modified or not, will be
-	left alone.
+	left alone.  Note that this is always assumed when removing
+	a checked-out submodule.
 
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
diff --git a/builtin-rm.c b/builtin-rm.c
index 22c9bd1..363d1fa 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "parse-options.h"
+#include "submodule.h"
 
 static const char * const builtin_rm_usage[] = {
 	"git-rm [options] [--] <file>...",
@@ -17,16 +18,21 @@ static const char * const builtin_rm_usage[] = {
 
 static struct {
 	int nr, alloc;
-	const char **name;
+	struct {
+		const char *name;
+		int is_gitlink;
+	} *info;
 } list;
 
-static void add_list(const char *name)
+static void add_list(const char *name, int is_gitlink)
 {
 	if (list.nr >= list.alloc) {
 		list.alloc = alloc_nr(list.alloc);
-		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
+		list.info = xrealloc(list.info, list.alloc * sizeof(*list.info));
 	}
-	list.name[list.nr++] = name;
+	list.info[list.nr].name = name;
+	list.info[list.nr].is_gitlink = is_gitlink;
+	list.nr++;
 }
 
 static int remove_file(const char *name)
@@ -38,6 +44,13 @@ static int remove_file(const char *name)
 	if (ret && errno == ENOENT)
 		/* The user has removed it from the filesystem by hand */
 		ret = errno = 0;
+	if (ret && errno == EISDIR) {
+		/* This is a gitlink entry; try to remove at least the
+		 * directory if the submodule is not checked out; we always
+		 * leave the checked out ones as they are */
+		if (!rmdir(name) || errno == ENOTEMPTY)
+			ret = errno = 0;
+	}
 
 	if (!ret && (slash = strrchr(name, '/'))) {
 		char *n = xstrdup(name);
@@ -65,7 +78,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 		struct stat st;
 		int pos;
 		struct cache_entry *ce;
-		const char *name = list.name[i];
+		const char *name = list.info[i].name;
 		unsigned char sha1[20];
 		unsigned mode;
 		int local_changes = 0;
@@ -83,7 +96,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 			/* It already vanished from the working tree */
 			continue;
 		}
-		else if (S_ISDIR(st.st_mode)) {
+		else if (S_ISDIR(st.st_mode) && !S_ISGITLINK(ce->ce_mode)) {
 			/* if a file was removed and it is now a
 			 * directory, that is the same as ENOENT as
 			 * far as git is concerned; we do not track
@@ -122,6 +135,22 @@ static int check_local_mod(unsigned char *head, int index_only)
 	return errs;
 }
 
+static void remove_submodule(const char *name)
+{
+	char *key = submodule_by_path(name);
+	char *sectend = strrchr(key, '.');
+
+	assert(sectend);
+	*sectend = 0;
+
+	config_exclusive_filename = ".gitmodules";
+	if (git_config_rename_section(key, NULL) <= 0)
+		die("cannot remove section `%s' from .gitmodules", key);
+	config_exclusive_filename = NULL;
+
+	free(key);
+}
+
 static struct lock_file lock_file;
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
@@ -140,7 +169,7 @@ static struct option builtin_rm_options[] = {
 
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd;
+	int i, newfd, subs;
 	const char **pathspec;
 	char *seen;
 
@@ -168,7 +197,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		struct cache_entry *ce = active_cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
-		add_list(ce->name);
+		add_list(ce->name, S_ISGITLINK(ce->ce_mode));
 	}
 
 	if (pathspec) {
@@ -216,9 +245,11 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * the index unless all of them succeed.
 	 */
 	for (i = 0; i < list.nr; i++) {
-		const char *path = list.name[i];
+		const char *path = list.info[i].name;
 		if (!quiet)
-			printf("rm '%s'\n", path);
+			printf("rm%s '%s'\n",
+				list.info[i].is_gitlink ? "dir" : "",
+				path);
 
 		if (remove_file_from_cache(path))
 			die("git-rm: unable to remove %s", path);
@@ -238,7 +269,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only) {
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
-			const char *path = list.name[i];
+			const char *path = list.info[i].name;
 			if (!remove_file(path)) {
 				removed = 1;
 				continue;
@@ -248,6 +279,18 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	/*
+	 * Get rid of stale submodule setup.
+	 */
+	subs = 0;
+	for (i = 0; i < list.nr; i++)
+		if (list.info[i].is_gitlink) {
+			remove_submodule(list.info[i].name);
+			subs++;
+		}
+	if (subs && add_file_to_cache(".gitmodules", 0))
+		die("cannot add new .gitmodules to the index");
+
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
