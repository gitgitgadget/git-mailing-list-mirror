From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] log: use true parents for diff when walking reflogs
Date: Sat, 3 Aug 2013 12:36:15 +0200
Message-ID: <d6dadc4ab54d81490ca46bcfbd44a61be24f6eb7.1375524982.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 03 12:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ZCE-0005TI-JW
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 12:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab3HCKgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 06:36:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:56693 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab3HCKgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 06:36:20 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 12:36:06 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 12:36:16 +0200
X-Mailer: git-send-email 1.8.4.rc1.414.g34bc5b2
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231576>

The reflog walking logic (git log -g) replaces the true parent list
with the preceding commit in the reflog.  This results in bogus commit
diffs when combined with options such as -p; the diff is against the
reflog predecessor, not the parent of the commit.

Save the true parents on the side, extending the functions from the
previous commit.  The diff logic picks them up and uses them to show
the correct diffs.

We do have to be somewhat careful about repeated calling of
save_parents(), since the reflog may list a commit more than once.  We
now store (commit_list*)-1 to distinguish the "not saved yet" and
"root commit" cases.  This lets us preserve an empty parent list even
if save_parents() is repeatedly called.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Jeff King <peff@peff.net> wrote:
> 
> Your description (and solution) make a lot of sense to me. Another code
> path that has a similar problem is the "-g" reflog walker. It rewrites
> the parents based on the reflog, and the diffs it produces are mostly
> useless (e.g., try "git stash list -p").
> 
> Should we be applying the same technique there?

Good point.  This is how.  It applies on top of the other patch.

It doesn't really help for 'git stash list -p', though, because
stashes are merge commits.  Now they just don't show anything.  You
could try 'git stash list -p -m', though.


 revision.c             | 28 +++++++++++++++++++++++++---
 t/t1411-reflog-show.sh | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index e3ca936..ac20d1a 100644
--- a/revision.c
+++ b/revision.c
@@ -2848,6 +2848,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		free(entry);
 
 		if (revs->reflog_info) {
+			save_parents(revs, commit);
 			fake_reflog_parent(revs->reflog_info, commit);
 			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 		}
@@ -3083,6 +3084,8 @@ void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 
 define_commit_slab(saved_parents, struct commit_list *);
 
+#define EMPTY_PARENT_LIST ((struct commit_list *)-1)
+
 void save_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp;
@@ -3093,16 +3096,35 @@ void save_parents(struct rev_info *revs, struct commit *commit)
 	}
 
 	pp = saved_parents_at(revs->saved_parents_slab, commit);
-	assert(*pp == NULL);
-	*pp = copy_commit_list(commit->parents);
+
+	/*
+	 * When walking with reflogs, we may visit the same commit
+	 * several times: once for each appearance in the reflog.
+	 *
+	 * In this case, save_parents() will be called multiple times.
+	 * We want to keep only the first set of parents.  We need to
+	 * store a sentinel value for an empty (i.e., NULL) parent
+	 * list to distinguish it from a not-yet-saved list, however.
+	 */
+	if (*pp)
+		return;
+	if (commit->parents)
+		*pp = copy_commit_list(commit->parents);
+	else
+		*pp = EMPTY_PARENT_LIST;
 }
 
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit)
 {
+	struct commit_list *parents;
+
 	if (!revs->saved_parents_slab)
 		return commit->parents;
 
-	return *saved_parents_at(revs->saved_parents_slab, commit);
+	parents = *saved_parents_at(revs->saved_parents_slab, commit);
+	if (parents == EMPTY_PARENT_LIST)
+		return NULL;
+	return parents;
 }
 
 void free_saved_parents(struct rev_info *revs)
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 9a105fe..6f47c0d 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -144,4 +144,26 @@ test_expect_success 'empty reflog file' '
 	test_cmp expect actual
 '
 
+# This guards against the alternative of showing the diffs vs. the
+# reflog ancestor.  The reflog used is designed to list the commits
+# more than once, so as to exercise the corresponding logic.
+test_expect_success 'git log -g -p shows diffs vs. parents' '
+	test_commit two &&
+	git branch flipflop &&
+	git update-ref refs/heads/flipflop -m flip1 HEAD^ &&
+	git update-ref refs/heads/flipflop -m flop1 HEAD &&
+	git update-ref refs/heads/flipflop -m flip2 HEAD^ &&
+	git log -g -p flipflop >reflog &&
+	grep -v ^Reflog reflog >actual &&
+	git log -1 -p HEAD^ >log.one &&
+	git log -1 -p HEAD >log.two &&
+	(
+		cat log.one; echo
+		cat log.two; echo
+		cat log.one; echo
+		cat log.two
+	) >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.4.rc1.414.g34bc5b2
