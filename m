From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] commit: add infrastructure for priority queues of commits
Date: Thu, 19 May 2011 17:25:17 -0400
Message-ID: <20110519212517.GC29584@sigill.intra.peff.net>
References: <20110519212349.GA28589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAik-000163-I5
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934493Ab1ESVZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:25:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47075
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455Ab1ESVZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:25:19 -0400
Received: (qmail 20782 invoked by uid 107); 19 May 2011 21:27:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:27:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:25:17 -0400
Content-Disposition: inline
In-Reply-To: <20110519212349.GA28589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174008>

Using a priority queue to store date-ordered commits can be
algorithmically faster than the current implementation
(which uses sorted linked lists).

The previous commit introduced a generic priority queue.
This commit adds some infrastructure for using it with
commits. Specifically:

  1. A date-comparison function and queue-initializer, so
     you can create a queue like:

       struct queue pq = COMMIT_QUEUE_INIT;

  2. A function to pop the most recent commit from the
     queue, adding its parents to the queue unless a
     particular mark is seen on them. This is equivalent to
     the current pop_most_recent_commit, which operates on
     commit_list structs.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c |   27 +++++++++++++++++++++++++++
 commit.h |    5 +++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index ac337c7..9d0a182 100644
--- a/commit.c
+++ b/commit.c
@@ -419,6 +419,33 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 	return ret;
 }
 
+int commit_datecmp(const void *va, const void *vb)
+{
+	const struct commit *a = va, *b = vb;
+	if (a->date < b->date)
+		return -1;
+	else if (a->date > b->date)
+		return 1;
+	return 0;
+}
+
+struct commit *pop_commit_from_queue(struct queue *pq, unsigned int mark)
+{
+	struct commit *ret = queue_pop(pq);
+	struct commit_list *parents = ret ? ret->parents : NULL;
+
+	while (parents) {
+		struct commit *commit = parents->item;
+		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
+			commit->object.flags |= mark;
+			queue_insert(pq, commit);
+		}
+		parents = parents->next;
+	}
+
+	return ret;
+}
+
 void clear_commit_marks(struct commit *commit, unsigned int mark)
 {
 	while (commit) {
diff --git a/commit.h b/commit.h
index 43940e2..87c9b4a 100644
--- a/commit.h
+++ b/commit.h
@@ -5,6 +5,7 @@
 #include "tree.h"
 #include "strbuf.h"
 #include "decorate.h"
+#include "queue.h"
 
 struct commit_list {
 	struct commit *item;
@@ -121,6 +122,10 @@ void pp_remainder(enum cmit_fmt fmt,
 struct commit *pop_most_recent_commit(struct commit_list **list,
 				      unsigned int mark);
 
+#define COMMIT_QUEUE_INIT { commit_datecmp }
+int commit_datecmp(const void *a, const void *b);
+struct commit *pop_commit_from_queue(struct queue *pq, unsigned int mark);
+
 struct commit *pop_commit(struct commit_list **stack);
 
 void clear_commit_marks(struct commit *commit, unsigned int mark);
-- 
1.7.5.8.ga95ab
