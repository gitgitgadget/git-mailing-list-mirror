From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] fsck: do not print dangling objects by default
Date: Sun, 26 Feb 2012 21:43:57 +0100
Message-ID: <20120226204357.GA26088@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 21:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1l53-0001cM-56
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 21:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab2BZUwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 15:52:25 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:40765 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752913Ab2BZUwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 15:52:24 -0500
Received: from localhost (p5B22E044.dip.t-dialin.net [91.34.224.68])
	by bsmtp.bon.at (Postfix) with ESMTP id 514F7CDF82;
	Sun, 26 Feb 2012 21:52:27 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191575>

Every reference to git fsck that I could find in the documentation or on
the web is followed by the some kind of assurance that dangling objects
are "not a problem", "nothing to worry about" or "not at all
interesting".

Instead of telling the user everywhere to ignore those messages, let's
not print them in the first place. The --dangling flag can be used to
explicitly enable printing dangling objects.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 Documentation/git-fsck.txt    |    3 +++
 Documentation/git-repack.txt  |    2 +-
 Documentation/user-manual.txt |   20 ++------------------
 builtin/fsck.c                |    7 +++++--
 t/t1410-reflog.sh             |    2 +-
 t/t1450-fsck.sh               |    6 +-----
 t/t6050-replace.sh            |    2 +-
 7 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 6c47395..199c5a0 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -30,6 +30,9 @@ index file, all SHA1 references in .git/refs/*, and all reflogs (unless
 	Print out objects that exist but that aren't reachable from any
 	of the reference nodes.
 
+--dangling::
+	Print objects that exist but that are never 'directly' used.
+
 --root::
 	Report root nodes.
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 40af321..4c1aff6 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -34,7 +34,7 @@ OPTIONS
 	Especially useful when packing a repository that is used
 	for private development. Use
 	with '-d'.  This will clean up the objects that `git prune`
-	leaves behind, but `git fsck --full` shows as
+	leaves behind, but `git fsck --full --dangling` shows as
 	dangling.
 +
 Note that users fetching over dumb protocols will have to fetch the
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f13a846..09ffbcc 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1582,25 +1582,12 @@ Checking the repository for corruption
 
 The linkgit:git-fsck[1] command runs a number of self-consistency checks
 on the repository, and reports on any problems.  This may take some
-time.  The most common warning by far is about "dangling" objects:
+time.
 
 -------------------------------------------------
 $ git fsck
-dangling commit 7281251ddd2a61e38657c827739c57015671a6b3
-dangling commit 2706a059f258c6b245f298dc4ff2ccd30ec21a63
-dangling commit 13472b7c4b80851a1bc551779171dcb03655e9b5
-dangling blob 218761f9d90712d37a9c5e36f406f92202db07eb
-dangling commit bf093535a34a4d35731aa2bd90fe6b176302f14f
-dangling commit 8e4bec7f2ddaa268bef999853c25755452100f8e
-dangling tree d50bb86186bf27b681d25af89d3b5b68382e4085
-dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
-...
 -------------------------------------------------
 
-Dangling objects are not a problem.  At worst they may take up a little
-extra disk space.  They can sometimes provide a last-resort method for
-recovering lost work--see <<dangling-objects>> for details.
-
 [[recovering-lost-changes]]
 Recovering lost changes
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -1665,7 +1652,7 @@ commits in the dangling objects that `git fsck` reports.  See
 <<dangling-objects>> for the details.
 
 -------------------------------------------------
-$ git fsck
+$ git fsck --dangling
 dangling commit 7281251ddd2a61e38657c827739c57015671a6b3
 dangling commit 2706a059f258c6b245f298dc4ff2ccd30ec21a63
 dangling commit 13472b7c4b80851a1bc551779171dcb03655e9b5
@@ -3301,9 +3288,6 @@ broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
 missing blob 4b9458b3786228369c63936db65827de3cc06200
 ------------------------------------------------
 
-(Typically there will be some "dangling object" messages too, but they
-aren't interesting.)
-
 Now you know that blob 4b9458b3 is missing, and that the tree 2d9263c6
 points to it.  If you could find just one copy of that missing blob
 object, possibly in some other repository, you could move it into
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8c479a7..0745535 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -29,6 +29,7 @@ static int errors_found;
 static int write_lost_and_found;
 static int verbose;
 static int show_progress = -1;
+static int show_dangling;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -221,8 +222,9 @@ static void check_unreachable_object(struct object *obj)
 	 * start looking at, for example.
 	 */
 	if (!obj->used) {
-		printf("dangling %s %s\n", typename(obj->type),
-		       sha1_to_hex(obj->sha1));
+		if (show_dangling)
+			printf("dangling %s %s\n", typename(obj->type),
+			       sha1_to_hex(obj->sha1));
 		if (write_lost_and_found) {
 			char *filename = git_path("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
@@ -614,6 +616,7 @@ static char const * const fsck_usage[] = {
 static struct option fsck_opts[] = {
 	OPT__VERBOSE(&verbose, "be verbose"),
 	OPT_BOOLEAN(0, "unreachable", &show_unreachable, "show unreachable objects"),
+	OPT_BOOLEAN(0, "dangling", &show_dangling, "show dangling objects"),
 	OPT_BOOLEAN(0, "tags", &show_tags, "report tags"),
 	OPT_BOOLEAN(0, "root", &show_root, "report root nodes"),
 	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head nodes"),
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 252fc82..12441c5 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -20,7 +20,7 @@ check_have () {
 }
 
 check_fsck () {
-	output=$(git fsck --full)
+	output=$(git fsck --full --dangling)
 	case "$1" in
 	'')
 		test -z "$output" ;;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 523ce9c..78bfbc3 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -27,12 +27,8 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
 		git init &&
 		echo ../../../.git/objects >.git/objects/info/alternates &&
 		test_commit C fileC one &&
-		git fsck >../out 2>&1
+		git fsck >../actual 2>&1
 	) &&
-	{
-		grep -v dangling out >actual ||
-		:
-	} &&
 	test_cmp empty actual
 '
 
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 5c87f28..5b36ee3 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -95,7 +95,7 @@ test_expect_success 'tag replaced commit' '
 '
 
 test_expect_success '"git fsck" works' '
-     git fsck master > fsck_master.out &&
+     git fsck --dangling master > fsck_master.out &&
      grep "dangling commit $R" fsck_master.out &&
      grep "dangling tag $(cat .git/refs/tags/mytag)" fsck_master.out &&
      test -z "$(git fsck)"
-- 
1.7.9.1
