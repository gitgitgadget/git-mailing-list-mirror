From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 6/8] simplify-merges: never remove all TREESAME parents
Date: Tue, 30 Apr 2013 20:26:26 +0300
Message-ID: <1367342788-7795-7-git-send-email-kevin@bracey.fi>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 19:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXERu-0004m7-Dl
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761021Ab3D3Reg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:34:36 -0400
Received: from mo5.mail-out.ovh.net ([178.32.228.5]:47467 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760984Ab3D3Ree (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:34:34 -0400
Received: from mail414.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 04F6CFFA6B3
	for <git@vger.kernel.org>; Tue, 30 Apr 2013 19:27:08 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Apr 2013 19:27:07 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 30 Apr 2013 19:27:07 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
In-Reply-To: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18368494031224344804
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222959>

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
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1dad341..e23bdb0 100644
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
index c88ded8..7535757 100644
--- a/revision.c
+++ b/revision.c
@@ -2119,6 +2119,73 @@ static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
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
+	 *   I---------X       A modified the file, but mainline merge X used
+	 *    \       /        "-s ours", so took the version from I. X is
+	 *     `--A--'         TREESAME to I and !TREESAME to A.
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
+	 *     A--B           parents.
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
@@ -2222,6 +2289,8 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	if (1 < cnt) {
 		int marked = mark_redundant_parents(revs, commit);
 		if (marked)
+			marked -= leave_one_treesame_to_parent(revs, commit);
+		if (marked)
 			cnt = remove_marked_parents(revs, commit);
 	}
 
-- 
1.8.2.1.632.gd2b1879
