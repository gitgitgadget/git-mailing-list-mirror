From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 14/15] revision.c: don't show all merges for --parents
Date: Thu, 16 May 2013 18:32:40 +0300
Message-ID: <1368718361-27859-15-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0BQ-0003uH-RU
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab3EPPdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:33:21 -0400
Received: from mo4.mail-out.ovh.net ([178.32.228.4]:54708 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab3EPPdR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:33:17 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id B28EA1054100
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:16 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:16 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:12 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18174276297741406444
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224576>

When using --parents or --children, get_commit_action() previously showed
all merges, even if TREESAME to both parents.

This was intended to tie together the topology of the rewritten parents,
but it was excessive - in fact we only need to show merges that have two
or more relevant parents. Merges at the boundary do not necessarily need
to be shown.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 revision.c                   | 22 +++++++++++++++-------
 t/t6111-rev-list-treesame.sh |  4 ++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 1c75070..edb7e1c 100644
--- a/revision.c
+++ b/revision.c
@@ -2760,10 +2760,7 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	if (revs->min_age != -1 && (commit->date > revs->min_age))
 		return commit_ignore;
 	if (revs->min_parents || (revs->max_parents >= 0)) {
-		int n = 0;
-		struct commit_list *p;
-		for (p = commit->parents; p; p = p->next)
-			n++;
+		int n = commit_list_count(commit->parents);
 		if ((n < revs->min_parents) ||
 		    ((revs->max_parents >= 0) && (n > revs->max_parents)))
 			return commit_ignore;
@@ -2773,12 +2770,23 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	if (revs->prune && revs->dense) {
 		/* Commit without changes? */
 		if (commit->object.flags & TREESAME) {
+			int n;
+			struct commit_list *p;
 			/* drop merges unless we want parenthood */
 			if (!want_ancestry(revs))
 				return commit_ignore;
-			/* non-merge - always ignore it */
-			if (!commit->parents || !commit->parents->next)
-				return commit_ignore;
+			/*
+			 * If we want ancestry, then need to keep any merges
+			 * between relevant commits to tie together topology.
+			 * For consistency with TREESAME and simplification
+			 * use "relevant" here rather than just INTERESTING,
+			 * to treat bottom commit(s) as part of the topology.
+			 */
+			for (n = 0, p = commit->parents; p; p = p->next)
+				if (relevant_commit(p->item))
+					if (++n >= 2)
+						return commit_show;
+			return commit_ignore;
 		}
 	}
 	return commit_show;
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index e32b373..25cc8ad 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -139,7 +139,7 @@ check_result 'M L G' F..M --first-parent -- file
 # If we want history since E, then we're quite happy to ignore G that took E.
 check_result 'M L K J I H G' E..M --ancestry-path
 check_result 'M L J I H' E..M --ancestry-path -- file
-check_outcome failure '(LH)M (K)L (EJ)K (I)J (E)I (E)H' E..M --ancestry-path --parents -- file # includes G
+check_result '(LH)M (K)L (EJ)K (I)J (E)I (E)H' E..M --ancestry-path --parents -- file
 check_result '(LH)M (E)H (J)L (I)J (E)I' E..M --ancestry-path --simplify-merges -- file
 
 # Should still be able to ignore I-J branch in simple log, despite limiting
@@ -168,7 +168,7 @@ check_result '(D)F (BA)D' B..F --full-history --parents -- file
 check_result '(B)F' B..F --simplify-merges -- file
 check_result 'F D' B..F --ancestry-path
 check_result 'F' B..F --ancestry-path -- file
-check_outcome failure 'F' B..F --ancestry-path --parents -- file # includes D
+check_result 'F' B..F --ancestry-path --parents -- file
 check_result 'F' B..F --ancestry-path --simplify-merges -- file
 check_result 'F D' B..F --first-parent
 check_result 'F' B..F --first-parent -- file
-- 
1.8.3.rc0.28.g4b02ef5
