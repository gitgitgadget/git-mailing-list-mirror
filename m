From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH 1/8] Make git-write-tree a builtin
Date: Tue, 13 Jun 2006 22:21:42 +0200
Organization: Chalmers
Message-ID: <448F1E56.8010203@etek.chalmers.se>
References: <448EF791.7070504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFOZ-0006UL-Fx
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWFMUVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 16:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWFMUVs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:21:48 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:17342 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932200AbWFMUVr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:21:47 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout1-sn2.hy.skanova.net (7.2.072.1)
        id 448977B3000E73EC; Tue, 13 Jun 2006 22:21:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <448EF791.7070504@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21806>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 Makefile                             |    6 ++-
 write-tree.c =3D> builtin-write-tree.c |   68 +++++++++++++++++++++---=
----------
 builtin.h                            |    3 ++
 git.c                                |    3 +-
 4 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/Makefile b/Makefile
index 2a1e639..37b5e40 100644
--- a/Makefile
+++ b/Makefile
@@ -159,7 +159,7 @@ PROGRAMS =3D \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
-	git-upload-pack$X git-verify-pack$X git-write-tree$X \
+	git-upload-pack$X git-verify-pack$X \
 	git-update-ref$X git-symbolic-ref$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
@@ -170,7 +170,7 @@ BUILT_INS =3D git-log$X git-whatchanged$X=20
 	git-check-ref-format$X git-rev-parse$X \
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
 	git-ls-files$X git-ls-tree$X git-get-tar-commit-id$X \
-	git-read-tree$X git-commit-tree$X \
+	git-read-tree$X git-commit-tree$X git-write-tree$X \
 	git-apply$X git-show-branch$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X
=20
@@ -223,7 +223,7 @@ BUILTIN_OBJS =3D \
 	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-for=
mat.o \
 	builtin-rm.o builtin-init-db.o builtin-rev-parse.o \
 	builtin-tar-tree.o builtin-upload-tar.o \
-	builtin-ls-files.o builtin-ls-tree.o \
+	builtin-ls-files.o builtin-ls-tree.o builtin-write-tree.o \
 	builtin-read-tree.o builtin-commit-tree.o \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
diff --git a/write-tree.c b/builtin-write-tree.c
similarity index 66%
rename from write-tree.c
rename to builtin-write-tree.c
index bd07da6..c3aac36 100644
--- a/write-tree.c
+++ b/builtin-write-tree.c
@@ -3,41 +3,24 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#include "builtin.h"
 #include "cache.h"
 #include "tree.h"
 #include "cache-tree.h"
=20
-static int missing_ok =3D 0;
-static char *prefix =3D NULL;
-
 static const char write_tree_usage[] =3D
 "git-write-tree [--missing-ok] [--prefix=3D<prefix>/]";
=20
-static struct lock_file lock_file;
-
-int main(int argc, char **argv)
+int write_tree(unsigned char *sha1, int missing_ok, const char *prefix=
)
 {
 	int entries, was_valid, newfd;
=20
-	setup_git_directory();
+	/* We can't free this memory, it becomes part of a linked list parsed=
 atexit() */
+	struct lock_file *lock_file =3D xmalloc(sizeof(struct lock_file));
=20
-	newfd =3D hold_lock_file_for_update(&lock_file, get_index_file());
-	entries =3D read_cache();
-
-	while (1 < argc) {
-		char *arg =3D argv[1];
-		if (!strcmp(arg, "--missing-ok"))
-			missing_ok =3D 1;
-		else if (!strncmp(arg, "--prefix=3D", 9))
-			prefix =3D arg + 9;
-		else
-			die(write_tree_usage);
-		argc--; argv++;
-	}
-
-	if (argc > 2)
-		die("too many options");
+	newfd =3D hold_lock_file_for_update(lock_file, get_index_file());
=20
+	entries =3D read_cache();
 	if (entries < 0)
 		die("git-write-tree: error reading cache");
=20
@@ -45,6 +28,7 @@ int main(int argc, char **argv)
 		active_cache_tree =3D cache_tree();
=20
 	was_valid =3D cache_tree_fully_valid(active_cache_tree);
+
 	if (!was_valid) {
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
@@ -52,7 +36,7 @@ int main(int argc, char **argv)
 			die("git-write-tree: error building trees");
 		if (0 <=3D newfd) {
 			if (!write_cache(newfd, active_cache, active_nr))
-				commit_lock_file(&lock_file);
+				commit_lock_file(lock_file);
 		}
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
@@ -61,12 +45,44 @@ int main(int argc, char **argv)
 		 * performance penalty and not a big deal.
 		 */
 	}
+
 	if (prefix) {
 		struct cache_tree *subtree =3D
 			cache_tree_find(active_cache_tree, prefix);
-		printf("%s\n", sha1_to_hex(subtree->sha1));
+		memcpy(sha1, subtree->sha1, 20);
 	}
 	else
-		printf("%s\n", sha1_to_hex(active_cache_tree->sha1));
+		memcpy(sha1, active_cache_tree->sha1, 20);
+
+	rollback_lock_file(lock_file);
+
 	return 0;
 }
+
+int cmd_write_tree(int argc, const char **argv, char **envp)
+{
+	int missing_ok =3D 0, ret;
+	const char *prefix =3D NULL;
+	unsigned char sha1[20];
+
+	setup_git_directory();
+
+	while (1 < argc) {
+		const char *arg =3D argv[1];
+		if (!strcmp(arg, "--missing-ok"))
+			missing_ok =3D 1;
+		else if (!strncmp(arg, "--prefix=3D", 9))
+			prefix =3D arg + 9;
+		else
+			die(write_tree_usage);
+		argc--; argv++;
+	}
+
+	if (argc > 2)
+		die("too many options");
+
+	ret =3D write_tree(sha1, missing_ok, prefix);
+	printf("%s\n", sha1_to_hex(sha1));
+
+	return ret;
+}
diff --git a/builtin.h b/builtin.h
index b9f36be..885422e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -46,4 +46,7 @@ extern int cmd_diff_tree(int argc, const
 extern int cmd_cat_file(int argc, const char **argv, char **envp);
 extern int cmd_rev_parse(int argc, const char **argv, char **envp);
=20
+extern int cmd_write_tree(int argc, const char **argv, char **envp);
+extern int write_tree(unsigned char *sha1, int missing_ok, const char =
*prefix);
+
 #endif
diff --git a/git.c b/git.c
index 9469d44..5868fb9 100644
--- a/git.c
+++ b/git.c
@@ -178,7 +178,8 @@ static void handle_internal_command(int=20
 		{ "diff-stages", cmd_diff_stages },
 		{ "diff-tree", cmd_diff_tree },
 		{ "cat-file", cmd_cat_file },
-		{ "rev-parse", cmd_rev_parse }
+		{ "rev-parse", cmd_rev_parse },
+		{ "write-tree", cmd_write_tree }
 	};
 	int i;
=20
--=20
1.4.0
