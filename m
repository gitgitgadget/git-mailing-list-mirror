From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-fsck: add --lost-found option
Date: Mon, 2 Jul 2007 17:53:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707021751380.4071@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-236508297-1183395223=:4071"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 02 18:53:52 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5P9o-0006lp-Md
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 18:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbXGBQxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbXGBQxq
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 12:53:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:48327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752240AbXGBQxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 12:53:45 -0400
Received: (qmail invoked by alias); 02 Jul 2007 16:53:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 02 Jul 2007 18:53:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183amxhokc3Bkal0gyRFcxF7eoAUF6m26bTwhMSoa
	tZvX1wGyIw832j
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51383>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-236508297-1183395223=:4071
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


With this option, dangling objects are not only reported, but also
written to .git/lost-found/commit/ or .git/lost-found/other/.

This obsoletes git-lost-found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Even adding a test script, and changing C code, this removes more 
	lines than it adds...

	Something we might want to do, however, is to add a warning if the 
	user said --lost-found without --no-reflogs.

 Documentation/cmd-list.perl      |    1 -
 Documentation/git-fsck.txt       |    6 ++-
 Documentation/git-lost-found.txt |   77 --------------------------------------
 Makefile                         |    2 +-
 builtin-fsck.c                   |   20 ++++++++++
 t/t1420-lost-found.sh            |   35 +++++++++++++++++
 6 files changed, 61 insertions(+), 80 deletions(-)
 delete mode 100644 Documentation/git-lost-found.txt
 create mode 100755 t/t1420-lost-found.sh

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index f50f613..9cae338 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -123,7 +123,6 @@ git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
 git-local-fetch                         synchingrepositories
 git-log                                 mainporcelain
-git-lost-found                          ancillarymanipulators
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 234c22f..08512e0 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-		 [--full] [--strict] [--verbose] [<object>*]
+	 [--full] [--strict] [--verbose] [--lost-found] [<object>*]
 
 DESCRIPTION
 -----------
@@ -64,6 +64,10 @@ index file and all SHA1 references in .git/refs/* as heads.
 --verbose::
 	Be chatty.
 
+--lost-found::
+	Write dangling refs into .git/commit/ or .git/other/, depending
+	on type.
+
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
deleted file mode 100644
index e48607f..0000000
--- a/Documentation/git-lost-found.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-git-lost-found(1)
-=================
-
-NAME
-----
-git-lost-found - Recover lost refs that luckily have not yet been pruned
-
-SYNOPSIS
---------
-'git-lost-found'
-
-DESCRIPTION
------------
-Finds dangling commits and tags from the object database, and
-creates refs to them in the .git/lost-found/ directory.  Commits and
-tags that dereference to commits are stored in .git/lost-found/commit,
-and other objects are stored in .git/lost-found/other.
-
-
-OUTPUT
-------
-Prints to standard output the object names and one-line descriptions
-of any commits or tags found.
-
-EXAMPLE
--------
-
-Suppose you run 'git tag -f' and mistype the tag to overwrite.
-The ref to your tag is overwritten, but until you run 'git
-prune', the tag itself is still there.
-
-------------
-$ git lost-found
-[1ef2b196d909eed523d4f3c9bf54b78cdd6843c6] GIT 0.99.9c
-...
-------------
-
-Also you can use gitk to browse how any tags found relate to each
-other.
-
-------------
-$ gitk $(cd .git/lost-found/commit && echo ??*)
-------------
-
-After making sure you know which the object is the tag you are looking
-for, you can reconnect it to your regular .git/refs hierarchy.
-
-------------
-$ git cat-file -t 1ef2b196
-tag
-$ git cat-file tag 1ef2b196
-object fa41bbce8e38c67a218415de6cfa510c7e50032a
-type commit
-tag v0.99.9c
-tagger Junio C Hamano <junkio@cox.net> 1131059594 -0800
-
-GIT 0.99.9c
-
-This contains the following changes from the "master" branch, since
-...
-$ git update-ref refs/tags/not-lost-anymore 1ef2b196
-$ git rev-parse not-lost-anymore
-1ef2b196d909eed523d4f3c9bf54b78cdd6843c6
-------------
-
-Author
-------
-Written by Junio C Hamano 濱野 純 <junkio@cox.net>
-
-Documentation
---------------
-Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index d7f686a..d4633bc 100644
--- a/Makefile
+++ b/Makefile
@@ -215,7 +215,7 @@ SCRIPT_SH = \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
+	git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
 	git-stash.sh
 
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 944a496..a530700 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -20,6 +20,7 @@ static int check_strict;
 static int keep_cache_objects;
 static unsigned char head_sha1[20];
 static int errors_found;
+static int write_lost_and_found;
 static int verbose;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
@@ -138,6 +139,21 @@ static void check_unreachable_object(struct object *obj)
 	if (!obj->used) {
 		printf("dangling %s %s\n", typename(obj->type),
 		       sha1_to_hex(obj->sha1));
+		if (write_lost_and_found) {
+			char *filename = git_path("lost-found/%s/%s",
+				obj->type == OBJ_COMMIT ? "commit" : "other",
+				sha1_to_hex(obj->sha1));
+			FILE *f;
+
+			if (safe_create_leading_directories(filename)) {
+				error("Could not create lost-found");
+				return;
+			}
+			if (!(f = fopen(filename, "w")))
+				die("Could not open %s", filename);
+			fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
+			fclose(f);
+		}
 		return;
 	}
 
@@ -685,6 +701,10 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			verbose = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--lost-found")) {
+			write_lost_and_found = 1;
+			continue;
+		}
 		if (*arg == '-')
 			usage(fsck_usage);
 	}
diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
new file mode 100755
index 0000000..dc9e402
--- /dev/null
+++ b/t/t1420-lost-found.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test fsck --lost-found'
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config core.logAllRefUpdates 0 &&
+	: > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m initial &&
+	echo 1 > file1 &&
+	echo 2 > file2 &&
+	git add file1 file2 &&
+	test_tick &&
+	git commit -m second &&
+	echo 3 > file3 &&
+	git add file3
+'
+
+test_expect_success 'lost and found something' '
+	git rev-parse HEAD > lost-commit &&
+	git rev-parse :file3 > lost-other &&
+	test_tick &&
+	git reset --hard HEAD^ &&
+	git fsck --lost-found &&
+	test 2 = $(ls .git/lost-found/*/* | wc -l) &&
+	test -f .git/lost-found/commit/$(cat lost-commit) &&
+	test -f .git/lost-found/other/$(cat lost-other)
+'
+
+test_done
-- 
1.5.2.2.3295.g8c6d-dirty

--8323584-236508297-1183395223=:4071--
