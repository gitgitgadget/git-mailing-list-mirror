From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 15/15] revision.c: make default history consider bottom commits
Date: Thu, 16 May 2013 18:32:41 +0300
Message-ID: <1368718361-27859-16-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:40:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0Hn-00012I-A8
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033Ab3EPPjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:39:39 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:41913 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751322Ab3EPPji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:39:38 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id E9FF210540EB
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:16 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:16 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:13 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18174276297741406445
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.512862/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224585>

Previously, the default history treated bottom commits the same as any
other UNINTERESTING commit, which could force it down side branches.

Consider the following history:

   *A--*B---D--*F         * marks !TREESAME parent paths
     \     /*
      `-C-'

When requesting "B..F", B is UNINTERESTING but TREESAME to D. C is
!UNINTERESTING.

So default following would go from D into the irrelevant side branch C
to A, rather than to B.  Note also that if there had been an extra
!UNINTERESTING commit B1 between B and D, it wouldn't have gone down C.

Change the default following to test relevant_commit() instead of
!UNINTERESTING, so it can proceed straight from D to B, thus finishing
the traversal of that path.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 revision.c                   |  2 +-
 t/t6111-rev-list-treesame.sh | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index edb7e1c..914ac78 100644
--- a/revision.c
+++ b/revision.c
@@ -684,7 +684,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			    sha1_to_hex(p->object.sha1));
 		switch (rev_compare_tree(revs, p, commit)) {
 		case REV_TREE_SAME:
-			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
+			if (!revs->simplify_history || !relevant_commit(p)) {
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
 				 * we are interested in, we do not want
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 25cc8ad..88b84df 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -146,8 +146,8 @@ check_result '(LH)M (E)H (J)L (I)J (E)I' E..M --ancestry-path --simplify-merges
 # to G.
 check_result 'M L K J I H' G..M
 check_result 'M H L K J I' G..M --topo-order
-check_outcome failure 'M L H' G..M -- file # includes J I
-check_outcome failure '(LH)M (G)L (G)H' G..M --parents -- file # includes J I
+check_result 'M L H' G..M -- file
+check_result '(LH)M (G)L (G)H' G..M --parents -- file
 check_result 'M L J I H' G..M --full-history -- file
 check_result 'M L K J I H' G..M --full-history --parents -- file
 check_result 'M H L J I' G..M --simplify-merges -- file
@@ -161,8 +161,8 @@ check_result 'M H L J I' G..M --ancestry-path --simplify-merges -- file
 # But --full-history shouldn't drop D on its own - without simplification,
 # we can't decide if the merge from INTERESTING commit C was sensible.
 check_result 'F D C' B..F
-check_outcome failure 'F' B..F -- file # includes D
-check_outcome failure '(B)F' B..F --parents -- file # includes D
+check_result 'F' B..F -- file
+check_result '(B)F' B..F --parents -- file
 check_result 'F D' B..F --full-history -- file
 check_result '(D)F (BA)D' B..F --full-history --parents -- file
 check_result '(B)F' B..F --simplify-merges -- file
@@ -174,8 +174,8 @@ check_result 'F D' B..F --first-parent
 check_result 'F' B..F --first-parent -- file
 
 # E...F should be equivalent to E F ^B, and be able to drop D as above.
-check_outcome failure 'F' E F ^B -- file # includes D
-check_outcome failure 'F' E...F -- file # includes D
+check_result 'F' E F ^B -- file # includes D
+check_result 'F' E...F -- file # includes D
 
 # Any sort of full history of C..F should show D, as it's the connection to C,
 # and it differs from it.
-- 
1.8.3.rc0.28.g4b02ef5
