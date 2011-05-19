From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] fetch-pack: use priority queue for mark_complete
Date: Thu, 19 May 2011 17:26:57 -0400
Message-ID: <20110519212657.GD29584@sigill.intra.peff.net>
References: <20110519212349.GA28589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:27:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAkK-00025m-Bf
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033Ab1ESV07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:26:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47077
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455Ab1ESV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:26:59 -0400
Received: (qmail 20840 invoked by uid 107); 19 May 2011 21:29:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:29:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:26:57 -0400
Content-Disposition: inline
In-Reply-To: <20110519212349.GA28589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174009>

The regular commit_list has quadratic insertion complexity.
Fetch-pack will insert an item for each ref we have.  For a
"normal" number of refs, this is not a big deal, but it is
quite inefficient when you have tens or hundreds of
thousands of refs.

Instead, let's use a priority queue with better insertion
performance. For example, timings from one repo (which
stores alternates for all of the Rails forks at GitHub, with
mirrored refs from each individual repo to manage object
pruning):

  $ git for-each-ref | wc -l
  112514

  [before]
  $ time git fetch --no-tags ../remote.git
  63.52user 0.12system 1:03.68elapsed 99%CPU (0avgtext+0avgdata 137648maxresident)k
  1856inputs+48outputs (11major+19603minor)pagefaults 0swaps

  [after]
  $ time git fetch --no-tags ../remote.git
  6.20user 0.03system 0:06.25elapsed 99%CPU (0avgtext+0avgdata 123712maxresident)k
  0inputs+40outputs (0major+18885minor)pagefaults 0swaps

Signed-off-by: Jeff King <peff@peff.net>
---
So this is the big performance-win patch. But if you didn't read my
other "fetch: avoid repeated commits in mark_complete", go do that. It's
a much simpler solution that yields the same speedup in practice.

 builtin/fetch-pack.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 85aff02..9a951f3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -457,7 +457,7 @@ done:
 	return count ? retval : 0;
 }
 
-static struct commit_list *complete;
+static struct queue complete = COMMIT_QUEUE_INIT;
 
 static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
@@ -473,18 +473,19 @@ static int mark_complete(const char *path, const unsigned char *sha1, int flag,
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		commit->object.flags |= COMPLETE;
-		commit_list_insert_by_date(commit, &complete);
+		queue_insert(&complete, commit);
 	}
 	return 0;
 }
 
 static void mark_recent_complete_commits(unsigned long cutoff)
 {
-	while (complete && cutoff <= complete->item->date) {
+	struct commit *c;
+	while ((c = queue_peek(&complete)) && cutoff <= c->date) {
 		if (args.verbose)
 			fprintf(stderr, "Marking %s as complete\n",
-				sha1_to_hex(complete->item->object.sha1));
-		pop_most_recent_commit(&complete, COMPLETE);
+				sha1_to_hex(c->object.sha1));
+		pop_commit_from_queue(&complete, COMPLETE);
 	}
 }
 
-- 
1.7.5.8.ga95ab
