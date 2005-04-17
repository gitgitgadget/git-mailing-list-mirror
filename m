From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] checkout-cache -a should not extract unmerged stages
Date: Sat, 16 Apr 2005 22:30:43 -0700
Message-ID: <7vy8bi0y2k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:27:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2JT-00088G-3X
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVDQFa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 01:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDQFa5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 01:30:57 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2500 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261262AbVDQFau (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 01:30:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417053044.OGOM13104.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 01:30:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When checkout-cache -a is run, currently it attempts to extract
each existing unmerged stage to the same destination and
complains to what it itself has done.  This is nonsensical.

Presumably, the user is running checkout-cache -a in order to
verify the result of the part that has cleanly been merged.  So
check out only stage 0 entries and give warnings for paths that
are unmerged.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 checkout-cache.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

checkout-cache.c: 431b7032576f40d93a08be801e26f76c168ed57b
--- checkout-cache.c
+++ checkout-cache.c	2005-04-16 22:23:15.000000000 -0700
@@ -121,10 +121,21 @@
 
 static int checkout_all(void)
 {
+	struct cache_entry *unmerge_skipping = NULL;
 	int i;
 
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
+		if (ce_stage(ce)) {
+			if (!unmerge_skipping ||
+			    strcmp(unmerge_skipping->name, ce->name))
+				fprintf(stderr,
+					"checkout-cache: needs merge %s\n",
+					ce->name);
+			unmerge_skipping = ce;
+			continue;
+		}
+		unmerge_skipping = NULL;
 		if (checkout_entry(ce) < 0)
 			return -1;
 	}

