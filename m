X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-pickaxe -C -C -C
Date: Mon, 06 Nov 2006 01:08:10 -0800
Message-ID: <7vmz75djt1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 09:08:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31003>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh0Sm-00039o-Ab for gcvg-git@gmane.org; Mon, 06 Nov
 2006 10:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161727AbWKFJIN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 04:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161728AbWKFJIN
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 04:08:13 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40888 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1161727AbWKFJIL
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 04:08:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061106090811.WHVA18816.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Mon, 6
 Nov 2006 04:08:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jM7o1V0011kojtg0000000 Mon, 06 Nov 2006
 04:07:48 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Three -C options makes the command to look for copied lines from _any_
existing file in the parent commit, not just changed files.

This is of course _very_ expensive.

Some numbers and observations.

* git-pickaxe -C revision.c
2.22user 0.02system 0:02.24elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+5263minor)pagefaults 0swaps
num read blob 486

* git-pickaxe -C -C -C revision.c
35.42user 0.27system 0:37.66elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (14major+115543minor)pagefaults 0swaps
num read blob 43277

Comparing the output from the above two, with this option, it
finds that some lines were copied from diff.c, diff-tree.c and
merge-cache.c; they are obvious patterns justifiably repeated.

 - list of parameters to a function (ll. 214-217, 247-249);

 - definitions of local variables (ll. 260-263);

 - loops over all cache entries (ll. 581-584).

This change probably falls into the category of "I did this not
because it is useful in practice but just because I could".

Nevertheless, looking at the output was very interesting.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pickaxe.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-pickaxe.c b/builtin-pickaxe.c
index f12b2d4..619a8c6 100644
--- a/builtin-pickaxe.c
+++ b/builtin-pickaxe.c
@@ -19,7 +19,7 @@
 #include <sys/time.h>
 
 static char pickaxe_usage[] =
-"git-pickaxe [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [commit] [--] file\n"
+"git-pickaxe [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [-C] [commit] [--] file\n"
 "  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
 "  -l, --long          Show long commit SHA1 (Default: off)\n"
 "  -t, --time          Show raw timestamp (Default: off)\n"
@@ -48,6 +48,7 @@ static int num_commits;
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
 #define PICKAXE_BLAME_COPY_HARDER	04
+#define PICKAXE_BLAME_COPY_HARDEST	010
 
 /*
  * blame for a blame_entry with score lower than these thresholds
@@ -885,8 +886,9 @@ static int find_copy_in_parent(struct sc
 	 * and this code needs to be after diff_setup_done(), which
 	 * usually makes find-copies-harder imply copy detection.
 	 */
-	if ((opt & PICKAXE_BLAME_COPY_HARDER) &&
-	    (!porigin || strcmp(target->path, porigin->path)))
+	if (((opt & PICKAXE_BLAME_COPY_HARDER) &&
+	     (!porigin || strcmp(target->path, porigin->path))) ||
+	    (opt & PICKAXE_BLAME_COPY_HARDEST))
 		diff_opts.find_copies_harder = 1;
 
 	diff_tree_sha1(parent->tree->object.sha1,
@@ -1569,6 +1571,8 @@ int cmd_pickaxe(int argc, const char **a
 			blame_move_score = parse_score(arg+2);
 		}
 		else if (!strncmp("-C", arg, 2)) {
+			if (opt & PICKAXE_BLAME_COPY_HARDER)
+				opt |= PICKAXE_BLAME_COPY_HARDEST;
 			if (opt & PICKAXE_BLAME_COPY)
 				opt |= PICKAXE_BLAME_COPY_HARDER;
 			opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
-- 
1.4.3.4.g9f05

