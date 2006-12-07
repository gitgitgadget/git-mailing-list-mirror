X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/1] Make sure the empty tree exists when needed in merge-recursive.
Date: Thu, 7 Dec 2006 05:17:07 -0500
Message-ID: <20061207101707.GA19139@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 10:17:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33566>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsGJX-0005cV-Kj for gcvg-git@gmane.org; Thu, 07 Dec
 2006 11:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031970AbWLGKRM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 05:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031972AbWLGKRM
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 05:17:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34122 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031970AbWLGKRL (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 05:17:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsGJQ-00018c-9J; Thu, 07 Dec 2006 05:17:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 EE8B320FB6E; Thu,  7 Dec 2006 05:17:07 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

There are some baseless merge cases where git-merge-recursive will
try to compare one of the branches against the empty tree.  However
most projects won't have the empty tree object in their object database
as Git does not normally create empty tree objects.  If the empty tree
object is missing then the merge process will die, as it cannot load the
object from the database.  The error message may make the user think that
their database is corrupt when its actually not.

So instead we should just create the empty tree object whenever it is
needed.  If the object already exists as a loose object then no harm
done.  Otherwise that loose object will be pruned away later by either
git-prune or git-prune-packed.

Thanks goes to Junio for suggesting this fix.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cd2cc77..32e186c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1238,7 +1238,7 @@ static int merge(struct commit *h1,
 
 		tree->object.parsed = 1;
 		tree->object.type = OBJ_TREE;
-		hash_sha1_file(NULL, 0, tree_type, tree->object.sha1);
+		write_sha1_file(NULL, 0, tree_type, tree->object.sha1);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
-- 
