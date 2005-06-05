From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pull: gracefully recover from delta retrieval failure.
Date: Sat, 04 Jun 2005 23:11:38 -0700
Message-ID: <7v4qcde3j9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 08:12:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeoMf-0000lX-0d
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 08:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVFEGPD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 02:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVFEGO4
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 02:14:56 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:5631 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261265AbVFEGLp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 02:11:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605061139.WIBI1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 02:11:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This addresses a concern raised by Jason McMullan in the mailing
list discussion.  After retrieving and storing a potentially
deltified object, pull logic tries to check and fulfil its delta
dependency.  When the pull procedure is killed at this point,
however, there was no easy way to recover by re-running pull,
since next run would have found that we already have that
deltified object and happily reported success, without really
checking its delta dependency is satisfied.

This patch introduces --recover option to git-*-pull family
which causes them to re-validate dependency of deltified objects
we are fetching.  A new test t5100-delta-pull.sh covers such a
failure mode.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Linus, from now on I will go into "calming down" mode and
*** refrain myself from sending you too many "new" stuff, until
*** you tell me otherwise.  I will concentrate on fixes like
*** this one and the "diff-* -B fix" patches I sent you earlier.
*** Perhaps I would also work on CVS migration documents if you
*** would like me to help you in that area as well.

*** Definitely things like the idea of diff-tree switching its
*** pathspec according rename detection results would not be
*** something I'll be bugging you about until 1.0 happens;
*** unless you tell me otherwise, that is.

 Documentation/git-http-pull.txt  |    5 ++
 Documentation/git-local-pull.txt |    5 ++
 Documentation/git-rpull.txt      |    5 ++
 pull.h                           |    4 +-
 http-pull.c                      |    4 +-
 local-pull.c                     |    4 +-
 pull.c                           |   15 +++++--
 rpull.c                          |    4 +-
 t/t5100-delta-pull.sh            |   79 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 113 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-http-pull.txt b/Documentation/git-http-pull.txt
--- a/Documentation/git-http-pull.txt
+++ b/Documentation/git-http-pull.txt
@@ -9,7 +9,7 @@ git-http-pull - Downloads a remote GIT r
 
 SYNOPSIS
 --------
-'git-http-pull' [-c] [-t] [-a] [-v] [-d] commit-id url
+'git-http-pull' [-c] [-t] [-a] [-v] [-d] [--recover] commit-id url
 
 DESCRIPTION
 -----------
@@ -25,6 +25,9 @@ Downloads a remote GIT repository via HT
 	Do not check for delta base objects (use this option
 	only when you know the remote repository is not
 	deltified).
+--recover::
+	Check dependency of deltified object more carefully than
+	usual, to recover after earlier pull that was interrupted.
 -v::
 	Report what is downloaded.
 
diff --git a/Documentation/git-local-pull.txt b/Documentation/git-local-pull.txt
--- a/Documentation/git-local-pull.txt
+++ b/Documentation/git-local-pull.txt
@@ -9,7 +9,7 @@ git-local-pull - Duplicates another GIT 
 
 SYNOPSIS
 --------
-'git-local-pull' [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] commit-id path
+'git-local-pull' [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] [--recover] commit-id path
 
 DESCRIPTION
 -----------
@@ -27,6 +27,9 @@ OPTIONS
 	Do not check for delta base objects (use this option
 	only when you know the remote repository is not
 	deltified).
+--recover::
+	Check dependency of deltified object more carefully than
+	usual, to recover after earlier pull that was interrupted.
 -v::
 	Report what is downloaded.
 
diff --git a/Documentation/git-rpull.txt b/Documentation/git-rpull.txt
--- a/Documentation/git-rpull.txt
+++ b/Documentation/git-rpull.txt
@@ -10,7 +10,7 @@ git-rpull - Pulls from a remote reposito
 
 SYNOPSIS
 --------
-'git-rpull' [-c] [-t] [-a] [-d] [-v] commit-id url
+'git-rpull' [-c] [-t] [-a] [-d] [-v] [--recover] commit-id url
 
 DESCRIPTION
 -----------
@@ -29,6 +29,9 @@ OPTIONS
 	Do not check for delta base objects (use this option
 	only when you know the remote repository is not
 	deltified).
+--recover::
+	Check dependency of deltified object more carefully than
+	usual, to recover after earlier pull that was interrupted.
 -v::
 	Report what is downloaded.
 
diff --git a/pull.h b/pull.h
--- a/pull.h
+++ b/pull.h
@@ -13,7 +13,9 @@ extern int get_history;
 /** Set to fetch the trees in the commit history. **/
 extern int get_all;
 
-/* Set to zero to skip the check for delta object base. */
+/* Set to zero to skip the check for delta object base;
+ * set to two to check delta dependency even for objects we already have.
+ */
 extern int get_delta;
 
 /* Set to be verbose */
diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -105,6 +105,8 @@ int main(int argc, char **argv)
 			get_history = 1;
 		} else if (argv[arg][1] == 'd') {
 			get_delta = 0;
+		} else if (!strcmp(argv[arg], "--recover")) {
+			get_delta = 2;
 		} else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
@@ -115,7 +117,7 @@ int main(int argc, char **argv)
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-http-pull [-c] [-t] [-a] [-d] [-v] commit-id url");
+		usage("git-http-pull [-c] [-t] [-a] [-d] [-v] [--recover] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -74,7 +74,7 @@ int fetch(unsigned char *sha1)
 }
 
 static const char *local_pull_usage = 
-"git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] commit-id path";
+"git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] [--recover] commit-id path";
 
 /* 
  * By default we only use file copy.
@@ -94,6 +94,8 @@ int main(int argc, char **argv)
 			get_history = 1;
 		else if (argv[arg][1] == 'd')
 			get_delta = 0;
+		else if (!strcmp(argv[arg], "--recover"))
+			get_delta = 2;
 		else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
diff --git a/pull.c b/pull.c
--- a/pull.c
+++ b/pull.c
@@ -6,6 +6,7 @@
 
 int get_tree = 0;
 int get_history = 0;
+/* 1 means "get delta", 2 means "really check delta harder */
 int get_delta = 1;
 int get_all = 0;
 int get_verbosely = 0;
@@ -32,12 +33,16 @@ static void report_missing(const char *w
 
 static int make_sure_we_have_it(const char *what, unsigned char *sha1)
 {
-	int status;
-	if (has_sha1_file(sha1))
+	int status = 0;
+
+	if (!has_sha1_file(sha1)) {
+		status = fetch(sha1);
+		if (status && what)
+			report_missing(what, sha1);
+	}
+	else if (get_delta < 2)
 		return 0;
-	status = fetch(sha1);
-	if (status && what)
-		report_missing(what, sha1);
+
 	if (get_delta) {
 		char delta_sha1[20];
 		status = sha1_delta_base(sha1, delta_sha1);
diff --git a/rpull.c b/rpull.c
--- a/rpull.c
+++ b/rpull.c
@@ -52,6 +52,8 @@ int main(int argc, char **argv)
 			get_history = 1;
 		} else if (argv[arg][1] == 'd') {
 			get_delta = 0;
+		} else if (!strcmp(argv[arg], "--recover")) {
+			get_delta = 2;
 		} else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
@@ -62,7 +64,7 @@ int main(int argc, char **argv)
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-rpull [-c] [-t] [-a] [-v] [-d] commit-id url");
+		usage("git-rpull [-c] [-t] [-a] [-v] [-d] [--recover] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
diff --git a/t/t5100-delta-pull.sh b/t/t5100-delta-pull.sh
new file mode 100644
--- /dev/null
+++ b/t/t5100-delta-pull.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Test pulling deltified objects
+
+'
+. ./test-lib.sh
+
+locate_obj='s|\(..\)|.git/objects/\1/|'
+
+test_expect_success \
+    setup \
+    'cat ../README >a &&
+    git-update-cache --add a &&
+    a0=`git-ls-files --stage |
+        sed -e '\''s/^[0-7]* \([0-9a-f]*\) .*/\1/'\''` &&
+
+    sed -e 's/test/TEST/g' ../README >a &&
+    git-update-cache a &&
+    a1=`git-ls-files --stage |
+        sed -e '\''s/^[0-7]* \([0-9a-f]*\) .*/\1/'\''` &&
+    tree=`git-write-tree` &&
+    commit=`git-commit-tree $tree </dev/null` &&
+    a0f=`echo "$a0" | sed -e "$locate_obj"` &&
+    a1f=`echo "$a1" | sed -e "$locate_obj"` &&
+    echo commit $commit &&
+    echo a0 $a0 &&
+    echo a1 $a1 &&
+    ls -l $a0f $a1f &&
+    echo $commit >.git/HEAD &&
+    git-mkdelta -v $a0 $a1 &&
+    ls -l $a0f $a1f'
+
+# Now commit has a tree that records delitified "a" whose SHA1 is a1.
+# Create a new repo and pull this commit into it.
+
+test_expect_success \
+    'setup and cd into new repo' \
+    'mkdir dest && cd dest && rm -fr .git && git-init-db'
+     
+test_expect_success \
+    'pull from deltified repo into a new repo without -d' \
+    'rm -fr .git a && git-init-db &&
+     git-local-pull -v -a $commit ../.git/ &&
+     git-cat-file blob $a1 >a &&
+     diff -u a ../a'
+
+test_expect_failure \
+    'pull from deltified repo into a new repo with -d' \
+    'rm -fr .git a && git-init-db &&
+     git-local-pull -v -a -d $commit ../.git/ &&
+     git-cat-file blob $a1 >a &&
+     diff -u a ../a'
+
+test_expect_failure \
+    'pull from deltified repo after delta failure without --recover' \
+    'rm -f a &&
+     git-local-pull -v -a $commit ../.git/ &&
+     git-cat-file blob $a1 >a &&
+     diff -u a ../a'
+
+test_expect_success \
+    'pull from deltified repo after delta failure with --recover' \
+    'rm -f a &&
+     git-local-pull -v -a --recover $commit ../.git/ &&
+     git-cat-file blob $a1 >a &&
+     diff -u a ../a'
+
+test_expect_success \
+    'missing-tree or missing-blob should be re-fetched without --recover' \
+    'rm -f a $a0f $a1f &&
+     git-local-pull -v -a $commit ../.git/ &&
+     git-cat-file blob $a1 >a &&
+     diff -u a ../a'
+
+test_done
+
------------

