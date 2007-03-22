From: Junio C Hamano <junkio@cox.net>
Subject: Re: Set up for better tree diff optimizations
Date: Wed, 21 Mar 2007 17:00:27 -0700
Message-ID: <7vd532ywo4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
	<7vircv3wfc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703210812590.6730@woody.linux-foundation.org>
	<7vslby1qvw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703211110050.6730@woody.linux-foundation.org>
	<7vhcse1kpu.fsf@assigned-by-dhcp.cox.net>
	<7vslbyz81b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 01:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUAk2-0000Ym-03
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 01:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965483AbXCVAAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 20:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965493AbXCVAAb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 20:00:31 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41233 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965483AbXCVAA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 20:00:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322000030.NJL2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 20:00:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dc0U1W00C1kojtg0000000; Wed, 21 Mar 2007 20:00:28 -0400
In-Reply-To: <7vslbyz81b.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 21 Mar 2007 12:54:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42827>

Junio C Hamano <junkio@cox.net> writes:

> So this is the round #2, as a replacement patch of what I sent
> earlier.  Once we know that there are pathspecs that sort later
> than the current path, we can defer doing strncmp() and skip
> that pathspec early by comparing length.  If the path is longer
> than the spec, we can tell that it would never match without
> comparing.

And then this comes on top of #2.

-- >8 --
tree_entry_interesting(): allow it to say "everything is interesting"

In addition to optimizing pathspecs that would never match which
was done earlier, this optimizes pathspecs that would always
match (e.g. "arch/" while the traversal is already in
"arch/i386/" hierarchy).

With this, the worst case become slightly more palatable, while
improving average case.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  For example, best-of-ten user times of
  "rev-list HEAD -- $pathspec" in the eclipse repository for
  various pathspecs are:

  * .cvsignore (best path, earliest in the tree)
    11.84 (without any optimization)
     6.35 (with patch #2)
     6.35 (with patch #2 and this patch)

  * platform-launcher (worst path, last in the tree)
    12.20 (without any optimization)
    12.90 (with patch #2)
    12.75 (with patch #2 and this patch)

  * org.eclipse.platform.macosx.carbon-feature (middle in the tree)
    12.02 (without any optimization)
    10.52 (with patch #2)
    10.43 (with patch #2 and this patch)

  The kernel archive number is similar.  Limited to arch/i386 and
  include/asm-i386, the numbers are:

     1.18 (without any optimization)
     1.11 (with patch #2)
     1.10 (with patch #2 and this patch).

 tree-diff.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 15fd665..852498e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -70,7 +70,8 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
  * Is a tree entry interesting given the pathspec we have?
  *
  * Return:
- *  - positive for yes
+ *  - 2 for "yes, and all subsequent entries will be"
+ *  - 1 for yes
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
@@ -100,8 +101,11 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 			if (strncmp(base, match, matchlen))
 				continue;
 
-			/* The base is a subdirectory of a path which was specified. */
-			return 1;
+			/*
+			 * The base is a subdirectory of a path which
+			 * was specified, so all of them are interesting.
+			 */
+			return 2;
 		}
 
 		/* Does the base match? */
@@ -173,8 +177,18 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 /* A whole sub-tree went away or appeared */
 static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base, int baselen)
 {
+	int all_interesting = 0;
 	while (desc->size) {
-		int show = tree_entry_interesting(desc, base, baselen, opt);
+		int show;
+
+		if (all_interesting)
+			show = 1;
+		else {
+			show = tree_entry_interesting(desc, base, baselen,
+						      opt);
+			if (show == 2)
+				all_interesting = 1;
+		}
 		if (show < 0)
 			break;
 		if (show)
@@ -215,8 +229,17 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 
 static void skip_uninteresting(struct tree_desc *t, const char *base, int baselen, struct diff_options *opt)
 {
+	int all_interesting = 0;
 	while (t->size) {
-		int show = tree_entry_interesting(t, base, baselen, opt);
+		int show;
+
+		if (all_interesting)
+			show = 1;
+		else {
+			show = tree_entry_interesting(t, base, baselen, opt);
+			if (show == 2)
+				all_interesting = 1;
+		}
 		if (!show) {
 			update_tree_entry(t);
 			continue;
