From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/3] Teach read_tree_recursive() how to traverse into submodules
Date: Sun, 18 Jan 2009 11:53:18 +0100
Message-ID: <1232275999-14852-3-git-send-email-hjemli@gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 11:55:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOVJ0-0008GS-DA
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 11:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761896AbZARKx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 05:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762809AbZARKx0
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 05:53:26 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:49588 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761043AbZARKxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 05:53:25 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n0IArKDc021200;
	Sun, 18 Jan 2009 11:53:21 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
In-Reply-To: <1232275999-14852-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106166>

The traversal of submodules is only triggered if the current submodule
HEAD commit object is accessible. To this end, read_tree_recursive()
will try to insert the submodule odb as an alternate odb but the lack
of such an odb is not treated as an error since it is then assumed that
the user is not interested in the submodule content. However, if the
submodule odb is found it is treated as an error if the HEAD commit
object is missing.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 cache.h       |    2 +
 environment.c |   12 ++++++++
 tree.c        |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index daa2d4e..6728467 100644
--- a/cache.h
+++ b/cache.h
@@ -382,6 +382,8 @@ extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
 extern void set_git_work_tree(const char *tree);
+extern int get_traverse_gitlinks();
+extern void set_traverse_gitlinks(int traverse);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index e278bce..35cc557 100644
--- a/environment.c
+++ b/environment.c
@@ -53,6 +53,8 @@ static char *work_tree;
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
 
+static int traverse_gitlinks = 0;
+
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
@@ -159,3 +161,13 @@ int set_git_dir(const char *path)
 	setup_git_env();
 	return 0;
 }
+
+int get_traverse_gitlinks()
+{
+	return traverse_gitlinks;
+}
+
+void set_traverse_gitlinks(int traverse)
+{
+	traverse_gitlinks = traverse;
+}
diff --git a/tree.c b/tree.c
index 03e782a..87cf309 100644
--- a/tree.c
+++ b/tree.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
+#include "refs.h"
 
 const char *tree_type = "tree";
 
@@ -89,6 +90,61 @@ static int match_tree_entry(const char *base, int baselen, const char *path, uns
 	return 0;
 }
 
+/* Try to add the objectdb of a submodule */
+int add_gitlink_odb(char *relpath)
+{
+	const char *odbpath;
+	struct stat st;
+
+	odbpath = read_gitfile_gently(mkpath("%s/.git", relpath));
+	if (!odbpath)
+		odbpath = mkpath("%s/.git/objects", relpath);
+
+	if (stat(odbpath, &st))
+		return 1;
+
+	return add_alt_odb(odbpath);
+}
+
+/* Check if we should recurse into the specified submodule */
+int traverse_gitlink(char *path, const unsigned char *commit_sha1,
+		     struct tree **subtree)
+{
+	unsigned char sha1[20];
+	int linked_odb = 0;
+	struct commit *commit;
+	void *buffer;
+	enum object_type type;
+	unsigned long size;
+
+	hashcpy(sha1, commit_sha1);
+	if (!add_gitlink_odb(path)) {
+		linked_odb = 1;
+		if (resolve_gitlink_ref(path, "HEAD", sha1))
+			die("Unable to lookup HEAD in %s", path);
+	}
+
+	buffer = read_sha1_file(sha1, &type, &size);
+	if (!buffer) {
+		if (linked_odb)
+			die("Unable to read object %s in submodule %s",
+			    sha1_to_hex(sha1), path);
+		else
+			return 0;
+	}
+
+	commit = lookup_commit(sha1);
+	if (!commit)
+		die("traverse_gitlink(): internal error");
+
+	if (parse_commit_buffer(commit, buffer, size))
+		die("Failed to parse commit %s in submodule %s",
+		    sha1_to_hex(sha1), path);
+
+	*subtree = commit->tree;
+	return 1;
+}
+
 int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
 			int stage, const char **match,
@@ -132,6 +188,30 @@ int read_tree_recursive(struct tree *tree,
 				return -1;
 			continue;
 		}
+		if (S_ISGITLINK(entry.mode) && get_traverse_gitlinks()) {
+			int retval;
+			char *newbase;
+			struct tree *subtree;
+			unsigned int pathlen = tree_entry_len(entry.path, entry.sha1);
+
+			newbase = xmalloc(baselen + 1 + pathlen);
+			memcpy(newbase, base, baselen);
+			memcpy(newbase + baselen, entry.path, pathlen);
+			newbase[baselen + pathlen] = 0;
+			if (!traverse_gitlink(newbase, entry.sha1, &subtree)) {
+				free(newbase);
+				continue;
+			}
+			newbase[baselen + pathlen] = '/';
+			retval = read_tree_recursive(subtree,
+						     newbase,
+						     baselen + pathlen + 1,
+						     stage, match, fn, context);
+			free(newbase);
+			if (retval)
+				return -1;
+			continue;
+		}
 	}
 	return 0;
 }
-- 
1.6.1.150.g5e733b
