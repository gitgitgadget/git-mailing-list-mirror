From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Add -q option to "git rm" to suppress output when there aren't errors.
Date: Sun, 15 Apr 2007 17:04:08 -0700
Message-ID: <20070416000408.GA19107@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 02:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEhp-00060k-Mn
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 02:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbXDPAEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 20:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbXDPAEM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 20:04:12 -0400
Received: from tater.midwinter.com ([216.32.86.90]:50667 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752105AbXDPAEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 20:04:11 -0400
Received: (qmail 19217 invoked by uid 1001); 16 Apr 2007 00:04:08 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44554>

This suppresses the output of "rm" commands, and also exits with a zero
exit code when no files match.  This allows "git rm" (and more importantly,
"git rm -r") to be used as an index filter with cg-admin-rewritehist.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 Documentation/git-rm.txt |    4 ++++
 builtin-rm.c             |   26 ++++++++++++++++++++------
 t/t3600-rm.sh            |   28 ++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 6feebc0..c354134 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -33,6 +33,10 @@ OPTIONS
         Don't actually remove the file(s), just show if they exist in
         the index.
 
+-q::
+	Don't output the names of the files being removed, and exit
+	with a zero status even if no files matched.
+
 -r::
         Allow recursive removal when a leading directory name is
         given.
diff --git a/builtin-rm.c b/builtin-rm.c
index 8a0738f..3d438de 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -10,7 +10,7 @@
 #include "tree-walk.h"
 
 static const char builtin_rm_usage[] =
-"git-rm [-f] [-n] [-r] [--cached] [--] <file>...";
+"git-rm [-f] [-n] [-q] [-r] [--cached] [--] <file>...";
 
 static struct {
 	int nr, alloc;
@@ -104,7 +104,7 @@ static struct lock_file lock_file;
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	int show_only = 0, force = 0, index_only = 0, recursive = 0;
+	int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
 	const char **pathspec;
 	char *seen;
 
@@ -130,6 +130,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			index_only = 1;
 		else if (!strcmp(arg, "-f"))
 			force = 1;
+		else if (!strcmp(arg, "-q"))
+			quiet = 1;
 		else if (!strcmp(arg, "-r"))
 			recursive = 1;
 		else
@@ -153,14 +155,24 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	if (pathspec) {
 		const char *match;
+		int seen_any = 0;
 		for (i = 0; (match = pathspec[i]) != NULL ; i++) {
-			if (!seen[i])
-				die("pathspec '%s' did not match any files",
-				    match);
+			if (!seen[i]) {
+				if (! quiet) {
+					die("pathspec '%s' did not match any files",
+					    match);
+				}
+			}
+			else {
+				seen_any = 1;
+			}
 			if (!recursive && seen[i] == MATCHED_RECURSIVELY)
 				die("not removing '%s' recursively without -r",
 				    *match ? match : ".");
 		}
+
+		if (! seen_any)
+			exit(0);
 	}
 
 	/*
@@ -187,7 +199,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 */
 	for (i = 0; i < list.nr; i++) {
 		const char *path = list.name[i];
-		printf("rm '%s'\n", path);
+		if (!quiet) {
+			printf("rm '%s'\n", path);
+		}
 
 		if (remove_file_from_cache(path))
 			die("git-rm: unable to remove %s", path);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index e31cf93..bd72feb 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -84,6 +84,30 @@ test_expect_success \
     'When the rm in "git-rm -f" fails, it should not remove the file from the index' \
     'git-ls-files --error-unmatch baz'
 
+test_expect_success 'Remove nonexistent file with -q returns zero exit status' '
+	git rm -q nonexistent
+'
+
+test_expect_success '"rm" command printed' '
+	echo frotz > test-file &&
+	git add test-file &&
+	git commit -m "add file for rm test" &&
+	git rm test-file > rm-output &&
+	test `egrep "^rm " rm-output | wc -l` = 1 &&
+	rm -f test-file rm-output &&
+	git commit -m "remove file from rm test"
+'
+
+test_expect_success '"rm" command suppressed with -q' '
+	echo frotz > test-file &&
+	git add test-file &&
+	git commit -m "add file for rm -q test" &&
+	git rm -q test-file > rm-output &&
+	test `wc -l < rm-output` = 0 &&
+	rm -f test-file rm-output &&
+	git commit -m "remove file from rm test"
+'
+
 # Now, failure cases.
 test_expect_success 'Re-add foo and baz' '
 	git add foo baz &&
@@ -154,4 +178,8 @@ test_expect_success 'Recursive with -r -f' '
 	! test -d frotz
 '
 
+test_expect_failure 'Remove nonexistent file returns nonzero exit status' '
+	git rm nonexistent
+'
+
 test_done
-- 
1.5.1.1.99.g0ea98
