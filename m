From: Jeff King <peff@peff.net>
Subject: Re: How to still kill git fetch with too many refs
Date: Tue, 2 Jul 2013 01:01:42 -0400
Message-ID: <20130702050142.GA1206@sigill.intra.peff.net>
References: <201307012102.31384.mfick@codeaurora.org>
 <20130702040758.GA7068@sigill.intra.peff.net>
 <20130702044151.GB7068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Jul 02 07:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utsiq-0006Ba-I5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 07:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab3GBFBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 01:01:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:54004 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab3GBFBf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 01:01:35 -0400
Received: (qmail 16750 invoked by uid 102); 2 Jul 2013 05:02:44 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Jul 2013 00:02:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2013 01:01:42 -0400
Content-Disposition: inline
In-Reply-To: <20130702044151.GB7068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229358>

On Tue, Jul 02, 2013 at 12:41:51AM -0400, Jeff King wrote:

> I replicated your test setup, and the problem is that we have many
> common objects on both sides during the ref negotiation. So we end up in
> rev_list_push for each one, which has the same O(n^2) behavior.
> Switching it to just sort at the end is not trivial; we first insert all
> of the objects, but then we actually walk the parents, pushing onto the
> list as we go. So I think we'd want a better data structure (like a
> priority queue).

Like the patch below, which is built on top of next (which has Junio's
prio_queue implementation), and has both the priority queue fix for
rev_list_push and the mark_complete sort-at-the-end fix. With this, your
test case completes in a few seconds (no clue if it would ever have
finished otherwise; I never let it run for more than a minute or two,
but I did confirm that it was spending all of its time in
commit_list_insert_by_date).

I didn't look too hard at the actual semantics, so there might be away
to not mark so many commits in the first place. This is just a mindless
replacement of an O(n^2) list insertion with the queue.

I did note two oddities, though:

  1. In the original, we never free the commit_list pointers when we pop
     them (or when we clear the list in find_common. So I think the
     existing code was leaking memory, and my version does not.

  2. In the original version of get_rev, we "peek" at the head commit of
     rev_list:

               commit = rev_list->item;

     Then we look at the parents of that commit, and possibly push them
     onto rev_list:

               while (parents) {
                      if (!(parents->item->object.flags & SEEN))
                              rev_list_push(parents->item, mark);
                      ...
               }

     and then finally, "pop" the commit off the list:

               rev_list = rev_list->next;

     But what guarantee do we have that the commit we just processed is
     still at the front of the list? If the timestamps are monotonic,
     then the parent must come after the descendent and therefore will
     not have gotten pushed onto the front of the list. But in the face
     of clock skew, this is not the case, and we will have just skipped
     over the parent with our "pop".

     So unless I am missing something very clever, I think this was a
     bug (albeit a difficult one to have matter). And it's also fixed by
     using prio_queue (which does the peek/pop together at the top of
     the function).

diff --git a/commit.c b/commit.c
index 521e49c..ebc0eea 100644
--- a/commit.c
+++ b/commit.c
@@ -581,7 +581,7 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
 	return 0;
 }
 
-static int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
+int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 {
 	const struct commit *a = a_, *b = b_;
 	/* newer commits with larger date first */
diff --git a/commit.h b/commit.h
index 4d452dc..18a5234 100644
--- a/commit.h
+++ b/commit.h
@@ -254,4 +254,6 @@ extern void check_commit_signature(const struct commit* commit, struct signature
  */
 extern void check_commit_signature(const struct commit* commit, struct signature_check *sigc);
 
+int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
+
 #endif /* COMMIT_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index abe5ffb..6684348 100644
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
@@ -505,7 +504,7 @@ static int mark_complete(const char *refname, const unsigned char *sha1, int fla
 		struct commit *commit = (struct commit *)o;
 		if (!(commit->object.flags & COMPLETE)) {
 			commit->object.flags |= COMPLETE;
-			commit_list_insert_by_date(commit, &complete);
+			commit_list_insert(commit, &complete);
 		}
 	}
 	return 0;
@@ -622,6 +621,7 @@ static int everything_local(struct fetch_pack_args *args,
 	if (!args->depth) {
 		for_each_ref(mark_complete, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
+		commit_list_sort_by_date(&complete);
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
