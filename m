From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] Remove git-zip-tree
Date: Sat, 23 Sep 2006 17:06:11 +0200
Message-ID: <45154D63.8030107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 17:06:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR95Q-0003J8-DC
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 17:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWIWPGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 11:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWIWPGQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 11:06:16 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:44950
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751203AbWIWPGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 11:06:15 -0400
Received: from [10.0.1.3] (p508E4EB9.dip.t-dialin.net [80.142.78.185])
	by neapel230.server4you.de (Postfix) with ESMTP id A18F719052;
	Sat, 23 Sep 2006 17:06:13 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27595>

git-zip-tree can be safely removed because it was never part of a formal
release.  This patch makes 'git-archive --format=zip' the one and only git
ZIP file creation command.  

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 Documentation/git-zip-tree.txt |   67 ----------------------------------------
 .gitignore                     |    1 -
 builtin-zip-tree.c             |   65 --------------------------------------
 builtin.h                      |    1 -
 git.c                          |    1 -
 5 files changed, 0 insertions(+), 135 deletions(-)

diff --git a/Documentation/git-zip-tree.txt b/Documentation/git-zip-tree.txt
deleted file mode 100644
index 2e9d981..0000000
--- a/Documentation/git-zip-tree.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-git-zip-tree(1)
-===============
-
-NAME
-----
-git-zip-tree - Creates a ZIP archive of the files in the named tree
-
-
-SYNOPSIS
---------
-'git-zip-tree' [-0|...|-9] <tree-ish> [ <base> ]
-
-DESCRIPTION
------------
-Creates a ZIP archive containing the tree structure for the named tree.
-When <base> is specified it is added as a leading path to the files in the
-generated ZIP archive.
-
-git-zip-tree behaves differently when given a tree ID versus when given
-a commit ID or tag ID.  In the first case the current time is used as
-modification time of each file in the archive.  In the latter case the
-commit time as recorded in the referenced commit object is used instead.
-Additionally the commit ID is stored as an archive comment.
-
-Currently git-zip-tree can handle only files and directories, symbolic
-links are not supported.
-
-OPTIONS
--------
-
--0::
-	Store the files instead of deflating them.
-
--9::
-	Highest and slowest compression level.  You can specify any
-	number from 1 to 9 to adjust compression speed and ratio.
-
-<tree-ish>::
-	The tree or commit to produce ZIP archive for.  If it is
-	the object name of a commit object.
-
-<base>::
-	Leading path to the files in the resulting ZIP archive.
-
-EXAMPLES
---------
-git zip-tree v1.4.0 git-1.4.0 >git-1.4.0.zip::
-
-	Create a ZIP file for v1.4.0 release.
-
-git zip-tree HEAD:Documentation/ git-docs >docs.zip::
-
-	Put everything in the current head's Documentation/ directory
-	into 'docs.zip', with the prefix 'git-docs/'.
-
-Author
-------
-Written by Rene Scharfe.
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
-
diff --git a/.gitignore b/.gitignore
index a3d9c7a..3ca66e4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -128,7 +128,6 @@ git-verify-pack
 git-verify-tag
 git-whatchanged
 git-write-tree
-git-zip-tree
 git-core-*/?*
 gitweb/gitweb.cgi
 test-date
diff --git a/builtin-zip-tree.c b/builtin-zip-tree.c
index 52d4b7a..3ffdad6 100644
--- a/builtin-zip-tree.c
+++ b/builtin-zip-tree.c
@@ -10,9 +10,6 @@ #include "quote.h"
 #include "builtin.h"
 #include "archive.h"
 
-static const char zip_tree_usage[] =
-"git-zip-tree [-0|...|-9] <tree-ish> [ <base> ]";
-
 static int verbose;
 static int zip_date;
 static int zip_time;
@@ -294,68 +291,6 @@ static void dos_time(time_t *time, int *
 	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
 }
 
-int cmd_zip_tree(int argc, const char **argv, const char *prefix)
-{
-	unsigned char sha1[20];
-	struct tree *tree;
-	struct commit *commit;
-	time_t archive_time;
-	char *base;
-	int baselen;
-
-	git_config(git_default_config);
-
-	if (argc > 1 && argv[1][0] == '-') {
-		if (isdigit(argv[1][1]) && argv[1][2] == '\0') {
-			zlib_compression_level = argv[1][1] - '0';
-			argc--;
-			argv++;
-		}
-	}
-
-	switch (argc) {
-	case 3:
-		base = xstrdup(argv[2]);
-		baselen = strlen(base);
-		break;
-	case 2:
-		base = xstrdup("");
-		baselen = 0;
-		break;
-	default:
-		usage(zip_tree_usage);
-	}
-
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
-
-	commit = lookup_commit_reference_gently(sha1, 1);
-	archive_time = commit ? commit->date : time(NULL);
-	dos_time(&archive_time, &zip_date, &zip_time);
-
-	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
-	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
-
-	tree = parse_tree_indirect(sha1);
-	if (!tree)
-		die("not a tree object");
-
-	if (baselen > 0) {
-		write_zip_entry(tree->object.sha1, "", 0, base, 040777, 0);
-		base = xrealloc(base, baselen + 1);
-		base[baselen] = '/';
-		baselen++;
-		base[baselen] = '\0';
-	}
-	read_tree_recursive(tree, base, baselen, 0, NULL, write_zip_entry);
-	write_zip_trailer(commit ? commit->object.sha1 : NULL);
-
-	free(zip_dir);
-	free(base);
-
-	return 0;
-}
-
 int write_zip_archive(struct archiver_args *args)
 {
 	int plen = strlen(args->base);
diff --git a/builtin.h b/builtin.h
index ccade94..f9fa9ff 100644
--- a/builtin.h
+++ b/builtin.h
@@ -53,7 +53,6 @@ extern int cmd_show(int argc, const char
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
-extern int cmd_zip_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 44ab0de..1686220 100644
--- a/git.c
+++ b/git.c
@@ -259,7 +259,6 @@ static void handle_internal_command(int 
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree, RUN_SETUP },
-		{ "zip-tree", cmd_zip_tree, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
