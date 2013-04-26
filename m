From: Kevin Bracey <kevin@bracey.fi>
Subject: [RFC/PATCH 2/3] simplify-merges: never remove all TREESAME parents
Date: Fri, 26 Apr 2013 22:31:57 +0300
Message-ID: <1367004718-30048-2-git-send-email-kevin@bracey.fi>
References: <517AD304.6020807@bracey.fi>
 <1367004718-30048-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 21:42:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoXV-0004ef-At
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395Ab3DZTmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:42:32 -0400
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:56035 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753986Ab3DZTmc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:42:32 -0400
Received: from mail422.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 88156FF8FEB
	for <git@vger.kernel.org>; Fri, 26 Apr 2013 21:32:11 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 26 Apr 2013 21:32:22 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 26 Apr 2013 21:32:21 +0200
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
In-Reply-To: <1367004718-30048-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 15439746899430445279
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222565>

In the event of an odd merge, we may find ourselves TREESAME to
apparently redundant parents. Prevent simplify_merges() from removing
every TREESAME parent - in the event of such a merge it's useful to see
where we came actually from came.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/rev-list-options.txt |  3 ++-
 revision.c                         | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 380db48..0832004 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -472,7 +472,8 @@ history according to the following rules:
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
index 176eb7b..4e27c9a 100644
--- a/revision.c
+++ b/revision.c
@@ -2106,8 +2106,32 @@ static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct treesame_state *ts = lookup_decoration(&revs->treesame, &commit->object);
 	struct commit_list **pp, *p;
+	struct commit *su = NULL, *sm = NULL;
 	int n, removed = 0;
 
+	/* Prescan - look for both marked and unmarked TREESAME parents */
+	for (p = commit->parents, n = 0; p; p = p->next, n++) {
+		if (ts->treesame[n]) {
+			if (p->item->object.flags & TMP_MARK) {
+				if (!sm) sm = p->item;
+			}
+			else {
+				if (!su) {
+					su = p->item;
+					break;
+				}
+			}
+		}
+	}
+
+	/* If we are TREESAME to a marked-for-deletion parent, but not to any
+	 * unmarked parents, unmark the first TREESAME parent. We don't want
+	 * to remove our "real" parent in the event of an "-s ours" type
+	 * merge.
+	 */
+	if (!su && sm)
+		sm->object.flags &= ~TMP_MARK;
+
 	pp = &commit->parents;
 	n = 0;
 	while ((p = *pp) != NULL) {
-- 
1.8.2.1.632.gd2b1879
