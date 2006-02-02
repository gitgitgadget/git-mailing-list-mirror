From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] combine-diff: add safety check to --cc.
Date: Thu, 02 Feb 2006 01:34:34 -0800
Message-ID: <7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Len Brown <len.brown@intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 10:35:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4arc-0001YX-36
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 10:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423415AbWBBJei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 04:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423419AbWBBJei
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 04:34:38 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6287 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1423415AbWBBJeg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 04:34:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202093441.CRSL25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 04:34:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 02 Feb 2006 00:18:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15500>

The earlier change implemented "only two version" check but
without checking if the change rewrites from all the parents.
This implements a check to make sure that a change introduced
by the merge from all the parents is caught to be interesting.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Junio C Hamano <junkio@cox.net> writes:

 >  Linus Torvalds <torvalds@osdl.org> writes:
 >
 >  > On Wed, 1 Feb 2006, Linus Torvalds wrote:
 >  >
 >  > Actually, I take that back.
 >
 >  I do not do that "result to match the final" check in this
 >  version yet.  I'll need to revisit it before placing this in
 >  the master, but I am going to bed.

 Well, I didn't ;-).

 combine-diff.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

43fef6678c8e925307197fb705e499a023bba838
diff --git a/combine-diff.c b/combine-diff.c
index 45f1822..69e19ed 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -397,7 +397,23 @@ static int make_hunks(struct sline *slin
 		hunk_end = j;
 
 		/* [i..hunk_end) are interesting.  Now is it really
-		 * interesting?
+		 * interesting?  We check if there are only two versions
+		 * and the result matches one of them.  That is, we look
+		 * at:
+		 *   (+) line, which records lines added to which parents;
+		 *       this line appears in the result.
+		 *   (-) line, which records from what parents the line
+		 *       was removed; this line does not appear in the result.
+		 * then check the set of parents the result has difference
+		 * from, from all lines.  If there are lines that has
+		 * different set of parents that the result has differences
+		 * from, that means we have more than two versions.
+		 *
+		 * Even when we have only two versions, if the result does
+		 * not match any of the parents, the it should be considered
+		 * interesting.  In such a case, we would have all '+' line.
+		 * After passing the above "two versions" test, that would
+		 * appear as "the same set of parents" to be "all parents".
 		 */
 		same_diff = 0;
 		has_interesting = 0;
@@ -429,7 +445,7 @@ static int make_hunks(struct sline *slin
 			}
 		}
 
-		if (!has_interesting) {
+		if (!has_interesting && same_diff != all_mask) {
 			/* This hunk is not that interesting after all */
 			for (j = hunk_begin; j < hunk_end; j++)
 				sline[j].flag &= ~mark;
-- 
1.1.6.g2672
