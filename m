From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH 1/2] Add --quiet option to suppress output of "rm" commands for removed files.
Date: Mon, 16 Apr 2007 00:46:48 -0700
Message-ID: <20070416074648.GA18719@midwinter.com>
References: <20070416000408.GA19107@midwinter.com> <7v4pnh18hr.fsf@assigned-by-dhcp.cox.net> <4622C0AC.8090904@midwinter.com> <7vps65yvc1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:46:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdLvJ-00055y-BQ
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbXDPHqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbXDPHqu
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:46:50 -0400
Received: from tater.midwinter.com ([216.32.86.90]:53091 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932386AbXDPHqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:46:49 -0400
Received: (qmail 18919 invoked by uid 1001); 16 Apr 2007 07:46:48 -0000
Content-Disposition: inline
In-Reply-To: <7vps65yvc1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44606>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

Splitting this into two different options (and two patches) per Junio's
comments.

 Documentation/git-rm.txt |    4 ++++
 builtin-rm.c             |   10 +++++++---
 t/t3600-rm.sh            |   24 ++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 6feebc0..b051ccb 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -47,6 +47,10 @@ OPTIONS
 	the paths only from the index, leaving working tree
 	files.
 
+\--quiet::
+	git-rm normally outputs one line (in the form of an "rm" command)
+	for each file removed. This option suppresses that output.
+
 
 DISCUSSION
 ----------
diff --git a/builtin-rm.c b/builtin-rm.c
index 8a0738f..7eb9a42 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -10,7 +10,7 @@
 #include "tree-walk.h"
 
 static const char builtin_rm_usage[] =
-"git-rm [-f] [-n] [-r] [--cached] [--] <file>...";
+"git-rm [-f] [-n] [-r] [--cached] [--quiet] [--] <file>...";
 
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
 
@@ -132,6 +132,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			force = 1;
 		else if (!strcmp(arg, "-r"))
 			recursive = 1;
+		else if (!strcmp(arg, "--quiet"))
+			quiet = 1;
 		else
 			usage(builtin_rm_usage);
 	}
@@ -187,7 +189,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
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
index e31cf93..da9da92 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -84,6 +84,26 @@ test_expect_success \
     'When the rm in "git-rm -f" fails, it should not remove the file from the index' \
     'git-ls-files --error-unmatch baz'
 
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
+test_expect_success '"rm" command suppressed with --quiet' '
+	echo frotz > test-file &&
+	git add test-file &&
+	git commit -m "add file for rm --quiet test" &&
+	git rm --quiet test-file > rm-output &&
+	test `wc -l < rm-output` = 0 &&
+	rm -f test-file rm-output &&
+	git commit -m "remove file from rm --quiet test"
+'
+
 # Now, failure cases.
 test_expect_success 'Re-add foo and baz' '
 	git add foo baz &&
@@ -154,4 +174,8 @@ test_expect_success 'Recursive with -r -f' '
 	! test -d frotz
 '
 
+test_expect_failure 'Remove nonexistent file returns nonzero exit status' '
+	git rm nonexistent
+'
+
 test_done
-- 
1.5.1.1.99.g0ea98
