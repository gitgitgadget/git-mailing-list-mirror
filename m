From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] fetch-pack: avoid quadratic behavior in rev_list_push
Date: Tue, 2 Jul 2013 02:24:21 -0400
Message-ID: <20130702062420.GC27856@sigill.intra.peff.net>
References: <20130702061149.GB1206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 08:24:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utu0g-0001EO-2P
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 08:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab3GBGYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 02:24:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:54560 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790Ab3GBGYN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 02:24:13 -0400
Received: (qmail 21027 invoked by uid 102); 2 Jul 2013 06:25:22 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Jul 2013 01:25:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2013 02:24:21 -0400
Content-Disposition: inline
In-Reply-To: <20130702061149.GB1206@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229367>

When we call find_common to start finding common ancestors
with the remote side of a fetch, the first thing we do is
insert the tip of each ref into our rev_list linked list. We
keep the list sorted the whole time with
commit_list_insert_by_date, which means our insertion ends
up doing O(n^2) timestamp comparisons.

We could teach rev_list_push to use an unsorted list, and
then sort it once after we have added each ref. However, in
get_rev, we process the list by popping commits off the
front and adding parents back in timestamp-sorted order. So
that procedure would still operate on the large list.

Instead, we can replace the linked list with a heap-based
priority queue, which can do O(log n) insertion, making the
whole insertion procedure O(n log n).

As a result of switching to the prio_queue struct, we fix
two minor bugs:

  1. When we "pop" a commit in get_rev, and when we clear
     the rev_list in find_common, we do not take care to
     free the "struct commit_list", and just leak its
     memory. With the prio_queue implementation, the memory
     management is handled for us.

  2. In get_rev, we look at the head commit of the list,
     possibly push its parents onto the list, and then "pop"
     the front of the list off, assuming it is the same
     element that we just peeked at. This is typically going
     to be the case, but would not be in the face of clock
     skew: the parents are inserted by date, and could
     potentailly be inserted at the head of the list if they
     have a timestamp newer than their descendent. In this
     case, we would accidentally pop the parent, and never
     process it at all.

     The new implementation pulls the commit off of the
     queue as we examine it, and so does not suffer from
     this problem.

With this patch, a fetch of a single commit into a
repository with 50,000 refs went from:

  real    0m7.984s
  user    0m7.852s
  sys     0m0.120s

to:

  real    0m2.017s
  user    0m1.884s
  sys     0m0.124s

Before this patch, a larger case with 370K refs still had
not completed after tens of minutes; with this patch, it
completes in about 12 seconds.

Signed-off-by: Jeff King <peff@peff.net>
---
Not that it really matters, but Martin, note that your "one million
refs" case is actually more like 370K, because that is how many commits
there are in the linux.git repo. The rest of the lines written to your
packed-refs file are just bogus.

 fetch-pack.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 4df8abd..6684348 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "transport.h"
 #include "version.h"
+#include "prio-queue.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -37,7 +38,7 @@ static int marked;
  */
 #define MAX_IN_VAIN 256
 
-static struct commit_list *rev_list;
+static struct prio_queue rev_list = { compare_commits_by_commit_date };
 static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
 
 static void rev_list_push(struct commit *commit, int mark)
@@ -49,7 +50,7 @@ static void rev_list_push(struct commit *commit, int mark)
 			if (parse_commit(commit))
 				return;
 
-		commit_list_insert_by_date(commit, &rev_list);
+		prio_queue_put(&rev_list, commit);
 
 		if (!(commit->object.flags & COMMON))
 			non_common_revs++;
@@ -122,10 +123,10 @@ static const unsigned char *get_rev(void)
 		unsigned int mark;
 		struct commit_list *parents;
 
-		if (rev_list == NULL || non_common_revs == 0)
+		if (rev_list.nr == 0 || non_common_revs == 0)
 			return NULL;
 
-		commit = rev_list->item;
+		commit = prio_queue_get(&rev_list);
 		if (!commit->object.parsed)
 			parse_commit(commit);
 		parents = commit->parents;
@@ -152,8 +153,6 @@ static const unsigned char *get_rev(void)
 				mark_common(parents->item, 1, 0);
 			parents = parents->next;
 		}
-
-		rev_list = rev_list->next;
 	}
 
 	return commit->object.sha1;
@@ -442,7 +441,7 @@ static int find_common(struct fetch_pack_args *args,
 					in_vain = 0;
 					got_continue = 1;
 					if (ack == ACK_ready) {
-						rev_list = NULL;
+						clear_prio_queue(&rev_list);
 						got_ready = 1;
 					}
 					break;
-- 
1.8.3.rc2.14.g7eee6b3
