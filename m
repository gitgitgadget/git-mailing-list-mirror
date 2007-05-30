From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Simplify index access condition in count-objects, pack-redundant
Date: Wed, 30 May 2007 02:12:28 -0400
Message-ID: <20070530061228.GA12738@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 08:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtHQI-0000iR-Gp
	for gcvg-git@gmane.org; Wed, 30 May 2007 08:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbXE3GMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 02:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbXE3GMe
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 02:12:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45421 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbXE3GMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 02:12:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtHQ6-0003c9-6E; Wed, 30 May 2007 02:12:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5BABB20FBAE; Wed, 30 May 2007 02:12:28 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48742>

My earlier lazy index opening patch changed this condition to check
index_data and call open_pack_index if it was NULL. In truth we only
care about num_objects.  Since open_pack_index does no harm if the
index is already open, and all indexes are likely to be closed in
this application, the "performance optimization" of inlining the
index_data check here was wrong.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 First of a 3 part series to cleanup behind the lazy index patch.
 This particular one was stupid; the lazy index patch never should
 have been submitted with the conditions like this.

 After this series, I'm pretty sure we've got everything covered.
 Additional eyes from other people wouldn't hurt, but I have gone
 through every caller several times now and am pretty sure they
 are all correct.

 Note that we are *not* safe to unload an index once opened; unlike
 the use_pack() interface the index_data interface does not offer a
 way for a caller to pin the index_data into memory for the duration
 of the block.  That's one reason I haven't tried to GC indexes yet.

 builtin-count-objects.c |    2 +-
 pack-redundant.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index ac65e03..4274ec1 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -111,7 +111,7 @@ int cmd_count_objects(int ac, const char **av, const char *prefix)
 		for (p = packed_git; p; p = p->next) {
 			if (!p->pack_local)
 				continue;
-			if (!p->index_data && open_pack_index(p))
+			if (open_pack_index(p))
 				continue;
 			packed += p->num_objects;
 			num_pack++;
diff --git a/pack-redundant.c b/pack-redundant.c
index 0617320..6bc3bdf 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -550,7 +550,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	l.pack = p;
 	llist_init(&l.all_objects);
 
-	if (!p->index_data && open_pack_index(p))
+	if (open_pack_index(p))
 		return NULL;
 
 	base = p->index_data;
-- 
1.5.2.869.g6b3ba
