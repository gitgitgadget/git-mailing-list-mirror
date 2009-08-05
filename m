From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] diff-index: keep the original index intact
Date: Wed,  5 Aug 2009 02:15:43 -0700
Message-ID: <1249463746-21538-3-git-send-email-gitster@pobox.com>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYcbU-00082b-9o
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933914AbZHEJP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933836AbZHEJP4
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:15:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933832AbZHEJPz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:15:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A4771E08D
	for <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 074141E08C for
 <git@vger.kernel.org>; Wed,  5 Aug 2009 05:15:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.18.g07a4a
In-Reply-To: <1249463746-21538-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 952F4E68-81A0-11DE-8EC7-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124879>

When comparing the index and a tree, we used to read the contents of the
tree into stage #1 of the index and compared them with stage #0.  In order
not to lose sight of entries originally unmerged in the index, we hoisted
them to stage #3 before reading the tree.

Commit d1f2d7e (Make run_diff_index() use unpack_trees(), not read_tree(),
2008-01-19) changed all this.  These days, we instead use unpack_trees()
API to traverse the tree and compare the contents with the index, without
modifying the index at all.  There is no reason to hoist the unmerged
entries to stage #3 anymore.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index ad5b6ca..2a82dac 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -309,22 +309,6 @@ static int show_modified(struct rev_info *revs,
 }
 
 /*
- * This turns all merge entries into "stage 3". That guarantees that
- * when we read in the new tree (into "stage 1"), we won't lose sight
- * of the fact that we had unmerged entries.
- */
-static void mark_merge_entries(void)
-{
-	int i;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (!ce_stage(ce))
-			continue;
-		ce->ce_flags |= CE_STAGEMASK;
-	}
-}
-
-/*
  * This gets a mix of an existing index and a tree, one pathname entry
  * at a time. The index entry may be a single stage-0 one, but it could
  * also be multiple unmerged entries (in which case idx_pos/idx_nr will
@@ -435,8 +419,6 @@ int run_diff_index(struct rev_info *revs, int cached)
 	struct unpack_trees_options opts;
 	struct tree_desc t;
 
-	mark_merge_entries();
-
 	ent = revs->pending.objects[0].item;
 	tree_name = revs->pending.objects[0].name;
 	tree = parse_tree_indirect(ent->sha1);
-- 
1.6.4.18.g07a4a
