From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add --no-commit-id option for git-diff-tree, use it in gitk
Date: Thu, 10 Nov 2005 00:30:12 -0500
Message-ID: <1131600612.10499.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 10 06:32:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea50w-0003hr-7O
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 06:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVKJFaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 00:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKJFaR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 00:30:17 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:31156 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751096AbVKJFaP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 00:30:15 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ea50o-0001sK-6D
	for git@vger.kernel.org; Thu, 10 Nov 2005 00:30:14 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Ea50n-0002qQ-2h
	for git@vger.kernel.org; Thu, 10 Nov 2005 00:30:13 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11463>

This patch introduces -no-commit-id option for git-diff-tree, which
suppresses commit ID output.

This option is used in gitk, to suppress empty lines after "Comments"
introduced in 8b7e5d76e836396a097bb6f61cf930ea872a7bd3.  Also, the p
variable is removed where is became unused due to the same patch.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index f57c8d0..9a2947e 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -8,7 +8,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [--stdin] [-m] [-s] [-v] [--pretty] [-t] [-r] [--root] [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
+'git-diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty] [-t] [-r] [--root] [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -74,6 +74,10 @@ separated with a single space are given.
 	commit message.  Without "=<style>", it defaults to
 	medium.
 
+--no-commit-id::
+	git-diff-tree outputs a line with the commit ID when
+	applicable.  This flag suppressed the commit ID output.
+
 
 Limiting Output
 ---------------
diff --git a/diff-tree.c b/diff-tree.c
index ed323d8..f2c629b 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 
 static int show_root_diff = 0;
+static int no_commit_id = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
 static int read_stdin = 0;
@@ -28,7 +29,7 @@ static int call_diff_flush(void)
 		diff_options.output_format = saved_fmt;
 		return 0;
 	}
-	if (header) {
+	if (header && !no_commit_id) {
 		printf("%s%c", header, diff_options.line_termination);
 		header = NULL;
 	}
@@ -231,6 +232,10 @@ int main(int argc, const char **argv)
 			show_root_diff = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-commit-id")) {
+			no_commit_id = 1;
+			continue;
+		}
 		usage(diff_tree_usage);
 	}
 	if (diff_options.output_format == DIFF_FORMAT_PATCH)
diff --git a/gitk b/gitk
index a9d37d9..6d47139 100755
--- a/gitk
+++ b/gitk
@@ -2805,8 +2805,7 @@ proc gettreediffs {ids} {
     set treepending $ids
     set treediff {}
     set id [lindex $ids 0]
-    set p [lindex $ids 1]
-    if [catch {set gdtf [open "|git-diff-tree -r $id" r]}] return
+    if [catch {set gdtf [open "|git-diff-tree --no-commit-id -r $id" r]}] return
     fconfigure $gdtf -blocking 0
     fileevent $gdtf readable [list gettreediffline $gdtf $ids]
 }
@@ -2840,9 +2839,8 @@ proc getblobdiffs {ids} {
     global difffilestart nextupdate diffinhdr treediffs
 
     set id [lindex $ids 0]
-    set p [lindex $ids 1]
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [list | git-diff-tree -r -p -C $id]
+    set cmd [list | git-diff-tree --no-commit-id -r -p -C $id]
     if {[catch {set bdf [open $cmd r]} err]} {
 	puts "error getting diffs: $err"
 	return


-- 
Regards,
Pavel Roskin
