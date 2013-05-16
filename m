From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 10/15] simplify-merges: never remove all TREESAME parents
Date: Thu, 16 May 2013 18:32:36 +0300
Message-ID: <1368718361-27859-11-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:39:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0HV-0000lm-VA
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab3EPPjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:39:44 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:45958 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752612Ab3EPPjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:39:39 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 94BA710540F0
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:13 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:13 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:09 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18173150397834563816
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224581>

When simplifying an odd merge, such as one that used "-s ours", we may
find ourselves TREESAME to apparently redundant parents. Prevent
simplify_merges() from removing every TREESAME parent; if this would
happen reinstate the first TREESAME parent - the one that the default
log would have followed.

This avoids producing a totally disjoint history from the default log
when the default log is a better explanation of the end result, and aids
visualisation of odd merges.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/rev-list-options.txt |  3 +-
 revision.c                         | 69 ++++++++++++++++++++++++++++++++++++++
 t/t6111-rev-list-treesame.sh       |  4 +--
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index d166384..f41e865 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -471,7 +471,8 @@ history according to the following rules:
 +
 * Replace each parent `P` of `C'` with its simplification `P'`.  In
   the process, drop parents that are ancestors of other parents, and
-  remove duplicates.
+  remove duplicates, but take care to never drop all parents that
+  we are TREESAME to.
 +
 * If after this parent rewriting, `C'` is a root or merge commit (has
   zero or >1 parents), a boundary commit, or !TREESAME, it remains.
diff --git a/revision.c b/revision.c
index 64b86ae..62f399c 100644
--- a/revision.c
+++ b/revision.c
@@ -2136,6 +2136,73 @@ static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
 	return marked;
 }
 
+/*
+ * Awkward naming - this means one parent we are TREESAME to.
+ * cf mark_treesame_root_parents: root parents that are TREESAME (to an
+ * empty tree). Better name suggestions?
+ */
+static int leave_one_treesame_to_parent(struct rev_info *revs, struct commit *commit)
+{
+	struct treesame_state *ts = lookup_decoration(&revs->treesame, &commit->object);
+	struct commit *unmarked = NULL, *marked = NULL;
+	struct commit_list *p;
+	unsigned n;
+
+	for (p = commit->parents, n = 0; p; p = p->next, n++) {
+		if (ts->treesame[n]) {
+			if (p->item->object.flags & TMP_MARK) {
+				if (!marked)
+					marked = p->item;
+			} else {
+				if (!unmarked) {
+					unmarked = p->item;
+					break;
+				}
+			}
+		}
+	}
+
+	/*
+	 * If we are TREESAME to a marked-for-deletion parent, but not to any
+	 * unmarked parents, unmark the first TREESAME parent. This is the
+	 * parent that the default simplify_history==1 scan would have followed,
+	 * and it doesn't make sense to omit that path when asking for a
+	 * simplified full history. Retaining it improves the chances of
+	 * understanding odd missed merges that took an old version of a file.
+	 *
+	 * Example:
+	 *
+	 *   I--------*X       A modified the file, but mainline merge X used
+	 *    \       /        "-s ours", so took the version from I. X is
+	 *     `-*A--'         TREESAME to I and !TREESAME to A.
+	 *
+	 * Default log from X would produce "I". Without this check,
+	 * --full-history --simplify-merges would produce "I-A-X", showing
+	 * the merge commit X and that it changed A, but not making clear that
+	 * it had just taken the I version. With this check, the topology above
+	 * is retained.
+	 *
+	 * Note that it is possible that the simplification chooses a different
+	 * TREESAME parent from the default, in which case this test doesn't
+	 * activate, and we _do_ drop the default parent. Example:
+	 *
+	 *   I------X         A modified the file, but it was reverted in B,
+	 *    \    /          meaning mainline merge X is TREESAME to both
+	 *    *A-*B           parents.
+	 *
+	 * Default log would produce "I" by following the first parent;
+	 * --full-history --simplify-merges will produce "I-A-B". But this is a
+	 * reasonable result - it presents a logical full history leading from
+	 * I to X, and X is not an important merge.
+	 */
+	if (!unmarked && marked) {
+		marked->object.flags &= ~TMP_MARK;
+		return 1;
+	}
+
+	return 0;
+}
+
 static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *p;
@@ -2239,6 +2306,8 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	if (1 < cnt) {
 		int marked = mark_redundant_parents(revs, commit);
 		if (marked)
+			marked -= leave_one_treesame_to_parent(revs, commit);
+		if (marked)
 			cnt = remove_marked_parents(revs, commit);
 	}
 
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 0047b54..484b69b 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -116,7 +116,7 @@ check_result 'M L H B A' -- file
 check_result '(LH)M (B)L (B)H (A)B A' --parents -- file
 check_result 'M L J I H G F D B A' --full-history -- file
 check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FB)G (D)F (BA)D (A)B A' --full-history --parents -- file
-check_outcome failure '(LH)M (G)H (J)L (I)J (G)I (FB)G (B)F (A)B A' --simplify-merges -- file # drops parent B from G
+check_result '(LH)M (G)H (J)L (I)J (G)I (FB)G (B)F (A)B A' --simplify-merges -- file
 check_result 'M L K G F D B A' --first-parent
 check_result 'M L G F B A' --first-parent -- file
 
@@ -127,7 +127,7 @@ check_result 'M L H' F..M -- file
 check_result '(LH)M (B)L (B)H' --parents F..M -- file
 check_result 'M L J I H G' F..M --full-history -- file
 check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FB)G' F..M --full-history --parents -- file
-check_outcome failure '(LH)M (G)H (J)L (I)J (G)I (FB)G' F..M --simplify-merges -- file # drops parent B from G
+check_result '(LH)M (G)H (J)L (I)J (G)I (FB)G' F..M --simplify-merges -- file
 check_result 'M L K J I H G' F..M --ancestry-path
 check_result 'M L J I H G' F..M --ancestry-path -- file
 check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FE)G' F..M --ancestry-path --parents -- file
-- 
1.8.3.rc0.28.g4b02ef5
