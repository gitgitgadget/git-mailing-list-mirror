From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] diff: Fix docs and add -O to diff-helper.
Date: Fri, 03 Jun 2005 01:36:43 -0700
Message-ID: <7v8y1rq1k4.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
	<7vmzqau3es.fsf@assigned-by-dhcp.cox.net>
	<7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506021716140.1876@ppc970.osdl.org>
	<7vis0wusv5.fsf@assigned-by-dhcp.cox.net>
	<7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:36:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De7dx-0007dP-5n
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 10:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFCIiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 04:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFCIiG
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 04:38:06 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1237 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261184AbVFCIgq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 04:36:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603083643.PGPA23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 04:36:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 03 Jun 2005 01:32:00 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch updates diff documentation and usage strings:

 - clarify the semantics of -R.  It is not "output in reverse";
   rather, it is "I will feed diff backwards".  Semantically
   they are different when -C is involved.

 - describe -O in usage strings of diff-* brothers.  It was
   implemented, documented but not described in usage text.

Also it adds -O to diff-helper.  Like -S (and unlike -M/-C/-B),
this option can work on sanitized diff-raw output produced by
the diff-* brothers.  While we are at it, the call it makes to
diffcore is cleaned up to use the diffcore_std() like everybody
else, and the declaration for the low level diffcore routines
are moved from diff.h (public) to diffcore.h (private between
diff.c and diffcore backends).

Signed-off-by: Junio C Hamano <junkio@cox.net> 
---

 Documentation/git-diff-cache.txt  |    3 ++-
 Documentation/git-diff-files.txt  |    3 ++-
 Documentation/git-diff-helper.txt |    5 ++++-
 Documentation/git-diff-tree.txt   |    2 +-
 diff.h                            |   10 +---------
 diffcore.h                        |    6 ++++++
 diff-cache.c                      |    2 +-
 diff-files.c                      |    2 +-
 diff-helper.c                     |   25 ++++++++++++++-----------
 diff-tree.c                       |    2 +-
 10 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -57,7 +57,8 @@ OPTIONS
 	<orderfile>, which has one shell glob pattern per line.
 
 -R::
-	Output diff in reverse.
+	Swap two inputs; that is, show differences from cache or
+	on-disk file to tree contents.
 
 --cached::
 	do not consider the on-disk file at all
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -27,7 +27,8 @@ OPTIONS
 	Remain silent even on nonexisting files
 
 -R::
-	Output diff in reverse.
+	Swap two inputs; that is, show differences from on-disk files
+	to cache contents.
 
 -B::
 	Break complete rewrite changes into pairs of delete and create.
diff --git a/Documentation/git-diff-helper.txt b/Documentation/git-diff-helper.txt
--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -9,7 +9,7 @@ git-diff-helper - Generates patch format
 
 SYNOPSIS
 --------
-'git-diff-helper' [-z] [-S<string>]
+'git-diff-helper' [-z] [-S<string>] [-O<orderfile>]
 
 DESCRIPTION
 -----------
@@ -24,6 +24,9 @@ OPTIONS
 -S<string>::
 	Look for differences that contains the change in <string>.
 
+-O<orderfile>::
+	Output the patch in the order specified in the
+	<orderfile>, which has one shell glob pattern per line.
 
 See Also
 --------
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -43,7 +43,7 @@ OPTIONS
 	Detect copies as well as renames.
 
 -R::
-	Output diff in reverse.
+	Swap two input trees.
 
 -S<string>::
 	Look for differences that contains the change in <string>.
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -35,21 +35,13 @@ extern int diff_scoreopt_parse(const cha
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
+
 extern void diff_setup(int flags);
 
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
 
-extern void diffcore_rename(int rename_copy, int minimum_score);
-
 #define DIFF_PICKAXE_ALL	1
-extern void diffcore_pickaxe(const char *needle, int opts);
-
-extern void diffcore_pathspec(const char **pathspec);
-
-extern void diffcore_order(const char *orderfile);
-
-extern void diffcore_break(int max_score);
 
 extern void diffcore_std(const char **paths,
 			 int detect_rename, int rename_score,
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -73,6 +73,12 @@ extern struct diff_filepair *diff_queue(
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
+extern void diffcore_pathspec(const char **pathspec);
+extern void diffcore_break(int);
+extern void diffcore_rename(int rename_copy, int);
+extern void diffcore_pickaxe(const char *needle, int opts);
+extern void diffcore_order(const char *orderfile);
+
 #define DIFF_DEBUG 0
 #if DIFF_DEBUG
 void diff_debug_filespec(struct diff_filespec *, int, const char *);
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -157,7 +157,7 @@ static void mark_merge_entries(void)
 }
 
 static char *diff_cache_usage =
-"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-C] [-R] [-S<string>] [--cached] <tree-ish> [<path>...]";
+"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] [--cached] <tree-ish> [<path>...]";
 
 int main(int argc, const char **argv)
 {
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -7,7 +7,7 @@
 #include "diff.h"
 
 static const char *diff_files_usage =
-"git-diff-files [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [paths...]";
+"git-diff-files [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] [paths...]";
 
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -7,11 +7,22 @@
 
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static const char *orderfile = NULL;
 static int line_termination = '\n';
 static int inter_name_termination = '\t';
 
+static void flush_them(int ac, const char **av)
+{
+	diffcore_std(av + 1,
+		     0, 0, /* no renames */
+		     pickaxe, pickaxe_opts,
+		     -1, /* no breaks */
+		     orderfile);
+	diff_flush(DIFF_FORMAT_PATCH, 0);
+}
+
 static const char *diff_helper_usage =
-	"git-diff-helper [-z] [-S<string>] paths...";
+	"git-diff-helper [-z] [-S<string>] [-O<orderfile>] paths...";
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
@@ -131,17 +142,9 @@ int main(int ac, const char **av) {
 					  new_path);
 			continue;
 		}
-		if (1 < ac)
-			diffcore_pathspec(av + 1);
-		if (pickaxe)
-			diffcore_pickaxe(pickaxe, pickaxe_opts);
-		diff_flush(DIFF_FORMAT_PATCH, 0);
+		flush_them(ac, av);
 		printf(garbage_flush_format, sb.buf);
 	}
-	if (1 < ac)
-		diffcore_pathspec(av + 1);
-	if (pickaxe)
-		diffcore_pickaxe(pickaxe, pickaxe_opts);
-	diff_flush(DIFF_FORMAT_PATCH, 0);
+	flush_them(ac, av);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -397,7 +397,7 @@ static int diff_tree_stdin(char *line)
 }
 
 static char *diff_tree_usage =
-"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish>";
+"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish>";
 
 int main(int argc, const char **argv)
 {
------------

