From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Add "--show-all" revision walker flag for debugging
Date: Sat, 9 Feb 2008 14:02:07 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 23:03:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNxn7-0004Xp-Ol
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 23:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945AbYBIWCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 17:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756719AbYBIWCf
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 17:02:35 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58622 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755846AbYBIWCd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 17:02:33 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m19M28GN013361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Feb 2008 14:02:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m19M27YD032685;
	Sat, 9 Feb 2008 14:02:07 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-0.838 required=5 tests=AWL,BAYES_00,LONGWORDS,TW_NV,TW_VX,TW_WC
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73270>


So the kernel merge window for 2.6.25 is closing today (or possibly 
tomorrow if I feel like it), and I've already mentally closed it, so I'm 
starting to free up some resources to look at the interesting problem with 
screwed-up commit dates confusing our commit walker into thinking that 
some uninteresting commit isn't actually uninteresting due to not 
traversing the uninteresting chain deep enough.

But one of the things I noticed is that it's really not very easy to 
visualize the commit walker, because - on purpose - it obvously doesn't 
show the uninteresting commits!

So here's a patch that adds a "--show-all" flag to the revision walker, 
which will make it show uninteresting commits too, and they'll have a '*' 
in front of them (it also fixes a logic error for !verbose_header for 
boundary commits - we should show the '-' even if left_right isn't shown).

It also updates 'gitk' to show those negative commits in gray. Whether 
that's the right color choice or not, I'll leave to bikeshedders, but it 
looks fairly neutral, and shows the differences pretty well.

It actually is interesting even for the cases that git doesn't have any 
problems with, ie for the kernel you can do

	gitk -d --show-all v2.6.24..

and you see just how far down it has to parse things to see it all. The 
use of "-d" is a good idea, since the date-ordered toposort is much better 
at showing why it goes deep down (ie the date of some of those commits 
after 2.6.24 is much older, because they were merged from trees that 
weren't rebased).

So I think this is a useful feature even for non-debugging - just to 
visualize what git does internally more.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Heh. Amusingly, the changes to gitk were much bigger than the trivial 
changes to core git routines themselves. The log-tree.c diffstat is a bit 
bigger just because of the logic fix (making it more than just another 
added "else if ()" statement), while much of the revision.c patch is just 
the argument parsing ;)

 builtin-rev-list.c |    2 ++
 gitk-git/gitk      |   15 ++++++++-------
 log-tree.c         |   12 ++++++++----
 revision.c         |    9 ++++++++-
 revision.h         |    1 +
 5 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index de80158..5966199 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -60,6 +60,8 @@ static void show_commit(struct commit *commit)
 		fputs(header_prefix, stdout);
 	if (commit->object.flags & BOUNDARY)
 		putchar('-');
+	else if (commit->object.flags & UNINTERESTING)
+		putchar('^');
 	else if (revs.left_right) {
 		if (commit->object.flags & SYMMETRIC_LEFT)
 			putchar('<');
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5560e4d..90d9b61 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -240,11 +240,12 @@ proc getcommitlines {fd view}  {
 	set listed 1
 	if {$j >= 0 && [string match "commit *" $cmit]} {
 	    set ids [string range $cmit 7 [expr {$j - 1}]]
-	    if {[string match {[-<>]*} $ids]} {
+	    if {[string match {[-^<>]*} $ids]} {
 		switch -- [string index $ids 0] {
 		    "-" {set listed 0}
-		    "<" {set listed 2}
-		    ">" {set listed 3}
+		    "^" {set listed 2}
+		    "<" {set listed 3}
+		    ">" {set listed 4}
 		}
 		set ids [string range $ids 1 end]
 	    }
@@ -3627,23 +3628,23 @@ proc drawcmittext {id row col} {
     global linehtag linentag linedtag selectedline
     global canvxmax boldrows boldnamerows fgcolor nullid nullid2
 
-    # listed is 0 for boundary, 1 for normal, 2 for left, 3 for right
+    # listed is 0 for boundary, 1 for normal, 2 for negative, 3 for left, 4 for right
     set listed [lindex $commitlisted $row]
     if {$id eq $nullid} {
 	set ofill red
     } elseif {$id eq $nullid2} {
 	set ofill green
     } else {
-	set ofill [expr {$listed != 0? "blue": "white"}]
+	set ofill [expr {$listed != 0 ? $listed == 2 ? "gray" : "blue" : "white"}]
     }
     set x [xc $row $col]
     set y [yc $row]
     set orad [expr {$linespc / 3}]
-    if {$listed <= 1} {
+    if {$listed <= 2} {
 	set t [$canv create oval [expr {$x - $orad}] [expr {$y - $orad}] \
 		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
 		   -fill $ofill -outline $fgcolor -width 1 -tags circle]
-    } elseif {$listed == 2} {
+    } elseif {$listed == 3} {
 	# triangle pointing left for left-side commits
 	set t [$canv create polygon \
 		   [expr {$x - $orad}] $y \
diff --git a/log-tree.c b/log-tree.c
index 1f3fcf1..dd110ca 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -149,10 +149,12 @@ void show_log(struct rev_info *opt, const char *sep)
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
-		if (opt->left_right) {
-			if (commit->object.flags & BOUNDARY)
-				putchar('-');
-			else if (commit->object.flags & SYMMETRIC_LEFT)
+		if (commit->object.flags & BOUNDARY)
+			putchar('-');
+		else if (commit->object.flags & UNINTERESTING)
+			putchar('^');
+		else if (opt->left_right) {
+			if (commit->object.flags & SYMMETRIC_LEFT)
 				putchar('<');
 			else
 				putchar('>');
@@ -250,6 +252,8 @@ void show_log(struct rev_info *opt, const char *sep)
 			fputs("commit ", stdout);
 		if (commit->object.flags & BOUNDARY)
 			putchar('-');
+		else if (commit->object.flags & UNINTERESTING)
+			putchar('^');
 		else if (opt->left_right) {
 			if (commit->object.flags & SYMMETRIC_LEFT)
 				putchar('<');
diff --git a/revision.c b/revision.c
index 6e85aaa..158727c 100644
--- a/revision.c
+++ b/revision.c
@@ -581,7 +581,8 @@ static int limit_list(struct rev_info *revs)
 			mark_parents_uninteresting(commit);
 			if (everybody_uninteresting(list))
 				break;
-			continue;
+			if (!revs->show_all)
+				continue;
 		}
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			continue;
@@ -1055,6 +1056,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->dense = 0;
 				continue;
 			}
+			if (!strcmp(arg, "--show-all")) {
+				revs->show_all = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--remove-empty")) {
 				revs->remove_empty_trees = 1;
 				continue;
@@ -1438,6 +1443,8 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 		return commit_ignore;
 	if (revs->unpacked && has_sha1_pack(commit->object.sha1, revs->ignore_packed))
 		return commit_ignore;
+	if (revs->show_all)
+		return commit_show;
 	if (commit->object.flags & UNINTERESTING)
 		return commit_ignore;
 	if (revs->min_age != -1 && (commit->date > revs->min_age))
diff --git a/revision.h b/revision.h
index 8572315..b5f01f8 100644
--- a/revision.h
+++ b/revision.h
@@ -33,6 +33,7 @@ struct rev_info {
 			prune:1,
 			no_merges:1,
 			no_walk:1,
+			show_all:1,
 			remove_empty_trees:1,
 			simplify_history:1,
 			lifo:1,
