From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] list-objects: only look at cmdline trees with edge_hint
Date: Mon, 20 Jan 2014 16:32:50 -0500
Message-ID: <20140120213250.GB16095@sigill.intra.peff.net>
References: <20140120212845.GA11451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 22:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5MSm-0005VF-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 22:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbaATVcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 16:32:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:35851 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751380AbaATVcw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 16:32:52 -0500
Received: (qmail 14458 invoked by uid 102); 20 Jan 2014 21:32:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 15:32:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 16:32:50 -0500
Content-Disposition: inline
In-Reply-To: <20140120212845.GA11451@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240728>

When rev-list is given a command-line like:

  git rev-list --objects $commit --not --all

the most accurate answer is the difference between the set
of objects reachable from $commit and the set reachable from
all of the existing refs. However, we have not historically
provided that answer, because it is very expensive to
calculate. We would have to open every tree of every commit
in the entire history.

Instead, we find the accurate set difference of the
reachable commits, and then mark the trees at the boundaries
as uninteresting. This misses objects which appear in the
trees of both the interesting commits and deep within the
uninteresting history.

Commit fbd4a70 (list-objects: mark more commits as edges in
mark_edges_uninteresting, 2013-08-16) noticed that we miss
those objects during pack-objects, and added code to examine
the trees of all of the "--not" refs given on the
command-line.  Note that this is still not the complete set
difference, because we look only at the tips of the
command-line arguments, not all of their reachable commits.
But it increases the set of boundary objects we consider,
which is especially important for shallow fetches.  So we
are trading extra CPU time for a larger set of boundary
objects, which can improve the resulting pack size for a
--thin pack.

This tradeoff probably makes sense in the context of
pack-objects, where we have set revs->edge_hint to have the
traversal feed us the set of boundary objects.  For a
regular rev-list, though, it is probably not a good
tradeoff. It is true that it makes our list slightly closer
to a true set difference, but it is a rare case where this
is important. And because we do not have revs->edge_hint
set, we do nothing useful with the larger set of boundary
objects.

This patch therefore ties the extra tree examination to the
revs->edge_hint flag; it is the presence of that flag that
makes the tradeoff worthwhile.

Here is output from the p0001-rev-list showing the
improvement in performance:

Test                                             HEAD^             HEAD
-----------------------------------------------------------------------------------------
0001.1: rev-list --all                           0.69(0.65+0.02)   0.69(0.66+0.02) +0.0%
0001.2: rev-list --all --objects                 3.22(3.19+0.03)   3.23(3.20+0.03) +0.3%
0001.4: rev-list $commit --not --all             0.04(0.04+0.00)   0.04(0.04+0.00) +0.0%
0001.5: rev-list --objects $commit --not --all   0.27(0.26+0.01)   0.04(0.04+0.00) -85.2%

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 6cbedf0..43ce1d9 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -162,15 +162,17 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 		}
 		mark_edge_parents_uninteresting(commit, revs, show_edge);
 	}
-	for (i = 0; i < revs->cmdline.nr; i++) {
-		struct object *obj = revs->cmdline.rev[i].item;
-		struct commit *commit = (struct commit *)obj;
-		if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
-			continue;
-		mark_tree_uninteresting(commit->tree);
-		if (revs->edge_hint && !(obj->flags & SHOWN)) {
-			obj->flags |= SHOWN;
-			show_edge(commit);
+	if (revs->edge_hint) {
+		for (i = 0; i < revs->cmdline.nr; i++) {
+			struct object *obj = revs->cmdline.rev[i].item;
+			struct commit *commit = (struct commit *)obj;
+			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
+				continue;
+			mark_tree_uninteresting(commit->tree);
+			if (revs->edge_hint && !(obj->flags & SHOWN)) {
+				obj->flags |= SHOWN;
+				show_edge(commit);
+			}
 		}
 	}
 }
-- 
1.8.5.2.500.g8060133
