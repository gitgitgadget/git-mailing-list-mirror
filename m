From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 09:51:41 -0700
Message-ID: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 18:50:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQTF7-0007Df-Hn
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 18:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDZQx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDZQx2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 12:53:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64492 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261637AbVDZQvo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 12:51:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426165143.TIQF7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 12:51:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

	what do you want diff-cache to do upon finding an
unmerged path?  Currently your code says "undecided" to me.

The main() attempts to first remove all merge entries before
letting the diff_cache() do its work, but the diff_cache()
itself has also some code to deal with unmerged entries.

In the attached patch, the second hunk starting at ll 76 is a
pure and obvious bugfix.  The function is attempting to remove
all merge entries, but it stops in the middle; that's why I said
"attempts" in the above.

The patch lets you have it in both ways by adding --unmerged
flag.  Without it, unmerged entries are culled at the beginning;
with it, you will see diffs for all unmerged stages.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

jit-snap -v 0
--- k/diff-cache.c
+++ l/diff-cache.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 
+static int leave_unmerged = 0;
 static int cached_only = 0;
 static int line_termination = '\n';
 
@@ -76,7 +77,7 @@ static void remove_merge_entries(void)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
-			break;
+			continue;
 		printf("%s: unmerged\n", ce->name);
 		while (remove_entry_at(i)) {
 			if (!ce_stage(active_cache[i]))
@@ -85,7 +86,8 @@ static void remove_merge_entries(void)
 	}
 }
 
-static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
+static char *diff_cache_usage =
+"diff-cache [-r] [-z] [--cached] [--unmerged] <tree sha1>";
 
 int main(int argc, char **argv)
 {
@@ -110,13 +112,18 @@ int main(int argc, char **argv)
 			cached_only = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--unmerged")) {
+			leave_unmerged = 1;
+			continue;
+		}
 		usage(diff_cache_usage);
 	}
 
 	if (argc != 2 || get_sha1_hex(argv[1], tree_sha1))
 		usage(diff_cache_usage);
 
-	remove_merge_entries();
+	if (!leave_unmerged)
+		remove_merge_entries();
 
 	tree = read_tree_with_tree_or_commit_sha1(tree_sha1, &size, 0);
 	if (!tree)



