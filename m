From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/6] git-merge-base: --check-ancestry option
Date: Tue, 09 Jan 2007 02:41:28 -0800
Message-ID: <7vodp8o52f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 11:41:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EQN-0003nM-HH
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbXAIKle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbXAIKld
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:41:33 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:45342 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbXAIKl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:41:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109104128.BBSA3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 05:41:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yhk1W0051kojtg0000000; Tue, 09 Jan 2007 05:41:44 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36348>

A new option drives underlying in_merge_bases() function to
determine if a commit is reachable from any of the other commits
supplied on the command line.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-merge-base.txt |   13 +++++++++++-
 merge-base.c                     |   39 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 6099be2..7d4d027 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,7 +8,9 @@ git-merge-base - Finds as good a common ancestor as possible for a merge
 
 SYNOPSIS
 --------
+[verse]
 'git-merge-base' [--all] <commit> <commit>
+'git-merge-base' --check-ancestry <commit> <commit>...
 
 DESCRIPTION
 -----------
@@ -21,7 +23,10 @@ the parent relationship.
 Given a selection of equally good common ancestors it should not be
 relied on to decide in any particular way.
 
-The "git-merge-base" algorithm is still in flux - use the source...
+With `--check-ancestry` option, the command can be used to check
+if the first commit is an ancestor of any of the remaining
+commits.
+
 
 OPTIONS
 -------
@@ -29,6 +34,12 @@ OPTIONS
 	Output all common ancestors for the two commits instead of
 	just one.
 
+--check-ancestry::
+
+	Check if the first commit is an ancestor of any of the
+	remaining commits.  If so, exit with status 0, otherwise
+	non-zero.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/merge-base.c b/merge-base.c
index 385f4ba..bc478eb 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -2,6 +2,8 @@
 #include "commit.h"
 
 static int show_all;
+static const char merge_base_usage[] =
+"git-merge-base [--all] <commit> <commit> | --check-ancestry <commit> <commit>...";
 
 static int merge_base(struct commit *rev1, struct commit *rev2)
 {
@@ -20,13 +22,37 @@ static int merge_base(struct commit *rev1, struct commit *rev2)
 	return 0;
 }
 
-static const char merge_base_usage[] =
-"git-merge-base [--all] <commit-id> <commit-id>";
+static int check_ancestry(int argc, char **argv)
+{
+	struct commit *one, *two, **reference;
+	unsigned char sha1[20];
+	int i;
+
+	if (argc < 2)
+		usage(merge_base_usage);
+	if (get_sha1(argv[0], sha1))
+		die("Not a valid object name %s", argv[0]);
+	one = lookup_commit_reference(sha1);
+	if (!one)
+		return 1;
+
+	reference = xcalloc(argc - 1, sizeof(struct commit *));
+	for (i = 1; i < argc; i++) {
+		if (get_sha1(argv[i], sha1))
+			die("Not a valid object name %s", argv[i]);
+		two = lookup_commit_reference(sha1);
+		if (!two)
+			return 1;
+		reference[i - 1] = two;
+	}
+	return !!in_merge_bases(one, reference, argc - 1);
+}
 
 int main(int argc, char **argv)
 {
 	struct commit *rev1, *rev2;
 	unsigned char rev1key[20], rev2key[20];
+	int check = 0;
 
 	setup_git_directory();
 	git_config(git_default_config);
@@ -35,10 +61,19 @@ int main(int argc, char **argv)
 		char *arg = argv[1];
 		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
 			show_all = 1;
+		else if (!strcmp(arg, "-c") || !strcmp(arg, "--check-ancestry"))
+			check = 1;
 		else
 			usage(merge_base_usage);
 		argc--; argv++;
 	}
+
+	if (check) {
+		if (show_all)
+			die("--all and --check-ancestry are mutually incompatible");
+		return check_ancestry(argc - 1, argv + 1);
+	}
+
 	if (argc != 3)
 		usage(merge_base_usage);
 	if (get_sha1(argv[1], rev1key))
-- 
1.4.4.4.g564d
