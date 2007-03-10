From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] fast-import: grow tree storage more aggressively
Date: Sat, 10 Mar 2007 14:16:48 -0500
Message-ID: <20070310191648.GA3596@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 20:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ73p-000432-Hk
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 20:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbXCJTQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 14:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbXCJTQv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 14:16:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4587 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751529AbXCJTQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 14:16:50 -0500
Received: (qmail 19152 invoked from network); 10 Mar 2007 14:17:10 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Mar 2007 14:17:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Mar 2007 14:16:48 -0500
Content-Disposition: inline
In-Reply-To: <<20070310191515.GA3416@coredump.intra.peff.net>>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41878>

When building up a tree for a commit, fast-import
dynamically allocates memory for the tree entries. When more
space is needed, the allocated memory is increased by a
constant amount. For very large trees, this means
re-allocating and memcpy()ing the memory O(n) times.

To compound this problem, releasing the previous tree
resource does not free the memory; it is kept in a pool
for future trees. This means that each of the O(n)
allocations will consume increasing amounts of memory,
giving O(n^2) memory consumption.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fda5018..81bc6ea 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1058,7 +1058,7 @@ static void load_tree(struct tree_entry *root)
 		struct tree_entry *e = new_tree_entry();
 
 		if (t->entry_count == t->entry_capacity)
-			root->tree = t = grow_tree_content(t, 8);
+			root->tree = t = grow_tree_content(t, t->entry_count);
 		t->entries[t->entry_count++] = e;
 
 		e->tree = NULL;
@@ -1225,7 +1225,7 @@ static int tree_content_set(
 	}
 
 	if (t->entry_count == t->entry_capacity)
-		root->tree = t = grow_tree_content(t, 8);
+		root->tree = t = grow_tree_content(t, t->entry_count);
 	e = new_tree_entry();
 	e->name = to_atom(p, (unsigned short)n);
 	e->versions[0].mode = 0;
-- 
1.5.0.3.931.g55c05
