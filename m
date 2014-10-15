From: Jeff King <peff@peff.net>
Subject: [PATCH v2 05/25] clean up name allocation in prepare_revision_walk
Date: Wed, 15 Oct 2014 18:35:12 -0400
Message-ID: <20141015223512.GE25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:35:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXA8-0004Gk-OX
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbaJOWfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:35:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:58933 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751188AbaJOWfO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:35:14 -0400
Received: (qmail 2134 invoked by uid 102); 15 Oct 2014 22:35:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:35:14 -0500
Received: (qmail 27919 invoked by uid 107); 15 Oct 2014 22:35:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:35:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:35:12 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we enter prepare_revision_walk, we have zero or more
entries in our "pending" array. We disconnect that array
from the rev_info, and then process each entry:

  1. If the entry is a commit and the --source option is in
     effect, we keep a pointer to the object name.

  2. Otherwise, we re-add the item to the pending list with
     a blank name.

We then throw away the old array by freeing the array
itself, but do not touch the "name" field of each entry. For
any items of type (2), we leak the memory associated with
the name. This commit fixes that by calling object_array_clear,
which handles the cleanup for us.

That breaks (1), though, because it depends on the memory
pointed to by the name to last forever. We can solve that by
making a copy of the name. This is slightly less efficient,
but it shouldn't matter in practice, as we do it only for
the tip commits of the traversal.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index e498b7c..01cc276 100644
--- a/revision.c
+++ b/revision.c
@@ -300,7 +300,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			revs->limited = 1;
 		}
 		if (revs->show_source && !commit->util)
-			commit->util = (void *) name;
+			commit->util = xstrdup(name);
 		return commit;
 	}
 
@@ -2656,15 +2656,16 @@ void reset_revision_walk(void)
 
 int prepare_revision_walk(struct rev_info *revs)
 {
-	int nr = revs->pending.nr;
-	struct object_array_entry *e, *list;
+	int i;
+	struct object_array old_pending;
 	struct commit_list **next = &revs->commits;
 
-	e = list = revs->pending.objects;
+	memcpy(&old_pending, &revs->pending, sizeof(old_pending));
 	revs->pending.nr = 0;
 	revs->pending.alloc = 0;
 	revs->pending.objects = NULL;
-	while (--nr >= 0) {
+	for (i = 0; i < old_pending.nr; i++) {
+		struct object_array_entry *e = old_pending.objects + i;
 		struct commit *commit = handle_commit(revs, e->item, e->name);
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
@@ -2672,10 +2673,9 @@ int prepare_revision_walk(struct rev_info *revs)
 				next = commit_list_append(commit, next);
 			}
 		}
-		e++;
 	}
 	if (!revs->leak_pending)
-		free(list);
+		object_array_clear(&old_pending);
 
 	/* Signal whether we need per-parent treesame decoration */
 	if (revs->simplify_merges ||
-- 
2.1.2.596.g7379948
