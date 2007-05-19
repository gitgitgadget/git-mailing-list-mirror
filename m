From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-archive: recursive prefix directory creation
Date: Sat, 19 May 2007 13:37:13 +0200
Message-ID: <464EE169.30306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 13:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpNG2-0003Ma-6E
	for gcvg-git@gmane.org; Sat, 19 May 2007 13:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbXESLhT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 07:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbXESLhT
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 07:37:19 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:35545
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755354AbXESLhS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 07:37:18 -0400
Received: from [10.0.1.201] (p508e68da.dip.t-dialin.net [80.142.104.218])
	by neapel230.server4you.de (Postfix) with ESMTP id 095C03D009;
	Sat, 19 May 2007 13:37:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47739>

Currently git-archive only adds a single directory entry for prefixes,
e.g. for --prefix=a/b/c/ only the directory a/b/c/ would be added to
the archive, not a/ nor a/b/.  While tar and unzip don't seem to have
a problem handling these missing entries, their omission was not
intended.

This patch replaces the prefix path creation code in git-archive with
calls to a new path walker similar to read_tree_recursive, named
descend_leading_dirs.  It calls a read_tree_fn_t function for each
leading directory while descending deeper into the path (e.g. first
a/, then a/b/ etc.).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-tar.c |   11 ++---------
 archive-zip.c |   11 ++---------
 tree.c        |   45 +++++++++++++++++++++++++++++++++++++++++++++
 tree.h        |    5 +++++
 4 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 33e7657..7ea396d 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -308,15 +308,8 @@ int write_tar_archive(struct archiver_args *args)
 	if (args->commit_sha1)
 		write_global_extended_header(args->commit_sha1);
 
-	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
-		char *base = xstrdup(args->base);
-		int baselen = strlen(base);
-
-		while (baselen > 0 && base[baselen - 1] == '/')
-			base[--baselen] = '\0';
-		write_tar_entry(args->tree->object.sha1, "", 0, base, 040777, 0);
-		free(base);
-	}
+	descend_leading_dirs(args->tree->object.sha1, args->base, plen,
+	                     040777, 0, write_tar_entry);
 	read_tree_recursive(args->tree, args->base, plen, 0,
 			    args->pathspec, write_tar_entry);
 	write_trailer();
diff --git a/archive-zip.c b/archive-zip.c
index 3cbf6bb..2fc22ff 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -317,15 +317,8 @@ int write_zip_archive(struct archiver_args *args)
 	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
 	verbose = args->verbose;
 
-	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
-		char *base = xstrdup(args->base);
-		int baselen = strlen(base);
-
-		while (baselen > 0 && base[baselen - 1] == '/')
-			base[--baselen] = '\0';
-		write_zip_entry(args->tree->object.sha1, "", 0, base, 040777, 0);
-		free(base);
-	}
+	descend_leading_dirs(args->tree->object.sha1, args->base, plen,
+	                     040777, 0, write_zip_entry);
 	read_tree_recursive(args->tree, args->base, plen, 0,
 			    args->pathspec, write_zip_entry);
 	write_zip_trailer(args->commit_sha1);
diff --git a/tree.c b/tree.c
index e4a39aa..5cd1f90 100644
--- a/tree.c
+++ b/tree.c
@@ -231,3 +231,48 @@ struct tree *parse_tree_indirect(const unsigned char *sha1)
 			parse_object(obj->sha1);
 	} while (1);
 }
+
+int descend_leading_dirs(const unsigned char *sha1,
+                         const char *path, size_t pathlen,
+                         unsigned int mode, int stage, read_tree_fn_t fn)
+{
+	int err;
+	size_t baselen;
+
+	if (!path)
+		return 0;
+
+	/* Discard file name part. */
+	while (pathlen > 0 && path[pathlen - 1] != '/')
+		pathlen--;
+	while (pathlen > 0 && path[pathlen - 1] == '/')
+		pathlen--;
+	if (pathlen == 0)
+		return 0;
+
+	/* Now separate base and current directory name. */
+	baselen = pathlen;
+	while (baselen > 0 && path[baselen - 1] != '/')
+		baselen--;
+
+	err = descend_leading_dirs(null_sha1, path, baselen, mode, stage, fn);
+
+	if (!err) {
+		/* We need a NUL-terminated version of the directory name. */
+		char *dirname = xstrndup(path + baselen, pathlen - baselen);
+		switch (fn(sha1, path, baselen, dirname, mode, stage)) {
+		case 0:
+			err = 1;
+			break;
+		case READ_TREE_RECURSIVE:
+			err = 0;
+			break;
+		default:
+			err = -1;
+			break;
+		}
+		free(dirname);
+	}
+
+	return err;
+}
diff --git a/tree.h b/tree.h
index dd25c53..6b0f5d9 100644
--- a/tree.h
+++ b/tree.h
@@ -30,4 +30,9 @@ extern int read_tree_recursive(struct tree *tree,
 
 extern int read_tree(struct tree *tree, int stage, const char **paths);
 
+extern int descend_leading_dirs(const unsigned char *sha1,
+                                const char *path, size_t pathlen,
+                                unsigned int mode, int stage,
+                                read_tree_fn_t fn);
+
 #endif /* TREE_H */
