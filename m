From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] assume parse_commit checks commit->object.parsed
Date: Thu, 24 Oct 2013 04:53:01 -0400
Message-ID: <20131024085301.GB1346@sigill.intra.peff.net>
References: <20131024085213.GA1267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 10:53:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZGfF-0005A7-Uz
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 10:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab3JXIxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 04:53:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:54652 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753888Ab3JXIxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 04:53:04 -0400
Received: (qmail 7465 invoked by uid 102); 24 Oct 2013 08:53:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 03:53:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 04:53:01 -0400
Content-Disposition: inline
In-Reply-To: <20131024085213.GA1267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236577>

The parse_commit function will check the "parsed" flag of
the object and do nothing if it is set. There is no need
for callers to check the flag themselves, and doing so only
clutters the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c       | 3 +--
 builtin/name-rev.c    | 3 +--
 builtin/show-branch.c | 3 +--
 fetch-pack.c          | 8 +++-----
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6da7233..5f1cb09 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1549,8 +1549,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		 */
 		origin_incref(suspect);
 		commit = suspect->commit;
-		if (!commit->object.parsed)
-			parse_commit(commit);
+		parse_commit(commit);
 		if (reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 20fcf8c..23daaa7 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -27,8 +27,7 @@ static void name_rev(struct commit *commit,
 	struct commit_list *parents;
 	int parent_number = 1;
 
-	if (!commit->object.parsed)
-		parse_commit(commit);
+	parse_commit(commit);
 
 	if (commit->date < cutoff)
 		return;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 001f29c..46902c3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -227,8 +227,7 @@ static void join_revs(struct commit_list **list_p,
 			parents = parents->next;
 			if ((this_flag & flags) == flags)
 				continue;
-			if (!p->object.parsed)
-				parse_commit(p);
+			parse_commit(p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |= flags;
diff --git a/fetch-pack.c b/fetch-pack.c
index a0e0350..a141eb4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -47,9 +47,8 @@ static void rev_list_push(struct commit *commit, int mark)
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
 
-		if (!(commit->object.parsed))
-			if (parse_commit(commit))
-				return;
+		if (parse_commit(commit))
+			return;
 
 		prio_queue_put(&rev_list, commit);
 
@@ -128,8 +127,7 @@ static const unsigned char *get_rev(void)
 			return NULL;
 
 		commit = prio_queue_get(&rev_list);
-		if (!commit->object.parsed)
-			parse_commit(commit);
+		parse_commit(commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
-- 
1.8.4.1.898.g8bf8a41.dirty
