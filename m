From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/2] tree.c: allow read_tree_recursive() to traverse gitlink entries
Date: Sun, 25 Jan 2009 01:52:05 +0100
Message-ID: <1232844726-14902-2-git-send-email-hjemli@gmail.com>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 01:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQtGC-0004nS-HR
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 01:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057AbZAYAwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 19:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755854AbZAYAwR
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 19:52:17 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:53687 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132AbZAYAwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 19:52:14 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id n0P0q7Ju014475;
	Sun, 25 Jan 2009 01:52:09 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
In-Reply-To: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107029>

When the callback function invoked from read_tree_recursive() returns
the value `READ_TREE_RECURSIVE` for a gitlink entry, the traversal will
now continue into the tree connected to the gitlinked commit. This
functionality can be used to allow inter-repository operations, but
since the current users of read_tree_recursive() does not yet support
such operations, they have been modified where necessary to make sure
that they never return READ_TREE_RECURSIVE for gitlink entries (hence
no change in behaviour should be introduces by this patch alone).

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 archive.c         |    2 +-
 builtin-ls-tree.c |    9 ++-------
 merge-recursive.c |    2 +-
 tree.c            |   28 ++++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index 9ac455d..e6de039 100644
--- a/archive.c
+++ b/archive.c
@@ -132,7 +132,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		err = write_entry(args, sha1, path.buf, path.len, mode, NULL, 0);
 		if (err)
 			return err;
-		return READ_TREE_RECURSIVE;
+		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 	}
 
 	buffer = sha1_file_to_archive(path_without_prefix, sha1, mode,
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 5b63e6e..fca4631 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -68,13 +68,8 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 		 *
 		 * Something similar to this incomplete example:
 		 *
-		if (show_subprojects(base, baselen, pathname)) {
-			struct child_process ls_tree;
-
-			ls_tree.dir = base;
-			ls_tree.argv = ls-tree;
-			start_command(&ls_tree);
-		}
+		if (show_subprojects(base, baselen, pathname))
+			retval = READ_TREE_RECURSIVE;
 		 *
 		 */
 		type = commit_type;
diff --git a/merge-recursive.c b/merge-recursive.c
index b97026b..ee853b9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -237,7 +237,7 @@ static int save_files_dirs(const unsigned char *sha1,
 		string_list_insert(newpath, &o->current_file_set);
 	free(newpath);
 
-	return READ_TREE_RECURSIVE;
+	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 }
 
 static int get_files_dirs(struct merge_options *o, struct tree *tree)
diff --git a/tree.c b/tree.c
index 03e782a..dfe4d5f 100644
--- a/tree.c
+++ b/tree.c
@@ -131,6 +131,34 @@ int read_tree_recursive(struct tree *tree,
 			if (retval)
 				return -1;
 			continue;
+		} else if (S_ISGITLINK(entry.mode)) {
+			int retval;
+			struct strbuf path;
+			unsigned int entrylen;
+			struct commit *commit;
+
+			entrylen = tree_entry_len(entry.path, entry.sha1);
+			strbuf_init(&path, baselen + entrylen + 1);
+			strbuf_add(&path, base, baselen);
+			strbuf_add(&path, entry.path, entrylen);
+			strbuf_addch(&path, '/');
+
+			commit = lookup_commit(entry.sha1);
+			if (!commit)
+				die("Commit %s in submodule path %s not found",
+				    sha1_to_hex(entry.sha1), path.buf);
+
+			if (parse_commit(commit))
+				die("Invalid commit %s in submodule path %s",
+				    sha1_to_hex(entry.sha1), path.buf);
+
+			retval = read_tree_recursive(commit->tree,
+						     path.buf, path.len,
+						     stage, match, fn, context);
+			strbuf_release(&path);
+			if (retval)
+				return -1;
+			continue;
 		}
 	}
 	return 0;
-- 
1.6.1.150.g5e733b
