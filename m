From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Merge non-first refs that match first refspec
Date: Thu, 27 Sep 2007 23:52:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709272351010.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 05:52:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib6tw-0005uT-Vv
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 05:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbXI1DwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 23:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756122AbXI1DwV
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 23:52:21 -0400
Received: from iabervon.org ([66.92.72.58]:49832 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939AbXI1DwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 23:52:20 -0400
Received: (qmail 24198 invoked by uid 1000); 28 Sep 2007 03:52:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Sep 2007 03:52:16 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59355>

The code only looked at the first ref in the map of refs when looking
for matches for the first refspec in the case where there is not
per-branch configuration of ref to merge. This is often sufficient,
but not always. Make the logic clearer and test everything in the map.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I ran all the usual tests with this, and it seems like it should fix a bug 
you saw, but I don't have the test case to make sure.

 builtin-fetch.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 2f639cc..47811c9 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -101,12 +101,13 @@ static struct ref *get_ref_map(struct transport *transport,
 				if (remote->fetch[i].dst &&
 				    remote->fetch[i].dst[0])
 					*autotags = 1;
-				if (!i && !has_merge && ref_map &&
-				    !strcmp(remote->fetch[0].src, ref_map->name))
-					ref_map->merge = 1;
 			}
 			if (has_merge)
 				add_merge_config(&ref_map, remote_refs, branch, &tail);
+			else
+				for (rm = ref_map; rm; rm = rm->next)
+					if (!strcmp(remote->fetch[0].src, rm->name))
+						rm->merge = 1;
 		} else {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
 			ref_map->merge = 1;
-- 
1.5.3.2.1041.g2df10
