From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix update-cache --remove fix.
Date: Sun, 17 Apr 2005 01:58:42 -0700
Message-ID: <7v3btp230d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 10:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN5YT-0002vR-JW
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 10:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDQI6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVDQI6p
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 04:58:45 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:8681 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261285AbVDQI6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 04:58:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417085844.ONXQ19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 04:58:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

There is a boundary case bug in the update-cache --remove fix I
sent earlier, which results in a segfault when trying to remove
a nonexistent name that sorts later than anything in the
dircache.  Here is a fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 read-cache.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

read-cache.c: 60b8efb3201fbf0a67bef48775bd1c9a1ccae2ff
--- read-cache.c
+++ read-cache.c	2005-04-17 01:50:00.000000000 -0700
@@ -371,7 +371,8 @@
 	int pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		pos = -pos-1;
-	while (! strcmp(active_cache[pos]->name, path))
+	while ((pos < active_nr) &&
+	       ! strcmp(active_cache[pos]->name, path))
 		remove_entry_at(pos);
 	return 0;
 }

