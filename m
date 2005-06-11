From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-tree: --find-copies-harder
Date: Fri, 10 Jun 2005 18:31:02 -0700
Message-ID: <7vpsut7k89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 03:27:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgum3-0003nK-T3
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 03:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFKBbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 21:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVFKBbL
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 21:31:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15531 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261155AbVFKBbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 21:31:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611013103.MKFI1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Jun 2005 21:31:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Normally, diff-tree does not feed unchanged filepair to diffcore
for performance reasons, so copies are detected only when the
source file of the copy happens to be modified in the same
changeset.  This adds --find-copies-harder flag to tell
diff-tree to sacrifice the performance in order to find copies
the same way as other commands in diff-* family.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Linus I am submitting this one because some patches on
*** read-tree I am going to send you will need this for
*** formatting into a form that is easier to review.  Also this
*** feature came up during the recent discussion on "what to do
*** with merging rename/copy in the longer term".

 diff-tree.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -11,6 +11,7 @@ static int show_tree_entry_in_recursive 
 static int read_stdin = 0;
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
+static int find_copies_harder = 0;
 static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
@@ -115,7 +116,7 @@ static int compare_tree_entry(void *tree
 		show_file("+", tree2, size2, base);
 		return 1;
 	}
-	if (!memcmp(sha1, sha2, 20) && mode1 == mode2)
+	if (!find_copies_harder && !memcmp(sha1, sha2, 20) && mode1 == mode2)
 		return 0;
 
 	/*
@@ -199,7 +200,7 @@ static int interesting(void *tree, unsig
 static void show_tree(const char *prefix, void *tree, unsigned long size, const char *base)
 {
 	while (size) {
-		if (interesting(tree, size, base))
+		if (find_copies_harder || interesting(tree, size, base))
 			show_file(prefix, tree, size, base);
 		update_tree_entry(&tree, &size);
 	}
@@ -267,7 +268,7 @@ static void call_diff_setup(void)
 
 static int call_diff_flush(void)
 {
-	diffcore_std(0,
+	diffcore_std(find_copies_harder ? paths : 0,
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
 		     diff_break_opt,
@@ -475,6 +476,10 @@ int main(int argc, const char **argv)
 				usage(diff_tree_usage);
 			continue;
 		}
+		if (!strcmp(arg, "--find-copies-harder")) {
+			find_copies_harder = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			diff_output_format = DIFF_FORMAT_MACHINE;
 			continue;
@@ -502,6 +507,8 @@ int main(int argc, const char **argv)
 		}
 		usage(diff_tree_usage);
 	}
+	if (find_copies_harder && detect_rename != DIFF_DETECT_COPY)
+		usage(diff_tree_usage);
 
 	if (argc > 0) {
 		int i;
------------

