From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Pickaxe fixes.
Date: Sat, 28 May 2005 02:53:43 -0700
Message-ID: <7v7jhjy8uw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 11:52:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbxz7-0002XA-G8
	for gcvg-git@gmane.org; Sat, 28 May 2005 11:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVE1Jx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 05:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVE1Jx5
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 05:53:57 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:3740 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262675AbVE1Jxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 05:53:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528095344.MZBY26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 05:53:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A bug in the command line argument parsing code was making
pickaxe not to work at all in diff-cache and diff-files commands.
Embarrassingly enough, the working pickaxe in diff-tree tells me
that it was not working in these two commands from day one.
This patch fixes it.

Also updates the documentation to describe the --pickaxe-all option.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-cache.txt |    6 +++++-
Documentation/git-diff-files.txt |    6 +++++-
Documentation/git-diff-tree.txt  |    7 ++++++-
diff-cache.c                     |    2 +-
diff-files.c                     |    2 +-
5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-S<string>] [--cached] <tree-ish> [<path>...]
+'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -44,6 +44,10 @@ OPTIONS
 -S<string>::
 	Look for differences that contains the change in <string>.
 
+--pickaxe-all::
+	When -S finds a change, show all the changes in that
+	changeset, not just the files that contains the change
+	in <string>.
 
 -R::
 	Output diff in reverse.
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the w
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [--pickaxe-all] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -38,6 +38,10 @@ OPTIONS
 -S<string>::
 	Look for differences that contains the change in <string>.
 
+--pickaxe-all::
+	When -S finds a change, show all the changes in that
+	changeset, not just the files that contains the change
+	in <string>.
 
 -r::
 	This flag does not mean anything.  It is there only to match
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-S<string>] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -45,6 +45,11 @@ OPTIONS
 -S<string>::
 	Look for differences that contains the change in <string>.
 
+--pickaxe-all::
+	When -S finds a change, show all the changes in that
+	changeset, not just the files that contains the change
+	in <string>.
+
 -r::
 	recurse
 
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -206,7 +206,7 @@ int main(int argc, const char **argv)
 			diff_setup_opt |= DIFF_SETUP_REVERSE;
 			continue;
 		}
-		if (!strcmp(arg, "-S")) {
+		if (!strncmp(arg, "-S", 2)) {
 			pickaxe = arg + 2;
 			continue;
 		}
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -53,7 +53,7 @@ int main(int argc, const char **argv)
 			diff_output_format = DIFF_FORMAT_MACHINE;
 		else if (!strcmp(argv[1], "-R"))
 			diff_setup_opt |= DIFF_SETUP_REVERSE;
-		else if (!strcmp(argv[1], "-S"))
+		else if (!strncmp(argv[1], "-S", 2))
 			pickaxe = argv[1] + 2;
 		else if (!strcmp(argv[1], "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
------------------------------------------------

