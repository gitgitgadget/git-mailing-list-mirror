From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Better error message from checkout-cache for unmerged
 files.
Date: Sun, 17 Apr 2005 02:00:44 -0700
Message-ID: <7vvf6lzsjn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 10:57:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN5ad-00034w-Jy
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 10:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDQJAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 05:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVDQJAz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 05:00:55 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:23462 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261290AbVDQJAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 05:00:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417090044.DKLA1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 05:00:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The checkout-cache command says "file is not in the cache" when
an unmerged path is given.  This patch adds code to distinguish
the unmerged and the nonexistent cases and gives an appropriate
error message.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 checkout-cache.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

checkout-cache.c: e16619c9d099367c224fb485f5525d66267bbd92
--- checkout-cache.c
+++ checkout-cache.c	2005-04-17 01:49:01.000000000 -0700
@@ -121,8 +121,15 @@
 {
 	int pos = cache_name_pos(name, strlen(name));
 	if (pos < 0) {
-		if (!quiet)
-			fprintf(stderr, "checkout-cache: %s is not in the cache\n", name);
+		if (!quiet) {
+			pos = -pos - 1;
+			fprintf(stderr,
+				"checkout-cache: %s is %s.\n",
+				name,
+				(pos < active_nr &&
+				 !strcmp(active_cache[pos]->name, name)) ?
+				"unmerged" : "not in the cache");
+		}
 		return -1;
 	}
 	return checkout_entry(active_cache[pos]);

