From: Jeff King <peff@peff.net>
Subject: [PATCH] fetch: avoid repeated commits in mark_complete
Date: Thu, 19 May 2011 16:48:51 -0400
Message-ID: <20110519204851.GA28574@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git-dev@github.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 22:48:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNA9T-0003vX-7f
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 22:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934653Ab1ESUsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 16:48:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44826
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934077Ab1ESUsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 16:48:53 -0400
Received: (qmail 19820 invoked by uid 107); 19 May 2011 20:50:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 16:50:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 16:48:51 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174003>

We add every local ref to a list so that we can mark them
and all of their ancestors back to a certain cutoff point.
However, if some refs point to the same commit, we will end
up adding them to the list many times.

Furthermore, since commit_lists are stored as linked lists,
we must do an O(n) traversal of the list in order to find
the right place to insert each commit. This makes building
the list O(n^2) in the number of refs.

For normal repositories, this isn't a big deal. We have a
few hundreds refs at most, and most of them are unique. But
consider an "alternates" repo that serves as an object
database for many other similar repos. For reachability, it
needs to keep a copy of the refs in each child repo. This
means it may have a large number of refs, many of which
point to the same commits.

By noting commits we have already added to the list, we can
shrink the size of "n" in such a repo to the number of
unique commits, which is on the order of what a normal repo
would contain (it's actually more than a normal repo, since child repos
may have branches at different states, but in practice it tends
to be much smaller than the list with duplicates).

Here are the results on one particular giant repo
(containing objects for all Rails forks on GitHub):

  $ git for-each-ref | wc -l
  112514

  [before]
  $ git fetch --no-tags ../remote.git
  63.52user 0.12system 1:03.68elapsed 99%CPU (0avgtext+0avgdata 137648maxresident)k
  1856inputs+48outputs (11major+19603minor)pagefaults 0swaps

  $ git fetch --no-tags ../remote.git
  6.15user 0.08system 0:06.25elapsed 99%CPU (0avgtext+0avgdata 123856maxresident)k
  0inputs+40outputs (0major+18872minor)pagefaults 0swaps

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 85aff02..56c0b4a 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -472,8 +472,10 @@ static int mark_complete(const char *path, const unsigned char *sha1, int flag,
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
-		commit->object.flags |= COMPLETE;
-		commit_list_insert_by_date(commit, &complete);
+		if (!(commit->object.flags & COMPLETE)) {
+			commit->object.flags |= COMPLETE;
+			commit_list_insert_by_date(commit, &complete);
+		}
 	}
 	return 0;
 }
-- 
1.7.5.8.ga95ab
