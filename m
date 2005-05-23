From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Performance fix for pickaxe.
Date: Mon, 23 May 2005 00:25:15 -0700
Message-ID: <7vis1a76as.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 09:24:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da7IQ-0002UL-T0
	for gcvg-git@gmane.org; Mon, 23 May 2005 09:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVEWHZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 03:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVEWHZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 03:25:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61895 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261854AbVEWHZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 03:25:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523072515.IDRZ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 03:25:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The pickaxe was expanding the blobs and searching in them even
when it should have already known that both sides are the same.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diffcore-pickaxe.c |    3 ++-
1 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -44,7 +44,8 @@ void diffcore_pickaxe(const char *needle
 			if (contains(p->one, needle, len))
 				diff_q(&outq, p);
 		}
-		else if (contains(p->one, needle, len) !=
+		else if (!diff_unmodified_pair(p) &&
+			 contains(p->one, needle, len) !=
 			 contains(p->two, needle, len))
 			diff_q(&outq, p);
 		if (onum == outq.nr)
------------------------------------------------

