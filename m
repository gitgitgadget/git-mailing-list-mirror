From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: devolve git-tar-tree into a wrapper for git-archive
Date: Sat, 16 Sep 2006 21:20:36 +0200
Message-ID: <450C4E84.3000803@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 16 21:21:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOfjI-00064B-VA
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 21:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWIPTUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 15:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWIPTUp
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 15:20:45 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:28062
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750737AbWIPTUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 15:20:44 -0400
Received: from [10.0.1.3] (p508E4E70.dip.t-dialin.net [80.142.78.112])
	by neapel230.server4you.de (Postfix) with ESMTP id 1EDEF3B0FA;
	Sat, 16 Sep 2006 21:20:43 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27126>

This patch removes the custom tree walker tree_traverse(), and makes
generate_tar() use write_tar_archive() and the infrastructure provided
by git-archive instead.

As a kind of side effect, make write_tar_archive() able to handle NULL
as base directory, as this is what the new and simple generate_tar()
uses to indicate the absence of a base directory.  This was simpler
and cleaner than playing tricks with empty strings.

The behaviour of git-tar-tree should be unchanged (quick tests didn't
indicate otherwise) except for the text of some error messages.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 builtin-tar-tree.c |   90 ++++++++++-------------------------------------------
 1 file changed, 18 insertions(+), 72 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f2679a8..437eb72 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -3,7 +3,6 @@
  */
 #include <time.h>
 #include "cache.h"
-#include "tree-walk.h"
 #include "commit.h"
 #include "strbuf.h"
 #include "tar.h"
@@ -248,37 +247,6 @@ static void write_global_extended_header
 	free(ext_header.buf);
 }
 
-static void traverse_tree(struct tree_desc *tree, struct strbuf *path)
-{
-	int pathlen = path->len;
-	struct name_entry entry;
-
-	while (tree_entry(tree, &entry)) {
-		void *eltbuf;
-		char elttype[20];
-		unsigned long eltsize;
-
-		eltbuf = read_sha1_file(entry.sha1, elttype, &eltsize);
-		if (!eltbuf)
-			die("cannot read %s", sha1_to_hex(entry.sha1));
-
-		path->len = pathlen;
-		strbuf_append_string(path, entry.path);
-		if (S_ISDIR(entry.mode))
-			strbuf_append_string(path, "/");
-
-		write_entry(entry.sha1, path, entry.mode, eltbuf, eltsize);
-
-		if (S_ISDIR(entry.mode)) {
-			struct tree_desc subtree;
-			subtree.buf = eltbuf;
-			subtree.size = eltsize;
-			traverse_tree(&subtree, path);
-		}
-		free(eltbuf);
-	}
-}
-
 static int git_tar_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "tar.umask")) {
@@ -295,51 +263,29 @@ static int git_tar_config(const char *va
 
 static int generate_tar(int argc, const char **argv, const char *prefix)
 {
-	unsigned char sha1[20], tree_sha1[20];
-	struct commit *commit;
-	struct tree_desc tree;
-	struct strbuf current_path;
-	void *buffer;
-
-	current_path.buf = xmalloc(PATH_MAX);
-	current_path.alloc = PATH_MAX;
-	current_path.len = current_path.eof = 0;
+	struct archiver_args args;
+	int result;
+	char *base = NULL;
 
 	git_config(git_tar_config);
 
-	switch (argc) {
-	case 3:
-		strbuf_append_string(&current_path, argv[2]);
-		strbuf_append_string(&current_path, "/");
-		/* FALLTHROUGH */
-	case 2:
-		if (get_sha1(argv[1], sha1))
-			die("Not a valid object name %s", argv[1]);
-		break;
-	default:
+	memset(&args, 0, sizeof(args));
+	if (argc != 2 && argc != 3)
 		usage(tar_tree_usage);
+	if (argc == 3) {
+		int baselen = strlen(argv[2]);
+		base = xmalloc(baselen + 2);
+		memcpy(base, argv[2], baselen);
+		base[baselen] = '/';
+		base[baselen + 1] = '\0';
 	}
+	args.base = base;
+	parse_treeish_arg(argv + 1, &args, NULL);
 
-	commit = lookup_commit_reference_gently(sha1, 1);
-	if (commit) {
-		write_global_extended_header(commit->object.sha1);
-		archive_time = commit->date;
-	} else
-		archive_time = time(NULL);
-
-	tree.buf = buffer = read_object_with_reference(sha1, tree_type,
-	                                               &tree.size, tree_sha1);
-	if (!tree.buf)
-		die("not a reference to a tag, commit or tree object: %s",
-		    sha1_to_hex(sha1));
-
-	if (current_path.len > 0)
-		write_entry(tree_sha1, &current_path, 040777, NULL, 0);
-	traverse_tree(&tree, &current_path);
-	write_trailer();
-	free(buffer);
-	free(current_path.buf);
-	return 0;
+	result = write_tar_archive(&args);
+	free(base);
+
+	return result;
 }
 
 static int write_tar_entry(const unsigned char *sha1,
@@ -383,7 +329,7 @@ static int write_tar_entry(const unsigne
 
 int write_tar_archive(struct archiver_args *args)
 {
-	int plen = strlen(args->base);
+	int plen = args->base ? strlen(args->base) : 0;
 
 	git_config(git_tar_config);
 
