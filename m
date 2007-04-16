From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH 2/2] Add --ignore-notfound option to exit with zero status when no files are removed.
Date: Mon, 16 Apr 2007 00:53:24 -0700
Message-ID: <20070416075324.GA18961@midwinter.com>
References: <20070416000408.GA19107@midwinter.com> <7v4pnh18hr.fsf@assigned-by-dhcp.cox.net> <4622C0AC.8090904@midwinter.com> <7vps65yvc1.fsf@assigned-by-dhcp.cox.net> <20070416074648.GA18719@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdM1g-0007fp-DU
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbXDPHxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbXDPHxZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:53:25 -0400
Received: from tater.midwinter.com ([216.32.86.90]:53127 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932478AbXDPHxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:53:25 -0400
Received: (qmail 19443 invoked by uid 1001); 16 Apr 2007 07:53:24 -0000
Content-Disposition: inline
In-Reply-To: <20070416074648.GA18719@midwinter.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44609>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

This allows "git rm -r --ignore-notfound" to be used as an index filter
with cg-admin-rewritehist. The documentation for that command recommends
using git-update-index --remove to filter files out of a tree's history,
but that doesn't support recursive deletion like git-rm does, making it
less convenient to filter directories from history.

 Documentation/git-rm.txt |    3 +++
 builtin-rm.c             |   21 +++++++++++++++++----
 t/t3600-rm.sh            |    4 ++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index b051ccb..9ffb515 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -47,6 +47,9 @@ OPTIONS
 	the paths only from the index, leaving working tree
 	files.
 
+\--ignore-notfound::
+	Exit with a zero status even if no files matched.
+
 \--quiet::
 	git-rm normally outputs one line (in the form of an "rm" command)
 	for each file removed. This option suppresses that output.
diff --git a/builtin-rm.c b/builtin-rm.c
index 7eb9a42..71166fb 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -10,7 +10,7 @@
 #include "tree-walk.h"
 
 static const char builtin_rm_usage[] =
-"git-rm [-f] [-n] [-r] [--cached] [--quiet] [--] <file>...";
+"git-rm [-f] [-n] [-r] [--cached] [--ignore-notfound] [--quiet] [--] <file>...";
 
 static struct {
 	int nr, alloc;
@@ -105,6 +105,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
 	int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
+	int ignore_notfound = 0;
 	const char **pathspec;
 	char *seen;
 
@@ -134,6 +135,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			recursive = 1;
 		else if (!strcmp(arg, "--quiet"))
 			quiet = 1;
+		else if (!strcmp(arg, "--ignore-notfound"))
+			ignore_notfound = 1;
 		else
 			usage(builtin_rm_usage);
 	}
@@ -155,14 +158,24 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	if (pathspec) {
 		const char *match;
+		int seen_any = 0;
 		for (i = 0; (match = pathspec[i]) != NULL ; i++) {
-			if (!seen[i])
-				die("pathspec '%s' did not match any files",
-				    match);
+			if (!seen[i]) {
+				if (!ignore_notfound) {
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
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index da9da92..665b8b0 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -84,6 +84,10 @@ test_expect_success \
     'When the rm in "git-rm -f" fails, it should not remove the file from the index' \
     'git-ls-files --error-unmatch baz'
 
+test_expect_success 'Remove nonexistent file with --ignore-notfound' '
+	git rm --ignore-notfound nonexistent
+'
+
 test_expect_success '"rm" command printed' '
 	echo frotz > test-file &&
 	git add test-file &&
-- 
1.5.1.1.99.g0ea98
